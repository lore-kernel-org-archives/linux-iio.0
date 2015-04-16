Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:58143 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbbDPWa1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 16 Apr 2015 18:30:27 -0400
Message-ID: <553037FB.3040305@gmx.de>
Date: Fri, 17 Apr 2015 00:30:19 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 4/9] iio: mma8452: Basic support for transient events.
References: <20150219141553.27001.18825.stgit@localhost> <20150219141602.27001.51592.stgit@localhost>
In-Reply-To: <20150219141602.27001.51592.stgit@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Martin Fuzzey schrieb am 19.02.2015 um 15:16:
> The event is triggered when the highpass filtered absolute acceleration
> exceeds the threshold.
> 
The strict checks of checkpatch.pl complain about several alignment issues
of function parameters. Besides, I have put a few comments inline.

> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/iio/accel/mma8452.c |  212 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 211 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index c46df4e..d44044f 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -9,7 +9,7 @@
>   *
>   * 7-bit I2C slave address 0x1c/0x1d (pin selectable)
>   *
> - * TODO: interrupt, thresholding, orientation / freefall events, autosleep
> + * TODO: orientation / freefall events, autosleep
>   */
>  
>  #include <linux/module.h>
> @@ -19,20 +19,33 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/delay.h>
>  
>  #define MMA8452_STATUS 0x00
>  #define MMA8452_OUT_X 0x01 /* MSB first, 12-bit  */
>  #define MMA8452_OUT_Y 0x03
>  #define MMA8452_OUT_Z 0x05
> +#define MMA8452_INT_SRC 0x0c
>  #define MMA8452_WHO_AM_I 0x0d
>  #define MMA8452_DATA_CFG 0x0e
> +#define MMA8452_TRANSIENT_CFG 0x1d
> +#define MMA8452_TRANSIENT_CFG_ELE		BIT(4)
> +#define MMA8452_TRANSIENT_CFG_CHAN_MASK(chan)	(BIT(1) << chan)
This is not a mask but a channel selection, so that part of the name can
be dropped. Besides, I would define it as BIT(chan + 1)

> +#define MMA8452_TRANSIENT_SRC 0x1e
> +#define MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
> +#define MMA8452_TRANSIENT_SRC_YTRANSE		BIT(3)
> +#define MMA8452_TRANSIENT_SRC_ZTRANSE		BIT(5)
> +#define MMA8452_TRANSIENT_THS 0x1f
> +#define MMA8452_TRANSIENT_COUNT 0x20
This one is unused.

>  #define MMA8452_OFF_X 0x2f
>  #define MMA8452_OFF_Y 0x30
>  #define MMA8452_OFF_Z 0x31
>  #define MMA8452_CTRL_REG1 0x2a
>  #define MMA8452_CTRL_REG2 0x2b
>  #define MMA8452_CTRL_REG2_RST		BIT(6)
> +#define MMA8452_CTRL_REG4 0x2d
> +#define MMA8452_CTRL_REG5 0x2e
>  
>  #define MMA8452_MAX_REG 0x31
>  
> @@ -48,6 +61,13 @@
>  #define MMA8452_DATA_CFG_FS_4G 1
>  #define MMA8452_DATA_CFG_FS_8G 2
>  
> +#define MMA8452_INT_DRDY	BIT(0)
> +#define MMA8452_INT_FF_MT	BIT(2)
> +#define MMA8452_INT_PULSE	BIT(3)
> +#define MMA8452_INT_LNDPRT	BIT(4)
> +#define MMA8452_INT_TRANS	BIT(5)
> +#define MMA8452_INT_ASLP	BIT(7)
All except MMA8452_INT_TRANS are unused.

> +
>  #define MMA8452_DEVICE_ID 0x2a
>  
>  struct mma8452_data {
> @@ -274,6 +294,121 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int mma8452_read_thresh(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, enum iio_event_info info, int *val,
> +	int *val2)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_THS);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret & 0x7f;
It would be better to define the threshold mask and then make use of it here
and in those other instances below.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int mma8452_write_thresh(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, enum iio_event_info info, int val,
> +	int val2)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +
> +	return mma8452_change_config(data, MMA8452_TRANSIENT_THS, val & 0x7f);
Like here.

> +}
> +
> +static int mma8452_read_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_CFG);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret & MMA8452_TRANSIENT_CFG_CHAN_MASK(chan->scan_index) ? 1 : 0;
return !!(ret & MMA8452_TRANSIENT_CFG_CHAN_MASK(chan->scan_index)); does the same.

