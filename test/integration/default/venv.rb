# Cookbook:: spython
# Suite:: default
# Control:: venv
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

venv = input('venv')

if venv
  describe directory venv do
    it { should exist }
    its(:owner) { should eq input('user') }
    its(:group) { should eq input('group') }
  end

  describe file "#{venv}/bin/activate" do
    its(:owner) { should eq input('user') }
    its(:group) { should eq input('group') }
  end

  input('venv_packages').each do |package, version|
    regex = version ? "^#{package}=+#{version}$" : "^#{package}[= ]+"

    unless input('packages').keys.include?(package)
      describe command "#{input('pip_bin')} freeze --all" do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should_not match /#{regex}/ }
      end
    end

    describe command "bash -c \". #{venv}/bin/activate && #{input('pip_bin')} freeze --all\"" do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /#{regex}/ }
    end
  end

end
