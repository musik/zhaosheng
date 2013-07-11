#encoding: utf-8
module MajorsHelper
  def majors_title args
    arr = []
    arr << "名称含有\"#{args[:name_cont]}\"" if args[:name_cont].present?
    arr << "学校名称含有\"#{args[:school_name_cont]}\"" if args[:school_name_cont].present?
    arr << "面向#{args[:duixiang_eq]}招生" if args[:duixiang_eq].present?
    arr << "的" if arr.present?
    arr << args[:leibie_eq] if args[:leibie_eq].present?
    arr << args[:moshi_eq] if args[:moshi_eq].present?
    arr << "专业"
    arr.join
  end
end
