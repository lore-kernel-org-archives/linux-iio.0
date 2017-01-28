Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46044 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdA1O7f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 09:59:35 -0500
Subject: Re: [PATCH v2 19/25] iio: adc: axp20x_adc: map battery IIO channels
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-20-quentin.schulz@free-electrons.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7ecf7c00-3f8e-04e5-4c96-db1843294f2e@kernel.org>
Date: Sat, 28 Jan 2017 14:52:56 +0000
MIME-Version: 1.0
In-Reply-To: <20170127085458.18270-20-quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/17 08:54, Quentin Schulz wrote:
> This maps the IIO channels batt_v, batt_chrg_i and batt_dischrg_i
> (respectively exposing the current charging and discharging currents and
> current voltage measures of the battery power supply) to the battery
> power supply driver.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> 
> added in v2
> 
>  drivers/iio/adc/axp20x_adc.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 14f4ec0..64c7c75 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -112,6 +112,34 @@ static struct iio_map axp20x_maps[] = {
>  		.consumer_dev_name = "axp20x-ac-power-supply",
>  		.consumer_channel = "acin_i",
>  		.adc_channel_label = "acin_i",
> +	}, {
> +		.consumer_dev_name = "axp20x-battery-power-supply",
> +		.consumer_channel = "batt_v",
> +		.adc_channel_label = "batt_v",
> +	}, {
> +		.consumer_dev_name = "axp20x-battery-power-supply",
> +		.consumer_channel = "batt_chrg_i",
> +		.adc_channel_label = "batt_chrg_i",
> +	}, {
> +		.consumer_dev_name = "axp20x-battery-power-supply",
> +		.consumer_channel = "batt_dischrg_i",
> +		.adc_channel_label = "batt_dischrg_i",
> +	}, { /* sentinel */ }
> +};
> +
> +static struct iio_map axp22x_maps[] = {
> +	{
> +		.consumer_dev_name = "axp20x-battery-power-supply",
> +		.consumer_channel = "batt_v",
> +		.adc_channel_label = "batt_v",
> +	}, {
> +		.consumer_dev_name = "axp20x-battery-power-supply",
> +		.consumer_channel = "batt_chrg_i",
> +		.adc_channel_label = "batt_chrg_i",
> +	}, {
> +		.consumer_dev_name = "axp20x-battery-power-supply",
> +		.consumer_channel = "batt_dischrg_i",
> +		.adc_channel_label = "batt_dischrg_i",
>  	}, { /* sentinel */ }
>  };
>  
> @@ -479,6 +507,7 @@ static const struct axp_data axp22x_data = {
>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>  	.adc_rate = axp22x_adc_rate,
>  	.adc_en2 = false,
> +	.maps = axp22x_maps,
>  };
>  
>  static const struct of_device_id axp20x_adc_of_match[] = {
> 

