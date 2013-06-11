require 'spec_helper'

describe 'nrpe::service' do
  context 'with no parameters' do
    it do
      expect { should contain_xinetd__service_entry } \
        .to raise_error( Puppet::Error, /parameter left unset/i )
    end
  end

  context 'with xinetd == false' do
    let(:params) { { 'xinetd' => false } }

    it do
      should contain_service('nrped') \
        .with(
          { 'ensure' => 'running',
            'enable' => true } )
    end
  end

  context 'with xinetd == true' do
    let(:params) { { 'xinetd' => true } }

    it do
      should contain_service('nrped') \
        .with(
          { 'ensure' => 'stopped',
            'enable' => false } )
    end
  end
     
end
