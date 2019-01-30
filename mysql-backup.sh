#!/bin/sh

#保存备份个数，备份31天数据
number=30
#备份保存路径
backup_dir=/mnt/backup/db
#日期
dd=`date +%Y%m%d`

#如果文件夹不存在则创建
if [ ! -d $backup_dir ]; 
then     
    mkdir -p $backup_dir; 
fi

mysqldump -uroot -p123456 hospital > $backup_dir/$dd-hospital.sql
#写创建备份日志
echo "create $backup_dir/$dd.dump" >> $backup_dir/log.txt

#找出需要删除的备份
delfile=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | head -1`

#判断现在的备份数量是否大于$number
count=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | wc -l`

if [ $count -gt $number ]
then
  #删除最早生成的备份，只保留number数量的备份
  rm $delfile
  #写删除文件日志
  echo "delete $delfile" >> $backup_dir/log.txt
fi


mysqldump -uroot -p123456 ghospital > $backup_dir/$dd-ghospital.sql
#写创建备份日志
echo "create $backup_dir/$dd.dump" >> $backup_dir/log.txt

#找出需要删除的备份
delfile=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | head -1`

#判断现在的备份数量是否大于$number
count=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | wc -l`

if [ $count -gt $number ]
then
  #删除最早生成的备份，只保留number数量的备份
  rm $delfile
  #写删除文件日志
  echo "delete $delfile" >> $backup_dir/log.txt
fi