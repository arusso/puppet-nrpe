require 'spec_helper'

describe 'nrpe::config' do
  context 'with no parameters' do
    it do
      expect { should contain_xinetd__service_entry } \
        .to raise_error( Puppet::Error, /parameter left unset/i )
    end
  end

  context 'with xinetd == true' do
    let(:params) {
      { 'xinetd' => true,
        'allowed_hosts' => [ '127.0.0.1' ] } }

    it do
      # We can't test parameters where a hash is being passed in (not ye
      # anyways).  See:
      #  - https://github.com/rodjek/rspec-puppet/issues/71
      #  - https://github.com/rodjek/rspec-puppet/issues/101
      #  - https://github.com/rodjek/rspec-puppet/issues/107
      #
      #  At this time, it looks like #107 will resolve the issue, once it's
      #  pulled in by rodjek.
      should contain_xinetd__service_entry('nrpe')
    end
  end
     
end
