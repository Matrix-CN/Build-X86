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

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# Add build date to index page
export orig_version="$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
sed -i "s/${orig_version}/${orig_version} ($(date +"%Y-%m-%d"))/g" package/lean/default-settings/files/zzz-default-settings

# Add luci-theme-argon
rm -rf ./feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# Add luci-theme-design
rm -rf ./feeds/luci/themes/luci-theme-design
git clone https://github.com/gngpp/luci-theme-design.git  package/luci-theme-design
git clone https://github.com/gngpp/luci-app-design-config.git package/luci-app-design-config

#Add luci-app-mosdns
# remove v2ray-geodata package from feeds (openwrt-22.03 & master)
#rm -rf ./feeds/packages/net/v2ray-geodata
#rm -rf ./feeds/luci/applications/luci-app-mosdns/
#rm -rf ./feeds/packages/net/mosdns
#git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
#git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# alist
#git clone https://github.com/sbwml/luci-app-alist package/alist
#rm -rf feeds/packages/lang/golang
#svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang

# Add openclash
#git clone --depth=1 -b master https://github.com/vernesong/OpenClash package/luci-app-openclash

# Add iStore
#svn export https://github.com/linkease/istore-ui/trunk/app-store-ui package/app-store-ui
#svn export https://github.com/linkease/istore/trunk/luci package/luci-app-store

#smartdns
#rm -rf ./feeds/packages/net/smartdns
#rm -rf ./feeds/luci/applications/luci-app-smartdns
#git clone https://github.com/pymumu/smartdns.git package/smartdns
#git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

# Add luci-aliyundrive-webdav
#rm -rf ../../customfeeds/luci/applications/luci-app-aliyundrive-webdav 
#rm -rf ../../customfeeds/packages/multimedia/aliyundrive-webdav
#svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
#svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav
#popd

./scripts/feeds update -a
./scripts/feeds install -a
