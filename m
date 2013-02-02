Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <1359401903-15664-1-git-send-email-ggao@invensense.com> <510BA44F.5040803@metafoo.de>
In-Reply-To: <510BA44F.5040803@metafoo.de>
MIME-Version: 1.0
Date: Fri, 1 Feb 2013 16:29:35 -0800
Message-ID: <e9a9902f75d4232cbe4930b49d732fb6@mail.gmail.com>
Subject: RE: [PATCH] [V8] Invensense MPU6050 Device Driver.
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Dear Lars-Peter,
	Thanks for the comments. I have submitted another version for
review. Basically , it fixes everything you said. One thing I am not sure
is the hardware info. I have put it per my understanding. Hopefully, it
fits the requirements.

Best Regards,

Ge GAO


-----Original Message-----
From: Lars-Peter Clausen [mailto:lars@metafoo.de]
Sent: Friday, February 01, 2013 3:18 AM
To: Ge GAO
Cc: Jonathan Cameron; linux-iio@vger.kernel.org
Subject: Re: [PATCH] [V8] Invensense MPU6050 Device Driver.

Hi,

Overall it looks good, a few bits of pieces which need to be fixed.

Also, you are inconsistent in your coding style. E.g. sometime you use if
((foo < 0) || (bar != 2)) a few lines later you use if (foo < 0 || bar !=
2). I think the prefered kernel style is the one without the extra
parenthesis.


On 01/28/2013 08:38 PM, Ge GAO wrote:
> From: Ge Gao <ggao@invensense.com>
>
> --This the basic function of Invensense MPU6050 Deivce driver.
> --Make all non-static variable and functions names into INV_MPU6050.
> --Add call-back function for trigger.
> --other cleanup.
>
> Change-Id: I70991a64707114b76b420d4d89bd6d1e8028a207

No need to include this in the upstream submission.

> Signed-off-by: Ge Gao <ggao@invensense.com>
> ---
[...]
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig
> b/drivers/iio/imu/inv_mpu6050/Kconfig
> new file mode 100644
> index 0000000..938a870
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -0,0 +1,13 @@
> +#
> +# inv-mpu6050 drivers for Invensense MPU devices and combos #
> +
> +config INV_MPU6050_IIO
> +	tristate "Invensense MPU6050 devices"
> +	depends on I2C && SYSFS && IIO

The depends on IIO is redundant

> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  This driver supports the Invensense MPU6050 devices.
> +	  It is a gyroscope/accelerometer combo device.
> +	  This driver can be built as a module. The module will be called
> +	  inv-mpu6050.
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile
> b/drivers/iio/imu/inv_mpu6050/Makefile
> new file mode 100644
> index 0000000..3a677c7
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for Invensense MPU6050 device.
> +#
> +
> +obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o inv-mpu6050-objs :=
> +inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> new file mode 100644
> index 0000000..062a570
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
[...]
> +
> +/*
> + *  inv_mpu6050_temperature_show() - Read temperature from registers.
> + */
> +static int inv_mpu6050_temperature_show(struct inv_mpu6050_state  *st,
> +						int *val)
> +{
> +	int result;
> +	s16 temp;
> +	__be16 d;
> +
> +	result = i2c_smbus_read_i2c_block_data(st->client,
> +				       st->reg->temperature, 2, (u8 *)&d);
> +	if (result != 2) {
> +		dev_err(&st->client->adapter->dev, "%s failed %d\n",
__func__,
> +				result);
> +		return -EINVAL;
> +	}
> +	temp = (s16)(be16_to_cpup(&d));
> +	*val = temp;
> +
> +	return IIO_VAL_INT;

Hm, this function is pretty much the same as inv_mpu6050_sensor_show(
st->reg->temperature, IIO_MOD_X, val)

> +}
> +
> +static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int
reg,
> +				int axis, int *val)
> +{
> +	int ind, result;
> +	__be16 d;
> +
> +	ind = (axis - IIO_MOD_X) * 2;
> +	result = i2c_smbus_read_i2c_block_data(st->client, reg + ind,  2,
> +						(u8 *)&d);
> +	if (result != 2)
> +		return -EINVAL;
> +	*val = (short)be16_to_cpup(&d);
> +
> +	return IIO_VAL_INT;
> +}
> +
[...]
> +/*
> + *  inv_mpu6050_fifo_rate_store() - Set fifo rate.
> + */
> +static ssize_t inv_mpu6050_fifo_rate_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count) {
> +	s32 fifo_rate;
> +	u8 d;
> +	int result;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);

Have you tested this aginst the latest IIO? This should not have been
working for quite some time now. Use:

stuct iio_dev *indio_dev = dev_to_iio_dev(dev);

> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +
> +	if (kstrtoint(buf, 10, &fifo_rate))
> +		return -EINVAL;
> +	if ((fifo_rate < INV_MPU6050_MIN_FIFO_RATE) ||
> +				(fifo_rate > INV_MPU6050_MAX_FIFO_RATE))
> +		return -EINVAL;
> +	if (fifo_rate == st->chip_config.fifo_rate)
> +		return count;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	if (st->chip_config.enable) {
> +		result = -EBUSY;
> +		goto fifo_rate_fail;
> +	}
> +	result = inv_mpu6050_set_power_itg(st, true);
> +	if (result)
> +		goto fifo_rate_fail;
> +
> +	d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
> +	result = inv_mpu6050_write_reg(st, st->reg->sample_rate_div, d);
> +	if (result)
> +		goto fifo_rate_fail;
> +	st->chip_config.fifo_rate = fifo_rate;
> +
> +	result = inv_mpu6050_set_lpf(st, fifo_rate);
> +	if (result)
> +		goto fifo_rate_fail;
> +
> +fifo_rate_fail:
> +	result |= inv_mpu6050_set_power_itg(st, false);
> +	mutex_unlock(&indio_dev->mlock);
> +	if (result)
> +		return result;
> +
> +	return count;
> +}
> +
> +/*
> + *  inv_fifo_rate_show() - Get the current sampling rate.
> + */
> +static ssize_t inv_fifo_rate_show(struct device *dev,
> +	struct device_attribute *attr, char *buf) {
> +	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));

Same here.

> +
> +	return sprintf(buf, "%d\n", st->chip_config.fifo_rate); }
> +
> +/*
> + * inv_attr_show() -  calling this function will show current
> + *                     parameters.
> + */
> +static ssize_t inv_attr_show(struct device *dev,
> +	struct device_attribute *attr, char *buf) {
> +	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));

And here

> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	s8 *m;
> +
> +	switch (this_attr->address) {
> +	/* In MPU6050, the two matrix are the same because gyro and accel
> +	   are integrated in one chip */
> +	case ATTR_GYRO_MATRIX:
> +	case ATTR_ACCL_MATRIX:
> +		m = st->plat_data.orientation;
> +
> +		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d,
%d\n",
> +			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7],
m[8]);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * inv_mpu6050_validate_trigger() - validate_trigger callback for
invensense
> + *                                  MPU6050 device.
> + * @indio_dev: The IIO device
> + * @trig: The new trigger
> + *
> + * Returns: 0 if the 'trig' matches the trigger registered by the
> +MPU6050
> + * device, -EINVAL otherwise.
> + */
> +int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
> +					struct iio_trigger *trig)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +
> +	if (st->trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(inv_mpu6050_validate_trigger);

inv_mpu6050_validate_trigger is only used in this file, so there isn't
really a need to export it or to make it non-static.

[...]
> +
> +/*
> + *  inv_check_and_setup_chip() - check and setup chip.
> + */
> +static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
> +		const struct i2c_device_id *id)
> +{
> +	int result;
> +
> +	st->chip_type = INV_MPU6050;
> +	st->hw  = &hw_info[st->chip_type];
> +	st->reg = &reg_set_6050;

If the reg_set is chip specific should it be part of the hw_info struct?
Same goes for the default chip config.

[...]
> +}
> +
> +/**
> + *  inv_mpu_probe() - probe function.
> + *  @client:          i2c client.
> + *  @id:              i2c device id.
> + *
> + *  Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_mpu_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct inv_mpu6050_state *st;
> +	struct iio_dev *indio_dev;
> +	int result;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {

As far as I can see you are only using i2c_smbus_read_i2c_block_data
i2c_smbus_write_i2c_block_data. So checking for
I2C_FUNC_SMBUS_READ_I2C_BLOCK | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK should be
sufficent.

> +		result = -ENOSYS;
> +		goto out_no_free;
> +	}
> +	indio_dev = iio_device_alloc(sizeof(*st));
> +	if (indio_dev == NULL) {
> +		result =  -ENOMEM;
> +		goto out_no_free;
> +	}
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +	/* put cast here to avoid compilation warning */

It's not only a warning, without the cast this simply would not compile.

