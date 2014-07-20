Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41178 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbaGTQCA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 12:02:00 -0400
Message-ID: <53CBE883.1080403@kernel.org>
Date: Sun, 20 Jul 2014 17:04:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: accel: kxcjk-1013: Support thresholds
References: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1405557754-19601-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405557754-19601-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/14 01:42, Srinivas Pandruvada wrote:
> This chip can operate in two modes. In one mode it can issue periodic
> interrupts based on sample rate setting or when there is a motion.
But not both?  This had me confused below.

Also, the event description is incorrect for conventional motion detection
(magnitude rising detection).

J
> Using events mechanism to allow configuration and receive events.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/iio/accel/kxcjk-1013.c | 238 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 230 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 975f8a6..f5bb682 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -27,6 +27,7 @@
>   #include <linux/iio/sysfs.h>
>   #include <linux/iio/buffer.h>
>   #include <linux/iio/trigger.h>
> +#include <linux/iio/events.h>
>   #include <linux/iio/trigger_consumer.h>
>   #include <linux/iio/triggered_buffer.h>
>   #include <linux/iio/accel/kxcjk_1013.h>
> @@ -92,6 +93,9 @@ struct kxcjk1013_data {
>   	u8 odr_bits;
>   	u8 range;
>   	bool active_high_intr;
> +	int ev_enable_state;
> +	int wake_thres;
> +	int wake_dur;
>   	bool trigger_on;
>   };
>
> @@ -116,6 +120,23 @@ static const struct {
>   			{200, 0, 0x04}, {400, 0, 0x05}, {800, 0, 0x06},
>   			{1600, 0, 0x07} };
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
>   /* Refer to section 4 of the specification */
>   static const struct {
>   	int odr_bits;
> @@ -283,10 +304,36 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>   	return 0;
>   }
>
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
> +		dev_err(&data->client->dev,
> +			"Error writing reg_wake_thres\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int kxcjk1013_chip_setup_interrupt(struct kxcjk1013_data *data,
>   					  bool status)
>   {
>   	int ret;
> +	u8 intr_bit;
>   	enum kxcjk1013_mode store_mode;
>
>   	ret = kxcjk1013_get_mode(data, &store_mode);
> @@ -316,6 +363,16 @@ static int kxcjk1013_chip_setup_interrupt(struct kxcjk1013_data *data,
>   		return ret;
>   	}
>
> +	if (data->wake_thres) {
rather than ev_enable_state?
> +		if (status) {
> +			ret = kxcjk1013_chip_update_thresholds(data);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		intr_bit = KXCJK1013_REG_CTRL1_BIT_WUFE;
> +	} else
> +		intr_bit = KXCJK1013_REG_CTRL1_BIT_DRDY;
> +
Does this mean the dataready interrupt is disabled whenever thresholds
are non zero?  This needs some explanation.

>   	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
>   	if (ret < 0) {
>   		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
> @@ -323,9 +380,10 @@ static int kxcjk1013_chip_setup_interrupt(struct kxcjk1013_data *data,
>   	}
>
>   	if (status)
> -		ret |= KXCJK1013_REG_CTRL1_BIT_DRDY;
> +		ret |= intr_bit;
>   	else
> -		ret &= ~KXCJK1013_REG_CTRL1_BIT_DRDY;
> +		ret &= ~(KXCJK1013_REG_CTRL1_BIT_WUFE |
> +			 KXCJK1013_REG_CTRL1_BIT_DRDY);
>
>   	ret = i2c_smbus_write_byte_data(data->client,
>   					KXCJK1013_REG_CTRL1, ret);
> @@ -357,6 +415,20 @@ static int kxcjk1013_convert_freq_to_bit(int val, int val2)
>   	return -EINVAL;
>   }
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
>   static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>   {
>   	int ret;
> @@ -385,6 +457,17 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>
>   	data->odr_bits = odr_bits;
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
>   	if (store_mode == OPERATION) {
>   		ret = kxcjk1013_set_mode(data, OPERATION);
>   		if (ret < 0)
> @@ -567,6 +650,94 @@ static int kxcjk1013_write_raw(struct iio_dev *indio_dev,
>   	return ret;
>   }
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
Perhaps check val2 == 0
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		data->wake_thres = val;
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		data->wake_dur	= val;
Double space above.
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int kxcjk1013_read_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir)
> +{
> +
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	return data->ev_enable_state;
> +}
> +
> +static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					int state)
> +{
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (data->trigger_on)
> +		return -EAGAIN;
> +
> +	if (state && data->ev_enable_state)
> +		return 0;
> +
> +	mutex_lock(&data->mutex);
> +	ret = kxcjk1013_chip_setup_interrupt(data, state);
> +	if (!ret) {
> +		ret = kxcjk1013_set_power_state(data, state);
> +		if (ret < 0) {
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +	}
> +	data->ev_enable_state = state;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
>   static int kxcjk1013_validate_trigger(struct iio_dev *indio_dev,
>   				      struct iio_trigger *trig)
>   {
> @@ -593,6 +764,14 @@ static const struct attribute_group kxcjk1013_attrs_group = {
>   	.attrs = kxcjk1013_attributes,
>   };
>
> +static const struct iio_event_spec kxcjk1013_event = {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
As stated below I'm a little doubtful this is correct.
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE) |
> +				 BIT(IIO_EV_INFO_PERIOD)
> +};
> +
>   #define KXCJK1013_CHANNEL(_axis) {					\
>   	.type = IIO_ACCEL,						\
>   	.modified = 1,							\
> @@ -608,6 +787,8 @@ static const struct attribute_group kxcjk1013_attrs_group = {
>   		.shift = 4,						\
>   		.endianness = IIO_LE,					\
>   	},								\
> +	.event_spec = &kxcjk1013_event,				\
> +	.num_event_specs = 1						\
>   }
>
>   static const struct iio_chan_spec kxcjk1013_channels[] = {
> @@ -621,6 +802,10 @@ static const struct iio_info kxcjk1013_info = {
>   	.attrs			= &kxcjk1013_attrs_group,
>   	.read_raw		= kxcjk1013_read_raw,
>   	.write_raw		= kxcjk1013_write_raw,
> +	.read_event_value	= kxcjk1013_read_event,
> +	.write_event_value	= kxcjk1013_write_event,
> +	.write_event_config	= kxcjk1013_write_event_config,
> +	.read_event_config	= kxcjk1013_read_event_config,
>   	.validate_trigger	= kxcjk1013_validate_trigger,
>   	.driver_module		= THIS_MODULE,
>   };
> @@ -675,6 +860,9 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
>   	struct kxcjk1013_data *data = iio_priv(indio_dev);
>   	int ret;
>
> +	if (data->ev_enable_state)
> +		return -EAGAIN;
> +
>   	if (state && data->trigger_on)
>   		return 0;
>
> @@ -699,6 +887,38 @@ static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
>   	.owner = THIS_MODULE,
>   };
>
> +static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +	int ret;
> +
Slight preference for a comment here saying what the event is...
> +	iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						     0,
> +						     IIO_MOD_X_OR_Y_OR_Z,
> +						     IIO_EV_TYPE_THRESH,
> +						     IIO_EV_DIR_EITHER),
Really? Note this means that a fall in the magnitude will trigger the event
as well as a rise?  (e.g. stop of a previously existing motion).

It's possible but seems unlikely.  I'm guessing you want IIO_EV_TYPE_MAG
and IIO_EV_DIR_RISING.
> +						     iio_get_time_ns());
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
> +	if (data->trigger_on) {
> +		iio_trigger_poll(data->trig);
> +		return IRQ_HANDLED;
> +	} else
> +		return IRQ_WAKE_THREAD;
> +}
> +
>   static int kxcjk1013_acpi_gpio_probe(struct i2c_client *client,
>   				     struct kxcjk1013_data *data)
>   {
> @@ -783,11 +1003,13 @@ static int kxcjk1013_probe(struct i2c_client *client,
>
>   		data->trig_mode = true;
>
> -		ret = devm_request_irq(&client->dev, client->irq,
> -					iio_trigger_generic_data_rdy_poll,
> -					IRQF_TRIGGER_RISING,
> -					KXCJK1013_IRQ_NAME,
> -					trig);
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						kxcjk1013_data_rdy_trig_poll,
> +						kxcjk1013_event_handler,
> +						IRQF_TRIGGER_RISING |
> +								IRQF_ONESHOT,
> +						KXCJK1013_IRQ_NAME,
> +						indio_dev);
>   		if (ret) {
>   			dev_err(&client->dev, "unable to request IRQ\n");
>   			goto err_trigger_free;
> @@ -889,7 +1111,7 @@ static int kxcjk1013_resume(struct device *dev)
>
>   	mutex_lock(&data->mutex);
>   	/* Check, if the suspend occured while active */
> -	if (data->trigger_on)
> +	if (data->trigger_on || data->ev_enable_state)
>   		ret = kxcjk1013_set_mode(data, OPERATION);
>   	mutex_unlock(&data->mutex);
>
>

