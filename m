Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53408 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbcAPMY2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 07:24:28 -0500
Subject: Re: [PATCH v5] iio: mma8452: add freefall detection for Freescale's
 accelerometers
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1452764917-15628-1-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A3677.20903@kernel.org>
Date: Sat, 16 Jan 2016 12:24:23 +0000
MIME-Version: 1.0
In-Reply-To: <1452764917-15628-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/01/16 09:48, Martin Kepplinger wrote:
> This adds freefall event detection to the supported devices. It adds
> the in_accel_x&y&z_mag_falling_en iio event attribute, which activates
> freefall mode.
> 
> In freefall mode, the current acceleration magnitude (AND combination
> of all axis values) is compared to the specified threshold.
> If it falls under the threshold (in_accel_mag_falling_value),
> the appropriate IIO event code is generated.
> 
> This is what the sysfs "events" directory for these devices looks
> like after this change:
> 
> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_period
> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_value
> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_period
> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_value
> -r--r--r--    4096 Oct 23 08:45 in_accel_scale
> -rw-r--r--    4096 Oct 23 08:45 in_accel_x&y&z_mag_falling_en
> -rw-r--r--    4096 Oct 23 08:45 in_accel_x_mag_rising_en
> -rw-r--r--    4096 Oct 23 08:45 in_accel_y_mag_rising_en
> -rw-r--r--    4096 Oct 23 08:45 in_accel_z_mag_rising_en
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Looking good.  A few bits inline. One case of what I think is an error return
on an attempt to turn off and event that is off.  We should aim for idempotent
writes on that so just silently say 'it's fine! instead.

Also one suggestion for a minor reorganization.

