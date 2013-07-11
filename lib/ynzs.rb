#encoding: utf-8
class Ynzs
  def initialize
    @base = 'http://score.ynzs.cn:8080/ZbSchemeSearch.aspx'
  end
  def run
  end
  def import
    School.delete_all
    Major.delete_all
    File.readlines("#{Rails.root}/tmp/data1.csv").each do |line|
      arr = line.strip.split(',')
      school_data = {
        #:name => arr[1],
        :code => arr[0],
        :gongban => (arr[2] == '公办'),
        :address => arr[13],
        :phone => arr[14],
        :postal => arr[16]
      }
      sch = School.where(:name=>arr[1]).first_or_create school_data
      data = {
        :name => arr[5],
        :moshi => arr[3],
        :leibie => arr[4],
        :duixiang => arr[12],
        :code => arr[6],
        :xuezhi => arr[8],
        :renshu => arr[7],
        :xuefei => arr[9],
        :source_id => arr[10]
      }
      sch.majors.create(data) unless Major.exists?(:source_id=>arr[10])
      break if Rails.env.test?
    end
  end
  def list page=1,continue=true,options={}
    args = {
      '__VIEWSTATE'=>'/wEPDwULLTEwNjExNTc4NjRkZPdCpqaLQgTlQxqQCYREJ/gL5gMW',
      '__EVENTVALIDATION'=>'/wEWDwLR167mCgKC09zOCwKBqIPQCgKEg5NzAs77u8UHApOhq6QGAs6Wz8wBAtvB5JUCAueJmvMPAo6zw5gFAr6xjr4OAqG4mdwBAqG43ZgOApKPy7UNAvuSgdQJGkeOFN0+MTMPM50FFOO3JCs2HiI=',
      '__EVENTTARGET'=>'Pager',
      '__EVENTARGUMENT'=> page.to_s,
    }
    args['__VIEWSTATE'] = @__VIEWSTATE if @__VIEWSTATE
    #args['__EVENTVALIDATION'] = @__EVENTVALIDATION if @__EVENTVALIDATION
    @method = @__VIEWSTATE.present? ? "POST" : "GET"
    key = @__VIEWSTATE.present? ? "body" : "params"
    args.merge! options

    @request = Typhoeus::Request.new @base,
      key.to_sym=>args,
      #:headers=>{'Content-Type'=> 'application/x-www-form-urlencoded'},
      :verbose=>Rails.env.test?,
      :method=>@method
    @request.on_complete do |response|
      @doc = Nokogiri::HTML(response.body)
      @__VIEWSTATE = @doc.at_css('#__VIEWSTATE').attr('value')
      #@__EVENTVALIDATION = @doc.at_css('#__EVENTVALIDATION').attr('value')
      #pp response
      @doc.css(".TableList tr").each do |tr|
        if tr.attr("class").nil?
          arr =[]
          tr.css("td").collect do |td|
            arr << td.text.strip
          end
          arr[1] = tr.css('td')[1].attr('title')
          arr[5] = tr.css('td')[5].attr('title')
          arr[10] = tr.css("a").last.attr('href').match(/\d+/).to_s.to_i
          data = parse_line(arr)
          puts data.values.join(',')
          #school_id = School.where(name: data['name']).pluck(:id).first
          #if school_id.nil?
            #school = School.create :name=>data.delete('name'),
              #:gongban => data.delete('banxueleixing') == '公办',
              #:code => data.delete('school_daima')
            #school_id = school.id
            #pp school
          #end
          #pp line.values.join(',')
          #break
        end
      end
      @has_next_page = has_next_page? @doc if continue
    end
    @request.run
    list page+1 if @has_next_page
  end
  def has_next_page? doc
    (doc.at_css('.Page a[@disabled]').text() == '下一页' ? false : true) rescue true
  end
  def parse_line arr
    @keys ||= %w(school_daima school_name banxueleixing zhaoshengleibie zhuanye_leibie zhuanye_ming zhuanye_daihao renshu xuezhi xuefei id)
    data = {}
    @keys.each_with_index do |key,i|
      data[key] = arr[i]
    end
    %w(school_daima zhuanye_daihao renshu xuezhi xuefei).each do |key|
      data[key] = data[key].to_i
    end
    data.merge! item(data['id'])
    data
  end
  def item id
    response = Typhoeus::Request.get "http://score.ynzs.cn:8080/zbSChemeInfo.aspx?id=#{id}"
    if response.success?
      doc = Nokogiri::HTML(response.body)
      data = {}
      keys = {
        "学校名称："=>"school_name",
        "招生对象："=>"duixiang",
        "学校地址："=>"address",
        "联系电话："=>"phone",
        "备注："=>"beizhu",
        "邮政编码："=>"postal"
      }
      doc.css(".TableList tr span").each do |span|
        #data[keys[tr.css('td')[0].text().strip]] = tr.css('td')[1].text().strip
        data[span.attr('id')] = span.text()
      end
    end
    data

  end
end
