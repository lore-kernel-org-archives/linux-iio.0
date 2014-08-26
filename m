Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55455 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbaHZUCO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Aug 2014 16:02:14 -0400
Message-ID: <53FCE7C1.4040203@kernel.org>
Date: Tue, 26 Aug 2014 21:02:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
CC: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1] iio: accel: kxcjk-1013: Support thresholds
References: <1408734083-12804-1-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1408734083-12804-1-git-send-email-srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/14 20:01, Srinivas Pandruvada wrote:
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> This chip has a motion detect capability. Using IIO events to
> specify thresholds and pushing events.
> In addition a new trigger of type any-motion is added, which
> pushes data to buffer only when there is any movement.
> 
> Change list:
> Comments addressed for
> Re: [PATCH 5/6] iio: accel: kxcjk-1013: Support thresholds
> Date: 07/20/2014
> 
> - Both motion detect and data ready can be enabled together
> - Sending RISING/FALLING events based on int status
> - Separate interrupt configuration for data ready and motion detect
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Looks good - a couple of idle thoughts inline.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxcjk-1013.c | 499 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 448 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 57c515b..b4d6d7a 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -27,6 +27,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/accel/kxcjk_1013.h>
> @@ -75,16 +76,30 @@
>  
>  #define KXCJK1013_SLEEP_DELAY_MS	2000
>  
> +#define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
> +#define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
> +#define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
> +#define KXCJK1013_REG_INT_SRC2_BIT_YN	BIT(3)
> +#define KXCJK1013_REG_INT_SRC2_BIT_XP	BIT(4)
> +#define KXCJK1013_REG_INT_SRC2_BIT_XN	BIT(5)
> +
> +#define KXCJK1013_DEFAULT_WAKE_THRES	1
> +
>  struct kxcjk1013_data {
>  	struct i2c_client *client;
> -	struct iio_trigger *trig;
> -	bool trig_mode;
> +	struct iio_trigger *dready_trig;
> +	struct iio_trigger *motion_trig;
>  	struct mutex mutex;
>  	s16 buffer[8];
>  	u8 odr_bits;
>  	u8 range;
> +	int wake_thres;
> +	int wake_dur;
>  	bool active_high_intr;
> -	bool trigger_on;
> +	bool dready_trigger_on;
> +	int ev_enable_state;
> +	bool motion_trigger_on;
> +	int64_t timestamp;
>  };
>  
>  enum kxcjk1013_axis {
> @@ -131,6 +146,23 @@ static const struct {
>  			      {19163, 1, 0},
>  			      {38326, 0, 1} };
>  
> +static const struct {
> +	int val;
> +	int val2;
> +	int odr_bits;
> +} wake_odr_data_rate_table[] = { {0, 781000, 0x00},
> +				 {1, 563000, 0x01},
> +				 {3, 125000, 0x02},
> +				 {6, 250000, 0x03},
> +				 {12, 500000, 0x04},
> +				 {25, 0, 0x05},
> +				 {50, 0, 0x06},
> +				 {100, 0, 0x06},
> +				 {200, 0, 0x06},
> +				 {400, 0, 0x06},
> +				 {800, 0, 0x06},
> +				 {1600, 0, 0x06} };
> +
>  static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
>  			      enum kxcjk1013_mode mode)
>  {
> @@ -241,7 +273,6 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  
>  	data->range = KXCJK1013_RANGE_4G;
>  
> -
>  	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_DATA_CTRL);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_data_ctrl\n");
> @@ -273,6 +304,8 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> +	data->wake_thres = KXCJK1013_DEFAULT_WAKE_THRES;
> +
>  	return 0;
>  }
>  
> @@ -307,8 +340,96 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  	return 0;
>  }
>  
> -static int kxcjk1013_chip_setup_interrupt(struct kxcjk1013_data *data,
> -					  bool status)
> +static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					KXCJK1013_REG_WAKE_TIMER,
> +					data->wake_dur);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Error writing reg_wake_timer\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					KXCJK1013_REG_WAKE_THRES,
> +					data->wake_thres);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_wake_thres\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
> +						bool status)
> +{
> +	int ret;
> +	enum kxcjk1013_mode store_mode;
> +
> +	ret = kxcjk1013_get_mode(data, &store_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* This is requirement by spec to change state to STANDBY */
> +	ret = kxcjk1013_set_mode(data, STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = kxcjk1013_chip_update_thresholds(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
> +		return ret;
> +	}
> +
> +	if (status)
> +		ret |= KXCJK1013_REG_INT_REG1_BIT_IEN;
> +	else
> +		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEN;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
> +					ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
> +		return ret;
> +	}
> +
> +	if (status)
> +		ret |= KXCJK1013_REG_CTRL1_BIT_WUFE;
> +	else
> +		ret &= ~KXCJK1013_REG_CTRL1_BIT_WUFE;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					KXCJK1013_REG_CTRL1, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
> +		return ret;
> +	}
> +
> +	if (store_mode == OPERATION) {
> +		ret = kxcjk1013_set_mode(data, OPERATION);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
> +					      bool status)
>  {
>  	int ret;
>  	enum kxcjk1013_mode store_mode;
> @@ -381,6 +502,20 @@ static int kxcjk1013_convert_freq_to_bit(int val, int val2)
>  	return -EINVAL;
>  }
>  
> +static int kxcjk1013_convert_wake_odr_to_bit(int val, int val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(wake_odr_data_rate_table); ++i) {
> +		if (wake_odr_data_rate_table[i].val == val &&
> +			wake_odr_data_rate_table[i].val2 == val2) {
> +			return wake_odr_data_rate_table[i].odr_bits;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>  {
>  	int ret;
> @@ -409,6 +544,17 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>  
>  	data->odr_bits = odr_bits;
>  
> +	odr_bits = kxcjk1013_convert_wake_odr_to_bit(val, val2);
> +	if (odr_bits < 0)
> +		return odr_bits;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL2,
> +					odr_bits);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_ctrl2\n");
> +		return ret;
> +	}
> +
>  	if (store_mode == OPERATION) {
>  		ret = kxcjk1013_set_mode(data, OPERATION);
>  		if (ret < 0)
> @@ -560,12 +706,120 @@ static int kxcjk1013_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int kxcjk1013_read_event(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	*val2 = 0;
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		*val = data->wake_thres;
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		*val = data->wake_dur;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int kxcjk1013_write_event(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	if (data->ev_enable_state)
> +		return -EBUSY;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		data->wake_thres = val;
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		data->wake_dur = val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int kxcjk1013_read_event_config(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir)
> +{
> +
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	return data->ev_enable_state;
> +}
> +
> +static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   enum iio_event_type type,
> +					   enum iio_event_direction dir,
> +					   int state)
> +{
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (state && data->ev_enable_state)
> +		return 0;
> +
> +	mutex_lock(&data->mutex);
> +
> +	if (!state && data->motion_trigger_on) {
> +		data->ev_enable_state = 0;
> +		mutex_unlock(&data->mutex);
> +		return 0;
> +	}
> +
> +	/*
> +	 * We will expect the enable and disable to do operation in
> +	 * in reverse order. This will happen here anyway as our
> +	 * resume operation uses sync mode runtime pm calls, the
> +	 * suspend operation will be delayed by autosuspend delay
> +	 * So the disable operation will still happen in reverse of
> +	 * enable operation. When runtime pm is disabled the mode
> +	 * is always on so sequence doesn't matter
> +	 */
> +	ret = kxcjk1013_set_power_state(data, state);
> +	if (ret < 0) {
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +
> +	ret =  kxcjk1013_setup_any_motion_interrupt(data, state);
> +	if (ret < 0) {
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +
> +	data->ev_enable_state = state;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
>  static int kxcjk1013_validate_trigger(struct iio_dev *indio_dev,
>  				      struct iio_trigger *trig)
>  {
>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
>  
> -	if (data->trig != trig)
> +	if (data->dready_trig != trig && data->motion_trig != trig)
>  		return -EINVAL;
>  
>  	return 0;
> @@ -586,6 +840,14 @@ static const struct attribute_group kxcjk1013_attrs_group = {
>  	.attrs = kxcjk1013_attributes,
>  };
>  
> +static const struct iio_event_spec kxcjk1013_event = {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE) |
> +				 BIT(IIO_EV_INFO_PERIOD)
> +};
> +
>  #define KXCJK1013_CHANNEL(_axis) {					\
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\
> @@ -601,6 +863,8 @@ static const struct attribute_group kxcjk1013_attrs_group = {
>  		.shift = 4,						\
>  		.endianness = IIO_CPU,					\
>  	},								\
> +	.event_spec = &kxcjk1013_event,				\
> +	.num_event_specs = 1						\
>  }
>  
>  static const struct iio_chan_spec kxcjk1013_channels[] = {
> @@ -614,6 +878,10 @@ static const struct iio_info kxcjk1013_info = {
>  	.attrs			= &kxcjk1013_attrs_group,
>  	.read_raw		= kxcjk1013_read_raw,
>  	.write_raw		= kxcjk1013_write_raw,
> +	.read_event_value	= kxcjk1013_read_event,
> +	.write_event_value	= kxcjk1013_write_event,
> +	.write_event_config	= kxcjk1013_write_event_config,
> +	.read_event_config	= kxcjk1013_read_event_config,
>  	.validate_trigger	= kxcjk1013_validate_trigger,
>  	.driver_module		= THIS_MODULE,
>  };
> @@ -639,7 +907,7 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
>  	mutex_unlock(&data->mutex);
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -					   pf->timestamp);
> +					   data->timestamp);
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> @@ -668,19 +936,32 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	if (state && data->trigger_on)
> +	mutex_lock(&data->mutex);
> +
> +	if (!state && data->ev_enable_state && data->motion_trigger_on) {
> +		data->motion_trigger_on = false;
> +		mutex_unlock(&data->mutex);
>  		return 0;
> +	}
>  
> -	mutex_lock(&data->mutex);
> -	ret = kxcjk1013_chip_setup_interrupt(data, state);
> -	if (!ret) {
> -		ret = kxcjk1013_set_power_state(data, state);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			return ret;
> -		}
> +	ret = kxcjk1013_set_power_state(data, state);
> +	if (ret < 0) {
> +		mutex_unlock(&data->mutex);
> +		return ret;
>  	}
> -	data->trigger_on = state;
> +	if (data->motion_trig == trig)
> +		ret = kxcjk1013_setup_any_motion_interrupt(data, state);
> +	else
> +		ret = kxcjk1013_setup_new_data_interrupt(data, state);
> +	if (ret < 0) {
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +	if (data->motion_trig == trig)
> +		data->motion_trigger_on = state;
> +	else
> +		data->dready_trigger_on = state;
> +
>  	mutex_unlock(&data->mutex);
>  
>  	return 0;
> @@ -692,6 +973,109 @@ static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_SRC1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_src1\n");
> +		goto ack_intr;
> +	}
> +
> +	if (ret & 0x02) {
> +		ret = i2c_smbus_read_byte_data(data->client,
> +					       KXCJK1013_REG_INT_SRC2);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev,
> +				"Error reading reg_int_src2\n");
> +			goto ack_intr;
> +		}
> +
Could do this whole set as a combination of for_each_set_bit and
a lookup table for the event codes (or the elements used to build
them).  Would make it a little more apparent that this is really
picking between constant values...

Mind you, might well prove more complex than what we have here!

> +		if (ret & KXCJK1013_REG_INT_SRC2_BIT_XN)
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +				       0,
> +				       IIO_MOD_X,
> +				       IIO_EV_TYPE_THRESH,
> +				       IIO_EV_DIR_FALLING),
> +				       data->timestamp);
> +		if (ret & KXCJK1013_REG_INT_SRC2_BIT_XP)
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +				       0,
> +				       IIO_MOD_X,
> +				       IIO_EV_TYPE_THRESH,
> +				       IIO_EV_DIR_RISING),
> +				       data->timestamp);
> +
> +
> +		if (ret & KXCJK1013_REG_INT_SRC2_BIT_YN)
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +				       0,
> +				       IIO_MOD_Y,
> +				       IIO_EV_TYPE_THRESH,
> +				       IIO_EV_DIR_FALLING),
> +				       data->timestamp);
> +		if (ret & KXCJK1013_REG_INT_SRC2_BIT_YP)
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +				       0,
> +				       IIO_MOD_Y,
> +				       IIO_EV_TYPE_THRESH,
> +				       IIO_EV_DIR_RISING),
> +				       data->timestamp);
> +
> +		if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZN)
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +				       0,
> +				       IIO_MOD_Z,
> +				       IIO_EV_TYPE_THRESH,
> +				       IIO_EV_DIR_FALLING),
> +				       data->timestamp);
> +		if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZP)
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +				       0,
> +				       IIO_MOD_Z,
> +				       IIO_EV_TYPE_THRESH,
> +				       IIO_EV_DIR_RISING),
> +				       data->timestamp);
> +	}
> +
> +ack_intr:
> +	if (data->dready_trigger_on)
> +		return IRQ_HANDLED;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	data->timestamp = iio_get_time_ns();
> +
> +	if (data->dready_trigger_on)
> +		iio_trigger_poll(data->dready_trig);
> +	else if (data->motion_trigger_on)
> +		iio_trigger_poll(data->motion_trig);
> +
> +	if (data->ev_enable_state)
> +		return IRQ_WAKE_THREAD;
> +	else
> +		return IRQ_HANDLED;
> +}
> +
>  static int kxcjk1013_acpi_gpio_probe(struct i2c_client *client,
>  				     struct kxcjk1013_data *data)
>  {
> @@ -734,7 +1118,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  {
>  	struct kxcjk1013_data *data;
>  	struct iio_dev *indio_dev;
> -	struct iio_trigger *trig = NULL;
>  	struct kxcjk_1013_platform_data *pdata;
>  	int ret;
>  
> @@ -769,33 +1152,47 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  		client->irq = kxcjk1013_acpi_gpio_probe(client, data);
>  
>  	if (client->irq >= 0) {
> -		trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> -					 indio_dev->id);
> -		if (!trig)
> -			return -ENOMEM;
> +		ret = devm_request_threaded_irq(
Why the new line before the arguements?
> +						&client->dev, client->irq,
> +						kxcjk1013_data_rdy_trig_poll,
> +						kxcjk1013_event_handler,
> +						IRQF_TRIGGER_RISING,
> +						KXCJK1013_IRQ_NAME,
> +						indio_dev);
> +		if (ret)
> +			return ret;
>  
> -		data->trig_mode = true;
> +		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> +							   "%s-dev%d",
> +							   indio_dev->name,
> +							   indio_dev->id);
> +		if (!data->dready_trig)
> +			return -ENOMEM;
>  
> -		ret = devm_request_irq(&client->dev, client->irq,
> -					iio_trigger_generic_data_rdy_poll,
> -					IRQF_TRIGGER_RISING,
> -					KXCJK1013_IRQ_NAME,
> -					trig);
> -		if (ret) {
> -			dev_err(&client->dev, "unable to request IRQ\n");
> -			goto err_trigger_free;
> -		}
> +		data->motion_trig = devm_iio_trigger_alloc(&client->dev,
> +							  "%s-any-motion-dev%d",
> +							  indio_dev->name,
> +							  indio_dev->id);
> +		if (!data->motion_trig)
> +			return -ENOMEM;
>  
> -		trig->dev.parent = &client->dev;
> -		trig->ops = &kxcjk1013_trigger_ops;
> -		iio_trigger_set_drvdata(trig, indio_dev);
> -		data->trig = trig;
> -		indio_dev->trig = trig;
> +		data->dready_trig->dev.parent = &client->dev;
> +		data->dready_trig->ops = &kxcjk1013_trigger_ops;
> +		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> +		indio_dev->trig = data->dready_trig;
>  		iio_trigger_get(indio_dev->trig);
> -
> -		ret = iio_trigger_register(trig);
> +		ret = iio_trigger_register(data->dready_trig);
>  		if (ret)
> -			goto err_trigger_free;
> +			return ret;
> +
> +		data->motion_trig->dev.parent = &client->dev;
> +		data->motion_trig->ops = &kxcjk1013_trigger_ops;
> +		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
> +		ret = iio_trigger_register(data->motion_trig);
> +		if (ret) {
> +			data->motion_trig = NULL;
> +			goto err_trigger_unregister;
> +		}
>  
>  		ret = iio_triggered_buffer_setup(indio_dev,
>  						&iio_pollfunc_store_time,
> @@ -828,14 +1225,13 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  err_iio_unregister:
>  	iio_device_unregister(indio_dev);
>  err_buffer_cleanup:
> -	if (data->trig_mode)
> +	if (data->dready_trig)
>  		iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
> -	if (data->trig_mode)
> -		iio_trigger_unregister(trig);
> -err_trigger_free:
> -	if (data->trig_mode)
> -		iio_trigger_free(trig);
> +	if (data->dready_trig)
> +		iio_trigger_unregister(data->dready_trig);
> +	if (data->motion_trig)
> +		iio_trigger_unregister(data->motion_trig);
>  
>  	return ret;
>  }
> @@ -851,10 +1247,10 @@ static int kxcjk1013_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	if (data->trig_mode) {
> +	if (data->dready_trig) {
>  		iio_triggered_buffer_cleanup(indio_dev);
> -		iio_trigger_unregister(data->trig);
> -		iio_trigger_free(data->trig);
> +		iio_trigger_unregister(data->dready_trig);
> +		iio_trigger_unregister(data->motion_trig);
>  	}
>  
>  	mutex_lock(&data->mutex);
> @@ -886,7 +1282,8 @@ static int kxcjk1013_resume(struct device *dev)
>  
>  	mutex_lock(&data->mutex);
>  	/* Check, if the suspend occured while active */
> -	if (data->trigger_on)
> +	if (data->dready_trigger_on || data->motion_trigger_on ||
> +							data->ev_enable_state)
>  		ret = kxcjk1013_set_mode(data, OPERATION);
>  	mutex_unlock(&data->mutex);
>  
> 
