Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:37747
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752138AbcKCPbi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2016 11:31:38 -0400
Date: Thu, 3 Nov 2016 16:31:34 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
        antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
cc: linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        wens@csie.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmitry.torokhov@gmail.com, lee.jones@linaro.org,
        kbuild-all@01.org
Subject: Re: [PATCH v7 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <201611032049.auU2FIXo%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.20.1611031630220.3008@hadrien>
References: <201611032049.auU2FIXo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I haven't checked the complete context, but it seems that *irq that is
tested on line 431 is unsigned.

julia

On Thu, 3 Nov 2016, kbuild test robot wrote:

> Hi Quentin,
>
> [auto build test WARNING on next-20161028]
> [cannot apply to iio/togreg input/next linus/master v4.9-rc3 v4.9-rc2 v4.9-rc1 v4.9-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/add-support-for-Allwinner-SoCs-ADC/20161103-182828
> :::::: branch date: 2 hours ago
> :::::: commit date: 2 hours ago
>
> >> drivers/iio/adc/sun4i-gpadc-iio.c:431:5-9: WARNING: Unsigned expression compared with zero: * irq < 0
>
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 0068e4d1386fff54958ef3b8b304239982feaa8a
> vim +431 drivers/iio/adc/sun4i-gpadc-iio.c
>
> 0068e4d1 Quentin Schulz 2016-11-03  415
> 0068e4d1 Quentin Schulz 2016-11-03  416  	/*
> 0068e4d1 Quentin Schulz 2016-11-03  417  	 * Once the interrupt is activated, the IP continuously performs
> 0068e4d1 Quentin Schulz 2016-11-03  418  	 * conversions thus throws interrupts. The interrupt is activated right
> 0068e4d1 Quentin Schulz 2016-11-03  419  	 * after being requested but we want to control when these interrupts
> 0068e4d1 Quentin Schulz 2016-11-03  420  	 * occur thus we disable it right after being requested. However, an
> 0068e4d1 Quentin Schulz 2016-11-03  421  	 * interrupt might occur between these two instructions and we have to
> 0068e4d1 Quentin Schulz 2016-11-03  422  	 * make sure that does not happen, by using atomic flags. We set the
> 0068e4d1 Quentin Schulz 2016-11-03  423  	 * flag before requesting the interrupt and unset it right after
> 0068e4d1 Quentin Schulz 2016-11-03  424  	 * disabling the interrupt. When an interrupt occurs between these two
> 0068e4d1 Quentin Schulz 2016-11-03  425  	 * instructions, reading the atomic flag will tell us to ignore the
> 0068e4d1 Quentin Schulz 2016-11-03  426  	 * interrupt.
> 0068e4d1 Quentin Schulz 2016-11-03  427  	 */
> 0068e4d1 Quentin Schulz 2016-11-03  428  	atomic_set(atomic, 1);
> 0068e4d1 Quentin Schulz 2016-11-03  429
> 0068e4d1 Quentin Schulz 2016-11-03  430  	*irq = platform_get_irq_byname(pdev, name);
> 0068e4d1 Quentin Schulz 2016-11-03 @431  	if (*irq < 0) {
> 0068e4d1 Quentin Schulz 2016-11-03  432  		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
> 0068e4d1 Quentin Schulz 2016-11-03  433  		return *irq;
> 0068e4d1 Quentin Schulz 2016-11-03  434  	}
> 0068e4d1 Quentin Schulz 2016-11-03  435
> 0068e4d1 Quentin Schulz 2016-11-03  436  	*irq = regmap_irq_get_virq(mfd_dev->regmap_irqc, *irq);
> 0068e4d1 Quentin Schulz 2016-11-03  437  	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler, 0,
> 0068e4d1 Quentin Schulz 2016-11-03  438  					   devname, info);
> 0068e4d1 Quentin Schulz 2016-11-03  439  	if (ret < 0) {
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
