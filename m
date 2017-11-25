Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751814AbdKYPQV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 10:16:21 -0500
Date: Sat, 25 Nov 2017 15:16:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jesse Chan <jc@linux.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rama Krishna Phani A <rphani@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-vadc: add missing
 MODULE_DESCRIPTION/LICENSE
Message-ID: <20171125151614.5d1d96da@archlinux>
In-Reply-To: <20171120205601.85296-1-jc@linux.com>
References: <20171120205601.85296-1-jc@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Nov 2017 12:55:51 -0800
Jesse Chan <jc@linux.com> wrote:

> This change resolves a new compile-time warning
> when built as a loadable module:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/adc/qcom-vadc-common.o
> see include/linux/module.h for more information
> 
> This adds the license as "GPL v2", which matches the header of the file.
> 
> MODULE_DESCRIPTION is also added.
> 
> Signed-off-by: Jesse Chan <jc@linux.com>
Again, already handled by Linus Walleij.

I'm also far from keen on pushing the header include up into
the header...

> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 1 -
>  drivers/iio/adc/qcom-spmi-vadc.c    | 1 -
>  drivers/iio/adc/qcom-vadc-common.c  | 3 +++
>  drivers/iio/adc/qcom-vadc-common.h  | 2 ++
>  4 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index b093ecddf1a8..e7ba66798362 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -11,7 +11,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 3680e0d47412..569f88ce9385 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -19,7 +19,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/math64.h>
> -#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index 47d24ae5462f..8078a0cbdc46 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -229,3 +229,6 @@ int qcom_vadc_decimation_from_dt(u32 value)
>  	return __ffs64(value / VADC_DECIMATION_MIN);
>  }
>  EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
> +
> +MODULE_DESCRIPTION("Qualcomm voltage ADC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
> index 1d5354ff5c72..c62500147bb1 100644
> --- a/drivers/iio/adc/qcom-vadc-common.h
> +++ b/drivers/iio/adc/qcom-vadc-common.h
> @@ -6,6 +6,8 @@
>  #ifndef QCOM_VADC_COMMON_H
>  #define QCOM_VADC_COMMON_H
>  
> +#include <linux/module.h>
> +
>  #define VADC_CONV_TIME_MIN_US			2000
>  #define VADC_CONV_TIME_MAX_US			2100
>  

