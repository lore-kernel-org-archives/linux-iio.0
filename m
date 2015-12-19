Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56342 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbbLSQ7d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 11:59:33 -0500
Subject: Re: [PATCH 3/3] iio: mma8452: add freefall detection for Freescale's
 accelerometers
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1450197901-9826-1-git-send-email-martink@posteo.de>
 <1450197901-9826-4-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56758CEF.7020600@kernel.org>
Date: Sat, 19 Dec 2015 16:59:27 +0000
MIME-Version: 1.0
In-Reply-To: <1450197901-9826-4-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/12/15 16:45, Martin Kepplinger wrote:
> This adds freefall event detection to the supported devices. It adds
> the in_accel_x&y&z_mag_falling_en iio event attribute, which activates
> freefall mode.
> 
> In freefall mode, the current acceleration magnitude (AND combination
> of all axis values) is compared to the specified threshold.
> If it falls under the threshold (in_accel_mag_falling_value),
> the appropriate IIO event code is generated.
> 
> The values of rising and falling versions of various sysfs files are
> shared, which is compliant to the IIO specification.
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
I didn't explain myself clearly enough in the last review.

My issue was that if freefall is enabled, any query of whether the mag_rising
values are enabled will I think return true when they aren't.

Few more bits inline as well.  In particularly I'd like the 'priority'
of all events to be treated as equal.  So the last event enabled will disable
other incompatible events if it needs to.  Alternative is to reject any
incompatible event sets.  I don't like the current option where the freefall
event is considered higher priority than the others and will effectively
always win any clash.

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 113 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index ccc632a..02c027d 100644
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
> @@ -416,6 +416,46 @@ fail:
>  	return ret;
>  }
>  
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
> +static int mma8452_set_freefall_mode(struct mma8452_data *data, u8 state)
> +{
> +	int val, ret;
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
> +	ret = mma8452_change_config(data, chip->ev_cfg, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>  					   int val, int val2)
>  {
> @@ -609,6 +649,11 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
>  	const struct mma_chip_info *chip = data->chip_info;
>  	int ret;
>  
> +	switch (chan->channel2) {
> +	case IIO_MOD_X_AND_Y_AND_Z:
> +		return mma8452_freefall_mode_enabled(data);
> +	}
> +
If in freefall mode and queried we indeed return true.
However, if in freefall mode and we query if we are in rising for a single
channel... I think it will always return that the rising event is also
enabled when it isn't (as we are in freefall mode)

I think you need to confirm that we are not in freefall mode before
doing the axis checks that follow which are for the rising case.

The ABI allows the write of any element to change the value of any
other (thus it's fine to have enabling freefall mode turn off the rising
events) but if the other values are read back they must then reflect the
new state so userspace can find out what happened.

>  	ret = i2c_smbus_read_byte_data(data->client,
>  				       data->chip_info->ev_cfg);
>  	if (ret < 0)
> @@ -627,6 +672,14 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  	const struct mma_chip_info *chip = data->chip_info;
>  	int val;
>  
> +	switch (chan->channel2) {
> +	case IIO_MOD_X_AND_Y_AND_Z:
> +		return mma8452_set_freefall_mode(data, state);
> +	default:
> +		if (mma8452_freefall_mode_enabled(data))
I'd rather this was all symmetric.  So if another event is enabled
free fall mode should then be disabled.  In any case this should return an
error code to reflect what has happened (-EBUSY)
> +			return 0;
> +	}
> +
>  	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>  	if (val < 0)
>  		return val;
> @@ -637,7 +690,6 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  		val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
>  
>  	val |= chip->ev_cfg_ele;
> -	val |= MMA8452_FF_MT_CFG_OAE;
>  
>  	return mma8452_change_config(data, chip->ev_cfg, val);
>  }
> @@ -652,6 +704,16 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
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
> @@ -745,6 +807,27 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
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
> @@ -781,6 +864,24 @@ static struct attribute_group mma8452_event_attribute_group = {
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
> @@ -827,6 +928,7 @@ static const struct iio_chan_spec mma8452_channels[] = {
>  	MMA8452_CHANNEL(Y, idx_y, 12),
>  	MMA8452_CHANNEL(Z, idx_z, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
>  static const struct iio_chan_spec mma8453_channels[] = {
> @@ -834,6 +936,7 @@ static const struct iio_chan_spec mma8453_channels[] = {
>  	MMA8452_CHANNEL(Y, idx_y, 10),
>  	MMA8452_CHANNEL(Z, idx_z, 10),
>  	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
>  static const struct iio_chan_spec mma8652_channels[] = {
> @@ -841,6 +944,7 @@ static const struct iio_chan_spec mma8652_channels[] = {
>  	MMA8652_CHANNEL(Y, idx_y, 12),
>  	MMA8652_CHANNEL(Z, idx_z, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8652_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
>  static const struct iio_chan_spec mma8653_channels[] = {
> @@ -848,6 +952,7 @@ static const struct iio_chan_spec mma8653_channels[] = {
>  	MMA8652_CHANNEL(Y, idx_y, 10),
>  	MMA8652_CHANNEL(Z, idx_z, 10),
>  	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8652_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
>  enum {
> @@ -1190,6 +1295,10 @@ static int mma8452_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		goto buffer_cleanup;
>  
> +	ret = mma8452_set_freefall_mode(data, 0);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  
>  buffer_cleanup:
> 

