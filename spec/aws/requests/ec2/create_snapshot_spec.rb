require File.dirname(__FILE__) + '/../../spec_helper'

describe 'EC2.create_snapshot' do

  before(:all) do
    @ec2 = Fog::AWS::EC2.gen
    @volume_id = @ec2.create_volume('us-east-1a', 1).body['volumeId']
  end

  after(:all) do
    @ec2.delete_volume(@volume_id)
    eventually do
      @ec2.delete_snapshot(@snapshot_id)
    end
  end

  it "should return proper attributes" do
    actual = @ec2.create_snapshot(@volume_id)
    actual.body['progress'].should be_a(String)
    @snapshot_id = actual.body['snapshotId']
    actual.body['snapshotId'].should be_a(String)
    actual.body['startTime'].should be_a(Time)
    actual.body['status'].should be_a(String)
    actual.body['volumeId'].should be_a(String)
  end

end