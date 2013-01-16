Return-Path: <lars@metafoo.de>
Message-ID: <50F6B90D.6020608@metafoo.de>
Date: Wed, 16 Jan 2013 15:28:29 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/9] iio:accel: Add STMicroelectronics accelerometers
 driver
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com> <1358238660-14929-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358238660-14929-3-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/15/2013 09:30 AM, Denis CIOCCA wrote:
> This patch adds generic accelerometer driver for STMicroelectronics
> accelerometers, currently it supports:
> LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
> LIS331DLH, LSM303DL, LSM303DLM, LSM330.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> ---
[...]
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> new file mode 100644
> index 0000000..4764d21
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -0,0 +1,119 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/interrupt.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +#include <linux/iio/common/st_sensors.h>
> +

This file looks pretty much the same for all drivers, any reason why it
can't be shared?

> +
> +int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = trig->private_data;
> +	return st_accel_set_dataready_irq(indio_dev, state);
> +}
> +EXPORT_SYMBOL(st_accel_trig_set_state);
> +
> +static int st_accel_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	int err;
> +
> +	err = st_accel_set_enable(indio_dev, true);
> +	if (err < 0)
> +		goto st_accel_set_enable_error;
> +
> +	err = iio_sw_buffer_preenable(indio_dev);
> +
> +st_accel_set_enable_error:
> +	return err;
> +}
> +
> +static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
> +	adata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	if (adata->buffer_data == NULL) {
> +		err = -ENOMEM;
> +		goto allocate_memory_error;
> +	}
> +
> +	err = st_accel_set_axis_enable(indio_dev,
> +					(u8)indio_dev->active_scan_mask[0]);
> +	if (err < 0)
> +		goto st_accel_buffer_postenable_error;
> +
> +	err = iio_triggered_buffer_postenable(indio_dev);
> +	if (err < 0)
> +		goto st_accel_buffer_postenable_error;
> +
> +	return err;
> +
> +st_accel_buffer_postenable_error:
> +	kfree(adata->buffer_data);
> +allocate_memory_error:
> +	return err;
> +}
> +
> +static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	int err;
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
> +	err = iio_triggered_buffer_predisable(indio_dev);
> +	if (err < 0)
> +		goto st_accel_buffer_predisable_error;
> +
> +	err = st_accel_set_axis_enable(indio_dev,
> +						ST_SENSORS_ENABLE_ALL_CHANNELS);
> +	if (err < 0)
> +		goto st_accel_buffer_predisable_error;
> +
> +	err = st_accel_set_enable(indio_dev, false);
> +
> +st_accel_buffer_predisable_error:
> +	kfree(adata->buffer_data);
> +	return err;
> +}
> +
> +static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
> +	.preenable = &st_accel_buffer_preenable,
> +	.postenable = &st_accel_buffer_postenable,
> +	.predisable = &st_accel_buffer_predisable,
> +};
> +
> +int st_accel_allocate_ring(struct iio_dev *indio_dev)
> +{
> +	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +		&st_sensors_trigger_handler, &st_accel_buffer_setup_ops);
> +}
> +EXPORT_SYMBOL(st_accel_allocate_ring);
> +
> +void st_accel_deallocate_ring(struct iio_dev *indio_dev)
> +{
> +	iio_triggered_buffer_cleanup(indio_dev);
> +}
> +EXPORT_SYMBOL(st_accel_deallocate_ring);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers buffer");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> new file mode 100644
> index 0000000..4e7108a
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_core.c
[....]
> +
> +static int st_accel_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *ch, int *val,
> +							int *val2, long mask)
> +{
> +	int err;
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +


Here again the function looks exactly the same in all three drivers and
could probably be moved to the common library.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +			err = -EBUSY;
> +			goto read_error;
> +		} else {
> +			err = st_sensors_set_enable(indio_dev,
> +					&st_accel_sensors[adata->index], true);
> +			if (err < 0)
> +				goto read_error;
> +
> +			msleep((st_accel_sensors[adata->index].bootime * 1000)
> +								/ adata->odr);
> +			err = st_sensors_read_axis_data(indio_dev,
> +							ch->address, val);
> +			if (err < 0)
> +				goto read_error;
> +
> +			*val = *val >> ch->scan_type.shift;
> +		}
> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = adata->current_fullscale->gain;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +read_error:
> +	mutex_unlock(&indio_dev->mlock);
> +	return err;
> +}
> +
> +static int st_accel_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	int err;
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +

