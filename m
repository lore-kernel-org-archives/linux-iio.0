Return-Path: <SRS0=wsFM=JI=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 22 Jun 2018 14:42:43 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <daniel.baluta@gmail.com>
Subject: Re: [RFC 2/3] iio: imu: bme680: Add temperaure, pressure & humidity
 channels
Message-ID: <20180622144243.000040b9@huawei.com>
In-Reply-To: <1529562877-9357-3-git-send-email-himanshujha199640@gmail.com>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
	<1529562877-9357-3-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Thu, 21 Jun 2018 12:04:36 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Add temperature,pressure,humidity channel function definitions to read
> raw values from the channels in bme680_read_*() and calibrate them
> to get the required readings in bme680_compensate_*() using the
> calibration parameters. These calibration parameters(read-only) are
> stored in the chip's NVM memory at the time of production and are
> used to get compensated readings for various channels.
> 
> The various channels' oversampling ratio and IIR filter configurations
> are handled by bme680_chip_config().
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

There are some small readability suggestions inline and other comments
on what has sneaked into this patch from the previous one.

Otherwise, the only larger comment is:

   Don't abstract for the sake of abstraction.  Right now this driver is
   targetting one part.  Adding an abstraction to make it easier to target
   multiple parts just leads to more complex code for no benefit.

   It is easy to rework to add that abstraction at the point where it is
   needed.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/bme680/bme680_core.c | 434 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 430 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/bme680/bme680_core.c b/drivers/iio/imu/bme680/bme680_core.c
> index a6d013d..05712de 100644
> --- a/drivers/iio/imu/bme680/bme680_core.c
> +++ b/drivers/iio/imu/bme680/bme680_core.c
> @@ -6,15 +6,73 @@
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/log2.h>
> +#include <linux/iio/sysfs.h>
>  
>  #define BME680_REG_CHIP_I2C_ID	0xD0
>  #define BME680_REG_CHIP_SPI_ID	0x50
>  #define BME680_CHIP_ID_VAL	0x61
>  #define BME680_SOFT_RESET	0xE0
>  #define BME680_CMD_SOFTRESET	0xB6
> +#define BME680_REG_MEAS_STAT	0x1D
> +
> +#define BME680_OSRS_TEMP_X(osrs_t)      ((osrs_t) << 5)
> +#define BME680_OSRS_PRESS_X(osrs_p)     ((osrs_p) << 2)
> +#define BME680_OSRS_HUMID_X(osrs_h)	((osrs_h) << 0)
> +
> +#define BME680_REG_TEMP_MSB		0x22
> +#define BME680_REG_PRESS_MSB		0x1F
> +#define BM6880_REG_HUMIDITY_MSB		0x25
> +
> +#define BME680_REG_CTRL_HUMIDITY	0x72
> +#define BME680_OSRS_HUMIDITY_MASK       GENMASK(2, 0)
> +
> +#define BME680_REG_CTRL_MEAS		0x74
> +#define BME680_OSRS_TEMP_MASK		GENMASK(7, 5)
> +#define BME680_OSRS_PRESS_MASK		GENMASK(4, 2)
> +#define BME680_MODE_MASK		GENMASK(1, 0)
> +
> +#define BME680_MODE_FORCED		BIT(0)
> +
> +#define BME680_REG_CONFIG		0x75
> +#define BME680_FILTER_MASK		GENMASK(4, 2)
> +#define BME680_FILTER_4X		BIT(2)
> +
> +/* TEMP/PRESS/HUMID reading skipped */
> +#define BME680_MEAS_SKIPPED		0x8000
> +
> +/* 
> + * TODO: the following structs stores various calibration
> + * paramters which are read from the sensor's NVM and used in
> + * the compensation function to obtain processed output.
> + */
> +struct bme680_calib {
> +};
>  
>  struct bme680_data {
>  	struct regmap *regmap;
> +	struct device *dev;
> +	const struct bme680_chip_info *chip_info;
> +	struct bme680_calib bme680;
> +	u8 oversampling_temp;
> +	u8 oversampling_press;
> +	u8 oversampling_humid;
> +};
> +
> +struct bme680_chip_info {
> +	const int *oversampling_temp_avail;
> +	int num_oversampling_temp_avail;
> +
> +	const int *oversampling_press_avail;
> +	int num_oversampling_press_avail;
> +
> +	const int *oversampling_humid_avail;
> +	int num_oversampling_humid_avail;
> +
> +	int (*chip_config)(struct bme680_data *data);
> +	int (*read_temp)(struct bme680_data *data, int *val);
> +	int (*read_press)(struct bme680_data *data, int *val);
> +	int (*read_humid)(struct bme680_data *data, int *val);
>  };
>  
>  const struct regmap_config bme680_regmap_config = {
> @@ -23,9 +81,339 @@ const struct regmap_config bme680_regmap_config = {
>  };
>  EXPORT_SYMBOL(bme680_regmap_config);
>  
> +static const struct iio_chan_spec bme680_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_PRESSURE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +};
> +
> +static const int bme680_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> +
> +/* TODO: read calibration parameters from the sensor's NVM */
> +static int bme680_read_calib(struct bme680_data *data,
> +			     struct bme680_calib *calib)
> +{
> +	memset(calib, 0, sizeof(*calib));
> +	return 0;
> +}
> +
> +/* TODO: compensate raw temp readings using temp calibration parameters */
> +static s16 bme680_compensate_temp(struct bme680_data *data,
> +				  s32 adc_temp)
> +{
> +	return adc_temp;
> +}
> +
> +/* TODO: compensate raw press readings using press calibration parameters */
> +static u32 bme680_compensate_press(struct bme680_data *data,
> +				   u32 adc_press)
> +{
> +	return adc_press;
> +}
> +
> +/* TODO: compensate raw humid readings using humid calibration parameters */
> +static u32 bme680_compensate_humid(struct bme680_data *data,
> +				   u16 adc_humid)
> +{
> +	return adc_humid;
> +}
> +
> +static int bme680_read_temp(struct bme680_data *data,
> +			    int *val)
> +{
> +	int ret;
> +	__be32 tmp = 0;
> +	u32 adc_temp;
> +	s16 comp_temp;
> +
> +	/* Set Forced Mode & sampling rate before reading raw data */
> +	ret = data->chip_info->chip_config(data);
> +	if (ret < 0) {
> +		dev_err(data->dev,
> +			"failed to set chip config %s\n", __func__);
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
> +				(u8 *) &tmp, 3);
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read temperature\n");
> +		return ret;
> +	}
> +
> +	adc_temp = be32_to_cpu(tmp) >> 12;
> +	if (adc_temp == BME680_MEAS_SKIPPED) {
> +		/* reading was skipped */
> +		dev_err(data->dev, "reading temperature skipped\n");
> +		return -EIO;
> +	}
> +	comp_temp = bme680_compensate_temp(data, adc_temp);
> +
> +	*val = comp_temp;
> +	return IIO_VAL_INT;
> +
> +	return 0;

