Return-Path: <SRS0=3Vdp=ZC=gmail.com=eballetbo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <d9b1a9c0-3d33-db5d-026b-81cddca43be0@kernel.org>
References: <20170111155139.6559-1-enric.balletbo@collabora.com>
 <20170111155139.6559-2-enric.balletbo@collabora.com> <d9b1a9c0-3d33-db5d-026b-81cddca43be0@kernel.org>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Fri, 20 Jan 2017 15:23:10 +0100
Message-ID: <CAFqH_50TJ8ydh5b1OKDqTATsdjodtcPHhcX4FY2HLJ+8JybVjg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] iio: cros_ec_light_prox: add ChromeOS EC Light and
 Proximity Sensors
To: Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Gwendal Grignou <gwendal@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Thanks for the review, I am preparing v3. Some answers to your questions below.

2017-01-14 14:06 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 11/01/17 15:51, Enric Balletbo i Serra wrote:
>> From: Gwendal Grignou <gwendal@chromium.org>
>>
>> Handle Light and Proximity sensors presented by the ChromeOS EC Sensor hub.
>> Creates an IIO device for each functions.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Hi.
>
> Looks like you were cleaning up the interface and left a few bits behind...
> Please tidy those up and repost.
>
> Thanks,
>
> Jonathan
>> ---
>>  drivers/iio/common/cros_ec_sensors/Kconfig         |   8 +
>>  drivers/iio/common/cros_ec_sensors/Makefile        |   1 +
>>  .../common/cros_ec_sensors/cros_ec_light_prox.c    | 287 +++++++++++++++++++++
> I missed this before.  I'd actually like to have this in the proximity
> directory rather than here.  The reason is to keep the drivers grouped
> by function is preferred to grouping by what implements them.

Ok, I'll move this.

>>  3 files changed, 296 insertions(+)
>>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
>> index 135f682..26360d4 100644
>> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
>> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
>> @@ -20,3 +20,11 @@ config IIO_CROS_EC_SENSORS
>>         Accelerometers, Gyroscope and Magnetometer that are
>>         presented by the ChromeOS EC Sensor hub.
>>         Creates an IIO device for each functions.
>> +
>> +config IIO_CROS_EC_LIGHT_PROX
>> +     tristate "ChromeOS EC Light and Proximity Sensors"
>> +     depends on IIO_CROS_EC_SENSORS_CORE
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
>> index 0000000..62faf58
>> --- /dev/null
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
>> @@ -0,0 +1,287 @@
>> +/*
>> + * cros_ec_light_prox - Driver for light and prox sensors behing CrosEC.
>> + *
>> + * Copyright (C) 2017 Google, Inc
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
>> +struct cros_ec_light_prox_state {
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
>> +     struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
>> +     u16 data = 0;
>> +     s64 val64;
>> +     int ret = IIO_VAL_INT;
>> +     int idx = chan->scan_index;
>> +
>> +     mutex_lock(&st->core.cmd_lock);
>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_PROCESSED:
>> +             if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
>> +                                          (s16 *)&data) < 0) {
>> +                     ret = -EIO;
>> +                     break;
>> +             }
>> +
>> +             switch (chan->type) {
>> +             /*
>> +              * The data coming from the sensor is pre-processed, represents
>> +              * the ambient light illuminance reading expressed in lux.
>> +              */
>> +             case IIO_LIGHT:
>> +                     *val = data;
>> +                     ret = IIO_VAL_INT;
>> +                     break;
>> +             /*
>> +              * The data coming from the sensor is pre-processed, represents
>> +              * the distance reading expressed in cm. Convert to m.
>> +              */
>> +             case IIO_PROXIMITY:
> Out of curiousity, what kind of proximity sensor is this?  I'm suprised it
> has any real world units as I'd assumed we were dealing with a light
> intensity based sensor and reflection.

The CrosEC acts as a sensor hub, it can have different sensors
attached that differs betweens Chromebooks models. The sensor hub
captures the data from sensors and does some conversion and then
exposes the result through it's interface. E.g For light and proximity
sensors it can have attached a si144x [1] Proximity/Ambient Light
Sensor Modules.

[1] http://www.silabs.com/products/sensors/infraredsensors/Pages/Si114x.aspx

