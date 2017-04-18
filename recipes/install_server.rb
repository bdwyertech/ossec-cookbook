#
# Cookbook:: ossec
# Recipe:: install_server
#
# Copyright:: 2015-2017, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['wazuh']['enabled']

  # include_recipe 'build-essential'
  package 'git'

  wz = git 'Clone Wazuh-OSSEC' do
    destination ::File.join(Chef::Config[:file_cache_path], 'wazuh')
    repository 'https://github.com/wazuh/wazuh.git'
    revision node['wazuh']['version']
    depth 1
    action :sync
    notifies :run, 'execute[Install Wazuh-OSSEC]', :immediately
  end

  execute 'Install Wazuh-OSSEC' do
    cwd wz.destination
    environment USER_INSTALL_TYPE: 'server'
    command './install.sh'
    action :nothing
  end

  # ark 'ossec-wazuh' do
  #   version node['wazuh']['version']
  #   url node['wazuh']['url'] || "https://github.com/wazuh/wazuh/archive/v#{version}.tar.gz"
  #   make_opts ['-C src', 'V=1', 'TARGET=server']
  #   action :install_with_make
  # end

else
  include_recipe 'ossec::repository'

  package 'ossec-hids'
end
