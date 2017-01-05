#
# Cookbook Name:: ossec
# Recipe:: rule_overrides
#
# Copyright 2010, Opscode, Inc.
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

# Add or override rules from cookbook files. This is run after the
# default ossec-hids are installed.

[
  'ossec_rules.xml'
].each do |rule_file|
  cookbook_file "#{node['ossec']['user']['dir']}/rules/#{rule_file}" do
    source "rules/#{rules_file}"
    owner "root"
    group "ossec"
    mode 0440
    notifies :restart, 'service[ossec]'
  end
end