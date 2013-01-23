Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-073.synserver.de ([212.40.185.73]:1323 "EHLO
	smtp-out-073.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab3AWJpE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jan 2013 04:45:04 -0500
Message-ID: <50FFB154.1090205@metafoo.de>
Date: Wed, 23 Jan 2013 10:45:56 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio:accel: Add STMicroelectronics accelerometers
 driver
References: <1358757380-3187-1-git-send-email-denis.ciocca@st.com> <1358757380-3187-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358757380-3187-3-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Same comments apply to the gyro and magnetometer driver

[...]
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> new file mode 100644
> index 0000000..ac90903
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -0,0 +1,119 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012-2013 STMicroelectronics Inc.
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

Never include this file directly. Use asm/byteorder.h instead. But I don't
think you need it here anyway, so just drop it

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
[...]
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> new file mode 100644
> index 0000000..4c32a4d
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -0,0 +1,582 @@
[..]
> +static int st_accel_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *ch, int *val,
> +							int *val2, long mask)
> +{
> +	int err;
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		err = st_sensors_read_info_raw(indio_dev, ch, val,
> +					&st_accel_sensors[adata->index]);
> +		if (err < 0)
> +			goto read_error;
> +
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
> +	return err;
> +}
> +
> +static int st_accel_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	int err;
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		err = st_sensors_set_fullscale_by_gain(indio_dev,
> +					&st_accel_sensors[adata->index], val2);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool state)
> +{
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
> +	return st_sensors_set_dataready_irq(indio_dev,
> +					&st_accel_sensors[adata->index], state);
> +}
> +EXPORT_SYMBOL(st_accel_set_dataready_irq);
> +
> +int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit)
> +{
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
> +	return st_sensors_set_axis_enable(indio_dev,
> +				&st_accel_sensors[adata->index], active_bit);
> +}
> +EXPORT_SYMBOL(st_accel_set_axis_enable);
> +
> +int st_accel_set_enable(struct iio_dev *indio_dev, bool enable)
> +{
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
> +	return st_sensors_set_enable(indio_dev,
> +				&st_accel_sensors[adata->index], enable);
> +}
> +EXPORT_SYMBOL(st_accel_set_enable);
> +
> +static ssize_t st_accel_sysfs_set_sampling_frequency(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	int err;
> +	unsigned int odr;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
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
> +	return sprintf(buf, "%d\n", adata->odr);
> +}
> +
> +static ssize_t st_accel_sysfs_scale_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
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
> +	return st_sensors_get_sampling_frequency_avl(indio_dev,
> +			st_accel_sensors[adata->index].odr.odr_avl, buf);
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_accel_sysfs_sampling_frequency_avail);
> +
> +static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
> +					st_accel_sysfs_scale_avail, NULL , 0);
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +			st_accel_sysfs_get_sampling_frequency,
> +					st_accel_sysfs_set_sampling_frequency);
> +
> +static struct attribute *st_accel_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group st_accel_attribute_group = {
> +	.attrs = st_accel_attributes,
> +};
> +


Still lots of duplication here. But wellm w

> +static const struct iio_info accel_info = {
> +	.driver_module = THIS_MODULE,
> +	.attrs = &st_accel_attribute_group,
> +	.read_raw = &st_accel_read_raw,
> +	.write_raw = &st_accel_write_raw,
> +};
> +
> +static struct iio_trigger_ops st_accel_trigger_ops = {
const
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = &st_accel_trig_set_state,

Does this work if CONFIG_IIO_BUFFER is disabled? st_accel_trig_set_state is
a static inline in that case. I'd move st_accel_trigger_ops to the
st_accel_buffer.c and add a #define st_accel_trigger_ops NULL for the case
where IIO_BUFFER is not selected.

> +};
