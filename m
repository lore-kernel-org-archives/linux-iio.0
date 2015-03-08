Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35133 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbCHLue (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 07:50:34 -0400
Message-ID: <54FC3786.5000000@kernel.org>
Date: Sun, 08 Mar 2015 11:50:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 4/4] staging: iio: light: isl29018: Use standard sysfs
 attributes for range and scale
References: <1424720154-4762-1-git-send-email-roberta.dobrescu@gmail.com> <1424720154-4762-5-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424720154-4762-5-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/02/15 19:35, Roberta Dobrescu wrote:
> This patch refactors the isl29018 driver code in order to use standard
> sysfs attributes for range and scale.
> 
> ISL29018 light sensor uses four ranges and four ADC's resolutions
> which influence the calculated lux.
> 
> This patch eliminates the resolution (adc bits) and introduces scale.
> Each range (1k, 4k, 16k or 64k) has a corresponding set of 4 scales
> (for 16, 12, 8 or 4 bits). Both range and scale can be changed by the
> user according to the corresponding set of values (exposed by the attributes
> in_illuminance_range_available and in_illuminance_scale_available).
> 
> When the range is changed, the set of available scales is set accordingly and
> by default the scale used is the one for 16 adc bits. Scale can be changed
> anytime with one of the available values.
So we have 3 things interacting here.

range - absolutely controlled for the device
scale - from current range, with the adc resolution confusing things - we could just
        multiply the output result up and not need to report this to userspace at all
integration_time - This is the one element that's really being controlled by the adc
                   resolution. This adc resolution is really effecting our sensitivity
                   not the accuracy of measurement of the signal.

Hence I'd have your adc resolution controlled by in_illuminance0_integration_time
and the full scale range controlled by scale.

For the lower adc resolutions simply apply the relevant scaling to get the output
value to be on the same scale (assuming the range has not changed)

How does that sound?

