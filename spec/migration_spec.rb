def migration_list(m)
#  ['app2 0003']
  blah = m.group_by do |x|
    x.split('/').first
  end
  blah.map do |(x, y)|
    present = y.sort_by do |a|
      a.split('_').first.to_i
    end.first
#    y.find do |a|
#    end
    [x, pad(present.split('/').last.split('_').first.to_i.pred)].join(' ')
  end
end

def pad(n)
  return "zero" if n == 0
  "000%d" % n
end

describe 'Migration' do
  let (:sample_data) {
    ['app1/migrations/0001_first.py', 'app1/migrations/0002_second.py', 'app2/migrations/0004_fourth.py', 'app8/migrations/0060_lots.py', 'app8/migrations/0061_lots_more.py']
  }

  it "return app name and previous migration number" do
    migration_list(['app2/migrations/0004_fourth.py']).should == ['app2 0003']
  end

  it "return app name and previous migration n
umber for two of the same" do
    migration_list(['app2/migrations/0003_blah.py', 'app2/migrations/0004_fourth.py']).should == ['app2 0002']
  end

  it "return app name and previous migration n
umber for zero" do
    migration_list(['app2/migrations/0001_blah.py']).should == ['app2 zero']
  end
end
