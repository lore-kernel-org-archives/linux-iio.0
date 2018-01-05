Return-Path: <SRS0=Pbfd=EA=collabora.com=enric.balletbo@kernel.org>
Subject: Re: [PATCH v2 2/3] iio: cros_ec: Add EC driver for Light and
 Proximity
To: Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
 groeck@chromium.org
Cc: linux-iio@vger.kernel.org
References: <20180105003242.11290-1-gwendal@chromium.org>
 <20180105003242.11290-2-gwendal@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <008fa639-e955-943d-f2c0-ca60fd4f2385@collabora.com>
Date: Fri, 5 Jan 2018 10:04:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180105003242.11290-2-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi Gwendal,

On 05/01/18 01:32, Gwendal Grignou wrote:
> Add driver for light and proximity sensors exposed by EC.
> 
> Reviewed-on: https://chromium-review.googlesource.com/291360
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> [rebase44(groeck): Adjust for API changes]
> [rebase414(gwendal): Adjust for API changes]
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> (cherry picked from commit 17e781c5f2747236ea1f9de6906e04aa92d383cb)
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/common/cros_ec_sensors/Kconfig         |   9 +
>  drivers/iio/common/cros_ec_sensors/Makefile        |   1 +
>  .../common/cros_ec_sensors/cros_ec_light_prox.c    | 260 +++++++++++++++++++++

Isn't this the driver that is already available in mainline at
drivers/iio/light/cros_ec_light_prox.c ?

iirc the maintainer told me to move the driver to his iio sensor type directory
when I posted this driver. I did a quick look at there are some few differences
but essentially is the same driver so maybe what we need to do is sync the one
is in mainline with the latest version in chromeos kernel.


Best regards,
 Enric