Jonathan
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> ---
>  drivers/staging/iio/light/isl29018.c | 167 ++++++++++++++++++++++++++---------
>  1 file changed, 124 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index ffc3d1b..1a91483 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -66,6 +66,25 @@
>  #define ISL29035_BOUT_SHIFT		0x07
>  #define ISL29035_BOUT_MASK		(0x01 << ISL29035_BOUT_SHIFT)
>  
> +enum isl29018_range {
> +	ISL29018_RANGE_1,
> +	ISL29018_RANGE_2,
> +	ISL29018_RANGE_3,
> +	ISL29018_RANGE_4,
> +};
> +
> +static const unsigned long isl29018_ranges[] = {1000, 4000, 16000, 64000};
> +
> +static const struct isl29018_scale {
> +	unsigned int scale;
> +	unsigned int uscale;
> +} isl29018_scales[4][4] = {
> +		{ {0, 15258}, {0, 244140}, {3, 906250}, {62, 500000} },
> +		{ {0, 61035}, {0, 976562}, {15, 625000}, {250, 0} },
> +		{ {0, 244140}, {3, 906250}, {62, 500000}, {1000, 0} },
> +		{ {0, 976562}, {15, 625000}, {250, 0}, {4000, 0} }
> +		};
> +
>  struct isl29018_chip {
>  	struct device		*dev;
>  	struct regmap		*regmap;
> @@ -74,50 +93,66 @@ struct isl29018_chip {
>  	unsigned int		calibscale;
>  	unsigned int		ucalibscale;
>  	unsigned int		range;
> -	unsigned int		adc_bit;
> +	struct isl29018_scale scale;
>  	int			prox_scheme;
>  	bool			suspended;
>  };
>  
> -static int isl29018_set_range(struct isl29018_chip *chip, unsigned long range,
> -		unsigned int *new_range)
> +/* when range is set, resolution is set by default at 16 bits */
> +static int isl29018_set_range(struct isl29018_chip *chip, unsigned long range)
>  {
> -	static const unsigned long supp_ranges[] = {1000, 4000, 16000, 64000};
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(supp_ranges); ++i) {
> -		if (range <= supp_ranges[i]) {
> -			*new_range = (unsigned int)supp_ranges[i];
> +	int i, ret;
> +	unsigned long new_range;
> +	struct isl29018_scale new_scale;
> +
> +	for (i = 0; i < ARRAY_SIZE(isl29018_ranges); ++i) {
> +		if (range == isl29018_ranges[i]) {
> +			new_range = i;
> +			new_scale = isl29018_scales[i][0];
>  			break;
>  		}
>  	}
>  
> -	if (i >= ARRAY_SIZE(supp_ranges))
> +	if (i >= ARRAY_SIZE(isl29018_ranges))
>  		return -EINVAL;
>  
> -	return regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
> -			COMMANDII_RANGE_MASK, i << COMMANDII_RANGE_SHIFT);
> +	ret = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
> +							 COMMANDII_RESOLUTION_MASK | COMMANDII_RANGE_MASK,
> +							 i << COMMANDII_RANGE_SHIFT);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->range = new_range;
> +	chip->scale = new_scale;
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
> +	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->range]); ++i) {
> +		if (scale == isl29018_scales[chip->range][i].scale &&
> +			uscale == isl29018_scales[chip->range][i].uscale) {
> +			new_scale = isl29018_scales[chip->range][i];
>  			break;
>  		}
>  	}
>  
> -	if (i >= ARRAY_SIZE(supp_adcbit))
> +	if (i >= ARRAY_SIZE(isl29018_scales[chip->range]))
>  		return -EINVAL;
>  
> -	return regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
> -			COMMANDII_RESOLUTION_MASK,
> -			i << COMMANDII_RESOLUTION_SHIFT);
> +	ret = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
> +							 COMMANDII_RESOLUTION_MASK,
> +							 i << COMMANDII_RESOLUTION_SHIFT);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->scale = new_scale;
> +
> +	return 0;
>  }
>  
>  static int isl29018_read_sensor_input(struct isl29018_chip *chip, int mode)
> @@ -156,7 +191,7 @@ static int isl29018_read_sensor_input(struct isl29018_chip *chip, int mode)
>  static int isl29018_read_lux(struct isl29018_chip *chip, int *lux)
>  {
>  	int lux_data;
> -	unsigned int data_x_range, lux_unshifted;
> +	unsigned int data_x_range;
>  
>  	lux_data = isl29018_read_sensor_input(chip, COMMMAND1_OPMODE_ALS_ONCE);
>  
> @@ -168,10 +203,11 @@ static int isl29018_read_lux(struct isl29018_chip *chip, int *lux)
>  	 * ucalibscale ranges from 0-999999, so about 20 bits.  Split
>  	 * the /1,000,000 in two to reduce the risk of over/underflow.
>  	 */
> -	data_x_range = lux_data * chip->range;
> -	lux_unshifted = data_x_range * chip->calibscale;
> -	lux_unshifted += data_x_range / 1000 * chip->ucalibscale / 1000;
> -	*lux = lux_unshifted >> chip->adc_bit;
> +	data_x_range = lux_data * chip->scale.scale;
> +	data_x_range += lux_data / 1000 * chip->scale.uscale / 1000;
> +	data_x_range *= chip->calibscale;
> +	data_x_range += data_x_range / 1000 * chip->ucalibscale / 1000;
> +	*lux = data_x_range;
>  
>  	return 0;
>  }
> @@ -229,7 +265,23 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
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
> +	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->range]); ++i)
> +		len += sprintf(buf + len, "%d.%06d ",
> +					   isl29018_scales[chip->range][i].scale,
> +					   isl29018_scales[chip->range][i].uscale);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
>  /* proximity scheme */
>  static ssize_t show_prox_infrared_suppression(struct device *dev,
>  			struct device_attribute *attr, char *buf)
> @@ -276,11 +328,24 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
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
> +	case IIO_CHAN_INFO_RANGE:
> +		if (chan->type == IIO_LIGHT)
> +			ret = isl29018_set_range(chip, val);
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
> @@ -321,6 +386,19 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
>  		if (!ret)
>  			ret = IIO_VAL_INT;
>  		break;
> +	case IIO_CHAN_INFO_RANGE:
> +		if (chan->type == IIO_LIGHT) {
> +			*val = isl29018_ranges[chip->range];
> +			ret = IIO_VAL_INT;
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
> @@ -340,7 +418,9 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
>  	.indexed = 1,							\
>  	.channel = 0,							\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |		\
> -	BIT(IIO_CHAN_INFO_CALIBSCALE),					\
> +	BIT(IIO_CHAN_INFO_CALIBSCALE) |				\
> +	BIT(IIO_CHAN_INFO_SCALE) |				\
> +	BIT(IIO_CHAN_INFO_RANGE),					\
>  }
>  
>  #define ISL29018_IR_CHANNEL {						\
> @@ -366,6 +446,9 @@ static const struct iio_chan_spec isl29023_channels[] = {
>  	ISL29018_IR_CHANNEL,
>  };
>  
> +static IIO_DEVICE_ATTR(in_illuminance_scale_available, S_IRUGO | S_IWUSR,
> +		show_scale_available, NULL, 0);
> +static IIO_CONST_ATTR(in_illuminance_range_available, "1000 4000 16000 64000");
>  static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_suppression,
>  					S_IRUGO | S_IWUSR,
>  					show_prox_infrared_suppression,
> @@ -374,11 +457,15 @@ static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_suppression,
>  #define ISL29018_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
>  #define ISL29018_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
>  static struct attribute *isl29018_attributes[] = {
> +	ISL29018_DEV_ATTR(in_illuminance_scale_available),
> +	ISL29018_CONST_ATTR(in_illuminance_range_available),
>  	ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_suppression),
>  	NULL
>  };
>  
>  static struct attribute *isl29023_attributes[] = {
> +	ISL29018_DEV_ATTR(in_illuminance_scale_available),
> +	ISL29018_CONST_ATTR(in_illuminance_range_available),
>  	NULL
>  };
>  
> @@ -422,8 +509,6 @@ enum {
>  static int isl29018_chip_init(struct isl29018_chip *chip)
>  {
>  	int status;
> -	unsigned int new_adc_bit;
> -	unsigned int new_range;
>  
>  	if (chip->type == isl29035) {
>  		status = isl29035_detect(chip);
> @@ -472,15 +557,12 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
>  	usleep_range(1000, 2000);	/* per data sheet, page 10 */
>  
>  	/* set defaults */
> -	status = isl29018_set_range(chip, chip->range, &new_range);
> +	status = isl29018_set_range(chip, isl29018_ranges[chip->range]);
>  	if (status < 0) {
>  		dev_err(chip->dev, "Init of isl29018 fails\n");
>  		return status;
>  	}
>  
> -	status = isl29018_set_resolution(chip, chip->adc_bit,
> -						&new_adc_bit);
> -
>  	return 0;
>  }
>  
> @@ -609,8 +691,7 @@ static int isl29018_probe(struct i2c_client *client,
>  	chip->type = dev_id;
>  	chip->calibscale = 1;
>  	chip->ucalibscale = 0;
> -	chip->range = 1000;
> -	chip->adc_bit = 16;
> +	chip->range = ISL29018_RANGE_1;
>  	chip->suspended = false;
>  
>  	chip->regmap = devm_regmap_init_i2c(client,
> 

