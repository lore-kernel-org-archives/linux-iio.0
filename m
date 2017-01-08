Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44857 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbdAHQnC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 11:43:02 -0500
Subject: Re: [iio:testing 56/57] drivers/iio/adc/qcom-spmi-vadc.c:667:3: note:
 in expansion of macro 'do_div'
To: kbuild test robot <fengguang.wu@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <201701082029.l6NFBaIq%fengguang.wu@intel.com>
Cc: kbuild-all@01.org,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <5a2cd22b-8b90-9620-817d-666c9ffcece4@jic23.retrosnub.co.uk>
Date: Sun, 8 Jan 2017 16:42:57 +0000
MIME-Version: 1.0
In-Reply-To: <201701082029.l6NFBaIq%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/17 12:09, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   35835152d900dc260e90f5f42e3e4541216fd3eb
> commit: f1f75f449faaba296cf651938da225880d84259c [56/57] iio:adc:qcom-spmi-vadc : fix undefined __divdi3
> config: blackfin-allmodconfig (attached as .config)
> compiler: bfin-uclinux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f1f75f449faaba296cf651938da225880d84259c
>         # save the attached .config to linux build tree
>         make.cross ARCH=blackfin 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from ./arch/blackfin/include/generated/asm/div64.h:1:0,
>                     from include/linux/kernel.h:142,
>                     from include/linux/list.h:8,
>                     from include/linux/wait.h:6,
>                     from include/linux/completion.h:11,
>                     from drivers/iio/adc/qcom-spmi-vadc.c:15:
>    drivers/iio/adc/qcom-spmi-vadc.c: In function 'vadc_scale_die_temp':
>    include/asm-generic/div64.h:207:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
>>> drivers/iio/adc/qcom-spmi-vadc.c:667:3: note: in expansion of macro 'do_div'
>       do_div(voltage, prescale->num * 2);
>       ^~~~~~
At this stage in the computation voltage is unsigned and fairly small.  Hence I've 
introduced a u64 temp variable to do this stage then assign voltage to that.

Bit of an overly complicated work around, but such is life.

Jonathan
> 
> vim +/do_div +667 drivers/iio/adc/qcom-spmi-vadc.c
> 
>    651	
>    652		return 0;
>    653	}
>    654	
>    655	static int vadc_scale_die_temp(struct vadc_priv *vadc,
>    656				       const struct vadc_channel_prop *prop,
>    657				       u16 adc_code, int *result_mdec)
>    658	{
>    659		const struct vadc_prescale_ratio *prescale;
>    660		s64 voltage = 0;
>    661	
>    662		vadc_scale_calib(vadc, adc_code, prop, &voltage);
>    663	
>    664		if (voltage > 0) {
>    665			prescale = &vadc_prescale_ratios[prop->prescale];
>    666			voltage = voltage * prescale->den;
>  > 667			do_div(voltage, prescale->num * 2);
>    668		} else {
>    669			voltage = 0;
>    670		}
>    671	
>    672		voltage -= KELVINMIL_CELSIUSMIL;
>    673		*result_mdec = voltage;
>    674	
>    675		return 0;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

