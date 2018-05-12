Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbeELLUe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 07:20:34 -0400
Date: Sat, 12 May 2018 12:20:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v3 5/9] staging: iio: tsl2x7x: convert to use read_avail
Message-ID: <20180512122028.31205986@archlinux>
In-Reply-To: <20180511001223.12378-6-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
        <20180511001223.12378-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 May 2018 20:12:19 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Make the sysfs attributes in_proximity0_calibscale_available, and
> in_intensity0_{calibscale,integration_time}_available be created
> using info_mask_separate_available on the channel configuration.
> 
> The driver assumed that the ALS increment was 2.72 ms, and the upper
> range was 696 ms. Some other supported devices use 2.73 ms - 699 ms.
> This patch adds support for the multiple ranges.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Nice thank you.

Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 93 ++++++++++++++++++++++++++++++-------
>  1 file changed, 76 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 51c1a90cb592..2d713d3c7c7b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -209,9 +209,9 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
>  };
>  
>  static const struct tsl2x7x_settings tsl2x7x_default_settings = {
> -	.als_time = 255, /* 2.73 ms */
> +	.als_time = 255, /* 2.72 / 2.73 ms */
>  	.als_gain = 0,
> -	.prox_time = 255, /* 2.73 ms */
> +	.prox_time = 255, /* 2.72 / 2.73 ms */
>  	.prox_gain = 0,
>  	.wait_time = 255,
>  	.als_prox_config = 0,
> @@ -245,6 +245,23 @@ static const s16 tsl2x7x_prox_gain[] = {
>  	8
>  };
>  
> +static const int tsl2x7x_int_time_avail[][6] = {
> +	[tsl2571] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tsl2671] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tmd2671] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tsl2771] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tmd2771] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tsl2572] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[tsl2672] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[tmd2672] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[tsl2772] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[tmd2772] = { 0, 2730, 0, 2730, 0, 699000 },
> +};
> +
> +static int tsl2x7x_int_calibscale_avail[] = { 1, 8, 16, 120 };
> +
> +static int tsl2x7x_prox_calibscale_avail[] = { 1, 2, 4, 8 };
> +
>  /* Channel variations */
>  enum {
>  	ALS,
> @@ -626,7 +643,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  
>  	/* set chip time scaling and saturation */
>  	als_count = 256 - chip->settings.als_time;
> -	als_time_us = als_count * 2720;
> +	als_time_us = als_count * tsl2x7x_int_time_avail[chip->id][3];
>  	chip->als_saturation = als_count * 768; /* 75% of full scale */
>  	chip->als_gain_time_scale = als_time_us *
>  		tsl2x7x_als_gain[chip->settings.als_gain];
> @@ -760,12 +777,33 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
> -static IIO_CONST_ATTR(in_intensity0_calibscale_available, "1 8 16 120");
> +static int tsl2x7x_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  
> -static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (chan->type == IIO_INTENSITY) {
> +			*length = ARRAY_SIZE(tsl2x7x_int_calibscale_avail);
> +			*vals = tsl2x7x_int_calibscale_avail;
> +		} else {
> +			*length = ARRAY_SIZE(tsl2x7x_prox_calibscale_avail);
> +			*vals = tsl2x7x_prox_calibscale_avail;
> +		}
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(tsl2x7x_int_time_avail[chip->id]);
> +		*vals = tsl2x7x_int_time_avail[chip->id];
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_RANGE;
> +	}
>  
> -static IIO_CONST_ATTR(in_intensity0_integration_time_available,
> -		".00272 - .696");
> +	return -EINVAL;
> +}
>  
>  static ssize_t in_illuminance0_target_input_show(struct device *dev,
>  						 struct device_attribute *attr,
> @@ -1110,7 +1148,8 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		*val = 0;
> -		*val2 = (256 - chip->settings.als_time) * 2720;
> +		*val2 = (256 - chip->settings.als_time) *
> +			tsl2x7x_int_time_avail[chip->id][3];
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
> @@ -1167,7 +1206,8 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		chip->settings.als_gain_trim = val;
>  		break;
>  	case IIO_CHAN_INFO_INT_TIME:
> -		chip->settings.als_time = 256 - (val2 / 2720);
> +		chip->settings.als_time = 256 -
> +			(val2 / tsl2x7x_int_time_avail[chip->id][3]);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1248,8 +1288,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  }
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> -	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1262,8 +1300,6 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> -	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1272,18 +1308,14 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
>  
>  static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
>  	&dev_attr_in_proximity0_calibrate.attr,
> -	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
>  	NULL
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> -	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
>  	&dev_attr_in_proximity0_calibrate.attr,
> -	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -1309,6 +1341,7 @@ static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
>  	{ \
>  		.attrs = &tsl2X7X_device_attr_group_tbl[type], \
>  		.read_raw = &tsl2x7x_read_raw, \
> +		.read_avail = &tsl2x7x_read_avail, \
>  		.write_raw = &tsl2x7x_write_raw, \
>  		.read_event_value = &tsl2x7x_read_event_value, \
>  		.write_event_value = &tsl2x7x_write_event_value, \
> @@ -1357,6 +1390,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1379,6 +1415,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1425,6 +1464,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1455,6 +1497,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1478,6 +1523,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
> @@ -1489,6 +1536,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			},
>  		},
>  		.chan_table_elements = 1,
> @@ -1509,6 +1558,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1522,6 +1574,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
> @@ -1540,6 +1594,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1551,6 +1608,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			},
>  		},
>  		.chan_table_elements = 4,

