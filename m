Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46107 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbbKOLK5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 06:10:57 -0500
Subject: Re: [PATCH] iio: adc: mxs-lradc: Prefer using the BIT macro
To: kbuild test robot <lkp@intel.com>,
	Nizam Haider <nizamhaider786@gmail.com>
References: <201511092214.i7Hnv6JY%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, gregkh@linuxfoundation.org, marex@denx.de,
	stefan.wahren@i2se.com, lars@metafoo.de, hamohammed.sa@gmail.com,
	linux-iio@vger.kernel.org, Nizam Haider <nijamh@cdac.in>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	alexandre.belloni@free-electrons.com, pmeerw@pmeerw.net,
	knaack.h@gmx.de, ciorneiioana@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5648683A.9050107@kernel.org>
Date: Sun, 15 Nov 2015 11:10:50 +0000
MIME-Version: 1.0
In-Reply-To: <201511092214.i7Hnv6JY%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/15 14:40, kbuild test robot wrote:
> Hi Nizam,
Wow, this one opens up a can of worms that as far as I can tell is in no
way actually connected to your patch Nizam!
(just in case you were wondering).

I'm not actually certain what did trigger this. 

Right now I haven't found any cases that actually overflow but
maybe I'm missing something...
> 
> [auto build test WARNING on staging/staging-testing]
> [also build test WARNING on v4.3 next-20151109]
> 
> url:    https://github.com/0day-ci/linux/commits/Nizam-Haider/iio-adc-mxs-lradc-Prefer-using-the-BIT-macro/20151109-222735
> config: sparc64-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/staging/iio/adc/mxs-lradc.c: In function 'mxs_lradc_complete_touch_event':
>>> drivers/staging/iio/adc/mxs-lradc.c:325:5: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>         (((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
>         ^
>>> drivers/staging/iio/adc/mxs-lradc.c:734:7: note: in expansion of macro 'LRADC_DELAY_TRIGGER'
>           LRADC_DELAY_TRIGGER(1 << TOUCHSCREEN_VCHANNEL1) |
>           ^
>    drivers/staging/iio/adc/mxs-lradc.c: In function 'mxs_lradc_buffer_preenable':
>    drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
>                                              ^
>>> drivers/staging/iio/adc/mxs-lradc.c:1308:29: note: in expansion of macro 'LRADC_DELAY_TRIGGER_LRADCS_MASK'
>      mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
>                                 ^
>    drivers/staging/iio/adc/mxs-lradc.c: In function 'mxs_lradc_buffer_postdisable':
>    drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>     #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
>                                              ^
>    drivers/staging/iio/adc/mxs-lradc.c:1327:29: note: in expansion of macro 'LRADC_DELAY_TRIGGER_LRADCS_MASK'
>      mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
>                                 ^
> 
> vim +325 drivers/staging/iio/adc/mxs-lradc.c
> 
> 06ddd353 Marek Vasut     2013-01-11  309  #define	LRADC_STATUS				0x40
> 418880f5 Haneen Mohammed 2015-03-26  310  #define	LRADC_STATUS_TOUCH_DETECT_RAW		BIT(0)
> 06ddd353 Marek Vasut     2013-01-11  311  
> bc2c90c9 Marek Vasut     2012-08-12  312  #define	LRADC_CH(n)				(0x50 + (0x10 * (n)))
> 418880f5 Haneen Mohammed 2015-03-26  313  #define	LRADC_CH_ACCUMULATE			BIT(29)
> bc2c90c9 Marek Vasut     2012-08-12  314  #define	LRADC_CH_NUM_SAMPLES_MASK		(0x1f << 24)
> bc2c90c9 Marek Vasut     2012-08-12  315  #define	LRADC_CH_NUM_SAMPLES_OFFSET		24
> dee05308 Juergen Beisert 2013-09-23  316  #define	LRADC_CH_NUM_SAMPLES(x) \
> dee05308 Juergen Beisert 2013-09-23  317  				((x) << LRADC_CH_NUM_SAMPLES_OFFSET)
> bc2c90c9 Marek Vasut     2012-08-12  318  #define	LRADC_CH_VALUE_MASK			0x3ffff
> bc2c90c9 Marek Vasut     2012-08-12  319  #define	LRADC_CH_VALUE_OFFSET			0
> bc2c90c9 Marek Vasut     2012-08-12  320  
> bc2c90c9 Marek Vasut     2012-08-12  321  #define	LRADC_DELAY(n)				(0xd0 + (0x10 * (n)))
> bc2c90c9 Marek Vasut     2012-08-12  322  #define	LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xff << 24)
> bc2c90c9 Marek Vasut     2012-08-12  323  #define	LRADC_DELAY_TRIGGER_LRADCS_OFFSET	24
> dee05308 Juergen Beisert 2013-09-23  324  #define	LRADC_DELAY_TRIGGER(x) \
> dee05308 Juergen Beisert 2013-09-23 @325  				(((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
> dee05308 Juergen Beisert 2013-09-23  326  				LRADC_DELAY_TRIGGER_LRADCS_MASK)
> 33365872 Nizam Haider    2015-11-09  327  #define	LRADC_DELAY_KICK			BIT(20)
> bc2c90c9 Marek Vasut     2012-08-12  328  #define	LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
> bc2c90c9 Marek Vasut     2012-08-12  329  #define	LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
> dee05308 Juergen Beisert 2013-09-23  330  #define	LRADC_DELAY_TRIGGER_DELAYS(x) \
> dee05308 Juergen Beisert 2013-09-23  331  				(((x) << LRADC_DELAY_TRIGGER_DELAYS_OFFSET) & \
> dee05308 Juergen Beisert 2013-09-23  332  				LRADC_DELAY_TRIGGER_DELAYS_MASK)
> bc2c90c9 Marek Vasut     2012-08-12  333  #define	LRADC_DELAY_LOOP_COUNT_MASK		(0x1f << 11)
> 
> :::::: The code at line 325 was first introduced by commit
> :::::: dee05308f6029caed91e1a015cafb1545958ba27 Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
> 
> :::::: TO: Juergen Beisert <jbe@pengutronix.de>
> :::::: CC: Jonathan Cameron <jic23@kernel.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

