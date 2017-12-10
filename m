Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751769AbdLJQhC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 11:37:02 -0500
Date: Sun, 10 Dec 2017 16:36:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, icenowy@aosc.io,
        linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH 2/8] iio: adc: axp20x_adc: add support for AXP813 ADC
Message-ID: <20171210163655.43fbd3c0@archlinux>
In-Reply-To: <ef830ce470a4f0f4be6040a776b6928bf89c0143.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
        <ef830ce470a4f0f4be6040a776b6928bf89c0143.1512396054.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  4 Dec 2017 15:12:48 +0100
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> The X-Powers AXP813 PMIC is really close to what is already done for
> AXP20X/AXP22X.
> 
> There are two pairs of bits to set the rate (one for Voltage and Current
> measurements and one for TS/GPIO0 voltage measurements) instead of one.

This would normally imply we need to split the device into two logical
IIO devices.  However, that only becomes relevant if we are using
buffered output which this driver doesn't support.

It'll be nasty to deal with this if we add that support down the line
though.  Up to you though as it's more likely to be your problem than
anyone else's :)

For now you could elect to support the different sampling frequencies
if you wanted to but just providing controls for each channel.

Given the driver doesn't currently expose these at all (I think)
this is all rather immaterial ;)
> 
> The register to set the ADC rates is different from the one for
> AXP20X/AXP22X.
> 
> GPIO0 can be used as an ADC (measuring Volts) unlike for AXP22X.
> 
> The scales to apply to the different inputs are unlike the ones from
> AXP20X and AXP22X.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Looks good to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm assuming these will probably go via MFD..

Jonathan
> ---
>  drivers/iio/adc/axp20x_adc.c | 122 ++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/axp20x.h   |   2 +-
>  2 files changed, 124 insertions(+)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 7274f4f..03d489b 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -35,8 +35,13 @@
>  #define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
>  
>  #define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
> +#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
> +#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>  #define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
>  #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
> +#define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
> +#define AXP813_V_I_ADC_RATE_HZ(x)		((ilog2((x) / 100) << 4) & AXP813_V_I_ADC_RATE_MASK)
> +#define AXP813_ADC_RATE_HZ(x)			(AXP20X_ADC_RATE_HZ(x) | AXP813_V_I_ADC_RATE_HZ(x))
>  
>  #define AXP20X_ADC_CHANNEL(_channel, _name, _type, _reg)	\
>  	{							\
> @@ -95,6 +100,12 @@ enum axp22x_adc_channel_i {
>  	AXP22X_BATT_DISCHRG_I,
>  };
>  
> +enum axp813_adc_channel_v {
> +	AXP813_TS_IN = 0,
> +	AXP813_GPIO0_V,
> +	AXP813_BATT_V,
> +};
> +
>  static struct iio_map axp20x_maps[] = {
>  	{
>  		.consumer_dev_name = "axp20x-usb-power-supply",
> @@ -197,6 +208,25 @@ static const struct iio_chan_spec axp22x_adc_channels[] = {
>  			   AXP20X_BATT_DISCHRG_I_H),
>  };
>  
> +static const struct iio_chan_spec axp813_adc_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = AXP22X_PMIC_TEMP_H,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.datasheet_name = "pmic_temp",
> +	},
> +	AXP20X_ADC_CHANNEL(AXP813_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
> +			   AXP288_GP_ADC_H),
> +	AXP20X_ADC_CHANNEL(AXP813_BATT_V, "batt_v", IIO_VOLTAGE,
> +			   AXP20X_BATT_V_H),
> +	AXP20X_ADC_CHANNEL(AXP22X_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
> +			   AXP20X_BATT_CHRG_I_H),
> +	AXP20X_ADC_CHANNEL(AXP22X_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRENT,
> +			   AXP20X_BATT_DISCHRG_I_H),
> +};
> +
>  static int axp20x_adc_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan, int *val)
>  {
> @@ -243,6 +273,18 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
>  	return IIO_VAL_INT;
>  }
>  
> +static int axp813_adc_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val)
> +{
> +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +
> +	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
> +	if (*val < 0)
> +		return *val;
> +
> +	return IIO_VAL_INT;
> +}
> +
>  static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
>  {
>  	switch (channel) {
> @@ -273,6 +315,24 @@ static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
>  	}
>  }
>  
> +static int axp813_adc_scale_voltage(int channel, int *val, int *val2)
> +{
> +	switch (channel) {
> +	case AXP813_GPIO0_V:
> +		*val = 0;
> +		*val2 = 800000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case AXP813_BATT_V:
> +		*val = 1;
> +		*val2 = 100000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int axp20x_adc_scale_current(int channel, int *val, int *val2)
>  {
>  	switch (channel) {
> @@ -342,6 +402,26 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
>  	}
>  }
>  
> +static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
> +			    int *val2)
> +{
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		return axp813_adc_scale_voltage(chan->channel, val, val2);
> +
> +	case IIO_CURRENT:
> +		*val = 1;
> +		return IIO_VAL_INT;
> +
> +	case IIO_TEMP:
> +		*val = 100;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>  				     int *val)
>  {
> @@ -425,6 +505,26 @@ static int axp22x_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int axp813_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -2667;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		return axp813_adc_scale(chan, val, val2);
> +
> +	case IIO_CHAN_INFO_RAW:
> +		return axp813_adc_raw(indio_dev, chan, val);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int axp20x_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan, int val, int val2,
>  			    long mask)
> @@ -470,6 +570,10 @@ static const struct iio_info axp22x_adc_iio_info = {
>  	.read_raw = axp22x_read_raw,
>  };
>  
> +static const struct iio_info axp813_adc_iio_info = {
> +	.read_raw = axp813_read_raw,
> +};
> +
>  static int axp20x_adc_rate(struct axp20x_adc_iio *info, int rate)
>  {
>  	return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> @@ -484,6 +588,13 @@ static int axp22x_adc_rate(struct axp20x_adc_iio *info, int rate)
>  				  AXP22X_ADC_RATE_HZ(rate));
>  }
>  
> +static int axp813_adc_rate(struct axp20x_adc_iio *info, int rate)
> +{
> +	return regmap_update_bits(info->regmap, AXP813_ADC_RATE,
> +				 AXP813_ADC_RATE_MASK,
> +				 AXP813_ADC_RATE_HZ(rate));
> +}
> +
>  struct axp_data {
>  	const struct iio_info		*iio_info;
>  	int				num_channels;
> @@ -514,9 +625,20 @@ static const struct axp_data axp22x_data = {
>  	.maps = axp22x_maps,
>  };
>  
> +static const struct axp_data axp813_data = {
> +	.iio_info = &axp813_adc_iio_info,
> +	.num_channels = ARRAY_SIZE(axp813_adc_channels),
> +	.channels = axp813_adc_channels,
> +	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
> +	.adc_rate = axp813_adc_rate,
> +	.adc_en2 = false,
> +	.maps = axp22x_maps,
> +};
> +
>  static const struct platform_device_id axp20x_adc_id_match[] = {
>  	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
>  	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
> +	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(platform, axp20x_adc_id_match);
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 78dc853..ff95414 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -266,6 +266,8 @@ enum axp20x_variants {
>  #define AXP288_RT_BATT_V_H		0xa0
>  #define AXP288_RT_BATT_V_L		0xa1
>  
> +#define AXP813_ADC_RATE			0x85
> +
>  /* Fuel Gauge */
>  #define AXP288_FG_RDC1_REG          0xba
>  #define AXP288_FG_RDC0_REG          0xbb