Jonathan
> ---
> revision history
> ----------------
> v1:
>         initial post
> v2:
>         build all from correct event and channel spec structs
> v3:
>         rising and falling are treated as equal now. Until last time, I had
>         misunderstood the iio events' user API definition. This works and
>         values always reflect the current state of operation.
> v4:
> 	fix error that caused a build warning
> v5:
> 	changes according to Peter's review
> 
> 
>  drivers/iio/accel/mma8452.c | 157 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 140 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index ccc632a..820a8a3 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -15,7 +15,7 @@
>   *
>   * 7-bit I2C slave address 0x1c/0x1d (pin selectable)
>   *
> - * TODO: orientation / freefall events, autosleep
> + * TODO: orientation events, autosleep
>   */
>  
>  #include <linux/module.h>
> @@ -416,6 +416,47 @@ fail:
>  	return ret;
>  }
>  
> +/* returns >0 if in freefall mode, 0 if not or <0 if an error occured */
> +static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
> +{
> +	int val;
> +	const struct mma_chip_info *chip = data->chip_info;
> +
> +	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
> +	if (val < 0)
> +		return val;
> +
> +	return !(val & MMA8452_FF_MT_CFG_OAE);
> +}
> +
> +static int mma8452_set_freefall_mode(struct mma8452_data *data, bool state)
> +{
> +	int val;
> +	const struct mma_chip_info *chip = data->chip_info;
> +
> +	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
> +	if (val < 0)
> +		return val;
> +
> +	if (state && !(mma8452_freefall_mode_enabled(data))) {
> +		val |= BIT(idx_x + chip->ev_cfg_chan_shift);
> +		val |= BIT(idx_y + chip->ev_cfg_chan_shift);
> +		val |= BIT(idx_z + chip->ev_cfg_chan_shift);
> +		val &= ~MMA8452_FF_MT_CFG_OAE;
> +	} else if (!state && mma8452_freefall_mode_enabled(data)) {
> +		val &= ~BIT(idx_x + chip->ev_cfg_chan_shift);
> +		val &= ~BIT(idx_y + chip->ev_cfg_chan_shift);
> +		val &= ~BIT(idx_z + chip->ev_cfg_chan_shift);
> +		val |= MMA8452_FF_MT_CFG_OAE;
> +	}
> +
I'd be tempted to sanity check right at the beginning for a lack of state
change and avoid the need to read the register then write it again with
the value you read from it.  I think it will also give you slightly cleaner
code.

> +	val = mma8452_change_config(data, chip->ev_cfg, val);
> +	if (val)
> +		return val;
> +
> +	return 0;
> +}
> +
>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>  					   int val, int val2)
>  {
> @@ -609,12 +650,22 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
>  	const struct mma_chip_info *chip = data->chip_info;
>  	int ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client,
> -				       data->chip_info->ev_cfg);
> -	if (ret < 0)
> -		return ret;
> +	switch (dir) {
> +	case IIO_EV_DIR_FALLING:
> +		return mma8452_freefall_mode_enabled(data);
> +	case IIO_EV_DIR_RISING:
> +		if (mma8452_freefall_mode_enabled(data))
> +			return 0;
> +
> +		ret = i2c_smbus_read_byte_data(data->client,
> +					       data->chip_info->ev_cfg);
> +		if (ret < 0)
> +			return ret;
>  
> -	return !!(ret & BIT(chan->scan_index + chip->ev_cfg_chan_shift));
> +		return !!(ret & BIT(chan->scan_index + chip->ev_cfg_chan_shift));
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static int mma8452_write_event_config(struct iio_dev *indio_dev,
> @@ -627,19 +678,34 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  	const struct mma_chip_info *chip = data->chip_info;
>  	int val;
>  
> -	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
> -	if (val < 0)
> -		return val;
> -
> -	if (state)
> -		val |= BIT(chan->scan_index + chip->ev_cfg_chan_shift);
> -	else
> -		val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
> +	switch (dir) {
> +	case IIO_EV_DIR_FALLING:
> +		return mma8452_set_freefall_mode(data, state);
> +	case IIO_EV_DIR_RISING:
> +		val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
> +		if (val < 0)
> +			return val;
> +
> +		if (state) {
> +			if (mma8452_freefall_mode_enabled(data)) {
> +				val &= ~BIT(idx_x + chip->ev_cfg_chan_shift);
> +				val &= ~BIT(idx_y + chip->ev_cfg_chan_shift);
> +				val &= ~BIT(idx_z + chip->ev_cfg_chan_shift);
> +				val |= MMA8452_FF_MT_CFG_OAE;
> +			}
> +			val |= BIT(chan->scan_index + chip->ev_cfg_chan_shift);
> +		} else {
> +			if (mma8452_freefall_mode_enabled(data))
> +				return -EBUSY;
This path has me a little confused.  An attempt was made to disable
an acceleration rising event when it wasn't enabled? (as we are in freefall
mode). I'd return 0 for that - it's pointless but not technically wrong
(can see userspace missorderings leading to this)
so shouldn't really be an error to my mind.

> +			val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
> +		}
>  
> -	val |= chip->ev_cfg_ele;
> -	val |= MMA8452_FF_MT_CFG_OAE;
> +		val |= chip->ev_cfg_ele;
>  
> -	return mma8452_change_config(data, chip->ev_cfg, val);
> +		return mma8452_change_config(data, chip->ev_cfg, val);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
> @@ -652,6 +718,16 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
>  	if (src < 0)
>  		return;
>  
> +	if (mma8452_freefall_mode_enabled(data)) {
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +						  IIO_MOD_X_AND_Y_AND_Z,
> +						  IIO_EV_TYPE_MAG,
> +						  IIO_EV_DIR_FALLING),
> +			       ts);
> +		return;
> +	}
> +
>  	if (src & data->chip_info->ev_src_xe)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
> @@ -745,6 +821,27 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static const struct iio_event_spec mma8452_freefall_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +					BIT(IIO_EV_INFO_PERIOD) |
> +					BIT(IIO_EV_INFO_HIGH_PASS_FILTER_3DB)
> +	},
> +};
> +
> +static const struct iio_event_spec mma8652_freefall_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +					BIT(IIO_EV_INFO_PERIOD)
> +	},
> +};
> +
>  static const struct iio_event_spec mma8452_transient_event[] = {
>  	{
>  		.type = IIO_EV_TYPE_MAG,
> @@ -781,6 +878,24 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.attrs = mma8452_event_attributes,
>  };
>  
> +#define MMA8452_FREEFALL_CHANNEL(modifier) { \
> +	.type = IIO_ACCEL, \
> +	.modified = 1, \
> +	.channel2 = modifier, \
> +	.scan_index = -1, \
> +	.event_spec = mma8452_freefall_event, \
> +	.num_event_specs = ARRAY_SIZE(mma8452_freefall_event), \
> +}
> +
> +#define MMA8652_FREEFALL_CHANNEL(modifier) { \
> +	.type = IIO_ACCEL, \
> +	.modified = 1, \
> +	.channel2 = modifier, \
> +	.scan_index = -1, \
> +	.event_spec = mma8652_freefall_event, \
> +	.num_event_specs = ARRAY_SIZE(mma8652_freefall_event), \
> +}
> +
>  #define MMA8452_CHANNEL(axis, idx, bits) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -827,6 +942,7 @@ static const struct iio_chan_spec mma8452_channels[] = {
>  	MMA8452_CHANNEL(Y, idx_y, 12),
>  	MMA8452_CHANNEL(Z, idx_z, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
>  static const struct iio_chan_spec mma8453_channels[] = {
> @@ -834,6 +950,7 @@ static const struct iio_chan_spec mma8453_channels[] = {
>  	MMA8452_CHANNEL(Y, idx_y, 10),
>  	MMA8452_CHANNEL(Z, idx_z, 10),
>  	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
>  static const struct iio_chan_spec mma8652_channels[] = {
> @@ -841,6 +958,7 @@ static const struct iio_chan_spec mma8652_channels[] = {
>  	MMA8652_CHANNEL(Y, idx_y, 12),
>  	MMA8652_CHANNEL(Z, idx_z, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8652_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
>  static const struct iio_chan_spec mma8653_channels[] = {
> @@ -848,6 +966,7 @@ static const struct iio_chan_spec mma8653_channels[] = {
>  	MMA8652_CHANNEL(Y, idx_y, 10),
>  	MMA8652_CHANNEL(Z, idx_z, 10),
>  	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8652_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
>  enum {
> @@ -1190,6 +1309,10 @@ static int mma8452_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		goto buffer_cleanup;
>  
> +	ret = mma8452_set_freefall_mode(data, false);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  
>  buffer_cleanup:
> 