Novel bit of C.  Please check carefully, even on RFCs.

> +}
> +
> +static int bme680_read_press(struct bme680_data *data,
> +			     int *val)
> +{
> +	int ret;
> +	__be32 tmp = 0;
> +	u32 comp_press, adc_press;
> +
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_PRESS_MSB,
> +				(u8 *) &tmp, 3);
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read pressure\n");
> +		return ret;
> +	}
> +
> +	adc_press = be32_to_cpu(tmp) >> 12;
> +	if (adc_press == BME680_MEAS_SKIPPED) {
> +		/* reading was skipped */
> +		dev_err(data->dev, "reading pressure skipped\n");

I've not looked at the datasheet, but given the device is doing this
deliberately I'm not sure EIO is the right error to use.
It doesn't reflect a hardware IO issue...

> +		return -EIO;
> +	}
> +	comp_press = bme680_compensate_press(data, adc_press);
> +
> +	*val = comp_press;
> +	return IIO_VAL_INT;
> +}
> +
> +static int bme680_read_humid(struct bme680_data *data,
> +			     int *val)
> +{
> +	int ret;
> +	__be16 tmp = 0;
> +	u16 adc_humidity;
> +	u32 comp_humidity;
> +
> +	ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
> +				(u8 *) &tmp, 2);
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read humidity\n");
> +		return ret;
> +	}
> +
> +	adc_humidity = be16_to_cpu(tmp);
> +	if (adc_humidity == BME680_MEAS_SKIPPED) {
> +		/* reading was skipped */
> +		dev_err(data->dev, "reading humidity skipped\n");
> +		return -EIO;
> +	}
> +	comp_humidity = bme680_compensate_humid(data, adc_humidity);
> +
> +	*val = comp_humidity;

