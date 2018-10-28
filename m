Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbeJ2BUS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 21:20:18 -0400
Date: Sun, 28 Oct 2018 16:35:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, khilman@baylibre.com,
        carlo@caione.org
Subject: Re: [PATCH 2/7] iio: adc: meson-saradc: add support for the chip's
 temperature sensor
Message-ID: <20181028163506.4305f0b8@archlinux>
In-Reply-To: <20181028122629.10144-3-martin.blumenstingl@googlemail.com>
References: <20181028122629.10144-1-martin.blumenstingl@googlemail.com>
        <20181028122629.10144-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 Oct 2018 13:26:24 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Channel 6 of the SAR ADC can be switched between two inputs:
> SAR_ADC_CH6 input (an actual pad on the SoC) and the signal from the
> temperature sensor inside the SoC.
> 
> To get usable results from the temperature sensor we need to read the
> corresponding calibration data from the eFuse and pass it to the SAR ADC
> (bits [3:0]) and (on Meson8b and Meson8m2) to a scratch register in the
> HHI region.
> If the temperature sensor is not calibrated (the eFuse data contains a
> bit for this) then the driver will return -ENOTSUPP when trying to read
> the temperature.

If it is not supported I'd rather not see it at all.  Have two channel
sets and pick the one without the channel (by all means report
the lack of support in the kernel log).

> 
> This only enables the temperature sensor for the Meson8, Meson8b and
> Meson8m2 SoCs because on the newer, 64-bit SoCs (GXBB, GXL and GXM) the
> temperature sensor inside SAR ADC is firmware-controlled (by BL30, we
> can simply use the SCPI hwmon driver to get the chip temperature).
> 
> To keep the devicetree interface backwards compatible we simply skip the
> temperature sensor initialization if no eFuse nvmem cell is passed via
> devicetree.
> 
> The public documentation for the SAR ADC IP block does not explain how
> to use the registers to read the temperature. The logic from this patch
> is based on reading and understanding Amlogic's GPL kernel sources.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Only one significant comment on this (rest looks good to me),
what are you using the ENABLE element for in the info_mask?

I 'think' it's an indicator that the temperature sensor reads
will always return -ENOSUP?  This is non standard so I'd definitely
prefer us to do it the way I suggest above.

Thanks,

Jonathan
...
> +#define MESON_SAR_ADC_TEMP_CHAN(_chan) {				\
> +	.type = IIO_TEMP,						\
> +	.indexed = 0,							\
> +	.channel = _chan,						\
> +	.address = MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL,		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |		\
> +					BIT(IIO_CHAN_INFO_SCALE) |	\
> +					BIT(IIO_CHAN_INFO_ENABLE),	\
ENABLE?

> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),		\
> +	.datasheet_name = "TEMP_SENSOR",				\
> +}
> +
>  static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>  	MESON_SAR_ADC_CHAN(0),
>  	MESON_SAR_ADC_CHAN(1),
> @@ -197,6 +221,19 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
...
> @@ -555,17 +613,31 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
>  		break;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = regulator_get_voltage(priv->vref);
> -		if (ret < 0) {
> -			dev_err(indio_dev->dev.parent,
> -				"failed to get vref voltage: %d\n", ret);
> -			return ret;
> +		if (chan->type == IIO_VOLTAGE) {
> +			ret = regulator_get_voltage(priv->vref);
> +			if (ret < 0) {
> +				dev_err(indio_dev->dev.parent,
> +					"failed to get vref voltage: %d\n",
> +					ret);
> +				return ret;
> +			}
> +
> +			*val = ret / 1000;
> +			*val2 = priv->param->resolution;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		} else if (chan->type == IIO_TEMP) {
> +			/* SoC specific multiplier and divider */
> +			*val = priv->param->temperature_multiplier;
> +			*val2 = priv->param->temperature_divider;
> +
> +			/* celsius to millicelsius */
> +			*val *= 1000;
> +
> +			return IIO_VAL_FRACTIONAL;
> +		} else {
> +			return -EINVAL;
>  		}
>  
> -		*val = ret / 1000;
> -		*val2 = priv->param->resolution;
> -		return IIO_VAL_FRACTIONAL_LOG2;
> -
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		*val = priv->calibbias;
>  		return IIO_VAL_INT;
> @@ -575,6 +647,17 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
>  		*val2 = priv->calibscale % MILLION;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = DIV_ROUND_CLOSEST(MESON_SAR_ADC_TEMP_OFFSET *
> +					 priv->param->temperature_divider,
> +					 priv->param->temperature_multiplier);
> +		*val -= priv->temperature_sensor_adc_val;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_ENABLE:

Hmm.  This is not a standard use of this attribute. It's normally only used
for things that are 'counting' where we want to start and stop
a cumulative counter.

> +		*val = priv->temperature_sensor_calibrated;
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -625,6 +708,77 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	u8 *buf, trimming_bits, trimming_mask, upper_adc_val;
> +	struct nvmem_cell *temperature_calib;
> +	size_t read_len;
> +	int ret;
> +
> +	temperature_calib = devm_nvmem_cell_get(&indio_dev->dev,
> +						"temperature_calib");
> +	if (IS_ERR(temperature_calib)) {
> +		ret = PTR_ERR(temperature_calib);
> +
> +		/*
> +		 * leave the temperature sensor disabled if no calibration data
> +		 * was passed via nvmem-cells.
> +		 */
> +		if (ret == -ENODEV)
> +			return 0;
> +
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(indio_dev->dev.parent,
> +				"failed to get temperature_calib cell\n");
> +
> +		return ret;
> +	}
> +
> +	priv->tsc_regmap = syscon_regmap_lookup_by_phandle(
> +						indio_dev->dev.parent->of_node,
> +						"amlogic,hhi-sysctrl");
> +	if (IS_ERR(priv->tsc_regmap)) {
> +		dev_err(indio_dev->dev.parent,
> +			"failed to get amlogic,hhi-sysctrl regmap\n");
> +		return PTR_ERR(priv->tsc_regmap);
> +	}
> +
> +	read_len = MESON_SAR_ADC_EFUSE_BYTES;
> +	buf = nvmem_cell_read(temperature_calib, &read_len);
> +	if (IS_ERR(buf)) {
> +		dev_err(indio_dev->dev.parent,
> +			"failed to read temperature_calib cell\n");
> +		return PTR_ERR(buf);
> +	} else if (read_len != MESON_SAR_ADC_EFUSE_BYTES) {
> +		kfree(buf);
> +		dev_err(indio_dev->dev.parent,
> +			"invalid read size of temperature_calib cell\n");
> +		return -EINVAL;
> +	}
> +
> +	trimming_bits = priv->param->temperature_trimming_bits;
> +	trimming_mask = BIT(trimming_bits) - 1;
> +
> +	if (buf[3] & MESON_SARADC_EFUSE_BYTE3_IS_CALIBRATED)
> +		priv->temperature_sensor_calibrated = true;
> +	else
> +		priv->temperature_sensor_calibrated = false;

Could just assign?
	priv->temperature_sensor_calibrated =
		buf[3] & MEESON_SARADC_EFUSE_BYTE3_IS_CALIBRATED;
> +
> +	priv->temperature_sensor_coefficient = buf[2] & trimming_mask;
> +
> +	upper_adc_val = FIELD_GET(MESON_SARADC_EFUSE_BYTE3_UPPER_ADC_VAL,
> +				  buf[3]);
> +
> +	priv->temperature_sensor_adc_val = buf[2];
> +	priv->temperature_sensor_adc_val |= upper_adc_val << BITS_PER_BYTE;
> +	priv->temperature_sensor_adc_val >>= trimming_bits;
> +
> +	kfree(buf);
> +
> +	return 0;
> +}
> +
...
