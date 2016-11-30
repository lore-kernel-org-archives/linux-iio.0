Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34242 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757334AbcK3I5c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2016 03:57:32 -0500
MIME-Version: 1.0
In-Reply-To: <02a154ef-55b8-6728-5438-3dc9cee04213@kernel.org>
References: <1480075385-26091-1-git-send-email-enric.balletbo@collabora.com> <02a154ef-55b8-6728-5438-3dc9cee04213@kernel.org>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Wed, 30 Nov 2016 09:57:30 +0100
Message-ID: <CAFqH_50NMb6SBNa65+M712pbmh4wkO2dztLz3VOA3Q6p42nNmQ@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_light_prox: add ChromeOS EC Light and
 Proximity Sensors
To: Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Many thanks for the review, I'm preparing v2. One question below.

2016-11-27 11:39 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 25/11/16 12:03, Enric Balletbo i Serra wrote:
>> From: Gwendal Grignou <gwendal@chromium.org>
>>
>> Handle Light and Proximity sensors presented by the ChromeOS EC Sensor hub.
>> Creates an IIO device for each functions.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> A few comments / questions inline.   We've missed the upcoming merge window
> now anyway so plenty of time to tidy up loose ends.
>
> Thanks,
>
> Jonathan
>> ---
>>  drivers/iio/common/cros_ec_sensors/Kconfig         |   8 +
>>  drivers/iio/common/cros_ec_sensors/Makefile        |   1 +
>>  .../common/cros_ec_sensors/cros_ec_light_prox.c    | 278 +++++++++++++++++++++
>>  3 files changed, 287 insertions(+)
>>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
>> index 135f682..4fd0b87 100644
>> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
>> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
>> @@ -20,3 +20,11 @@ config IIO_CROS_EC_SENSORS
>>         Accelerometers, Gyroscope and Magnetometer that are
>>         presented by the ChromeOS EC Sensor hub.
>>         Creates an IIO device for each functions.
>> +
>> +config IIO_CROS_EC_LIGHT_PROX
>> +     tristate "ChromeOS EC Light and Proximity Sensors"
>> +     select IIO_CROS_EC_SENSORS_CORE
> As the build bot has pointed out this doesn't work...
> I'd go with depends on myself as it's simpler than making sure to select
> the whole tree of things needed.
>

I'll fix this in v2.