> +}
> +
> +static int mma8452_write_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, int state)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int val;
Better use ret for consistency?
> +
> +	val = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_CFG);
> +	if (val < 0)
> +		return val;
> +
> +	if (state)
> +		val |= MMA8452_TRANSIENT_CFG_CHAN_MASK(chan->scan_index);
> +	else
> +		val &= ~MMA8452_TRANSIENT_CFG_CHAN_MASK(chan->scan_index);
> +
> +	val |= MMA8452_TRANSIENT_CFG_ELE;
> +
> +	return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, val);
> +}
> +
> +static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	s64 ts = iio_get_time_ns();
> +	int src;
> +
> +	src = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_SRC);
> +	if (src < 0)
> +		return;
> +
> +	if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +							0,
> +							IIO_MOD_X,
> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_RISING),
> +							ts);
I would use the following indentation:
		iio_push_event(indio_dev,
			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
						  IIO_EV_TYPE_THRESH,
						  IIO_EV_DIR_RISING),
			       ts);

> +
> +	if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +							0,
> +							IIO_MOD_Y,
> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_RISING),
> +							ts);
> +
> +	if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +							0,
> +							IIO_MOD_Z,
> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_RISING),
> +							ts);
> +}
> +
> +static irqreturn_t mma8452_interrupt(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int src;
> +
> +	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
> +	if (src < 0)
You could combine this check with !(src & MMA8452_INT_TRANS).

> +		return IRQ_NONE;
> +
> +	if (src & MMA8452_INT_TRANS) {
> +		mma8452_transient_interrupt(indio_dev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
>  static irqreturn_t mma8452_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -316,6 +451,32 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static const struct iio_event_spec mma8452_transient_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +					BIT(IIO_EV_INFO_HIGH_PASS_FILTER_3DB),
This would look better if you align the bottom line one space to the left.

> +	},
> +};
> +
> +/**
> + * Threshold is configured in fixed 8G/127 steps regardless of
> + * currently selected scale for measurement.
> + */
> +static IIO_CONST_ATTR_NAMED(accel_transient_scale, in_accel_scale, "0.617742");
what's this 0.617742 based on?

> +
> +static struct attribute *mma8452_event_attributes[] = {
> +	&iio_const_attr_accel_transient_scale.dev_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group mma8452_event_attribute_group = {
> +	.attrs = mma8452_event_attributes,
> +	.name = "events",
> +};
> +
>  #define MMA8452_CHANNEL(axis, idx) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -332,6 +493,8 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
>  		.shift = 4, \
>  		.endianness = IIO_BE, \
>  	}, \
> +	.event_spec = mma8452_transient_event, \
> +	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
>  }
>  
>  static const struct iio_chan_spec mma8452_channels[] = {
> @@ -355,6 +518,11 @@ static const struct iio_info mma8452_info = {
>  	.attrs = &mma8452_group,
>  	.read_raw = &mma8452_read_raw,
>  	.write_raw = &mma8452_write_raw,
> +	.event_attrs = &mma8452_event_attribute_group,
> +	.read_event_value = &mma8452_read_thresh,
> +	.write_event_value = &mma8452_write_thresh,
> +	.read_event_config = &mma8452_read_event_config,
> +	.write_event_config = &mma8452_write_event_config,
>  	.debugfs_reg_access = &mma8452_reg_access_dbg,
>  	.driver_module = THIS_MODULE,
>  };
> @@ -425,6 +593,37 @@ static int mma8452_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * By default set transient threshold to max to avoid events if
> +	 * enabling without configuring threshold
This sentence should be finished with a full stop.

> +	 */
> +	ret = i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS, 0x7f);
Yet another instance, which would benefit from the mentioned definition.

> +	if (ret < 0)
> +		return ret;
> +
> +	if (client->irq) {
> +		/*
> +		 * Although we enable the transient interrupt source once and
> +		 * for all here the transient event detection itself is not
> +		 * enabled until userspace asks for it by
> +		 * mma8452_write_event_config()
> +		 */
> +		int supported_interrupts = MMA8452_INT_TRANS;
> +
> +		/* Assume wired to INT1 pin */
> +		ret = i2c_smbus_write_byte_data(client,
> +						MMA8452_CTRL_REG5,
> +						supported_interrupts);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = i2c_smbus_write_byte_data(client,
> +						MMA8452_CTRL_REG4,
> +						supported_interrupts);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
>  		(MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
>  	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
> @@ -437,9 +636,20 @@ static int mma8452_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev,
> +						client->irq,
> +						NULL, mma8452_interrupt,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						client->name, indio_dev);
> +		if (ret)
> +			goto buffer_cleanup;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		goto buffer_cleanup;
> +
>  	return 0;
>  
>  buffer_cleanup:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

