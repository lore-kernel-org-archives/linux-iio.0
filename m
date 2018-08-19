Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUrT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 16:47:19 -0400
Date: Sun, 19 Aug 2018 18:35:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Parthiban Nallathambi <pn@denx.de>, kbuild-all@01.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v6 1/2] iio: light: Add support for vishay vcnl4035
Message-ID: <20180819183500.116733f8@archlinux>
In-Reply-To: <201808112324.Z16wUjWW%fengguang.wu@intel.com>
References: <20180807102704.1652656-1-pn@denx.de>
        <201808112324.Z16wUjWW%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 11 Aug 2018 23:25:41 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Parthiban,
> 
> Thank you for the patch! Yet something to improve:

The issue here is I think that you should be simply calling hweight8 rather
than directly calling the fallback software version.

I 'might' fix that up if it is the only issue known to remain.

Thanks,

Jonathan

> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.18-rc8 next-20180810]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Parthiban-Nallathambi/iio-light-Add-support-for-vishay-vcnl4035/20180810-012903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=ia64 
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>    ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko] undefined!
>    ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!
> >> ERROR: "__sw_hweight8" [drivers/iio/light/vcnl4035.ko] undefined!  
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
