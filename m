Return-Path: <SRS0=3P32=54=microchip.com=Eugen.Hristev@kernel.org>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: add support for
 suspend/resume functionality
To: kbuild test robot <lkp@intel.com>
CC: <kbuild-all@01.org>, <nicolas.ferre@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ludovic.desroches@microchip.com>, <jic23@kernel.org>
References: <201706230509.6BVT6qtS%fengguang.wu@intel.com>
From: Eugen Hristev <eugen.hristev@microchip.com>
Message-ID: <c6da1a72-3e7e-acd3-ae8f-50f6749f2885@microchip.com>
Date: Fri, 23 Jun 2017 12:25:35 +0300
MIME-Version: 1.0
In-Reply-To: <201706230509.6BVT6qtS%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 23.06.2017 01:07, kbuild test robot wrote:
> Hi Eugen,
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.12-rc6 next-20170622]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eugen-Hristev/iio-adc-at91-sama5d2_adc-add-support-for-suspend-resume-functionality/20170623-043330
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=sparc64
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/iio/adc/at91-sama5d2_adc.c: In function 'at91_adc_suspend':
>>> drivers/iio/adc/at91-sama5d2_adc.c:559:9: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
>       return pinctrl_pm_select_sleep_state(dev);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Will send a revised patch to fix this warning on SPARC architecture.

>     drivers/iio/adc/at91-sama5d2_adc.c: In function 'at91_adc_resume':
>>> drivers/iio/adc/at91-sama5d2_adc.c:569:8: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
>       ret = pinctrl_pm_select_default_state(dev);
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/iio/adc/at91-sama5d2_adc.c:589:3: error: implicit declaration of function 'at91_adc_configure_trigger' [-Werror=implicit-function-declaration]
>        at91_adc_configure_trigger(st->trig, true);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/iio/adc/at91-sama5d2_adc.c:589:32: error: 'struct at91_adc_state' has no member named 'trig'; did you mean 'reg'?
>        at91_adc_configure_trigger(st->trig, true);
These two errors appears because this patch is on top of my other patch
for hardware trigger and buffer which is on the way upstream, and not
yet in linux-next.
Building over the tree with the included patch will work.

Regards,
Eugen
>                                     ^~
>     cc1: some warnings being treated as errors
> 
> vim +/pinctrl_pm_select_sleep_state +559 drivers/iio/adc/at91-sama5d2_adc.c
> 
>     553		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
>     554	
>     555		clk_disable_unprepare(st->per_clk);
>     556		regulator_disable(st->vref);
>     557		regulator_disable(st->reg);
>     558	
>   > 559		return pinctrl_pm_select_sleep_state(dev);
>     560	}
>     561	
>     562	static int at91_adc_resume(struct device *dev)
>     563	{
>     564		struct iio_dev *indio_dev =
>     565				platform_get_drvdata(to_platform_device(dev));
>     566		struct at91_adc_state *st = iio_priv(indio_dev);
>     567		int ret;
>     568	
>   > 569		ret = pinctrl_pm_select_default_state(dev);
>     570		if (ret)
>     571			goto resume_failed;
>     572	
>     573		ret = regulator_enable(st->reg);
>     574		if (ret)
>     575			goto resume_failed;
>     576	
>     577		ret = regulator_enable(st->vref);
>     578		if (ret)
>     579			goto reg_disable_resume;
>     580	
>     581		ret = clk_prepare_enable(st->per_clk);
>     582		if (ret)
>     583			goto vref_disable_resume;
>     584	
>     585		at91_adc_hw_init(st);
>     586	
>     587		/* reconfiguring trigger hardware state */
>     588		if (iio_buffer_enabled(indio_dev))
>   > 589			at91_adc_configure_trigger(st->trig, true);
>     590	
>     591		return 0;
>     592	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
