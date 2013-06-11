require 'spec_helper'

describe 'nrpe::command' do
  context "with no parameters" do
    let(:title) { 'a_check_command' }
    it do
      expect {
        should contain_file('/etc/nrpe.d/a_check_command') 
      }.to raise_error(Puppet::Error, /command must be specified/i)
    end
  end

  context "with a bad command name" do
    let(:title) { 'a-check-command' }
    it do
      expect {
        should contain_file('/etc/nrpe.d/a-check-command')
      }.to raise_error(Puppet::Error, /invalid command/i)
    end
  end

  context "with a good command" do
    let(:title) { 'a_check_command' }
    let(:params) { { 'command' => '/sbin/check_service' } }
    it do
      should contain_file('/etc/nrpe.d/a_check_command.cfg') \
        .with(
          { 'ensure' => 'file',
            'owner' => 'nrpe',
            'group' => 'nrpe',
            'mode' => '0440',
            'content' => "command[a_check_command]=/sbin/check_service\n" } )
    end
  end
end
