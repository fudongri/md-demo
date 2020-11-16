#!/bin/bash
#author     tangchanggang <313996337@qq.com>
#date       2016-11-10

set -e  #告诉bash如果任何语句的执行结果不是true则应该退出 =set -o errexit
LC_ALL=C  #除所有本地化的设置，让命令能正确执行，"C"是系统默认的locale，"POSIX"是"C"的别名
LANG=C #解决乱码，LC_*的默认值，是最低级别的设置，如果LC_*没有设置，则使用该值。类似于 LC_ALL。
unset TZ #删除时区变量
TZBase=$(LC_ALL=C TZ=UTC0 date -R)
UTdate=$(LC_ALL=C TZ=UTC0 date -d "$TZBase")
TZdate=$(unset TZ ; LANG=C date -d "$TZBase")

# ，$( )与` `（反引号）都是用来作命令替换的。
 
file_path="`pwd`/data"              #要导入的sql文件夹
host="10.240.36.217"
username="root"                        #mysql的用户名
password="123456"        	        #mysql的密码
dbname="cncs"                       #mysql的数据库名
now=$(date "+%s")                       #计时。1970至今秒数
separator="@|@"				#数据分隔符
new_line_char="\n"			#换行符号
split_size=20				#多大文件需要拆分
split_lines=100000			#拆分后每个文件行数
tar_name=""

help(){ #echo -e 转义字符转义处理
    echo -e " USAGE EXAMPLE: sh mysql_dataload.sh -p /home/db/dataload/ -s 20 -l 10000 -- \n -h help. \n -p data files folder default current data folder(pwd/data). \n -s split size default 20 unit M. \n -l split lines default 10000 unit line. \n -- end of."
    exit 0
}

while [ -n "$1" ]; do
    case $1 in  #位置参数可以用shift命令左移
        -h) help;shift 1;;# shift 清除 -h
        -p) file_path=$2;shift 2;;#shift 清除 -p /home/db/dataload/
        -s) split_size=$2;shift 2;;#shift 清除 -s 20
        -l) split_lines=$2;shift 2;;#shift 清除 -l 10000
        -f) tar_name=$2;shift 2;;#shift 清除 -f JFCN_CS_2016_12_24.tar
        --) shift;break;;# end of options
        -*) echo "error: no such option $1. -h for help";exit 1;; #其它参数认为错误
        *) break;;
    esac
done