>> +     help
>> +       Module to handle Light and Proximity sensors
>> +       presented by the ChromeOS EC Sensor hub.
>> +       Creates an IIO device for each functions.
>> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
>> index ec716ff..7aaf2a2 100644
>> --- a/drivers/iio/common/cros_ec_sensors/Makefile
>> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
>> @@ -4,3 +4,4 @@
>>
>>  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
>>  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
>> +obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c b/drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
>> new file mode 100644
>> index 0000000..40a34de
>> --- /dev/null
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
>> @@ -0,0 +1,278 @@
>> +/*
>> + * cros_ec_light_prox - Driver for light and prox sensors behing CrosEC.
>> + *
>> + * Copyright (C) 2016 Google, Inc
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/kfifo_buf.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/cros_ec.h>
>> +#include <linux/mfd/cros_ec_commands.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +
>> +#include "cros_ec_sensors_core.h"
>> +
>> +/*
>> + * We only represent one entry for light or proximity. EC is merging different
>> + * light sensors to return the what the eye would see. For proximity, we
>> + * currently support only one light source.
>> + */
>> +#define CROS_EC_LIGHT_PROX_MAX_CHANNELS (1 + 1)
>> +
>> +/* State data for ec_sensors iio driver. */
>> +struct cros_ec_sensors_state {
>> +     /* Shared by all sensors */
>> +     struct cros_ec_sensors_core_state core;
>> +
>> +     struct iio_chan_spec channels[CROS_EC_LIGHT_PROX_MAX_CHANNELS];
>> +};
>> +
>> +static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
>> +                                struct iio_chan_spec const *chan,
>> +                                int *val, int *val2, long mask)
>> +{
>> +     struct cros_ec_sensors_state *st = iio_priv(indio_dev);
>> +     u16 data = 0;
>> +     s64 val64;
>> +     int ret;
>> +     int idx = chan->scan_index;
>> +
>> +     mutex_lock(&st->core.cmd_lock);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW:
>> +             ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
>> +                                            (s16 *)&data);
> As I read the code, this is already being output in lux or
>> +             if (ret < 0)
>> +                     break;
>> +             *val = data;
>> +             break;
>> +     case IIO_CHAN_INFO_CALIBBIAS:
>> +             st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
>> +             st->core.param.sensor_offset.flags = 0;
>> +
>> +             ret = cros_ec_motion_send_host_cmd(&st->core, 0);
>> +             if (ret < 0)
>> +                     break;
>> +
>> +             /* Save values */
>> +             st->core.calib[0] = st->core.resp->sensor_offset.offset[0];
> Why save the value?  As far as I can tell it's not used anywhere?
>> +
>> +             *val = st->core.calib[idx];
>> +             break;
>> +     case IIO_CHAN_INFO_CALIBSCALE:
>> +             /*
>> +              * RANGE is used for calibration
>> +              * scale is a number x.y, where x is coded on 16bits,
>> +              * y coded on 16 bits, between 0 and 9999.
>> +              */
>> +             st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
>> +             st->core.param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
>> +
>> +             ret = cros_ec_motion_send_host_cmd(&st->core, 0);
>> +             if (ret < 0)
>> +                     break;
>> +
>> +             val64 = st->core.resp->sensor_range.ret;
>> +             *val = val64 >> 16;
>> +             *val2 = (val64 & 0xffff) * 100;
>> +             ret = IIO_VAL_INT_PLUS_MICRO;
>> +             break;
>> +     case IIO_CHAN_INFO_SCALE:
>> +             /*
>> +              * Light: Result in Lux, using calibration multiplier.
> Hmm? I'm not following this.  The multiplier set here is 1 so 'using' it
> is a strong way of putting it ;)
>
>> +              * Prox: Result in cm.
> Ah, base unit should be in the simple SI unit.  Here m.  Just checked and the
> docs don't actually state a unit for proximity.  Feel free to fix that as well.
>
>> +              */
>> +             *val = 1;
>> +             ret = IIO_VAL_INT;
> No need to provide this if the scale is 1.  That means the results
> are 'processed' so shouldn't be using the _raw form at all.

Sorry, I'm still confused with the _raw/_processed details. Just to
make sure I understand the API, _raw should be only used for the raw
values of the sensor and _processed if the value is already in the
simple SI unit, right?

In this case the sensor returns lux for light and cm for proximity
because the EC (where the sensors are connected) does some
pre-processing. For light I must not use _raw and directly use
_processed. For proximity, I must use _processed too, but convert cm
to m.

What confused me is that  in acpi-als, the ALS sensor returns lux and
it is using _raw and _processed (though I guess _raw is used only for
backward compability)

To sum up, if a sensor returns a known SI unit I must use always
_processed, never _raw, right?


