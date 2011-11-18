def migration_list(migrations)
  migrations.group_by do |migration|
    migration.split('/').first
  end.map do |(app, migration)|
    present = migration.map do |a|
      a.split('/').last.split('_').first.to_i
    end.min
    app + ' ' + pad(present.pred)
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
