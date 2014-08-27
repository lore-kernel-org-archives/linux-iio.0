Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36153 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934305AbaH0N4m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Aug 2014 09:56:42 -0400
Received: by mail-qg0-f54.google.com with SMTP id j5so254100qga.27
        for <linux-iio@vger.kernel.org>; Wed, 27 Aug 2014 06:56:42 -0700 (PDT)
Date: Wed, 27 Aug 2014 14:56:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_adc: make sample delay, open
 delay, averaging DT parameters
Message-ID: <20140827135635.GH6364@lee--X1>
References: <1409141990-29627-1-git-send-email-vigneshr@ti.com>
 <1409141990-29627-2-git-send-email-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1409141990-29627-2-git-send-email-vigneshr@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Aug 2014, Vignesh R wrote:

> Number of averaging, open delay, sample delay are made DT parameters.
> By decreasing averaging and delays more samples can be obtained per
> second increasing performance of ADC. Previously the number of
> averages per step was fixed to 16. Making these parameters
> configurable will help in balancing speed vs accuracy.
> For each ADC step provide DT based paramters to set open delay,
> sample delay and number of averaging. One configurable step is
> used per ADC channel. Since there can be atmost 8 ADC channels,
> steps 16 to 8 are used for ADC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  .../bindings/input/touchscreen/ti-tsc-adc.txt      |   18 +++++++
>  drivers/iio/adc/ti_am335x_adc.c                    |   49 +++++++++++++++++---
>  include/linux/mfd/ti_am335x_tscadc.h               |    3 ++
>  3 files changed, 63 insertions(+), 7 deletions(-)

[...]

> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index fb96c84..26d3e84 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -82,14 +82,17 @@

There are so many different formats at play here, it's difficult to
see what's happening where!

>  #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
>  #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
>  #define STEPCONFIG_FIFO1	BIT(26)
> +#define STEPCONFIG_AVG_MAX	16
>  
>  /* Delay register */
>  #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>  #define STEPDELAY_OPEN(val)	((val) << 0)

What's the point in shifting by zero?

>  #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
> +#define STEPDELAY_OPEN_MAX	0x3FFFF

Put this up the top, then you can use it when defining
STEPDELAY_OPEN_MASK.

>  #define STEPDELAY_SAMPLE_MASK	(0xFF << 24)
>  #define STEPDELAY_SAMPLE(val)	((val) << 24)
>  #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
> +#define STEPDELAY_SAMPLE_MAX	0xFF

>  /* Charge Config */
>  #define STEPCHARGE_RFP_MASK	(7 << 12)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
