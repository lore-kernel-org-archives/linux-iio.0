Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbDZTvp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 15:51:45 -0400
Message-ID: <553D41CC.6070702@kernel.org>
Date: Sun, 26 Apr 2015 20:51:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH v2 3/3] staging: iio: light: isl29018: Use standard sysfs
 attributes for scale and integration time
References: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com> <1429212059-13010-4-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1429212059-13010-4-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/04/15 20:20, Roberta Dobrescu wrote:
> This patch refactors the isl29018 driver code in order to use standard
> sysfs attributes for scale and integration time.
> 
> ISL29018 light sensor uses four ranges and four ADC's resolutions
> which influence the calculated lux. Adc resolution is strongly
> connected to integration time and range should be controlled by scale.
> 
> This patch introduces the usage of integration time and scale instead
> of adc resolution and range.
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Looks good to me,  Applied to the togreg branch of iio.git - initially pushed out
as testing.

cc'd Rhyland though not heard from him for quite a while.

Rhyland, if you are still interested in this driver, give me a shout and I can
hold these patches back until you get a chance to look at them.

Sorry, forgot to cc you earlier in the discussion!

Jonathan

> ---
>  drivers/staging/iio/light/isl29018.c | 224 +++++++++++++++++++++++++++--------
>  1 file changed, 175 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index ffc3d1b..435d417 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -66,6 +66,39 @@
>  #define ISL29035_BOUT_SHIFT		0x07
>  #define ISL29035_BOUT_MASK		(0x01 << ISL29035_BOUT_SHIFT)
>  
> +#define ISL29018_INT_TIME_AVAIL		"0.090000 0.005630 0.000351 0.000021"
> +#define ISL29023_INT_TIME_AVAIL		"0.090000 0.005600 0.000352 0.000022"
> +#define ISL29035_INT_TIME_AVAIL		"0.105000 0.006500 0.000410 0.000025"
> +
> +static const char * const int_time_avail[] = {
> +	ISL29018_INT_TIME_AVAIL,
> +	ISL29023_INT_TIME_AVAIL,
> +	ISL29035_INT_TIME_AVAIL,
> +};
> +
> +enum isl29018_int_time {
> +	ISL29018_INT_TIME_16,
> +	ISL29018_INT_TIME_12,
> +	ISL29018_INT_TIME_8,
> +	ISL29018_INT_TIME_4,
> +};
> +
> +static const unsigned int isl29018_int_utimes[3][4] = {
> +	{90000, 5630, 351, 21},
> +	{90000, 5600, 352, 22},
> +	{105000, 6500, 410, 25},
> +};
> +
> +static const struct isl29018_scale {
> +	unsigned int scale;
> +	unsigned int uscale;
> +} isl29018_scales[4][4] = {
> +	{ {0, 15258}, {0, 61035}, {0, 244140}, {0, 976562} },
> +	{ {0, 244140}, {0, 976562}, {3, 906250}, {15, 625000} },
> +	{ {3, 906250}, {15, 625000}, {62, 500000}, {250, 0} },
> +	{ {62, 500000}, {250, 0}, {1000, 0}, {4000, 0} }
> +};
> +
>  struct isl29018_chip {
>  	struct device		*dev;
>  	struct regmap		*regmap;
> @@ -73,51 +106,75 @@ struct isl29018_chip {
>  	int			type;
>  	unsigned int		calibscale;
>  	unsigned int		ucalibscale;
> -	unsigned int		range;
> -	unsigned int		adc_bit;
> +	unsigned int		int_time;
> +	struct isl29018_scale	scale;
>  	int			prox_scheme;
>  	bool			suspended;
>  };
>  
> -static int isl29018_set_range(struct isl29018_chip *chip, unsigned long range,
> -		unsigned int *new_range)
> +static int isl29018_set_integration_time(struct isl29018_chip *chip,
> +					 unsigned int utime)
>  {
> -	static const unsigned long supp_ranges[] = {1000, 4000, 16000, 64000};
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(supp_ranges); ++i) {
> -		if (range <= supp_ranges[i]) {
> -			*new_range = (unsigned int)supp_ranges[i];
> +	int i, ret;
> +	unsigned int int_time, new_int_time;
> +	struct isl29018_scale new_scale;
> +
> +	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i) {
> +		if (utime == isl29018_int_utimes[chip->type][i]) {
> +			new_int_time = i;
> +			new_scale = isl29018_scales[new_int_time][0];
>  			break;
>  		}
>  	}
>  
> -	if (i >= ARRAY_SIZE(supp_ranges))
> +	if (i >= ARRAY_SIZE(isl29018_int_utimes[chip->type]))
>  		return -EINVAL;
>  
> -	return regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
> -			COMMANDII_RANGE_MASK, i << COMMANDII_RANGE_SHIFT);
> +	ret = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
> +				 COMMANDII_RESOLUTION_MASK,
> +				 i << COMMANDII_RESOLUTION_SHIFT);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* keep the same range when integration time changes */
> +	int_time = chip->int_time;
> +	for (i = 0; i < ARRAY_SIZE(isl29018_scales[int_time]); ++i) {
> +		if (chip->scale.scale == isl29018_scales[int_time][i].scale &&
> +		    chip->scale.uscale == isl29018_scales[int_time][i].uscale) {
> +			chip->scale = isl29018_scales[new_int_time][i];
> +			break;
> +		}
> +	}
> +	chip->int_time = new_int_time;
> +
> +	return 0;
>  }
>  
> -static int isl29018_set_resolution(struct isl29018_chip *chip,
> -			unsigned long adcbit, unsigned int *conf_adc_bit)
> +static int isl29018_set_scale(struct isl29018_chip *chip, int scale, int uscale)
>  {
> -	static const unsigned long supp_adcbit[] = {16, 12, 8, 4};
> -	int i;
> +	int i, ret;
> +	struct isl29018_scale new_scale;
>  
> -	for (i = 0; i < ARRAY_SIZE(supp_adcbit); ++i) {
> -		if (adcbit >= supp_adcbit[i]) {
> -			*conf_adc_bit = (unsigned int)supp_adcbit[i];
> +	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i) {
> +		if (scale == isl29018_scales[chip->int_time][i].scale &&
> +		    uscale == isl29018_scales[chip->int_time][i].uscale) {
> +			new_scale = isl29018_scales[chip->int_time][i];
>  			break;
>  		}
>  	}
>  
> -	if (i >= ARRAY_SIZE(supp_adcbit))
> +	if (i >= ARRAY_SIZE(isl29018_scales[chip->int_time]))
>  		return -EINVAL;
>  
> -	return regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
> -			COMMANDII_RESOLUTION_MASK,
> -			i << COMMANDII_RESOLUTION_SHIFT);
> +	ret = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
> +				 COMMANDII_RANGE_MASK,
> +				 i << COMMANDII_RANGE_SHIFT);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->scale = new_scale;
> +
> +	return 0;
>  }
>  
>  static int isl29018_read_sensor_input(struct isl29018_chip *chip, int mode)
> @@ -156,22 +213,17 @@ static int isl29018_read_sensor_input(struct isl29018_chip *chip, int mode)
>  static int isl29018_read_lux(struct isl29018_chip *chip, int *lux)
>  {
>  	int lux_data;
> -	unsigned int data_x_range, lux_unshifted;
> +	unsigned int data_x_range;
>  
>  	lux_data = isl29018_read_sensor_input(chip, COMMMAND1_OPMODE_ALS_ONCE);
>  
>  	if (lux_data < 0)
>  		return lux_data;
>  
> -	/* To support fractional scaling, separate the unshifted lux
> -	 * into two calculations: int scaling and micro-scaling.
> -	 * ucalibscale ranges from 0-999999, so about 20 bits.  Split
> -	 * the /1,000,000 in two to reduce the risk of over/underflow.
> -	 */
> -	data_x_range = lux_data * chip->range;
> -	lux_unshifted = data_x_range * chip->calibscale;
> -	lux_unshifted += data_x_range / 1000 * chip->ucalibscale / 1000;
> -	*lux = lux_unshifted >> chip->adc_bit;
> +	data_x_range = lux_data * chip->scale.scale +
> +		       lux_data * chip->scale.uscale / 1000000;
> +	*lux = data_x_range * chip->calibscale +
> +	       data_x_range * chip->ucalibscale / 1000000;
>  
>  	return 0;
>  }
> @@ -229,7 +281,39 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
>  	return 0;
>  }
>  
> -/* Sysfs interface */
> +static ssize_t show_scale_available(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct isl29018_chip *chip = iio_priv(indio_dev);
> +	int i, len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i)
> +		len += sprintf(buf + len, "%d.%06d ",
> +			       isl29018_scales[chip->int_time][i].scale,
> +			       isl29018_scales[chip->int_time][i].uscale);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t show_int_time_available(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct isl29018_chip *chip = iio_priv(indio_dev);
> +	int i, len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i)
> +		len += sprintf(buf + len, "0.%06d ",
> +			       isl29018_int_utimes[chip->type][i]);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
>  /* proximity scheme */
>  static ssize_t show_prox_infrared_suppression(struct device *dev,
>  			struct device_attribute *attr, char *buf)
> @@ -276,11 +360,26 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
>  	int ret = -EINVAL;
>  
>  	mutex_lock(&chip->lock);
> -	if (mask == IIO_CHAN_INFO_CALIBSCALE && chan->type == IIO_LIGHT) {
> -		chip->calibscale = val;
> -		/* With no write_raw_get_fmt(), val2 is a MICRO fraction. */
> -		chip->ucalibscale = val2;
> -		ret = 0;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (chan->type == IIO_LIGHT) {
> +			chip->calibscale = val;
> +			chip->ucalibscale = val2;
> +			ret = 0;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (chan->type == IIO_LIGHT)
> +			if (val != 0)
> +				return -EINVAL;
> +			ret = isl29018_set_integration_time(chip, val2);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_LIGHT)
> +			ret = isl29018_set_scale(chip, val, val2);
> +		break;
> +	default:
> +		break;
>  	}
>  	mutex_unlock(&chip->lock);
>  
> @@ -321,6 +420,20 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
>  		if (!ret)
>  			ret = IIO_VAL_INT;
>  		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (chan->type == IIO_LIGHT) {
> +			*val = 0;
> +			*val2 = isl29018_int_utimes[chip->type][chip->int_time];
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_LIGHT) {
> +			*val = chip->scale.scale;
> +			*val2 = chip->scale.uscale;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		if (chan->type == IIO_LIGHT) {
>  			*val = chip->calibscale;
> @@ -340,7 +453,9 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
>  	.indexed = 1,							\
>  	.channel = 0,							\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |		\
> -	BIT(IIO_CHAN_INFO_CALIBSCALE),					\
> +	BIT(IIO_CHAN_INFO_CALIBSCALE) |					\
> +	BIT(IIO_CHAN_INFO_SCALE) |					\
> +	BIT(IIO_CHAN_INFO_INT_TIME),					\
>  }
>  
>  #define ISL29018_IR_CHANNEL {						\
> @@ -366,19 +481,27 @@ static const struct iio_chan_spec isl29023_channels[] = {
>  	ISL29018_IR_CHANNEL,
>  };
>  
> +static IIO_DEVICE_ATTR(in_illuminance_integration_time_available, S_IRUGO,
> +		       show_int_time_available, NULL, 0);
> +static IIO_DEVICE_ATTR(in_illuminance_scale_available, S_IRUGO,
> +		      show_scale_available, NULL, 0);
>  static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_suppression,
>  					S_IRUGO | S_IWUSR,
>  					show_prox_infrared_suppression,
>  					store_prox_infrared_suppression, 0);
>  
>  #define ISL29018_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
> -#define ISL29018_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
> +
>  static struct attribute *isl29018_attributes[] = {
> +	ISL29018_DEV_ATTR(in_illuminance_scale_available),
> +	ISL29018_DEV_ATTR(in_illuminance_integration_time_available),
>  	ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_suppression),
>  	NULL
>  };
>  
>  static struct attribute *isl29023_attributes[] = {
> +	ISL29018_DEV_ATTR(in_illuminance_scale_available),
> +	ISL29018_DEV_ATTR(in_illuminance_integration_time_available),
>  	NULL
>  };
>  
> @@ -422,8 +545,6 @@ enum {
>  static int isl29018_chip_init(struct isl29018_chip *chip)
>  {
>  	int status;
> -	unsigned int new_adc_bit;
> -	unsigned int new_range;
>  
>  	if (chip->type == isl29035) {
>  		status = isl29035_detect(chip);
> @@ -472,14 +593,19 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
>  	usleep_range(1000, 2000);	/* per data sheet, page 10 */
>  
>  	/* set defaults */
> -	status = isl29018_set_range(chip, chip->range, &new_range);
> +	status = isl29018_set_scale(chip, chip->scale.scale,
> +				    chip->scale.uscale);
>  	if (status < 0) {
>  		dev_err(chip->dev, "Init of isl29018 fails\n");
>  		return status;
>  	}
>  
> -	status = isl29018_set_resolution(chip, chip->adc_bit,
> -						&new_adc_bit);
> +	status = isl29018_set_integration_time(chip,
> +			isl29018_int_utimes[chip->type][chip->int_time]);
> +	if (status < 0) {
> +		dev_err(chip->dev, "Init of isl29018 fails\n");
> +		return status;
> +	}
>  
>  	return 0;
>  }
> @@ -609,8 +735,8 @@ static int isl29018_probe(struct i2c_client *client,
>  	chip->type = dev_id;
>  	chip->calibscale = 1;
>  	chip->ucalibscale = 0;
> -	chip->range = 1000;
> -	chip->adc_bit = 16;
> +	chip->int_time = ISL29018_INT_TIME_16;
> +	chip->scale = isl29018_scales[chip->int_time][0];
>  	chip->suspended = false;
>  
>  	chip->regmap = devm_regmap_init_i2c(client,
> 

