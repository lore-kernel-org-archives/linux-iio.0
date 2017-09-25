Return-Path: <SRS0=len+=A2=free-electrons.com=quentin.schulz@kernel.org>
Subject: Re: [RFC PATCH 3/7] iio: adc: axp20x-adc: add support for AXP803
To: Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
References: <20170920151814.22461-1-icenowy@aosc.io>
 <20170920151814.22461-4-icenowy@aosc.io>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <1ba65180-9f13-0ef4-9213-1b20f15b5bdb@free-electrons.com>
Date: Mon, 25 Sep 2017 10:48:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170920151814.22461-4-icenowy@aosc.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi Icenowy,

On 20/09/2017 17:18, Icenowy Zheng wrote:
> AXP803 SoC features an ADC part including these channels: GPADC (GPIO0)
> and TS pins, PMIC internal temperature sensor, battery voltage, battery
> charge/discharge current.
> 
> Add support for the battery-related channels and internal temperature
> channel in order to allow battery monitoring. The TS and GPADC channels
> are complex and will be support after more investigation.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/iio/adc/axp20x_adc.c | 108 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 93dd6b80059e..4f0cd98cf6ea 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -28,6 +28,8 @@
[...]>  /*
> + * AXP803 shares the same consumer map with AXP22x, as it has no ADC for
> + * VBUS and ACIN inputs either.
> + */
> +
> +/*

Put that in the commit log?
If we add a comment for each newly supported PMIC we will end up with
more comments than code :)

[...]>
> +static const struct axp_data axp803_data = {
> +	.iio_info = &axp803_adc_iio_info,
> +	.num_channels = ARRAY_SIZE(axp803_adc_channels),
> +	.channels = axp803_adc_channels,
> +	.adc_en1_mask = AXP803_ADC_EN1_MASK,
> +	.adc_en2 = false,

Not required I guess, by default it is false.

Thanks,
Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
