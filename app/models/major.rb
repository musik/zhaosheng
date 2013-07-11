#encoding: utf-8
class Major < ActiveRecord::Base
  attr_accessible :code, :duixiang, :leibie, :name, :renshu, :school_id, :xuefei, :xuezhi, :zhaosheng_leibie,:source_id
  belongs_to :school
  MOSHI = {:zhongzhuan=>"中专", :gaozhi=>"五年制高职", :jixiao=>"技工学校", :zhizhong=>"职业高中"}
  LEIBIE = {putong: '普通类',yishu: '艺术类',tiyu: '体育类'}
  DUIXIANG = {chuzhong: "初中毕业生", chuer: "初二在校生及初中毕业生", xiaoxue: "小学毕业生", xiaowu: "小学五、六年级学生", xiaosan: "小学3、4年级学生"}
end