> +	st->plat_data = *(struct inv_mpu6050_platform_data
> +				*)dev_get_platdata(&client->dev);
> +	/* power is turned on inside check chip type*/
> +	result = inv_check_and_setup_chip(st, id);
> +	if (result)
> +		goto out_free;
> +
> +	result = inv_mpu6050_init_config(indio_dev);
> +	if (result) {
> +		dev_err(&client->dev,
> +			"Could not initialize device.\n");
> +		goto out_free;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->channels = inv_mpu_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> +
> +	indio_dev->info = &mpu_info;
> +	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
> +
> +	iio_triggered_buffer_setup(indio_dev,
> +				inv_mpu6050_irq_handler,
> +				inv_mpu6050_read_fifo,
> +				NULL);

result = ...

> +	if (result) {
> +		dev_err(&st->client->dev, "configure buffer fail %d\n",
> +				result);
> +		goto out_free;
> +	}
> +	result = inv_mpu6050_probe_trigger(indio_dev);
> +	if (result) {
> +		dev_err(&st->client->dev, "trigger probe fail %d\n",
result);
> +		goto out_unreg_ring;
> +	}
> +
> +	INIT_KFIFO(st->timestamps);
> +	spin_lock_init(&st->time_stamp_lock);
> +	result = iio_device_register(indio_dev);
> +	if (result) {
> +		dev_err(&st->client->dev, "IIO register fail %d\n",
result);
> +		goto out_remove_trigger;
> +	}
> +
> +	return 0;
> +
> +out_remove_trigger:
> +	inv_mpu6050_remove_trigger(st);
> +out_unreg_ring:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +out_free:
> +	iio_device_free(indio_dev);
> +out_no_free:
> +
> +	return result;
> +}
> +
[...]
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> new file mode 100644
> index 0000000..768b1a7
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
[...]
> +int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable) {
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int result;
> +	u8 d;
> +
> +	if (enable) {
> +		result = inv_mpu6050_set_power_itg(st, true);
> +		if (result)
> +			return result;
> +		inv_scan_query(indio_dev);
> +		if (st->chip_config.gyro_fifo_enable) {
> +			result = inv_mpu6050_switch_engine(st, true,
> +					INV_MPU6050_BIT_PWR_GYRO_STBY);
> +			if (result)
> +				return result;
> +		}
> +		if (st->chip_config.accl_fifo_enable) {
> +			result = inv_mpu6050_switch_engine(st, true,
> +					INV_MPU6050_BIT_PWR_ACCL_STBY);
> +			if (result)
> +				return result;
> +		}
> +		result = inv_reset_fifo(indio_dev);
> +		if (result)
> +			return result;
> +	} else {
> +		d = 0;

How about just using 0 direclty instead of d below?

> +		result = inv_mpu6050_write_reg(st, st->reg->fifo_en, d);
> +		if (result)
> +			return result;
> +
> +		result = inv_mpu6050_write_reg(st, st->reg->int_enable,
d);
> +		if (result)
> +			return result;
> +
> +		result = inv_mpu6050_write_reg(st, st->reg->user_ctrl, d);
> +		if (result)
> +			return result;
> +
> +		result = inv_mpu6050_switch_engine(st, false,
> +					INV_MPU6050_BIT_PWR_GYRO_STBY);
> +		if (result)
> +			return result;
> +
> +		result = inv_mpu6050_switch_engine(st, false,
> +					INV_MPU6050_BIT_PWR_ACCL_STBY);
> +		if (result)
> +			return result;
> +		result = inv_mpu6050_set_power_itg(st, false);
> +		if (result)
> +			return result;
> +	}
> +	st->chip_config.enable = enable;
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> new file mode 100644
> index 0000000..b96df2b
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -0,0 +1,71 @@
> +/*
> +* Copyright (C) 2012 Invensense, Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation,
> +and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*/
> +
> +#include "inv_mpu_iio.h"
> +
> +/*
> + * inv_mpu_data_rdy_trigger_set_state() set data ready interrupt
> +state  */ static int inv_mpu_data_rdy_trigger_set_state(struct
> +iio_trigger *trig,
> +						bool state)
> +{
> +	return inv_mpu6050_set_enable(trig->private_data, state);

How about moving inv_mpu6050_set_enable to this file? It only seems to be
used here.

> +}
> +
> +static const struct iio_trigger_ops inv_mpu_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
> +};
> +
> +int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev) {
> +	int ret;
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +
> +	st->trig = iio_trigger_alloc("%s-dev%d",
> +					indio_dev->name,
> +					indio_dev->id);
> +	if (st->trig == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	ret = request_irq(st->client->irq,
&iio_trigger_generic_data_rdy_poll,
> +				IRQF_TRIGGER_RISING,
> +				"inv_mpu",
> +				st->trig);
> +	if (ret)
> +		goto error_free_trig;
> +	st->trig->dev.parent = &st->client->dev;
> +	st->trig->private_data = indio_dev;
> +	st->trig->ops = &inv_mpu_trigger_ops;
> +	ret = iio_trigger_register(st->trig);
> +	if (ret)
> +		goto error_free_irq;
> +	indio_dev->trig = st->trig;
> +
> +	return 0;
> +
> +error_free_irq:
> +	free_irq(st->client->irq, st->trig);
> +error_free_trig:
> +	iio_trigger_free(st->trig);
> +error_ret:
> +	return ret;
> +	return 0;

The 'return 0' makes no sense.

> +}
> +
> +void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st) {
> +	iio_trigger_unregister(st->trig);

What about the IRQ, I think it needs to be freed here.

> +	iio_trigger_free(st->trig);
> +}
