Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57900 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbcGSFgg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 01:36:36 -0400
Subject: Re: [PATCH 07/10] iio: cros_ec_activity: add ChromeOS EC Activity
 Sensors
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
 <1468825370-20075-8-git-send-email-enric.balletbo@collabora.com>
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cefc6768-ce9f-58a7-4218-5b1ac57aaee0@kernel.org>
Date: Mon, 18 Jul 2016 17:16:16 +0100
MIME-Version: 1.0
In-Reply-To: <1468825370-20075-8-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/16 08:02, Enric Balletbo i Serra wrote:
> Handle activity events detections presented by the ChromeOS
> EC Sensor hub. Activities can be simple (low/no motion) or more complex
> (riding train). They are being reported by physical devices or the EC
> itself.
> 
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Interesting.  What docs exist?

For now this is probably more of an RFC than a finished driver, but
certainly interesting to know this stuff exists.

Jonathan
> ---
>  drivers/iio/common/cros_ec_sensors/Kconfig         |  10 +
>  drivers/iio/common/cros_ec_sensors/Makefile        |   1 +
>  .../iio/common/cros_ec_sensors/cros_ec_activity.c  | 294 +++++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> index 02559d2..22b4211 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -29,3 +29,13 @@ config IIO_CROS_EC_LIGHT_PROX
>  	  presented by the ChromeOS EC Sensor hub.
>  	  Creates an IIO device for each functions.
>  	  Only one source is exposed by the EC.
> +
> +config IIO_CROS_EC_ACTIVITY
> +	tristate "ChromeOS EC Activity Sensors"
> +	select IIO_CROS_EC_SENSORS_CORE
> +	help
> +	  Module to handle activity events detections presented by the ChromeOS
> +	  EC Sensor hub.
> +	  Activities can be simple (low/no motion) or more complex (riding train).
> +	  They are being reported by physical devices or the EC itself.
> +	  Creates an IIO device to manage all activities.
> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> index 7aaf2a2..8f54f1e 100644
> --- a/drivers/iio/common/cros_ec_sensors/Makefile
> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> @@ -5,3 +5,4 @@
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
>  obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
> +obj-$(CONFIG_IIO_CROS_EC_ACTIVITY) += cros_ec_activity.o
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> new file mode 100644
> index 0000000..b2e39d6
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> @@ -0,0 +1,294 @@
> +/*
> + * cros_ec_sensors_activity - Driver for activities/gesture recognition.
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
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_device.h>
> +
> +#include "cros_ec_sensors_core.h"
> +
> +/* st data for ec_sensors iio driver. */
> +struct cros_ec_sensors_state {
> +	/* Shared by all sensors */
> +	struct cros_ec_sensors_core_state core;
> +
> +	struct iio_chan_spec *channels;
> +	unsigned int nb_activities;
> +};
> +
> +static const struct iio_event_spec cros_ec_activity_single_shot[] = {
> +	{
> +		.type = IIO_EV_TYPE_CHANGE,
> +		/* significant motion trigger when we get out of still. */
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	 },
> +};
> +
> +static int ec_sensors_read(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	dev_warn(&indio_dev->dev, "%s: Not Expected: %d\n", __func__,
> +		 chan->channel2);
> +	return -EPERM;
> +}
> +
> +static int ec_sensors_write(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask)
> +{
> +	dev_warn(&indio_dev->dev, "%s: Not Expected: %d\n", __func__,
> +		 chan->channel2);
> +	return -EPERM;
> +}
> +
> +static int cros_ec_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_ACTIVITY)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
> +	if (cros_ec_motion_send_host_cmd(&st->core, 0) == EC_RES_SUCCESS) {
> +		switch (chan->channel2) {
> +		case IIO_MOD_STILL:
> +			ret = !!(st->core.resp->list_activities.enabled &
> +				 (1 << MOTIONSENSE_ACTIVITY_SIG_MOTION));
> +			break;
> +		case IIO_MOD_DOUBLE_TAP:
> +			ret = !!(st->core.resp->list_activities.enabled &
> +				 (1 << MOTIONSENSE_ACTIVITY_DOUBLE_TAP));
> +			break;
> +		default:
> +			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
> +				 chan->channel2);
> +			ret = -EINVAL;
> +		}
> +	} else {
> +		ret = -EIO;
> +	}
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static int cros_ec_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, int state)
> +{
> +	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_ACTIVITY)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +	st->core.param.cmd = MOTIONSENSE_CMD_SET_ACTIVITY;
> +	switch (chan->channel2) {
> +	case IIO_MOD_STILL:
> +		st->core.param.set_activity.activity =
> +			MOTIONSENSE_ACTIVITY_SIG_MOTION;
> +		break;
> +	case IIO_MOD_DOUBLE_TAP:
> +		st->core.param.set_activity.activity =
> +			MOTIONSENSE_ACTIVITY_DOUBLE_TAP;
> +		break;
> +	default:
> +		dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
> +			 chan->channel2);
> +	}
> +	st->core.param.set_activity.enable = state;
> +
> +	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +/* Not implemented */
> +static int cros_ec_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	dev_warn(&indio_dev->dev, "%s: Not Expected: %d\n", __func__,
> +		 chan->channel2);
> +	return -EPERM;
> +}
> +
> +static int cros_ec_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	dev_warn(&indio_dev->dev, "%s: Not Expected: %d\n", __func__,
> +		 chan->channel2);
> +	return -EPERM;
> +}
> +
> +static const struct iio_info ec_sensors_info = {
> +	.read_raw = &ec_sensors_read,
> +	.write_raw = &ec_sensors_write,
> +	.read_event_config = cros_ec_read_event_config,
> +	.write_event_config = cros_ec_write_event_config,
> +	.read_event_value = cros_ec_read_event_value,
> +	.write_event_value = cros_ec_write_event_value,
> +};
> +
> +static int cros_ec_sensors_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *ec_device;
> +	struct iio_dev *indio_dev;
> +	struct cros_ec_sensors_state *st;
> +	struct iio_chan_spec *channel;
> +	unsigned long activities;
> +	int i, index, ret, nb_activities;
> +
> +	if (!ec_dev || !ec_dev->ec_dev) {
> +		dev_warn(&pdev->dev, "No CROS EC device found.\n");
> +		return -EINVAL;
> +	}
> +	ec_device = ec_dev->ec_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &ec_sensors_info;
> +	st = iio_priv(indio_dev);
> +	st->core.type = st->core.resp->info.type;
> +	st->core.loc = st->core.resp->info.location;
> +
> +	/*
> +	 * List all available activities
> +	 */
Comment syntax please.
> +	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
> +	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
> +	if (ret)
> +		return ret;
> +	activities = st->core.resp->list_activities.enabled |
> +		     st->core.resp->list_activities.disabled;
> +	nb_activities = hweight_long(activities) + 1;
> +
> +	if (!activities)
> +		return -ENODEV;
> +
> +	/* Allocate a channel per activity and one for timestamp */
> +	st->channels = devm_kcalloc(&pdev->dev, nb_activities,
> +				    sizeof(*st->channels), GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
> +
> +	channel = &st->channels[0];
> +	index = 0;
> +	for_each_set_bit(i, &activities, BITS_PER_LONG) {
> +		channel->scan_index = index;
> +
> +		/* List all available activities */
> +		channel->type = IIO_ACTIVITY;
> +		channel->modified = 1;
> +		channel->event_spec = cros_ec_activity_single_shot;
> +		channel->num_event_specs =
> +				ARRAY_SIZE(cros_ec_activity_single_shot);
> +		switch (i) {
> +		case MOTIONSENSE_ACTIVITY_SIG_MOTION:
> +			channel->channel2 = IIO_MOD_STILL;
:) The only match we currently have?  Ah well guess that set is about
to get bigger.
> +			break;
> +		case MOTIONSENSE_ACTIVITY_DOUBLE_TAP:
> +			channel->channel2 = IIO_MOD_DOUBLE_TAP;
This particular one is an event that happens once, report it as such.

> +			break;
> +		default:
> +			dev_warn(&pdev->dev, "Unknown activity: %d\n", i);
> +			continue;
> +		}
> +		channel->ext_info = cros_ec_sensors_limited_info;
> +		channel++;
> +		index++;
> +	}
> +
> +	/* Timestamp */
> +	channel->scan_index = index;
> +	channel->type = IIO_TIMESTAMP;
> +	channel->channel = -1;
> +	channel->scan_type.sign = 's';
> +	channel->scan_type.realbits = 64;
> +	channel->scan_type.storagebits = 64;
> +
> +	indio_dev->channels = st->channels;
> +	indio_dev->num_channels = index + 1;
> +
> +	st->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> +
> +	/* Driver is incomplete: by itself, no way to get event directly */
Probably going to be a case of expanding the range of activities we already
report.  Trick has always been to assign these a percentage (likelihood).
So far all devices have given us 100 or 0, but who knows when they will start
being realistic about their ability to work this stuff out ;)  Just like
old weather forecasts used to be...

> +	ret = iio_device_register(indio_dev);
> +	return ret;
return iio_device_register(..)
> +}
> +
> +static int cros_ec_sensors_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(indio_dev);
blank line.
> +	return 0;
> +}
> +
> +static const struct platform_device_id cros_ec_sensors_ids[] = {
> +	{
> +		.name = "cros-ec-activity",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
> +
> +static struct platform_driver cros_ec_sensors_platform_driver = {
> +	.driver = {
> +		.name	= "cros-ec-activity",
> +	},
> +	.probe		= cros_ec_sensors_probe,
> +	.remove		= cros_ec_sensors_remove,
> +	.id_table	= cros_ec_sensors_ids,
> +};
> +module_platform_driver(cros_ec_sensors_platform_driver);
> +
> +MODULE_DESCRIPTION("ChromeOS EC activity sensors driver");
> +MODULE_LICENSE("GPL v2");
> 

