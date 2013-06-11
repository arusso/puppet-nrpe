require 'spec_helper'


describe 'nrpe' do
  context 'with default parameters' do
    it do
      should contain_nrpe__params
      should contain_nrpe__config
      should contain_nrpe__service
      should contain_nrpe__package
      should contain_file('/etc/nrpe.d/') \
        .with(
          { 'ensure' => 'directory',
            'purge' => 'true',
            'force' => 'true',
            'recurse' => 'true',
            'owner' => 'root',
            'group' => 'root',
            'mode' => '0555' } )
    end
  end

end
