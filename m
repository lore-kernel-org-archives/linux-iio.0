Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44603 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbaLZLCa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 06:02:30 -0500
Message-ID: <549D4044.8050406@kernel.org>
Date: Fri, 26 Dec 2014 11:02:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Manuel Stahl <thymythos@googlemail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7] iio: acpi: Add ACPI0008 ALS driver
References: <1419349152.30443.0@smtp.gmail.com>
In-Reply-To: <1419349152.30443.0@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/12/14 15:39, Manuel Stahl wrote:
> Add basic implementation of the ACPI0008 Ambient Light Sensor driver.
> This driver currently supports only the ALI property, yet is ready to
> be easily extended to handle ALC, ALT, ALP ones as well.
> 
> V2: Fix the channel mask, so it's really reading RAW data.
> V3: Put scan timestamp into the buffer only when enabled,
>     Set the light sensor ID to 0 instead of 1
> V4: Select IIO_TRIGGERED_BUFFER as we need it here
> V5: Use irq_work to trigger the buffer
>     Use module_acpi_driver()
> V6: Align with 3.15-rc7
>    Use iio_push_to_buffers_with_timestamp()
>    Use iio_trigger_set_drvdata()
>    Use .info_mask_separate
>    Use devm_iio_device_alloc()
>    Stuff the event buffer into struct acpi_als so we don't alloc mem twice
>    Compute the evt_buffer size automatically based on acpi_als_channels[]
>    Implement .validate_device() and .validate_trigger()
>    Tested on MacBook Air (Mid 2013) and Acer IconiaTab W510V2: Fix the channel mask, so it's really reading RAW data.
Change log doubled up for some reason!
> V3: Put scan timestamp into the buffer only when enabled,
>     Set the light sensor ID to 0 instead of 1
> V4: Select IIO_TRIGGERED_BUFFER as we need it here
> V5: Use irq_work to trigger the buffer
>     Use module_acpi_driver()
> V6: Align with 3.15-rc7
>    Use iio_push_to_buffers_with_timestamp()
>    Use iio_trigger_set_drvdata()
>    Use .info_mask_separate
>    Use devm_iio_device_alloc()
>    Stuff the event buffer into struct acpi_als so we don't alloc mem twice
>    Compute the evt_buffer size automatically based on acpi_als_channels[]
>    Implement .validate_device() and .validate_trigger()
>    Tested on MacBook Air (Mid 2013) and Acer IconiaTab W510
> V7: Remove IIO trigger support (As suggested by Jonathan)
>    Add enable function (needed on Zenbook)
>    Tested on Asus Zenbook UX301L
Also - no signoffs etc

Few bits below...

In particular we are using the hardware buffer stuff here and it isn't
a hardware buffer.  Clearly that doesn't matter from the point of view
of what the code does but for clarity I think we should add an additional
buffering type for non triggered software buffers like this one.  That is
those that come off hardware that is already bundling the data up in a
form that doesn't really fit the triggered model.

By coincidence most (perhaps all) the other drivers that have used a
non triggered software buffer have also had hardware buffer backends
so the lack of such a buffer type hasn't caused confusion before.

Jonathan