>> +                     *val = 0;
>> +                     *val2 = data * 10000;
>> +                     ret = IIO_VAL_INT_PLUS_MICRO;
>> +                     break;
>> +             default:
>> +                     ret = -EINVAL;
>> +                     break;
>> +             }
>> +             break;
>> +     case IIO_CHAN_INFO_CALIBBIAS:
>> +             st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
>> +             st->core.param.sensor_offset.flags = 0;
>> +
>> +             if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
>> +                     ret = -EIO;
>> +                     break;
>> +             }
>> +
>> +             /* Save values */
>> +             st->core.calib[0] = st->core.resp->sensor_offset.offset[0];
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
>> +             if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
>> +                     ret = -EIO;
>> +                     break;
>> +             }
>> +
>> +             val64 = st->core.resp->sensor_range.ret;
>> +             *val = val64 >> 16;
>> +             *val2 = (val64 & 0xffff) * 100;
>> +             ret = IIO_VAL_INT_PLUS_MICRO;
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
>> +     struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
>> +     int ret = 0;
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
>> +             st->core.param.sensor_offset.offset[0] = st->core.calib[0];
>> +             st->core.param.sensor_offset.temp =
>> +                                     EC_MOTION_SENSE_INVALID_CALIB_TEMP;
> This needs some explanation of what is going on.  This presumably is
> ultimately passing an offset to be applied by the sensor hub?

This sets the calibration information in the sensor hub (EC) for the
specified sensor, the MOTION_SENSE_SET_OFFSET is to be able to write
the values, in offset is stored the calibration value and temp is to
store the temperature at calibration which is unknown/invalid.


>> +             if (cros_ec_motion_send_host_cmd(&st->core, 0))
> Command of 0?  This wants an explanation.

The second parameter of cros_ec_motion_send_host_cmd is an optional
length for the response, when 0 it assumes a 'default' response,
otherwise it request a response to the command with the specified
length.

>> +                     ret = -EIO;
>> +             break;
>> +     case IIO_CHAN_INFO_CALIBSCALE:
>> +             st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
>> +             st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
>> +             if (cros_ec_motion_send_host_cmd(&st->core, 0))
>> +                     ret = -EIO;
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
>> +static const struct iio_info cros_ec_light_prox_info = {
>> +     .read_raw = &cros_ec_light_prox_read,
>> +     .write_raw = &cros_ec_light_prox_write,
>> +     .driver_module = THIS_MODULE,
>> +};
>> +
>> +static int cros_ec_light_prox_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>> +     struct cros_ec_device *ec_device;
>> +     struct iio_dev *indio_dev;
>> +     struct cros_ec_light_prox_state *state;
>> +     struct iio_chan_spec *channel;
>> +     int ret;
>> +
>> +     if (!ec_dev || !ec_dev->ec_dev) {
>> +             dev_warn(dev, "No CROS EC device found.\n");
>> +             return -EINVAL;
>> +     }
>> +     ec_device = ec_dev->ec_dev;
>> +
>> +     indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>> +     if (!indio_dev)
>> +             return -ENOMEM;
>> +
>> +     ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
>> +     if (ret)
>> +             return ret;
>> +
>> +     indio_dev->info = &cros_ec_light_prox_info;
>> +     state = iio_priv(indio_dev);
>> +     state->core.type = state->core.resp->info.type;
>> +     state->core.loc = state->core.resp->info.location;
>> +     channel = state->channels;
>> +
>> +     /* Common part */
>> +     channel->info_mask_separate =
>> +//           BIT(IIO_CHAN_INFO_RAW) |
> What's this doing here?

Sorry, removed.

>> +             BIT(IIO_CHAN_INFO_PROCESSED) |
>> +             BIT(IIO_CHAN_INFO_CALIBBIAS) |
>> +             BIT(IIO_CHAN_INFO_CALIBSCALE);
>> +     channel->info_mask_shared_by_all =
>> +             BIT(IIO_CHAN_INFO_SCALE) |
> Providing processed and 'scale' is unusual...  Even more interesting
> is you don't seem to provide it or indeed the next two...
>
> Please check out this whole area.

Yes, I get rid of scale from here.

>> +             BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +             BIT(IIO_CHAN_INFO_FREQUENCY);

These are from cros_ec_sensors_core

>> +     channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
>> +     channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
>> +     channel->scan_type.shift = 0;
>> +     channel->scan_index = 0;
>> +     channel->ext_info = cros_ec_sensors_ext_info;
>> +     channel->scan_type.sign = 'u';
>> +
>> +     state->core.calib[0] = 0;
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
>> +             dev_warn(dev, "Unknown motion sensor\n");
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
>> +     ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>> +                                           cros_ec_sensors_capture, NULL);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +static const struct platform_device_id cros_ec_light_prox_ids[] = {
>> +     {
>> +             .name = "cros-ec-prox",
>> +     },
>> +     {
>> +             .name = "cros-ec-light",
>> +     },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
>> +
>> +static struct platform_driver cros_ec_light_prox_platform_driver = {
>> +     .driver = {
>> +             .name   = "cros-ec-light-prox",
>> +     },
>> +     .probe          = cros_ec_light_prox_probe,
>> +     .id_table       = cros_ec_light_prox_ids,
>> +};
>> +module_platform_driver(cros_ec_light_prox_platform_driver);
>> +
>> +MODULE_DESCRIPTION("ChromeOS EC light/proximity sensors driver");
>> +MODULE_LICENSE("GPL v2");
>>
>

I'm preparing v3, thanks,
 Enric
