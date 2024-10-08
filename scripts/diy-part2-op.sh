#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果)
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
#sed -i 's/ImmortalWrt/X86/g' package/base-files/files/bin/config_generate

#Add tinyfilemanager
#git clone --depth 1 --branch master --single-branch --no-checkout https://github.com/muink/luci-app-tinyfilemanager.git package/luci-app-tinyfilemanager
#pushd package/luci-app-tinyfilemanager
#umask 022
#git checkout
#popd

# 移除 SNAPSHOT 标签
#sed -i 's,-SNAPSHOT,,g' include/version.mk
#sed -i 's,-SNAPSHOT,,g' package/base-files/image-config.in

#Add luci-app-daed-next
#git clone https://github.com/sbwml/luci-app-daed-next package/daed-next

#Add luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

#Add luci-app-netdata
git clone --depth 1 --branch master --single-branch --no-checkout https://github.com/muink/luci-app-netdata.git package/luci-app-netdata

#Add autocore
git clone https://github.com/immortalwrt/immortalwrt/tree/openwrt-23.05/package/emortal/autocore package/emortal/autocore

git clone https://github.com/immortalwrt/immortalwrt/tree/openwrt-23.05/package/emortal/ipv6-helper package/emortal/ipv6-helper

# Add build date to index page
#export orig_version="$(cat "package/emortal/default-settings/files/99-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
#sed -i "s/${orig_version}/${orig_version} ($(date +"%Y-%m-%d"))/g" package/emortal/default-settings/files/99-default-settings

#Add Mosdns
#git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
#git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

./scripts/feeds update -a
./scripts/feeds install -a
