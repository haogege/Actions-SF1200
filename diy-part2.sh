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

rm -rf feeds/packages/devel/diffutils
rm -rf feeds/packages/utils/jq
rm -rf feeds/packages/net/zerotier
git clone https://github.com/coolsnowwolf/packages.git
cp -r packages/devel/diffutils feeds/packages/devel
cp -r packages/utils/jq feeds/packages/utils
cp -r packages/net/zerotier feeds/packages/net
rm -rf packages

# 修改golang源码以编译xray1.8.8+版本
rm -rf feeds/packages/lang/golang
rm -rf feeds/packages2/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages2/lang/golang
sed -i '/-linkmode external \\/d' feeds/packages/lang/golang/golang-package.mk
sed -i '/-linkmode external \\/d' feeds/packages2/lang/golang/golang-package.mk

rm -rf feeds/packages2/multimedia/aliyundrive-webdav
rm -rf feeds/luci2/applications/luci-app-aliyundrive-webdav
git clone https://github.com/messense/aliyundrive-webdav.git
cp -r aliyundrive-webdav/openwrt/aliyundrive-webdav feeds/packages2/multimedia
cp -r aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav feeds/luci2/applications
rm -rf aliyundrive-webdav

# 修改frp版本为官网最新v0.56.0 https://github.com/fatedier/frp
sed -i 's/PKG_VERSION:=0.53.2/PKG_VERSION:=0.56.0/' feeds/packages2/net/frp/Makefile
sed -i 's/PKG_HASH:=ff2a4f04e7732bc77730304e48f97fdd062be2b142ae34c518ab9b9d7a3b32ec/PKG_HASH:=084542bad79f9bed7fb18f31e7763589663e1dca243fe1c3d3dbfec45610ad5a/' feeds/packages2/net/frp/Makefile

# 拉取最后能编译的shadowsocks-rust
wget https://codeload.github.com/fw876/helloworld/zip/28504024db649b7542347771704abc33c3b1ddc8 -O helloworld.zip
unzip helloworld.zip
rm -rf feeds/helloworld/shadowsocks-rust
cp -r helloworld-28504024db649b7542347771704abc33c3b1ddc8/shadowsocks-rust feeds/helloworld
rm -rf feeds/PWpackages/shadowsocks-rust
cp -r helloworld-28504024db649b7542347771704abc33c3b1ddc8/shadowsocks-rust feeds/PWpackages
rm -rf helloworld.zip helloworld-28504024db649b7542347771704abc33c3b1ddc8

# 拉取最后能编译的shadowsocksr-libev
#wget https://codeload.github.com/fw876/helloworld/zip/ea2a48dd6a30450ab84079a0c0a943cab86e29dc -O helloworld.zip
#unzip helloworld.zip
#rm -rf feeds/helloworld/shadowsocksr-libev
#cp -r helloworld-ea2a48dd6a30450ab84079a0c0a943cab86e29dc/shadowsocksr-libev feeds/helloworld
#sed -i '/DEPENDS:=+libev +libsodium +libopenssl +libpthread +libpcre +libudns +zlib +libopenssl-legacy/s/ +libopenssl-legacy//' feeds/helloworld/shadowsocksr-libev/Makefile
#rm -rf feeds/PWpackages/shadowsocksr-libev
#cp -r feeds/helloworld/shadowsocksr-libev feeds/PWpackages
#rm -rf helloworld.zip helloworld-ea2a48dd6a30450ab84079a0c0a943cab86e29dc

git clone https://github.com/coolsnowwolf/lede.git
cp -r lede/tools/ninja tools
cp -r lede/package/lean/adbyby package
rm -rf lede

git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome

rm -rf package/libs/openssl
#wget 'https://github.com/201821143044/Actions-GL.iNet-OpenWrt/raw/main/myfiles/openssl.zip' --no-check-certificate && unzip -o openssl.zip && rm -f openssl.zip
wget 'https://github.com/wekingchen/Actions-SFT1200/raw/2024.03.22-1725/openssl.zip' --no-check-certificate && unzip -o openssl.zip && rm -f openssl.zip
wget https://github.com/wekingchen/Actions-SFT1200/raw/main/board-2.bin.ddcec9efd245da9365c474f513a855a55f3ac7fe -P dl/
