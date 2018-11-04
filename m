Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbeKECQX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 21:16:23 -0500
Date: Sun, 4 Nov 2018 17:00:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v2 2/2] iio: adc: meson-saradc: add support for the
 chip's temperature sensor
Message-ID: <20181104170041.1fcc4932@archlinux>
In-Reply-To: <20181103231024.659-3-martin.blumenstingl@googlemail.com>
References: <20181103231024.659-1-martin.blumenstingl@googlemail.com>
        <20181103231024.659-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  4 Nov 2018 00:10:24 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Channel 6 of the SAR ADC can be switched between two inputs:
> SAR_ADC_CH6 input (an actual pad on the SoC) and the signal from the
> temperature sensor inside the SoC.
> 
> To get usable results from the temperature sensor we need to read the
> corresponding calibration data from the eFuse and pass it to the SAR ADC
> registers. If the temperature sensor is not calibrated (the eFuse data
> contains a bit for this) then the driver will only register the
> iio_chan_spec's for voltage measurements.
> 
> (bits [3:0]) and (on Meson8b and Meson8m2) to a scratch register in the
> HHI region.
> 
> This only enables the temperature sensor for the Meson8 SoC. Meson8b and
> Meson8m2 SoCs can be supported in the future as well but we first need
> a way to pass the fifth TSC (temperature sensor coefficient) bit to the
> HHI register area (apart from that the infrastructure as already
> implemented for Meson8 can be used). On the 64-bit SoCs (GXBB, GXL and
> GXM) the temperature sensor inside SAR ADC is firmware-controlled (by
> BL30, we can simply use the SCPI hwmon driver to get the chip
> temperature).
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
Good detailed explanation.  Thanks.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 229 +++++++++++++++++++++++++++++----
>  1 file changed, 203 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 028ccd218f82..26011254ffbc 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> @@ -165,6 +166,14 @@
>  
>  #define MESON_SAR_ADC_MAX_FIFO_SIZE				32
>  #define MESON_SAR_ADC_TIMEOUT					100 /* ms */
> +#define MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL			6
> +#define MESON_SAR_ADC_TEMP_OFFSET				27
> +
> +/* temperature sensor calibration information in eFuse */
> +#define MESON_SAR_ADC_EFUSE_BYTES				4
> +#define MESON_SAR_ADC_EFUSE_BYTE3_UPPER_ADC_VAL			GENMASK(6, 0)
> +#define MESON_SAR_ADC_EFUSE_BYTE3_IS_CALIBRATED			BIT(7)
> +
>  /* for use with IIO_VAL_INT_PLUS_MICRO */
>  #define MILLION							1000000
>  
> @@ -175,16 +184,25 @@
>  	.address = _chan,						\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>  				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> -				BIT(IIO_CHAN_INFO_CALIBBIAS) |		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),		\
>  	.datasheet_name = "SAR_ADC_CH"#_chan,				\
>  }
>  
> -/*
> - * TODO: the hardware supports IIO_TEMP for channel 6 as well which is
> - * currently not supported by this driver.
> - */
> +#define MESON_SAR_ADC_TEMP_CHAN(_chan) {				\
> +	.type = IIO_TEMP,						\
> +	.channel = _chan,						\
> +	.address = MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL,		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |		\
> +					BIT(IIO_CHAN_INFO_SCALE),	\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),		\
> +	.datasheet_name = "TEMP_SENSOR",				\
> +}
> +
>  static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>  	MESON_SAR_ADC_CHAN(0),
>  	MESON_SAR_ADC_CHAN(1),
> @@ -197,6 +215,19 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
> +static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
> +	MESON_SAR_ADC_CHAN(0),
> +	MESON_SAR_ADC_CHAN(1),
> +	MESON_SAR_ADC_CHAN(2),
> +	MESON_SAR_ADC_CHAN(3),
> +	MESON_SAR_ADC_CHAN(4),
> +	MESON_SAR_ADC_CHAN(5),
> +	MESON_SAR_ADC_CHAN(6),
> +	MESON_SAR_ADC_CHAN(7),
> +	MESON_SAR_ADC_TEMP_CHAN(8),
> +	IIO_CHAN_SOFT_TIMESTAMP(9),
> +};
> +
>  enum meson_sar_adc_avg_mode {
>  	NO_AVERAGING = 0x0,
>  	MEAN_AVERAGING = 0x1,
> @@ -225,6 +256,9 @@ struct meson_sar_adc_param {
>  	u32					bandgap_reg;
>  	unsigned int				resolution;
>  	const struct regmap_config		*regmap_config;
> +	u8					temperature_trimming_bits;
> +	unsigned int				temperature_multiplier;
> +	unsigned int				temperature_divider;
>  };
>  
>  struct meson_sar_adc_data {
> @@ -246,6 +280,9 @@ struct meson_sar_adc_priv {
>  	struct completion			done;
>  	int					calibbias;
>  	int					calibscale;
> +	bool					temperature_sensor_calibrated;
> +	u8					temperature_sensor_coefficient;
> +	u16					temperature_sensor_adc_val;
>  };
>  
>  static const struct regmap_config meson_sar_adc_regmap_config_gxbb = {
> @@ -389,9 +426,16 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
>  			   MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_MUX_SEL_MASK,
>  			   regval);
>  
> -	if (chan->address == 6)
> -		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
> -				   MESON_SAR_ADC_DELTA_10_TEMP_SEL, 0);
> +	if (chan->address == MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL) {
> +		if (chan->type == IIO_TEMP)
> +			regval = MESON_SAR_ADC_DELTA_10_TEMP_SEL;
> +		else
> +			regval = 0;
> +
> +		regmap_update_bits(priv->regmap,
> +				   MESON_SAR_ADC_DELTA_10,
> +				   MESON_SAR_ADC_DELTA_10_TEMP_SEL, regval);
> +	}
>  }
>  
>  static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
> @@ -506,8 +550,12 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
>  				    enum meson_sar_adc_num_samples avg_samples,
>  				    int *val)
>  {
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  	int ret;
>  
> +	if (chan->type == IIO_TEMP && !priv->temperature_sensor_calibrated)
> +		return -ENOTSUPP;
> +
>  	ret = meson_sar_adc_lock(indio_dev);
>  	if (ret)
>  		return ret;
> @@ -555,17 +603,31 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
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
> @@ -575,6 +637,13 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
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
>  	default:
>  		return -EINVAL;
>  	}
> @@ -625,6 +694,65 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
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
> +	priv->temperature_sensor_calibrated =
> +		buf[3] & MESON_SAR_ADC_EFUSE_BYTE3_IS_CALIBRATED;
> +	priv->temperature_sensor_coefficient = buf[2] & trimming_mask;
> +
> +	upper_adc_val = FIELD_GET(MESON_SAR_ADC_EFUSE_BYTE3_UPPER_ADC_VAL,
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
>  static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> @@ -649,10 +777,12 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  
>  	meson_sar_adc_stop_sample_engine(indio_dev);
>  
> -	/* update the channel 6 MUX to select the temperature sensor */
> +	/*
> +	 * disable this bit as seems to be only relevant for Meson6 (based
> +	 * on the vendor driver), which we don't support at the moment.
> +	 */
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
> -			MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL,
> -			MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL);
> +			MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL, 0);
>  
>  	/* disable all channels by default */
>  	regmap_write(priv->regmap, MESON_SAR_ADC_CHAN_LIST, 0x0);
> @@ -709,6 +839,29 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  	regval |= MESON_SAR_ADC_AUX_SW_XP_DRIVE_SW;
>  	regmap_write(priv->regmap, MESON_SAR_ADC_AUX_SW, regval);
>  
> +	if (priv->temperature_sensor_calibrated) {
> +		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
> +				   MESON_SAR_ADC_DELTA_10_TS_REVE1,
> +				   MESON_SAR_ADC_DELTA_10_TS_REVE1);
> +		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
> +				   MESON_SAR_ADC_DELTA_10_TS_REVE0,
> +				   MESON_SAR_ADC_DELTA_10_TS_REVE0);
> +
> +		/*
> +		 * set bits [3:0] of the TSC (temperature sensor coefficient)
> +		 * to get the correct values when reading the temperature.
> +		 */
> +		regval = FIELD_PREP(MESON_SAR_ADC_DELTA_10_TS_C_MASK,
> +				    priv->temperature_sensor_coefficient);
> +		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
> +				   MESON_SAR_ADC_DELTA_10_TS_C_MASK, regval);
> +	} else {
> +		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
> +				   MESON_SAR_ADC_DELTA_10_TS_REVE1, 0);
> +		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
> +				   MESON_SAR_ADC_DELTA_10_TS_REVE0, 0);
> +	}
> +
>  	ret = clk_set_parent(priv->adc_sel_clk, priv->clkin);
>  	if (ret) {
>  		dev_err(indio_dev->dev.parent,
> @@ -894,6 +1047,17 @@ static const struct meson_sar_adc_param meson_sar_adc_meson8_param = {
>  	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
>  	.regmap_config = &meson_sar_adc_regmap_config_meson8,
>  	.resolution = 10,
> +	.temperature_trimming_bits = 4,
> +	.temperature_multiplier = 18 * 10000,
> +	.temperature_divider = 1024 * 10 * 85,
> +};
> +
> +static const struct meson_sar_adc_param meson_sar_adc_meson8b_param = {
> +	.has_bl30_integration = false,
> +	.clock_rate = 1150000,
> +	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
> +	.regmap_config = &meson_sar_adc_regmap_config_meson8,
> +	.resolution = 10,
>  };
>  
>  static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
> @@ -918,12 +1082,12 @@ static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
>  };
>  
>  static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
> -	.param = &meson_sar_adc_meson8_param,
> +	.param = &meson_sar_adc_meson8b_param,
>  	.name = "meson-meson8b-saradc",
>  };
>  
>  static const struct meson_sar_adc_data meson_sar_adc_meson8m2_data = {
> -	.param = &meson_sar_adc_meson8_param,
> +	.param = &meson_sar_adc_meson8b_param,
>  	.name = "meson-meson8m2-saradc",
>  };
>  
> @@ -1009,9 +1173,6 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &meson_sar_adc_iio_info;
>  
> -	indio_dev->channels = meson_sar_adc_iio_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(meson_sar_adc_iio_channels);
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
> @@ -1078,6 +1239,22 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  
>  	priv->calibscale = MILLION;
>  
> +	if (priv->param->temperature_trimming_bits) {
> +		ret = meson_sar_adc_temp_sensor_init(indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (priv->temperature_sensor_calibrated) {
> +		indio_dev->channels = meson_sar_adc_and_temp_iio_channels;
> +		indio_dev->num_channels =
> +			ARRAY_SIZE(meson_sar_adc_and_temp_iio_channels);
> +	} else {
> +		indio_dev->channels = meson_sar_adc_iio_channels;
> +		indio_dev->num_channels =
> +			ARRAY_SIZE(meson_sar_adc_iio_channels);
> +	}
> +
>  	ret = meson_sar_adc_init(indio_dev);
>  	if (ret)
>  		goto err;
