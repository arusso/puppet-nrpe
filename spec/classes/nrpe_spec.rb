require 'spec_helper'


describe 'nrpe' do
  context 'with default parameters' do
    it do
      should contain_nrpe__params
      should contain_nrpe__service.with( { 'xinetd' => 'false' } )
      should contain_nrpe__package.with( { 'xinetd' => 'false' } )

      should contain_nrpe__config \
        .with(
          { 'xinetd' => 'false',
            'allowed_hosts' => [ '127.0.0.1' ] } )

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

  context 'with custom config directory' do
    let(:params) { { :conf_d => '/etc/nrpe/conf.d' } }
    it do
      should contain_nrpe__params
      should contain_nrpe__service.with( { 'xinetd' => 'false' } )
      should contain_nrpe__package.with( { 'xinetd' => 'false' } )

      should contain_nrpe__config \
        .with(
          { 'allowed_hosts' => [ '127.0.0.1' ],
            'xinetd' => 'false' } )

      should contain_file('/etc/nrpe/conf.d') \
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

  context 'specifying allowed hosts' do
    let(:params) { { :allowed_hosts => [ '127.0.0.1', '192.168.0.1' ] } }
    it do
      should contain_nrpe__params
      should contain_nrpe__service.with( { 'xinetd' => 'false' } )
      should contain_nrpe__package.with( { 'xinetd' => 'false' } )

      should contain_nrpe__config \
        .with(
          { 'allowed_hosts' => [ '127.0.0.1', '192.168.0.1' ],
            'xinetd' => 'false' } )

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

  context 'using xinetd' do
    let(:params) { { 'xinetd' => 'true' } }
    it do
      should contain_nrpe__params
      should contain_nrpe__service.with( { 'xinetd' => 'true' } )
      should contain_nrpe__package.with( { 'xinetd' => 'true' } )

      should contain_nrpe__config \
        .with(
          { 'allowed_hosts' => [ '127.0.0.1' ],
            'xinetd' => 'true' } )

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
