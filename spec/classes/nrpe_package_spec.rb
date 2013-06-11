require 'spec_helper'

describe 'nrpe::package' do
  context 'with no parameters' do
    it do
      expect { should contain_xinetd__service_entry } \
        .to raise_error( Puppet::Error, /parameter left unset/i )
    end
  end

  context 'with xinetd == false' do
    let(:params) { { 'xinetd' => false } }

    it do
      should_not contain_xinetd
      should contain_package('nrpe').with( { 'ensure' => 'installed' } )
    end
  end

  context 'with xinetd == true' do
    let(:params) { { 'xinetd' => true } }

    it do
      should contain_xinetd
      should contain_package('nrpe')
    end
  end
     
end
