Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:49047 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933047Ab0JXWPZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 18:15:25 -0400
Message-ID: <4CC4B15E.4090401@cam.ac.uk>
Date: Sun, 24 Oct 2010 23:21:18 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 07/14] staging: iio: adc: new driver for AD7475/6/6A/7/7A/8/8A
 and AD7495 devices
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org> <1287865757-1031-7-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287865757-1031-7-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/10 21:29, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 

This one looks familiar ;) It's already merged
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  drivers/staging/iio/adc/Kconfig       |   11 ++
>  drivers/staging/iio/adc/Makefile      |    4 +
>  drivers/staging/iio/adc/ad7476.h      |   66 +++++++++
>  drivers/staging/iio/adc/ad7476_core.c |  203 ++++++++++++++++++++++++++++
>  drivers/staging/iio/adc/ad7476_ring.c |  240 +++++++++++++++++++++++++++++++++
>  5 files changed, 524 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/ad7476.h
>  create mode 100644 drivers/staging/iio/adc/ad7476_core.c
>  create mode 100644 drivers/staging/iio/adc/ad7476_ring.c
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 59d6fb6..4cb1542 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -75,3 +75,14 @@ config AD7416
>  	help
>  	  Say yes here to build support for Analog Devices AD74167/8
>  	  temperature sensors and ADC.
> +
> +config AD7476
> +	tristate "Analog Devices AD7475/6/7/8 and AD7495 ADC driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD7475/6/7/8,
> +	  AD7495 ADC driver.
> +	  If unsure, say N (but it's safe to say "Y").
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7476.
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index e95c8d4..67e6341 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -5,6 +5,9 @@
>  max1363-y := max1363_core.o
>  max1363-y += max1363_ring.o
>  
> +ad7476-y := ad7476_core.o
> +ad7476-$(CONFIG_IIO_RING_BUFFER) += ad7476_ring.o
> +
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_AD7150) += ad7150.o
>  obj-$(CONFIG_AD7152) += ad7152.o
> @@ -13,3 +16,4 @@ obj-$(CONFIG_AD7298) += ad7298.o
>  obj-$(CONFIG_AD7314) += ad7314.o
>  obj-$(CONFIG_AD7414) += ad7414.o
>  obj-$(CONFIG_AD7416) += ad7416.o
> +obj-$(CONFIG_AD7476) += ad7476.o
> diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
> new file mode 100644
> index 0000000..fc69f83
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ad7476.h
> @@ -0,0 +1,66 @@
> +#ifndef _AD7476_H_
> +#define  _AD7476_H_
> +
> +struct ad7476_mode {
> +	const char	*name;
> +	int		numvals;
> +};
> +
> +struct ad7476_state {
> +	struct iio_dev			*indio_dev;
> +	struct spi_device		*spi;
> +	char				setupbyte;
> +	char				configbyte;
> +	const struct ad7476_chip_info	*chip_info;
> +	const struct ad7476_mode	*current_mode;
> +	struct work_struct		poll_work;
> +	atomic_t			protect_ring;
> +	struct iio_trigger		*trig;
> +	struct spi_transfer		xfer;
> +	struct spi_message		msg;
> +	unsigned char			data[2];
> +};
> +
> +#define CHIP_NAME "AD7876/7/8"
> +
> +#ifdef CONFIG_IIO_RING_BUFFER
> +
> +ssize_t ad7476_scan_from_ring(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf);
> +int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev);
> +void ad7476_ring_cleanup(struct iio_dev *indio_dev);
> +
> +int ad7476_initialize_ring(struct iio_ring_buffer *ring);
> +void ad7476_uninitialize_ring(struct iio_ring_buffer *ring);
> +
> +#else /* CONFIG_IIO_RING_BUFFER */
> +
> +static inline void ad7476_uninitialize_ring(struct iio_ring_buffer *ring)
> +{
> +}
> +
> +static inline int ad7476_initialize_ring(struct iio_ring_buffer *ring)
> +{
> +	return 0;
> +}
> +
> +
> +static inline ssize_t ad7476_scan_from_ring(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	return 0;
> +}
> +
> +static inline int
> +ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +
> +static inline void ad7476_ring_cleanup(struct iio_dev *indio_dev)
> +{
> +}
> +#endif /* CONFIG_IIO_RING_BUFFER */
> +#endif /* _AD7476_H_ */
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
> new file mode 100644
> index 0000000..7181440
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -0,0 +1,203 @@
> +/*
> + * AD7476/5/7/8 (A) SPI ADC driver
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/workqueue.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/spi/spi.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +
> +#include "ad7476.h"
> +
> +static const struct ad7476_mode ad7476_mode_table[] = {
> +	{
> +		.name = "s0",
> +		.numvals = 1,
> +	},
> +};
> +
> +static ssize_t ad7476_scan_direct(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7476_state *st = dev_info->dev_data;
> +	int ret;
> +	struct spi_device *spi = st->spi;
> +
> +	ret = spi_sync(spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", (st->data[0] << 8) | st->data[1]);
> +}
> +
> +static ssize_t ad7476_scan(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	int ret;
> +
> +	mutex_lock(&dev_info->mlock);
> +	if (dev_info->currentmode == INDIO_RING_TRIGGERED)
> +		ret = ad7476_scan_from_ring(dev, attr, buf);
> +	else
> +		ret = ad7476_scan_direct(dev, attr, buf);
> +	mutex_unlock(&dev_info->mlock);
> +
> +	return ret;
> +}
> +
> +/* Cannot query the device, so use local copy of state */
> +static ssize_t ad7476_show_scan_mode(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7476_state *st = dev_info->dev_data;
> +
> +	return sprintf(buf, "%s\n", st->current_mode->name);
> +}
> +
> +
> +static IIO_DEV_ATTR_AVAIL_SCAN_MODES(ad7476_show_scan_mode);
> +static IIO_DEV_ATTR_SCAN_MODE(S_IRUGO | S_IWUSR,
> +		       ad7476_show_scan_mode, NULL);
> +
> +static IIO_DEV_ATTR_SCAN(ad7476_scan);
> +
> +static ssize_t ad7476_show_name(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	return sprintf(buf, "%s\n", CHIP_NAME);
> +}
> +
> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad7476_show_name, NULL, 0);
> +
> +/*name export */
> +
> +static struct attribute *ad7476_attributes[] = {
> +	&iio_dev_attr_available_scan_modes.dev_attr.attr,
> +	&iio_dev_attr_scan_mode.dev_attr.attr,
> +	&iio_dev_attr_scan.dev_attr.attr,
> +	&iio_dev_attr_name.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad7476_attribute_group = {
> +	.attrs = ad7476_attributes,
> +};
> +
> +static int __devinit ad7476_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct ad7476_state *st = kzalloc(sizeof(*st), GFP_KERNEL);
> +	if (st == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	spi_set_drvdata(spi, st);
> +
> +	atomic_set(&st->protect_ring, 0);
> +	st->spi = spi;
> +
> +	st->indio_dev = iio_allocate_device();
> +	if (st->indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_st;
> +	}
> +
> +	/* Estabilish that the iio_dev is a child of the i2c device */
> +	st->indio_dev->dev.parent = &spi->dev;
> +	st->indio_dev->attrs = &ad7476_attribute_group;
> +	st->indio_dev->dev_data = (void *)(st);
> +	st->indio_dev->driver_module = THIS_MODULE;
> +	st->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	st->current_mode = &ad7476_mode_table[0];
> +
> +	/* Setup default message */
> +
> +	st->xfer.rx_buf = &st->data;
> +	st->xfer.len = st->current_mode->numvals * 2;
> +
> +	spi_message_init(&st->msg);
> +	spi_message_add_tail(&st->xfer, &st->msg);
> +
> +	ret = ad7476_register_ring_funcs_and_init(st->indio_dev);
> +	if (ret)
> +		goto error_free_device;
> +
> +	ret = iio_device_register(st->indio_dev);
> +	if (ret)
> +		goto error_free_device;
> +
> +	ret = ad7476_initialize_ring(st->indio_dev->ring);
> +	if (ret)
> +		goto error_cleanup_ring;
> +	return 0;
> +
> +error_cleanup_ring:
> +	ad7476_ring_cleanup(st->indio_dev);
> +	iio_device_unregister(st->indio_dev);
> +error_free_device:
> +	iio_free_device(st->indio_dev);
> +error_free_st:
> +	kfree(st);
> +error_ret:
> +	return ret;
> +}
> +
> +static int ad7476_remove(struct spi_device *spi)
> +{
> +	struct ad7476_state *st = spi_get_drvdata(spi);
> +	struct iio_dev *indio_dev = st->indio_dev;
> +	ad7476_uninitialize_ring(indio_dev->ring);
> +	ad7476_ring_cleanup(indio_dev);
> +	iio_device_unregister(indio_dev);
> +	kfree(st);
> +
> +	return 0;
> +}
> +
> +
> +static struct spi_driver ad7476_driver = {
> +	.driver = {
> +		.name	= "ad7476",
> +		.bus	= &spi_bus_type,
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= ad7476_probe,
> +	.remove		= __devexit_p(ad7476_remove),
> +};
> +
> +static int __init ad7476_init(void)
> +{
> +	return spi_register_driver(&ad7476_driver);
> +}
> +module_init(ad7476_init);
> +
> +static void __exit ad7476_exit(void)
> +{
> +	spi_unregister_driver(&ad7476_driver);
> +}
> +module_exit(ad7476_exit);
> +
> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> +MODULE_DESCRIPTION("Analog Devices AD7475/6/7/8(A) ADC");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:ad7476");
> diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
> new file mode 100644
> index 0000000..c1fe346
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ad7476_ring.c
> @@ -0,0 +1,240 @@
> +/*
> + * Copyright 2010 Analog Devices Inc.
> + * Copyright (C) 2008 Jonathan Cameron
> + *
> + * Licensed under the GPL-2 or later.
> + *
> + * ad7476_ring.c
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/workqueue.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/spi/spi.h>
> +
> +#include "../iio.h"
> +#include "../ring_generic.h"
> +#include "../ring_sw.h"
> +#include "../trigger.h"
> +#include "../sysfs.h"
> +
> +#include "ad7476.h"
> +
> +ssize_t ad7476_scan_from_ring(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad7476_state *info = dev_info->dev_data;
> +	int i, ret, len = 0;
> +	char *ring_data;
> +
> +	ring_data = kmalloc(info->current_mode->numvals*2, GFP_KERNEL);
> +	if (ring_data == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	ret = dev_info->ring->access.read_last(dev_info->ring, ring_data);
> +	if (ret)
> +		goto error_free_ring_data;
> +	len += sprintf(buf+len, "ring ");
> +	for (i = 0; i < info->current_mode->numvals; i++)
> +		len += sprintf(buf + len, "%d ",
> +			       ((int)(ring_data[i*2 + 0] & 0xFF) << 8)
> +			       + ((int)(ring_data[i*2 + 1])));
> +	len += sprintf(buf + len, "\n");
> +	kfree(ring_data);
> +
> +	return len;
> +
> +error_free_ring_data:
> +	kfree(ring_data);
> +error_ret:
> +	return ret;
> +}
> +
> +/**
> + * ad7476_ring_preenable() setup the parameters of the ring before enabling
> + *
> + * The complex nature of the setting of the nuber of bytes per datum is due
> + * to this driver currently ensuring that the timestamp is stored at an 8
> + * byte boundary.
> + **/
> +static int ad7476_ring_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7476_state *st = indio_dev->dev_data;
> +	size_t d_size;
> +
> +	if (indio_dev->ring->access.set_bpd) {
> +		d_size = st->current_mode->numvals*2 + sizeof(s64);
> +		if (d_size % 8)
> +			d_size += 8 - (d_size % 8);
> +		indio_dev->ring->access.set_bpd(indio_dev->ring, d_size);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ad7476_ring_postenable() typical ring post enable
> + *
> + * Only not moved into the core for the hardware ring buffer cases
> + * that are more sophisticated.
> + **/
> +static int ad7476_ring_postenable(struct iio_dev *indio_dev)
> +{
> +	if (indio_dev->trig == NULL)
> +		return 0;
> +	return iio_trigger_attach_poll_func(indio_dev->trig,
> +					    indio_dev->pollfunc);
> +}
> +
> +/**
> + * ad7476_ring_predisable() runs just prior to ring buffer being disabled
> + *
> + * Typical predisable function which ensures that no trigger events can
> + * occur before we disable the ring buffer (and hence would have no idea
> + * what to do with them)
> + **/
> +static int ad7476_ring_predisable(struct iio_dev *indio_dev)
> +{
> +	if (indio_dev->trig)
> +		return iio_trigger_dettach_poll_func(indio_dev->trig,
> +						     indio_dev->pollfunc);
> +	else
> +		return 0;
> +}
> +
> +/**
> + * ad7476_poll_func_th() th of trigger launched polling to ring buffer
> + *
> + * As sampling only occurs on i2c comms occuring, leave timestamping until
> + * then.  Some triggers will generate their own time stamp.  Currently
> + * there is no way of notifying them when no one cares.
> + **/
> +void ad7476_poll_func_th(struct iio_dev *indio_dev)
> +{
> +	struct ad7476_state *st = indio_dev->dev_data;
> +
> +	schedule_work(&st->poll_work);
> +
> +	return;
> +}
> +/**
> + * ad7476_poll_bh_to_ring() bh of trigger launched polling to ring buffer
> + * @work_s:	the work struct through which this was scheduled
> + *
> + * Currently there is no option in this driver to disable the saving of
> + * timestamps within the ring.
> + * I think the one copy of this at a time was to avoid problems if the
> + * trigger was set far too high and the reads then locked up the computer.
> + **/
> +static void ad7476_poll_bh_to_ring(struct work_struct *work_s)
> +{
> +	struct ad7476_state *st = container_of(work_s, struct ad7476_state,
> +						  poll_work);
> +	struct iio_dev *indio_dev = st->indio_dev;
> +	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(indio_dev->ring);
> +	s64 time_ns;
> +	__u8 *rxbuf;
> +	int b_sent;
> +	size_t d_size;
> +
> +	/* Ensure the timestamp is 8 byte aligned */
> +	d_size = st->current_mode->numvals*2 + sizeof(s64);
> +	if (d_size % sizeof(s64))
> +		d_size += sizeof(s64) - (d_size % sizeof(s64));
> +
> +	/* Ensure only one copy of this function running at a time */
> +	if (atomic_inc_return(&st->protect_ring) > 1)
> +		return;
> +
> +	/* Monitor mode prevents reading. Whilst not currently implemented
> +	 * might as well have this test in here in the meantime as it does
> +	 * no harm.
> +	 */
> +	if (st->current_mode->numvals == 0)
> +		return;
> +
> +	rxbuf = kmalloc(d_size,	GFP_KERNEL);
> +	if (rxbuf == NULL)
> +		return;
> +
> +	b_sent = spi_read(st->spi, rxbuf,
> +				 st->current_mode->numvals * 2);
> +	if (b_sent < 0)
> +		goto done;
> +
> +	time_ns = iio_get_time_ns();
> +
> +	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
> +
> +	indio_dev->ring->access.store_to(&ring->buf, rxbuf, time_ns);
> +done:
> +	kfree(rxbuf);
> +	atomic_dec(&st->protect_ring);
> +}
> +
> +
> +int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> +{
> +	struct ad7476_state *st = indio_dev->dev_data;
> +	int ret = 0;
> +
> +	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
> +	if (!indio_dev->ring) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	/* Effectively select the ring buffer implementation */
> +	iio_ring_sw_register_funcs(&st->indio_dev->ring->access);
> +	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
> +	if (indio_dev->pollfunc == NULL) {
> +		ret = -ENOMEM;
> +		goto error_deallocate_sw_rb;
> +	}
> +	/* Configure the polling function called on trigger interrupts */
> +	indio_dev->pollfunc->poll_func_main = &ad7476_poll_func_th;
> +	indio_dev->pollfunc->private_data = indio_dev;
> +
> +	/* Ring buffer functions - here trigger setup related */
> +	indio_dev->ring->postenable = &ad7476_ring_postenable;
> +	indio_dev->ring->preenable = &ad7476_ring_preenable;
> +	indio_dev->ring->predisable = &ad7476_ring_predisable;
> +	INIT_WORK(&st->poll_work, &ad7476_poll_bh_to_ring);
> +
> +	/* Flag that polled ring buffering is possible */
> +	indio_dev->modes |= INDIO_RING_TRIGGERED;
> +	return 0;
> +error_deallocate_sw_rb:
> +	iio_sw_rb_free(indio_dev->ring);
> +error_ret:
> +	return ret;
> +}
> +
> +void ad7476_ring_cleanup(struct iio_dev *indio_dev)
> +{
> +	/* ensure that the trigger has been detached */
> +	if (indio_dev->trig) {
> +		iio_put_trigger(indio_dev->trig);
> +		iio_trigger_dettach_poll_func(indio_dev->trig,
> +					      indio_dev->pollfunc);
> +	}
> +	kfree(indio_dev->pollfunc);
> +	iio_sw_rb_free(indio_dev->ring);
> +}
> +
> +void ad7476_uninitialize_ring(struct iio_ring_buffer *ring)
> +{
> +	iio_ring_buffer_unregister(ring);
> +}
> +
> +int ad7476_initialize_ring(struct iio_ring_buffer *ring)
> +{
> +	return iio_ring_buffer_register(ring, 0);
> +}