Same here.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		err = st_sensors_set_fullscale_by_gain(indio_dev,
> +					&st_accel_sensors[adata->index], val2);
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool state)
> +{
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +

and here

> +	return st_sensors_set_dataready_irq(indio_dev,
> +					&st_accel_sensors[adata->index], state);
> +}
> +EXPORT_SYMBOL(st_accel_set_dataready_irq);
> +
> +int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit)
> +{
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +

and here

> +	return st_sensors_set_axis_enable(indio_dev,
> +				&st_accel_sensors[adata->index], active_bit);
> +}
> +EXPORT_SYMBOL(st_accel_set_axis_enable);
> +
> +static int st_accel_check_device_support(struct iio_dev *indio_dev)
> +{
> +	int i, n, err;
> +	u8 wai;
> +	struct st_sensor_data *adata = iio_priv(indio_dev);

and here.

> +
> +	err = adata->tf->read_byte(&adata->tb, adata->dev,
> +					ST_SENSORS_DEFAULT_WAI_ADDRESS, &wai);
> +	if (err < 0) {
> +		dev_err(&indio_dev->dev, "failed to read Who-Am-I register.\n");
> +		goto read_wai_error;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(st_accel_sensors); i++) {
> +		if (st_accel_sensors[i].wai == wai)
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(st_accel_sensors))
> +		goto device_not_supported;
> +
> +	for (n = 0; n < ARRAY_SIZE(st_accel_sensors[i].sensors_supported);
> +									n++) {
> +		if (strcmp(indio_dev->name,
> +			&st_accel_sensors[i].sensors_supported[n][0]) == 0)
> +			break;
> +	}
> +	if (n == ARRAY_SIZE(st_accel_sensors[i].sensors_supported)) {
> +		dev_err(&indio_dev->dev, "device name and WhoAmI mismatch.\n");
> +		goto sensor_name_mismatch;
> +	}
> +
> +	adata->index = i;
> +
> +	return i;
> +
> +device_not_supported:
> +	dev_err(&indio_dev->dev, "device not supported: WhoAmI (0x%x).\n", wai);
> +sensor_name_mismatch:
> +	err = -ENODEV;
> +read_wai_error:
> +	return err;
> +}
> +
[...]
> +
> +static ssize_t st_accel_sysfs_set_sampling_frequency(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	int err;
> +	unsigned int odr;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +

and here

> +	err = kstrtoint(buf, 10, &odr);
> +	if (err < 0)
> +		goto conversion_error;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	err = st_sensors_set_odr(indio_dev,
> +					&st_accel_sensors[adata->index], odr);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +conversion_error:
> +	return err < 0 ? err : size;
> +}
> +
> +static ssize_t st_accel_sysfs_get_sampling_frequency(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +

and here

> +	return sprintf(buf, "%d\n", adata->odr);
> +}
> +
> +static ssize_t st_accel_sysfs_scale_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +

and here

> +	return st_sensors_get_scale_avl(indio_dev,
> +			st_accel_sensors[adata->index].fs.fs_avl, buf);
> +}
> +
> +static ssize_t st_accel_sysfs_sampling_frequency_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +

and here

> +	return st_sensors_get_sampling_frequency_avl(indio_dev,
> +			st_accel_sensors[adata->index].odr.odr_avl, buf);
> +}
> +
[...]