blank line before a simple return like this at the end of a function
tends to help readability (ever so slightly!)

> +	return IIO_VAL_INT;
> +}
> +
> +static int bme680_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	int ret = 0;

As below, direct returns are easier to follow during review
so are generally preferred in the kernel.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			ret = data->chip_info->read_temp(data, val);
> +			break;
> +		case IIO_PRESSURE:
> +			ret = data->chip_info->read_press(data, val);
> +			break;
> +		case IIO_HUMIDITYRELATIVE:
> +			ret = data->chip_info->read_humid(data, val);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = 1 << data->oversampling_temp;
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_PRESSURE:
> +			*val = 1 << data->oversampling_press;
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = 1 << data->oversampling_humid;
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int bme680_write_oversampling_ratio_temp(struct bme680_data *data,
> +						int val)
> +{
> +	const int *avail = data->chip_info->oversampling_temp_avail;
> +	const int n = data->chip_info->num_oversampling_temp_avail;
> +	int i;
> +
> +	for (i = 0; i < n; ++i) {
> +		if (avail[i] == val) {
> +			data->oversampling_temp = ilog2(val);
> +
> +			return data->chip_info->chip_config(data);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bme680_write_oversampling_ratio_press(struct bme680_data *data,
> +						 int val)
> +{
> +	const int *avail = data->chip_info->oversampling_press_avail;
> +	const int n = data->chip_info->num_oversampling_press_avail;
> +	int i;
> +
> +	for (i = 0; i < n; ++i) {
> +		if (avail[i] == val) {
> +			data->oversampling_press = ilog2(val);
> +
> +			return data->chip_info->chip_config(data);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bme680_write_oversampling_ratio_humid(struct bme680_data *data,
> +						 int val)
> +{
> +	const int *avail = data->chip_info->oversampling_humid_avail;
> +	const int n = data->chip_info->num_oversampling_humid_avail;
> +	int i;
> +
> +	for (i = 0; i < n; ++i) {
> +		if (avail[i] == val) {
> +			data->oversampling_humid = ilog2(val);
> +
> +		return data->chip_info->chip_config(data);

Could be my email messing up for some reason (I'm not on my usual system0
but superficially looks like a code indenting issue here.

> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bme680_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	int ret = 0;

Put a default in the outer switch and return -EINVAL (not 0)
as it should be an error if the switch doesn't match.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			ret = bme680_write_oversampling_ratio_temp(data, val);
return bme...
> +			break;
> +		case IIO_PRESSURE:
> +			ret = bme680_write_oversampling_ratio_press(data, val);
> +			break;
> +		case IIO_HUMIDITYRELATIVE:
> +			ret = bme680_write_oversampling_ratio_humid(data, val);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
> +
> +	return ret;

Direct returns always preferred (as when following code flow during review
you don't have to check below the switch only to find that nothing is done.

> +}
> +
> +static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
> +
> +static IIO_CONST_ATTR(oversampling_ratio_available,
> +			bme680_oversampling_ratio_show);
> +
> +static struct attribute *bme680_attributes[] = {
> +	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bme680_attribute_group = {
> +	.attrs = bme680_attributes,
> +};
> +
>  static const struct iio_info bme680_info = {
> +	.read_raw = &bme680_read_raw,
> +	.write_raw = &bme680_write_raw,
> +	.attrs = &bme680_attribute_group,
>  };
>  
> +static int bme680_chip_config(struct bme680_data *data)
> +{
> +	int ret;
> +	u8 osrs = BME680_OSRS_HUMID_X(data->oversampling_humid + 1);
> +
> +	/*
> +	 * Highly recommended to set oversampling of humidity before
> +	 * temperature/pressure oversampling.
> +	 */
> +	ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_HUMIDITY,
> +				 BME680_OSRS_HUMIDITY_MASK, osrs);
> +
Typically don't put a blank line between a function call and the
error handling that follows it.
> +	if (ret < 0) {
> +		dev_err(data->dev,
> +			"failed to write Ctrl_hum register\n");
> +		return ret;
> +	}

A blank line after the error handling makes the code flow slightly
more visible and hence improves readability.

> +	osrs = BME680_OSRS_TEMP_X(data->oversampling_temp + 1) |
> +		  BME680_OSRS_PRESS_X(data->oversampling_press + 1);
> +
> +	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +				BME680_OSRS_TEMP_MASK |
> +				BME680_OSRS_PRESS_MASK |
> +				BME680_MODE_MASK,
> +				osrs | BME680_MODE_FORCED);
> +	if (ret < 0) {
> +		dev_err(data->dev,
> +			"failed to write Ctrl_meas register\n");
> +		return ret;
> +	}
> +
> +	/* IIR filter settings */

Blank line here doesn't add anything as this comment refers
to the next block.

> +
> +	ret = regmap_update_bits(data->regmap, BME680_REG_CONFIG,
> +				 BME680_FILTER_MASK,
> +				 BME680_FILTER_4X);
> +
> +	if (ret < 0) {
> +		dev_err(data->dev,
> +			"failed to write Config register\n");
> +		return ret;

Drop this return out of the conditional.  One of the static checkers
picks up on this, so you'd only get an irritating email if you don't 
'fix' it now ;)

> +	}
> +
> +	return ret;
> +}
> +
>  static int bme680_chip_init(struct bme680_data *data, bool use_spi)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
> @@ -33,15 +421,15 @@ static int bme680_chip_init(struct bme680_data *data, bool use_spi)
>  	int ret;
>  
>  	/* Power on Soft Reset */
> -	ret = regmap_write(data->regmap, BME680_SOFT_RESET, BME680_CMD_SOFTRESET);
> +	ret = regmap_write(data->regmap, BME680_SOFT_RESET,
> +			   BME680_CMD_SOFTRESET);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!use_spi) {

This should have been fixed in patch 1.  The version you present to the list
should be clean.  We aren't really interested in seeing, what I guess is,
cleanup that you happened to see whilst doing this patch.


> +	if (!use_spi)
>  		ret = regmap_read(data->regmap, BME680_REG_CHIP_I2C_ID, &val);
> -	} else {
> +	else
>  		ret = regmap_read(data->regmap, BME680_REG_CHIP_SPI_ID, &val);
> -	}
>  
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading chip ID\n");
> @@ -57,6 +445,22 @@ static int bme680_chip_init(struct bme680_data *data, bool use_spi)
>  	return 0;
>  }
>  
> +static const struct bme680_chip_info bme680_chip_info = {
> +	.oversampling_temp_avail = bme680_oversampling_avail,
> +	.num_oversampling_temp_avail = ARRAY_SIZE(bme680_oversampling_avail),
> +
> +	.oversampling_press_avail = bme680_oversampling_avail,
> +	.num_oversampling_press_avail = ARRAY_SIZE(bme680_oversampling_avail),
> +
> +	.oversampling_humid_avail = bme680_oversampling_avail,
> +	.num_oversampling_press_avail = ARRAY_SIZE(bme680_oversampling_avail),
> +
> +	.chip_config = bme680_chip_config,
> +	.read_temp = bme680_read_temp,
> +	.read_press = bme680_read_press,
> +	.read_humid = bme680_read_humid,

Why this abstraction via callbacks?  This drive is currently only targeting on device.
Given it's going to be at least a while before it covers any other parts, don't put
this here.   The only thing such an abstraction does is make the code harder to review.

> +};
> +
>  int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  		      const char *name, bool use_spi)
>  {
> @@ -78,11 +482,33 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->name = name;
> +	indio_dev->channels = bme680_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(bme680_channels);
>  	indio_dev->info = &bme680_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	data->chip_info = &bme680_chip_info;
> +	data->oversampling_humid = ilog2(16);
> +	data->oversampling_press = ilog2(16);
> +	data->oversampling_temp = ilog2(2);
> +
> +	ret = data->chip_info->chip_config(data);
> +	if (ret < 0) {
> +		dev_err(data->dev,
> +			"failed to set chip_config data\n");
> +		return ret;
> +	}

Nitpick : A blank line here would be good.

> +	ret = bme680_read_calib(data, &data->bme680);
> +	if (ret < 0) {
> +		dev_err(data->dev,
> +			"failed to read calibration coefficients\n");
> +		return ret;
> +	}
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		return ret;
> +

Please 'scrub' the patches for any unconnected changes like this white space change.
They add noise for no gain so are generally a bad idea.

>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bme680_core_probe);