>> +             break;
>> +     default:
>> +             ret = cros_ec_sensors_core_read(&st->core, chan, val, val2,
>> +                                             mask);
>> +             break;
>> +     }
>> +
>> +     mutex_unlock(&st->core.cmd_lock);
>> +
>> +     return ret;
>> +}
>> +
>> +static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
>> +                            struct iio_chan_spec const *chan,
>> +                            int val, int val2, long mask)
>> +{
>> +     struct cros_ec_sensors_state *st = iio_priv(indio_dev);
>> +     int ret;
>> +     int idx = chan->scan_index;
>> +
>> +     mutex_lock(&st->core.cmd_lock);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_CALIBBIAS:
>> +             st->core.calib[idx] = val;
>> +             /* Send to EC for each axis, even if not complete */
>> +             st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
>> +             st->core.param.sensor_offset.flags = MOTION_SENSE_SET_OFFSET;
>> +             st->core.param.sensor_offset.offset[0] =
>> +                     st->core.calib[0];
>> +             st->core.param.sensor_offset.temp =
>> +                     EC_MOTION_SENSE_INVALID_CALIB_TEMP;
>> +             ret = cros_ec_motion_send_host_cmd(&st->core, 0);
>> +             break;
>> +     case IIO_CHAN_INFO_CALIBSCALE:
>> +             st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
>> +             st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
>> +             ret = cros_ec_motion_send_host_cmd(&st->core, 0);
>> +             break;
>> +     default:
>> +             ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
>> +                                              mask);
>> +             break;
>> +     }
>> +
>> +     mutex_unlock(&st->core.cmd_lock);
>> +
>> +     return ret;
>> +}
>> +
>> +static const struct iio_info ec_sensors_info = {
>> +     .read_raw = &cros_ec_light_prox_read,
>> +     .write_raw = &cros_ec_light_prox_write,
>> +     .driver_module = THIS_MODULE,
>> +};
>> +
>> +static int cros_ec_sensors_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>> +     struct cros_ec_device *ec_device;
>> +     struct iio_dev *indio_dev;
>> +     struct cros_ec_sensors_state *state;
>> +     struct iio_chan_spec *channel;
>> +     int ret;
>> +
>> +     if (!ec_dev || !ec_dev->ec_dev) {
>> +             dev_warn(&pdev->dev, "No CROS EC device found.\n");
>> +             return -EINVAL;
>> +     }
>> +     ec_device = ec_dev->ec_dev;
>> +
>> +     indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
>> +     if (!indio_dev)
>> +             return -ENOMEM;
>> +
>> +     ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
>> +     if (ret)
>> +             return ret;
>> +
>> +     indio_dev->info = &ec_sensors_info;
>> +     state = iio_priv(indio_dev);
>> +     state->core.type = state->core.resp->info.type;
>> +     state->core.loc = state->core.resp->info.location;
>> +     channel = state->channels;
>> +
>> +     /* Common part */
>> +     channel->info_mask_separate =
>> +             BIT(IIO_CHAN_INFO_RAW) |
>> +             BIT(IIO_CHAN_INFO_CALIBBIAS) |
>> +             BIT(IIO_CHAN_INFO_CALIBSCALE);
>> +     channel->info_mask_shared_by_all =
>> +             BIT(IIO_CHAN_INFO_SCALE) |
>> +             BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +             BIT(IIO_CHAN_INFO_FREQUENCY);
>> +     channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
>> +     channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
>> +     channel->ext_info = cros_ec_sensors_ext_info;
>> +
>> +     /* Sensor specific */
>> +     switch (state->core.type) {
>> +     case MOTIONSENSE_TYPE_LIGHT:
>> +             channel->type = IIO_LIGHT;
>> +             break;
>> +     case MOTIONSENSE_TYPE_PROX:
>> +             channel->type = IIO_PROXIMITY;
>> +             break;
>> +     default:
>> +             dev_warn(&pdev->dev, "Unknown motion sensor\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* Timestamp */
>> +     channel++;
>> +     channel->type = IIO_TIMESTAMP;
>> +     channel->channel = -1;
>> +     channel->scan_index = 1;
>> +     channel->scan_type.sign = 's';
>> +     channel->scan_type.realbits = 64;
>> +     channel->scan_type.storagebits = 64;
>> +
>> +     indio_dev->channels = state->channels;
>> +
>> +     indio_dev->num_channels = CROS_EC_LIGHT_PROX_MAX_CHANNELS;
>> +
>> +     state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>> +
>> +     ret = iio_triggered_buffer_setup(indio_dev, NULL,
>> +                                      cros_ec_sensors_capture, NULL);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = iio_device_register(indio_dev);
>> +     if (ret)
>> +             iio_triggered_buffer_cleanup(indio_dev);
>> +
>> +     return ret;
>> +}
>> +
>> +static int cros_ec_sensors_remove(struct platform_device *pdev)
>> +{
>> +     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +
>> +     iio_device_unregister(indio_dev);
>> +     iio_triggered_buffer_cleanup(indio_dev);
>
> You could use the devm versions of register and triggered_buffer_setup
> and drop this remove entirely.
>

Ok, done in v2.

>> +
>> +     return 0;
>> +}
>> +
>> +static const struct platform_device_id cros_ec_sensors_ids[] = {
>> +     {
>> +             .name = "cros-ec-prox",
>> +     },
>> +     {
>> +             .name = "cros-ec-light",
>> +     },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
>> +
>> +static struct platform_driver cros_ec_sensors_platform_driver = {
>> +     .driver = {
>> +             .name   = "cros-ec-light-prox",
>> +     },
>> +     .probe          = cros_ec_sensors_probe,
>> +     .remove         = cros_ec_sensors_remove,
>> +     .id_table       = cros_ec_sensors_ids,
>> +};
>> +module_platform_driver(cros_ec_sensors_platform_driver);
>> +
>> +MODULE_DESCRIPTION("ChromeOS EC light/proximity sensors driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