>  3 files changed, 270 insertions(+)
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> index 135f6825903f..b70138566870 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
>  	  Accelerometers, Gyroscope and Magnetometer that are
>  	  presented by the ChromeOS EC Sensor hub.
>  	  Creates an IIO device for each functions.
> +
> +config IIO_CROS_EC_LIGHT_PROX
> +	tristate "ChromeOS EC Light and Proximity Sensors"
> +	depends on IIO_CROS_EC_SENSORS_CORE
> +	help
> +	  Module to handle Light and Proximity sensors
> +	  presented by the ChromeOS EC Sensor hub.
> +	  Create an IIO device for each funcions.
> +	  Only one source is exposed by the EC.
> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> index ec716ff2a775..7aaf2a2dcdbd 100644
> --- a/drivers/iio/common/cros_ec_sensors/Makefile
> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
> +obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c b/drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
> new file mode 100644
> index 000000000000..17a19e918a38
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
> @@ -0,0 +1,260 @@
> +/*
> + * cros_ec_light_proxmity - Driver for light and prox sensors behing CrOS EC.
> + *
> + * Copyright (C) 2015 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * This driver uses the cros-ec interface to communicate with the Chrome OS
> + * EC about accelerometer data. Accelerometer access is presented through
> + * iio sysfs.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +
> +#include "cros_ec_sensors_core.h"
> +
> +/*
> + * We only represent one entry for light or proximity.
> + * EC is merging different light sensors to return the
> + * what the eye would see.
> + * For proximity, we currently support only one light source.
> + */
> +#define MAX_CHANNELS (1 + 1)
> +
> +/* State data for ec_sensors iio driver. */
> +struct cros_ec_light_prox_state {
> +	/* Shared by all sensors */
> +	struct cros_ec_sensors_core_state core;
> +
> +	struct iio_chan_spec channels[MAX_CHANNELS];
> +};
> +
> +static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
> +	u16 data = 0;
> +	s64 val64;
> +	int ret = IIO_VAL_INT;
> +	int idx = chan->scan_index;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
> +					(s16 *)&data) < 0)
> +			ret = -EIO;
> +		*val = data;
> +		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> +		st->core.param.sensor_offset.flags = 0;
> +
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret != 0)
> +			break;
> +
> +		/* Save values */
> +		st->core.calib[0] = st->core.resp->sensor_offset.offset[0];
> +
> +		*val = st->core.calib[idx];
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		/*
> +		 * RANGE is used for calibration
> +		 * scalse is a number x.y, where x is coded on 16bits,
> +		 * y coded on 16 bits, between 0 and 9999.
> +		 */
> +		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->core.param.sensor_range.data =
> +			EC_MOTION_SENSE_NO_VALUE;
> +
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		if (ret != 0)
> +			break;
> +
> +		val64 = st->core.resp->sensor_range.ret;
> +		*val = val64 >> 16;
> +		*val2 = (val64 & 0xffff) * 100;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Light: Result in Lux, using calibration multiplier */
> +		/* Prox: Result in cm. */
> +		*val = 1;
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = cros_ec_sensors_core_read(
> +				&st->core, chan, val, val2, mask);
> +		break;
> +	}
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask)
> +{
> +	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +	int idx = chan->scan_index;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		st->core.calib[idx] = val;
> +		/* Send to EC for each axis, even if not complete */
> +
> +		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
> +		st->core.param.sensor_offset.flags =
> +			MOTION_SENSE_SET_OFFSET;
> +		st->core.param.sensor_offset.offset[0] = st->core.calib[0];
> +		st->core.param.sensor_offset.temp =
> +			EC_MOTION_SENSE_INVALID_CALIB_TEMP;
> +
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
> +		st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
> +		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +		break;
> +	default:
> +		ret = cros_ec_sensors_core_write(
> +				&st->core, chan, val, val2, mask);
> +		break;
> +	}
> +
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static const struct iio_info cros_ec_light_prox_info = {
> +	.read_raw = &cros_ec_light_prox_read,
> +	.write_raw = &cros_ec_light_prox_write,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int cros_ec_light_prox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct cros_ec_light_prox_state *state;
> +	struct iio_chan_spec *channel;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &cros_ec_light_prox_info;
> +	state = iio_priv(indio_dev);
> +	state->core.type = state->core.resp->info.type;
> +	state->core.loc = state->core.resp->info.location;
> +	channel = state->channels;
> +	/* common part */
> +	channel->info_mask_separate =
> +		BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +		BIT(IIO_CHAN_INFO_CALIBSCALE);
> +	channel->info_mask_shared_by_all =
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_FREQUENCY);
> +	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> +	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
> +	channel->scan_type.shift = 0;
> +	channel->scan_index = 0;
> +	channel->ext_info = cros_ec_sensors_ext_info;
> +	channel->scan_type.sign = 'u';
> +
> +	state->core.calib[0] = 0;
> +
> +	/* sensor specific */
> +	switch (state->core.type) {
> +	case MOTIONSENSE_TYPE_LIGHT:
> +		channel->type = IIO_LIGHT;
> +		break;
> +	case MOTIONSENSE_TYPE_PROX:
> +		channel->type = IIO_PROXIMITY;
> +		break;
> +	default:
> +		dev_warn(dev, "unknown\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Timestamp */
> +	channel++;
> +	channel->type = IIO_TIMESTAMP;
> +	channel->channel = -1;
> +	channel->scan_index = 1;
> +	channel->scan_type.sign = 's';
> +	channel->scan_type.realbits = 64;
> +	channel->scan_type.storagebits = 64;
> +
> +	indio_dev->channels = state->channels;
> +	indio_dev->num_channels = MAX_CHANNELS;
> +
> +	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +			cros_ec_sensors_capture, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct platform_device_id cros_ec_light_prox_ids[] = {
> +	{
> +		.name = "cros-ec-prox",
> +	},
> +	{
> +		.name = "cros-ec-light",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
> +
> +static struct platform_driver cros_ec_light_prox_platform_driver = {
> +	.driver = {
> +		.name	= "cros-ec-light-prox",
> +		.pm	= &cros_ec_sensors_pm_ops,
> +	},
> +	.probe		= cros_ec_light_prox_probe,
> +	.id_table	= cros_ec_light_prox_ids,
> +};
> +module_platform_driver(cros_ec_light_prox_platform_driver);
> +
> +MODULE_DESCRIPTION("ChromeOS EC light/proximity sensors driver");
> +MODULE_LICENSE("GPL v2");
> 
