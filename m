Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbdKYPuO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 10:50:14 -0500
Date: Sat, 25 Nov 2017 15:50:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        linux-iio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iio: Add macro to populate struct iio_map array
Message-ID: <20171125155010.39c750b6@archlinux>
In-Reply-To: <2f78166e4b54d5c0d139121c00a69ee033918da6.1511598241.git.lukas@wunner.de>
References: <2f78166e4b54d5c0d139121c00a69ee033918da6.1511598241.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 25 Nov 2017 09:38:17 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> The GPIO core provides a handy GPIO_LOOKUP() macro to populate a struct
> gpiod_lookup array without having to spell out attribute names (but
> still avoid breakage when attributes within the struct are rearranged
> or added).
> 
> The axp288_adc.c driver uses a similar macro to populate a struct
> iio_map array.  Make it available to others.
> 
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
Seems reasonable to me but I'll let it sit for a few days in case
anyone wants to comment.

Jonathan

> ---
> The motivation for this change is that we're using it in a module which
> is currently out-of-tree.  I'm only converting axp288_adc.c here as it
> already has such a macro, and not all the other drivers which declare
> iio_map arrays because such trivial refactoring is not always welcome.
> I could convert these other drivers as well if desired.  If so, please
> let me know if this should all be put in a single patch or split per
> driver.
> 
> Note that I've replaced _adc_channel_label with _provider_channel,
> which is more apt in my opinion.  Please shout if you disagree.
> 
> Thanks!
> 
>  drivers/iio/adc/axp288_adc.c | 20 ++++++--------------
>  include/linux/iio/machine.h  |  7 +++++++
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 60c9e853dd81..031d568b4972 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -92,22 +92,14 @@ static const struct iio_chan_spec axp288_adc_channels[] = {
>  	},
>  };
>  
> -#define AXP288_ADC_MAP(_adc_channel_label, _consumer_dev_name,	\
> -		_consumer_channel)				\
> -	{							\
> -		.adc_channel_label = _adc_channel_label,	\
> -		.consumer_dev_name = _consumer_dev_name,	\
> -		.consumer_channel = _consumer_channel,		\
> -	}
> -
>  /* for consumer drivers */
>  static struct iio_map axp288_adc_default_maps[] = {
> -	AXP288_ADC_MAP("TS_PIN", "axp288-batt", "axp288-batt-temp"),
> -	AXP288_ADC_MAP("PMIC_TEMP", "axp288-pmic", "axp288-pmic-temp"),
> -	AXP288_ADC_MAP("GPADC", "axp288-gpadc", "axp288-system-temp"),
> -	AXP288_ADC_MAP("BATT_CHG_I", "axp288-chrg", "axp288-chrg-curr"),
> -	AXP288_ADC_MAP("BATT_DISCHRG_I", "axp288-chrg", "axp288-chrg-d-curr"),
> -	AXP288_ADC_MAP("BATT_V", "axp288-batt", "axp288-batt-volt"),
> +	IIO_MAP("TS_PIN", "axp288-batt", "axp288-batt-temp"),
> +	IIO_MAP("PMIC_TEMP", "axp288-pmic", "axp288-pmic-temp"),
> +	IIO_MAP("GPADC", "axp288-gpadc", "axp288-system-temp"),
> +	IIO_MAP("BATT_CHG_I", "axp288-chrg", "axp288-chrg-curr"),
> +	IIO_MAP("BATT_DISCHRG_I", "axp288-chrg", "axp288-chrg-d-curr"),
> +	IIO_MAP("BATT_V", "axp288-batt", "axp288-batt-volt"),
>  	{},
>  };
>  
> diff --git a/include/linux/iio/machine.h b/include/linux/iio/machine.h
> index 1601a2a63a72..5e1cfa75f652 100644
> --- a/include/linux/iio/machine.h
> +++ b/include/linux/iio/machine.h
> @@ -28,4 +28,11 @@ struct iio_map {
>  	void *consumer_data;
>  };
>  
> +#define IIO_MAP(_provider_channel, _consumer_dev_name, _consumer_channel) \
> +{									  \
> +	.adc_channel_label = _provider_channel,				  \
> +	.consumer_dev_name = _consumer_dev_name,			  \
> +	.consumer_channel  = _consumer_channel,				  \
> +}
> +
>  #endif