mysql_source(){
    TAR_FILE_COUNT="`ls -A $1 | grep ${tar_name}|wc -l`"	#查看文件（夹）个数 ls -A 同 -a ，但不列出 "." (目前目录) 及 ".." (父目录)
    if [ $TAR_FILE_COUNT == 0 ];then #
        echo " Error ${tar_name} not exists "
        return
    else
        echo " ${tar_name} exists "
    fi

    for tar_file_name in `ls -A $1  | grep ${tar_name}$`
    do
		rm $1${tar_file_name%.tar} -rf && mkdir $1${tar_file_name%.tar} && tar -xf $1$tar_file_name -C $1${tar_file_name%.tar} 
		echo " data folder $1${tar_file_name%.tar}"

		data_folder=$1${tar_file_name%.tar}
		if ls -A $data_folder | grep ^JFCN_CS.*.OK > /dev/null 2>&1 ;then #校验.ok文件，2表准错误输出，1标准输出查询结果输出的黑洞文件，返回0查找到，shell中0：true
		    echo " .ok file is exists"
        else
            echo " Error .ok file is not exists"
            return
        fi

        TEXT_FILE_COUNT="`ls  -A $data_folder |grep -i .txt |wc -l`"
		if [ $TEXT_FILE_COUNT == 6 ];then #校验是不是6个txt文件
 				echo " text files count ok"
		else
  			echo " Error text files count error,count:$TEXT_FILE_COUNT"
  			return
		fi

		for file_name in `ls -A $data_folder/  | grep -i .txt$` 
		do
			echo "###########################$file_name start########################"
			seg_start_time=$(date "+%s")
			time_postfix=$( expr $file_name : '.*\(_[0-9]\{4\}_[0-9]\{2\}_[0-9]\{2\}.\S\S\S\)' )
      tablename=${file_name%$time_postfix} #删掉$time_postfix及其右边字符串
			if [ -f "$data_folder/$file_name" ];then
			    # command="source $1$data_folder$file_name"
			    mkdir -p $data_folder/log
			    touch  $data_folder/log/$file_name.log

			    FILE_LINES=`awk '{print NR}' $data_folder/$file_name | tail -n1 ` #`wc -l $data_folder/$file_name | awk '{print $1+1}'`
          if [ "$FILE_LINES"x  == ""x ];then
              echo "data file count: 0 "
              continue
          fi

			    echo " $data_folder/$file_name"
			    `sed -i 's/\r//g'  $data_folder/$file_name`
			    `sed -i 's/\xEF\xBB\xBF//g' $data_folder/$file_name`
			    OK_FILE_NAME=`ls -A $data_folder  | grep ^JFCN_CS.*.OK$`

			    `sed -i 's/\r//g'  $data_folder/$OK_FILE_NAME`

                for line in  `cat $data_folder/$OK_FILE_NAME`
                do
                    OK_CHECK_FILE_LINE=$line #20210419@|@UNIONPAY_REPAYMENT_PLAN@|@count(1)@|@72
                    FILE_COUNT=(${OK_CHECK_FILE_LINE//@|@/ }) #将所有@|@替换为空格
                    if [ "$tablename"x = "${FILE_COUNT[1]}"x ];then
                        if [ "$FILE_LINES"x  != "${FILE_COUNT[3]}"x ];then
                            echo " Error $file_name check count:${FILE_COUNT[3]} ,but data file count:$FILE_LINES"
                            return
                        else
                            echo " $file_name check count:${FILE_COUNT[3]} , data file count:$FILE_LINES"
                        fi
                    fi
                done

                FILE_SIZE=`wc -c $data_folder/$file_name  | awk '{print int($1/(1024*1024))}'`
                echo " $data_folder/$file_name size is  $FILE_SIZE M"
                if [ -d "$data_folder/temp" ];then
                    echo " temp folder already exist execute delete : rm $data_folder/temp -rf  "
                    rm $data_folder/temp -rf
                    echo " create the temp folder : mkdir $data_folder/temp "
                    mkdir $data_folder/temp
                else
                    echo " create the temp folder : mkdir $data_folder/temp "
                    mkdir $data_folder/temp
                fi

                if [ $FILE_SIZE -ge $split_size ] ; then
                    echo " split load file $data_folder/$file_name"
                    #使用-l选项根据文件的行数来分割文件，例如把文件分割成每个包含$split_lines行的小文件
                    #文件被分割成多个带有字母的后缀文件，如果想用数字后缀可使用-d参数，同时可以使用-a length来指定后缀的长度：
                    split -l $split_lines -a 3 -d $data_folder/$file_name $data_folder/db_files_
                else
                    echo " copy load file $data_folder/$file_name"
                    cp $data_folder/$file_name $data_folder/db_files_000
                fi

                `mv $data_folder/db_files_* $data_folder/temp`
                insert_count=0;
                `/usr/bin/mysql  -h${host} -u${username} -p${password} ${dbname} --skip-secure-auth  -e "truncate table $tablename"`

                for file_child_name in `ls -A $data_folder/temp`
                do
                    if [ -f "$data_folder/temp/$file_child_name" ];then
                        echo " --------------------------------------------------"
                        echo " start load file $data_folder/temp/$file_child_name"
                        file_child_lines=`awk '{print NR}' $data_folder/temp/$file_child_name | tail -n1 ` #`wc -l $data_folder/temp/$file_child_name | awk '{print $1}'`
                        let insert_count+=$file_child_lines
                        results=$(/usr/bin/mysql --local-infile -h${host} -u${username} -p${password} ${dbname} --skip-secure-auth -f -v -e "set foreign_key_checks=0; set unique_checks=0; LOAD DATA CONCURRENT LOCAL INFILE '$data_folder/temp/$file_child_name' REPLACE INTO TABLE $tablename  character set utf8 FIELDS TERMINATED BY '$separator'  LINES TERMINATED BY '$new_line_char' IGNORE 0 LINES ;select (case when count(*) = $insert_count then 1 else 0 end) as is_right,count(*) as total_count from $tablename; "  | awk 'END {print}') > $data_folder/log/$file_name.log
                        # (name,@birthday,age) set birthday = SIR_TO_DATE(@birthday '%m%d%Y')   如果要对字段加工 需要指定字段 设置字段变量方式处理
                        if [ ${results:2} -eq $insert_count ]; then
                            echo " load file $data_folder/temp/$file_child_name Success,Load lines ${results:2} "
                        else
                            echo " Error load file $data_folder/temp/$file_child_name,Should load lines :$FILE_LINES table counts:${results:2}"

                        fi
                        echo " end load file $data_folder/temp/$file_child_name"
                        echo " --------------------------------------------------"
                    fi
                done
				echo " delete temp folder :rm $data_folder/temp -rf"
				rm  $data_folder/temp -rf
				echo " source:" \"$data_folder/$file_name\" "is ok, It takes " `expr $(date "+%s") - ${seg_start_time}` " seconds"
			fi
			echo "###########################$file_name end###########################"
		done
		rm  $data_folder -rf
		mkdir $1backup -p
		mv $1$tar_file_name $1backup -bfu
    done
 
    echo " All sql is done! Total cost: " `expr $(date "+%s") - ${now}` " seconds"
    echo " Start cleaning up 30 days before the backup data"
    find $1backup -mtime +30 |xargs rm -f
    echo " End cleaning up the backup data"
    echo " Successful !"
}
echo " Universal Time is now:  $UTdate."
echo " Local time is now:      $TZdate."
mysql_source $file_path
