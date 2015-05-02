Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58616 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbEBLZD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2015 07:25:03 -0400
Message-ID: <5544B40C.1010608@kernel.org>
Date: Sat, 02 May 2015 12:25:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	marxin.liska@gmail.com, marex@denx.de, rui.zhang@intel.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: acpi: Add ACPI0008 Ambient Light Sensor
References: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com>
In-Reply-To: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/15 12:27, Gabriele Mazzotta wrote:
> Add basic implementation of the ACPI0008 Ambient Light Sensor driver.
> This driver currently supports only the ALI property, yet is ready to
> be easily extended to handle ALC, ALT, ALP ones as well.
> 
> Signed-off-by: Martin Liska <marxin.liska@gmail.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> ---
> This continues http://marc.info/?t=140163463200002
> I've made few adjustments over the original patch:
> 
>  - Code aligned with 4.1-rc1 and cleaned up
>  - Use signed integers to store values: sensors report 32bit signed
>    values. In particular, -1 is reported when the current reading
>    is above the supported range of sensitivity.
> 
> Most of the changes are just a consequence of the changes in the
> iio subsystem.
> 
> Gabriele
Just one minor comment inline.

Looks good to me.
> 
>  drivers/iio/light/Kconfig    |  12 +++
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/acpi-als.c | 240 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100644 drivers/iio/light/acpi-als.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 01a1a16..898b2b5 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -5,6 +5,18 @@
>  
>  menu "Light sensors"
>  
> +config ACPI_ALS
> +	tristate "ACPI Ambient Light Sensor"
> +	depends on ACPI
> +	select IIO_TRIGGERED_BUFFER
> +	select IIO_KFIFO_BUF
> +	help
> +	 Say Y here if you want to build a driver for the ACPI0008
> +	 Ambient Light Sensor.
> +
> +	 To compile this driver as a module, choose M here: the module will
> +	 be called acpi-als.
> +
>  config ADJD_S311
>  	tristate "ADJD-S311-CR999 digital color sensor"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index ad7c30f..d9aad52a 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -3,6 +3,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
>  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>  obj-$(CONFIG_AL3320A)		+= al3320a.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> new file mode 100644
> index 0000000..fe9a8a0
> --- /dev/null
> +++ b/drivers/iio/light/acpi-als.c
> @@ -0,0 +1,240 @@
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
> + * Copyright (C) 2015 Gabriele Mazzotta <gabriele.mzt@gmail.com>
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
> +#define ACPI_ALS_CLASS			"als"
> +#define ACPI_ALS_DEVICE_NAME		"acpi-als"
> +#define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
> +
> +ACPI_MODULE_NAME("acpi-als");
> +
> +/*
> + * So far, there's only one channel in here, but the specification for
> + * ACPI0008 says there can be more to what the block can report. Like
> + * chromaticity and such. We are ready for incoming additions!
> + */
> +static const struct iio_chan_spec acpi_als_channels[] = {
> +	{
> +		.type		= IIO_LIGHT,
> +		.scan_type	= {
> +			.sign		= 's',
> +			.realbits	= 10,
> +			.storagebits	= 32,
> +		},
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),
> +	},
> +};
> +
> +/*
> + * The event buffer contains timestamp and all the data from
> + * the ACPI0008 block. There are multiple, but so far we only
> + * support _ALI (illuminance). Once someone adds new channels
> + * to acpi_als_channels[], the evt_buffer below will grow
> + * automatically.
> + */
> +#define EVT_NR_SOURCES		ARRAY_SIZE(acpi_als_channels)
> +#define EVT_BUFFER_SIZE		\
> +	(sizeof(s64) + (EVT_NR_SOURCES * sizeof(s32)))
> +
> +struct acpi_als {
> +	struct acpi_device	*device;
> +	struct mutex		lock;
> +
> +	s32			evt_buffer[EVT_BUFFER_SIZE];
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
> +#define ACPI_ALS_ILLUMINANCE	"_ALI"
> +#define ACPI_ALS_CHROMATICITY	"_ALC"
> +#define ACPI_ALS_COLOR_TEMP	"_ALT"
> +#define ACPI_ALS_POLLING	"_ALP"
> +#define ACPI_ALS_TABLES		"_ALR"
> +
> +static int als_read_value(struct acpi_als *als, char *prop, s32 *val)
> +{
> +	unsigned long long temp_val;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_integer(als->device->handle, prop, NULL,
> +				       &temp_val);
> +
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS %s", prop));
> +		return -EIO;
> +	}
> +
> +	*val = temp_val;
> +
> +	return 0;
> +}
> +
> +static void acpi_als_notify(struct acpi_device *device, u32 event)
> +{
> +	struct iio_dev *indio_dev = acpi_driver_data(device);
> +	struct acpi_als *als = iio_priv(indio_dev);
> +	s32 *buffer = als->evt_buffer;
> +	s64 time_ns = iio_get_time_ns();
> +	s32 val;
> +	int ret;
> +
> +	mutex_lock(&als->lock);
> +
> +	memset(buffer, 0, EVT_BUFFER_SIZE);
> +
> +	switch (event) {
> +	case ACPI_ALS_NOTIFY_ILLUMINANCE:
> +		ret = als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> +		if (ret < 0)
> +			goto out;
> +		*buffer++ = val;
> +		break;
> +	default:
> +		/* Unhandled event */
> +		dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
> +			event);
> +		goto out;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev,
> +					   (u8 *)als->evt_buffer, time_ns);
> +
> +out:
> +	mutex_unlock(&als->lock);
> +}
> +
> +static int acpi_als_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct acpi_als *als = iio_priv(indio_dev);
> +	s32 temp_val;
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	/* we support only illumination (_ALI) so far. */
> +	if (chan->type != IIO_LIGHT)
> +		return -EINVAL;
> +
> +	ret = als_read_value(als, ACPI_ALS_ILLUMINANCE, &temp_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = temp_val;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info acpi_als_info = {
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= acpi_als_read_raw,
> +};
> +
> +static int acpi_als_add(struct acpi_device *device)
> +{
> +	struct acpi_als *als;
> +	struct iio_dev *indio_dev;
> +	struct iio_buffer *buffer;
> +
> +	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	als = iio_priv(indio_dev);
> +
> +	device->driver_data = indio_dev;
> +	als->device = device;
> +	mutex_init(&als->lock);
> +
> +	indio_dev->name = ACPI_ALS_DEVICE_NAME;
> +	indio_dev->dev.parent = &device->dev;
> +	indio_dev->info = &acpi_als_info;
> +	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels = acpi_als_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
> +
> +	buffer = devm_iio_kfifo_allocate(&device->dev);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int acpi_als_remove(struct acpi_device *device)
> +{
> +	struct iio_dev *indio_dev = acpi_driver_data(device);
> +
> +	iio_device_unregister(indio_dev);
As this is all you have here, you can use devm_iio_device_register
and then getting rid of the remove entirely.

> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id acpi_als_device_ids[] = {
> +	{"ACPI0008", 0},
> +	{"", 0},
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
> +
> +static struct acpi_driver acpi_als_driver = {
> +	.name	= "acpi_als",
> +	.class	= ACPI_ALS_CLASS,
> +	.ids	= acpi_als_device_ids,
> +	.ops = {
> +		.add	= acpi_als_add,
> +		.remove	= acpi_als_remove,
> +		.notify	= acpi_als_notify,
> +	},
> +};
> +
> +module_acpi_driver(acpi_als_driver);
> +
> +MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
> +MODULE_AUTHOR("Martin Liska <marxin.liska@gmail.com>");
> +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> +MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
> +MODULE_LICENSE("GPL");
> 

