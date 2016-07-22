Return-Path: <zhiyong.tao@mediatek.com>
Message-ID: <1469161161.419.48.camel@mhfsdcap03>
Subject: Re: [PATCH v5 3/3] arm: dts: mt2701: Add auxadc node.
From: zhiyong tao <zhiyong.tao@mediatek.com>
To: kbuild test robot <lkp@intel.com>
CC: <kbuild-all@01.org>, <robh+dt@kernel.org>, <jic23@kernel.org>,
	<knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
	<yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
	<erin.lo@mediatek.com>, <dawei.chien@mediatek.com>, <matthias.bgg@gmail.com>,
	<s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<robh@kernel.org>
Date: Fri, 22 Jul 2016 12:19:21 +0800
In-Reply-To: <201607220639.0tIT3cRj%fengguang.wu@intel.com>
References: <201607220639.0tIT3cRj%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2016-07-22 at 06:08 +0800, kbuild test robot wrote:

sorry, I forget to add this information:
---
This patch dependents on "Add clock support for Mediatek MT2701"[1].
Please accept this patch together with [1].
[1]http://lists.infradead.org/pipermail/linux-mediatek/2016-June/005969.html
---
I will add this information in next version commit message.

> Hi,
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.7-rc7 next-20160721]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Zhiyong-Tao/AUXADC-Mediatek-auxadc-driver/20160722-041141
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm/boot/dts/mt2701.dtsi:145.22-23 syntax error
>    FATAL ERROR: Unable to parse input tree
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