> 
> diff -uprN a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> --- a/drivers/iio/light/acpi-als.c    1970-01-01 01:00:00.000000000 +0100
> +++ b/drivers/iio/light/acpi-als.c    2014-12-23 16:21:24.763821632 +0100
> @@ -0,0 +1,318 @@
> +/*
> + * ACPI Ambient Light Sensor Driver
> + *
> + * Based on ALS driver:
> + * Copyright (C) 2009 Zhang Rui <rui.zhang@intel.com>
> + *
> + * Rework for IIO subsystem:
> + * Copyright (C) 2012-2013 Martin Liska <marxin.liska@gmail.com>
> + *
> + * Final cleanup and debugging:
> + * Copyright (C) 2013-2014 Marek Vasut <marex@denx.de>
> + * Copyright (C) 2014 Manuel Stahl <thymythos@googlemail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +
> +#define ACPI_ALS_CLASS            "als"
> +#define ACPI_ALS_DEVICE_NAME        "acpi-als"
> +#define ACPI_ALS_NOTIFY_ILLUMINANCE    0x80
> +
> +ACPI_MODULE_NAME("acpi-als");
> +
> +/*
> + * So far, there's only one channel in here, but the specification for
> + * ACPI0008 says there can be more to what the block can report. Like
> + * chromaticity and such. We are ready for incoming additions!
> + */
> +static const struct iio_chan_spec acpi_als_channels[] = {
> +    {
> +        .type        = IIO_LIGHT,
> +        .scan_type    = {
> +            .sign        = 'u',
> +            .realbits    = 10,
> +            .storagebits    = 16,
> +        },
> +        .info_mask_separate    = BIT(IIO_CHAN_INFO_RAW),
> +    },
> +};
> +
> +/*
> + * The event buffer contains timestamp and all the data from
> + * the ACPI0008 block. There are multiple, but so far we only
> + * support _ALI (illuminance). Once someone adds new channels
> + * to acpi_als_channels[], the evt_buffer below will grow
> + * automatically.
> + */
> +#define EVT_NR_SOURCES        ARRAY_SIZE(acpi_als_channels)
> +#define EVT_BUFFER_SIZE        \
> +    (sizeof(int64_t) + (EVT_NR_SOURCES * sizeof(uint16_t)))
> +
> +struct acpi_als {
> +    struct acpi_device    *device;
> +    struct mutex        lock;
> +
> +    uint16_t        evt_buffer[EVT_BUFFER_SIZE];
> +};
> +
> +/*
> + * All types of properties the ACPI0008 block can report. The ALI, ALC, ALT
> + * and ALP can all be handled by als_read_value() below, while the ALR is
> + * special.
> + *
> + * The _ALR property returns tables that can be used to fine-tune the values
> + * reported by the other props based on the particular hardware type and it's
> + * location (it contains tables for "rainy", "bright inhouse lighting" etc.).
> + *
> + * So far, we support only ALI (illuminance).
> + */
> +#define ACPI_ALS_ILLUMINANCE    "_ALI"
> +#define ACPI_ALS_CHROMATICITY    "_ALC"
> +#define ACPI_ALS_COLOR_TEMP    "_ALT"
> +#define ACPI_ALS_POLLING    "_ALP"
> +#define ACPI_ALS_TABLES        "_ALR"
> +
> +static int32_t als_read_value(struct acpi_als *als, char *prop)
> +{
> +    unsigned long long illuminance;
> +    acpi_status status;
> +
> +    status = acpi_evaluate_integer(als->device->handle,
> +                prop, NULL, &illuminance);
> +
> +    if (ACPI_FAILURE(status)) {
> +        ACPI_EXCEPTION((AE_INFO, status,
> +                "Error reading ALS illuminance"));
> +        return -EIO;
> +    }
> +
> +    return illuminance;
> +}
> +
> +static void acpi_als_notify(struct acpi_device *device, u32 event)
> +{
> +    struct iio_dev *indio_dev = acpi_driver_data(device);
> +    struct acpi_als *als = iio_priv(indio_dev);
> +    uint16_t *buffer = als->evt_buffer;
> +    int64_t time_ns = iio_get_time_ns();
> +    int32_t val;
> +
> +    mutex_lock(&als->lock);
> +
> +    memset(buffer, 0, EVT_BUFFER_SIZE);
> +
> +    switch (event) {
> +    case ACPI_ALS_NOTIFY_ILLUMINANCE:
> +        val = als_read_value(als, ACPI_ALS_ILLUMINANCE);
> +        if (val < 0)
> +            goto err_ret;
> +        *buffer++ = (uint16_t)val;
> +        break;
> +    default: /* Unhandled event */
> +        dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
> +            event);
> +        goto err_ret;
> +    }
> +
> +    iio_push_to_buffers_with_timestamp(indio_dev,
> +                       (uint8_t *)als->evt_buffer,
> +                       time_ns);
> +
> +err_ret:
> +    mutex_unlock(&als->lock);
> +}
> +
> +static int acpi_als_read_raw(struct iio_dev *indio_dev,
> +            struct iio_chan_spec const *chan, int *val,
> +            int *val2, long mask)
> +{
> +    struct acpi_als *als = iio_priv(indio_dev);
> +
> +    if (mask != IIO_CHAN_INFO_RAW)
> +        return -EINVAL;
> +
> +    /* we support only illumination (_ALI) so far. */
> +    if (chan->type != IIO_LIGHT)
> +        return -EINVAL;
> +
> +    *val = als_read_value(als, ACPI_ALS_ILLUMINANCE);
> +    if (*val < 0)
> +        return *val;
> +
> +    return IIO_VAL_INT;
> +}
> +
> +static acpi_handle acpi_handle_from_string(const char *str)
> +{
> +    acpi_handle handle;
> +    acpi_status handle_status;
> +
> +    handle_status = acpi_get_handle(NULL, (acpi_string)str, &handle);
> +    return ACPI_FAILURE(handle_status) ? NULL : handle;
> +}
> +
> +static int acpi_als_enable(struct acpi_device *device, int enable)
> +{
> +    acpi_handle handle;
> +    acpi_status result;
> +    struct acpi_object_list arg;
> +    union acpi_object param;
> +
> +    arg.count = 1;
> +    arg.pointer = &param;
> +    param.type = ACPI_TYPE_INTEGER;
> +
> +    handle = acpi_handle_from_string("\\_SB.PCI0.LPCB.EC0.TALS");
> +    if (handle == NULL) {
> +        dev_err(&device->dev, "unable to get handle for \\_SB.PCI0.LPCB.EC0.TALS\n");
> +        return -EIO;
> +    }
> +
> +    param.integer.value = enable;
> +    result = acpi_evaluate_object(handle, NULL, &arg, NULL);
> +
> +    if (enable) {
> +        handle = acpi_handle_from_string("\\_SB.ATKD.ALSC");
> +        if (handle == NULL) {
> +            dev_err(&device->dev, "unable to get handle for \\_SB.PCI0.LPCB.EC0.TALS\n");
> +            return -EIO;
> +        }
> +        result = acpi_evaluate_object(handle, NULL, &arg, NULL);
> +    }
> +
> +    return 0;
> +}
> +
> +static int acpi_als_buffer_register(struct iio_dev *indio_dev)
> +{
> +    struct iio_buffer *buffer;
> +    int ret;
> +
> +    buffer = iio_kfifo_allocate(indio_dev);
> +    if (!buffer)
> +        return -ENOMEM;
> +
> +    iio_device_attach_buffer(indio_dev, buffer);
> +    indio_dev->modes |= INDIO_BUFFER_HARDWARE;
Hmm. It's not actually a hardware buffer is it?
I think we need a new buffer type to indicate non triggered
software buffers.

> +
> +    ret = iio_buffer_register(indio_dev,
> +                  indio_dev->channels,
> +                  indio_dev->num_channels);
> +    if (ret)
> +        goto error_kfifo_free;
> +
> +    return 0;
> +
> +error_kfifo_free:
> +    iio_kfifo_free(indio_dev->buffer);
> +    return ret;
> +}
> +
> +static void acpi_als_buffer_unregister(struct iio_dev *indio_dev)
> +{
> +    iio_kfifo_free(indio_dev->buffer);
> +    iio_buffer_unregister(indio_dev);
Unregister before free.
> +}
> +
> +static const struct iio_info acpi_als_info = {
> +    .driver_module        = THIS_MODULE,
> +    .read_raw        = acpi_als_read_raw,
> +};
> +
> +static int acpi_als_add(struct acpi_device *device)
> +{
> +    struct acpi_als *als;
> +    struct iio_dev *indio_dev;
> +    int ret;
> +
> +    indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
> +    if (!indio_dev)
> +        return -ENOMEM;
> +
> +    als = iio_priv(indio_dev);
> +
> +    device->driver_data = indio_dev;
> +    als->device = device;
> +    mutex_init(&als->lock);
> +
> +    indio_dev->name = ACPI_ALS_DEVICE_NAME;
> +    indio_dev->dev.parent = &device->dev;
> +    indio_dev->info = &acpi_als_info;
> +    indio_dev->modes = INDIO_DIRECT_MODE;
> +    indio_dev->channels = acpi_als_channels;
> +    indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
> +
> +    ret = acpi_als_enable(device, 1);
> +    if (ret < 0)
> +        return ret;
> +
> +    ret = acpi_als_buffer_register(indio_dev);
> +    if (ret < 0)
> +        return ret;
> +
> +    ret = iio_device_register(indio_dev);
> +    if (ret < 0)
> +        goto err_ret;
> +
> +    return 0;
> +
> +err_ret:
> +    acpi_als_buffer_unregister(indio_dev);
> +    return ret;
> +}
> +
> +static int acpi_als_remove(struct acpi_device *device)
> +{
> +    struct iio_dev *indio_dev = acpi_driver_data(device);
> +
> +    iio_device_unregister(indio_dev);
> +    acpi_als_buffer_unregister(indio_dev);
> +    acpi_als_enable(device, 0);
Blank line here would be nice.
> +    return 0;
> +}
> +
> +static const struct acpi_device_id acpi_als_device_ids[] = {
> +    {"ACPI0008", 0},
> +    {"", 0},
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
> +
> +static struct acpi_driver acpi_als_driver = {
> +    .name    = "acpi_als",
> +    .class    = ACPI_ALS_CLASS,
> +    .ids    = acpi_als_device_ids,
> +    .ops = {
> +        .add    = acpi_als_add,
> +        .remove    = acpi_als_remove,
> +        .notify    = acpi_als_notify,
> +    },
> +};
> +
> +module_acpi_driver(acpi_als_driver);
> +
> +MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
> +MODULE_AUTHOR("Martin Liska <marxin.liska@gmail.com>");
> +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> +MODULE_AUTHOR("Manuel Stahl <thymythos@googlemail.com>");
> +MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
> +MODULE_LICENSE("GPL");
> diff -uprN a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> --- a/drivers/iio/light/Kconfig    2014-12-23 16:13:28.219815997 +0100
> +++ b/drivers/iio/light/Kconfig    2014-12-23 16:23:34.275823164 +0100
> @@ -5,6 +5,17 @@
> 
> menu "Light sensors"
> 
> +config ACPI_ALS
> +    tristate "ACPI Ambient Light Sensor"
> +    depends on ACPI
> +    select IIO_BUFFER
> +    select IIO_KFIFO_BUF
> +    help
> +     Support for the ACPI0008 Ambient Light Sensor.
> +
> +     This driver can also be built as a module.  If so, the module
> +     will be called acpi-als.
> +
> config ADJD_S311
>     tristate "ADJD-S311-CR999 digital color sensor"
>     select IIO_BUFFER
> diff -uprN a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> --- a/drivers/iio/light/Makefile    2014-12-23 16:13:03.575815706 +0100
> +++ b/drivers/iio/light/Makefile    2014-12-23 15:11:18.923771897 +0100
> @@ -3,6 +3,7 @@
> #
> 
> # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_ACPI_ALS)        += acpi-als.o
> obj-$(CONFIG_ADJD_S311)        += adjd_s311.o
> obj-$(CONFIG_APDS9300)        += apds9300.o
> obj-$(CONFIG_CM32181)        += cm32181.o
> 
> 
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

