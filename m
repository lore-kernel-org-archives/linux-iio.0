Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <1343881711-31209-1-git-send-email-srinivas.pandruvada@intel.com> <1343881711-31209-9-git-send-email-srinivas.pandruvada@intel.com> <501F95C2.6020803@kernel.org> <501F973E.4030008@kernel.org> <4FA419E87744DF4DAECD5BCE1214B7A91938F2EA@ORSMSX104.amr.corp.intel.com>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91938F2EA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [PATCH 8/9] HID-Sensors: Added Compass/Magnetometer 3D
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 06 Aug 2012 17:02:41 +0100
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio <linux-iio@vger.kernel.org>,Lars-Peter Clausen <lars@metafoo.de>,"Hennerich, Michael" <Michael.Hennerich@analog.com>
Message-ID: <016c2a24-1ab0-40ca-a929-e01bc91c6b20@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> wrote:

>Hi Jonathan,
>
>Thanks for the review.
>These drivers implements the main elements which I can test in current
>hubs. There are some more elements, which can be added in future.
>For example Orientation sensor has many fields like Quattrocchi
>rotation matrix, which is defined in specification, but I didn't
>implement as I can't test.
>So keeping in separate folder, has advantage for extending capability
>of driver cleanly without much patch work to prevent regression on
>other drivers.
>
>Our internal review, also preferred separate driver as you suggested
>before.
>What do you think of letting this structure in with this structure (of
>course after your other suggested changes), and later improve based on
>feedback.

That approach is fine.  If long term these remain similar we can look at merging them then. Looking forward to the fun bits as they become available!
>
>Thanks,
>Srinivas
>
>
>
>
>
>
>
>
>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@kernel.org] 
>Sent: Monday, August 06, 2012 3:07 AM
>To: Pandruvada, Srinivas
>Cc: linux-iio; Lars-Peter Clausen; Hennerich, Michael
>Subject: Re: [PATCH 8/9] HID-Sensors: Added Compass/Magnetometer 3D
>
>On 06/08/2012 11:00, Jonathan Cameron wrote:
>> On 02/08/2012 05:28, srinivas pandruvada wrote:
>>> Added usage id processing for Compass 3D. This uses IIO interfaces 
>>> for triggerred buffer to present data to user mode.This uses HID 
>>> sensor framework for registering callback events from the sensor
>hub.
>>
>> Based on a quick look this can also be trivially handled by a
>combined 
>> accel/gyro/magnetometer driver.
>
>Thinking a bit more about this, I'm guessing the reason you have not
>done this so far is that I already told you to put the components into
>subdirectories. Looking at this I would say we need to perhaps be a
>little more flexible about that rule - either that or move the majority
>of this into your common/hid-sensors directory and have trivial drivers
>for each of the components so that we can have them in the
>accel/gyro/magnetometer directories. Or we make an arbitary call and as
>with device naming (where the first part supported gives the driver
>it's name) and arbitarily put the combined driver into accel.
>
>What do people think? (cc'd analog devices guys as they are probably
>most likely of current contributors to have similar situations in the
>future).
>
>Sorry for sending you down the route of doing the separate drivers in
>the first place. I clearly wasn't thinking this through....
>
>>
>>
>>>
>>> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
>>> ---
>>>   drivers/iio/Kconfig                           |    1 +
>>>   drivers/iio/Makefile                          |    1 +
>>>   drivers/iio/magnetometer/Kconfig              |   16 +
>>>   drivers/iio/magnetometer/Makefile             |    6 +
>>>   drivers/iio/magnetometer/hid-sensor-magn-3d.c |  419
>>> +++++++++++++++++++++++++
>>>   5 files changed, 443 insertions(+), 0 deletions(-)
>>>   create mode 100644 drivers/iio/magnetometer/Kconfig
>>>   create mode 100644 drivers/iio/magnetometer/Makefile
>>>   create mode 100644 drivers/iio/magnetometer/hid-sensor-magn-3d.c
>>>
>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig index 
>>> 20212af..cdb3cfb 100644
>>> --- a/drivers/iio/Kconfig
>>> +++ b/drivers/iio/Kconfig
>>> @@ -59,5 +59,6 @@ source "drivers/iio/adc/Kconfig"
>>>   source "drivers/iio/amplifiers/Kconfig"
>>>   source "drivers/iio/common/Kconfig"
>>>   source "drivers/iio/gyro/Kconfig"
>>> +source "drivers/iio/magnetometer/Kconfig"
>>>
>>>   endif # IIO
>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile index 
>>> 7660bc4..71b643a 100644
>>> --- a/drivers/iio/Makefile
>>> +++ b/drivers/iio/Makefile
>>> @@ -15,3 +15,4 @@ obj-y += adc/
>>>   obj-y += amplifiers/
>>>   obj-y += common/
>>>   obj-y += gyro/
>>> +obj-y += magnetometer/
>>> diff --git a/drivers/iio/magnetometer/Kconfig
>>> b/drivers/iio/magnetometer/Kconfig
>>> new file mode 100644
>>> index 0000000..c1f0cdd
>>> --- /dev/null
>>> +++ b/drivers/iio/magnetometer/Kconfig
>>> @@ -0,0 +1,16 @@
>>> +#
>>> +# Magnetometer sensors
>>> +#
>>> +menu "Magnetometer sensors"
>>> +
>>> +config HID_SENSOR_MAGNETOMETER_3D
>>> +    depends on HID_SENSOR_HUB
>>> +    select IIO_BUFFER
>>> +    select IIO_TRIGGERED_BUFFER
>>> +    select HID_SENSOR_IIO_COMMON
>>> +    tristate "HID Magenetometer 3D"
>>> +    help
>>> +      Say yes here to build support for the HID SENSOR
>>> +      Magnetometer 3D.
>>> +
>>> +endmenu
>>> diff --git a/drivers/iio/magnetometer/Makefile
>>> b/drivers/iio/magnetometer/Makefile
>>> new file mode 100644
>>> index 0000000..cb26b44
>>> --- /dev/null
>>> +++ b/drivers/iio/magnetometer/Makefile
>>> @@ -0,0 +1,6 @@
>>> +#
>>> +# Makefile for industrial I/O Magnetometer sensor drivers #
>>> +
>>> +hid-sensor-magn-3d-drv-y := hid-sensor-magn-3d.o
>>> +obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) +=
>hid-sensor-magn-3d-drv.o
>>> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>>> b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>>> new file mode 100644
>>> index 0000000..b34682d
>>> --- /dev/null
>>> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>>> @@ -0,0 +1,419 @@
>>> +/*
>>> + * HID Sensors Driver
>>> + * Copyright (c) 2012, Intel Corporation.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> modify it
>>> + * under the terms and conditions of the GNU General Public
>License,
>>> + * version 2, as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope it will be useful, but
>>> WITHOUT
>>> + * ANY WARRANTY; without even the implied warranty of 
>>> + MERCHANTABILITY or
>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>>> License for
>>> + * more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public
>License
>>> along with
>>> + * this program; if not, write to the Free Software Foundation, 
>>> +Inc.,
>>> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>>> + *
>>> + */
>>> +#include <linux/device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/module.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/hid-sensor-hub.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/iio/buffer.h>
>>> +#include <linux/iio/trigger_consumer.h> #include 
>>> +<linux/iio/triggered_buffer.h> #include 
>>> +"../common/hid-sensors/hid-sensor-attributes.h"
>>> +#include "../common/hid-sensors/hid-sensor-trigger.h"
>>> +
>>> +/*Format: HID-SENSOR-usage_id_in_hex*/ #define DRIVER_NAME 
>>> +"HID-SENSOR-200083"
>>> +
>>> +enum magn_3d_channel {
>>> +    CHANNEL_SCAN_INDEX_X,
>>> +    CHANNEL_SCAN_INDEX_Y,
>>> +    CHANNEL_SCAN_INDEX_Z,
>>> +    MAGN_3D_CHANNEL_MAX,
>>> +};
>>> +
>>> +struct magn_3d_state {
>>> +    struct hid_sensor_iio_common common_attributes;
>>> +    struct hid_sensor_hub_attribute_info magn[MAGN_3D_CHANNEL_MAX];
>>> +    u32 magn_val[MAGN_3D_CHANNEL_MAX]; };
>>> +
>>> +const u32 magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
>>> +    HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_X_AXIS,
>>> +    HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_Y_AXIS,
>>> +    HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_Z_AXIS
>>> +};
>>> +
>>> +/* Channel definitions */
>>> +static struct iio_chan_spec magn_3d_channels[] = {
>>> +    {
>>> +        .type = IIO_MAGN,
>>> +        .modified = 1,
>>> +        .channel2 = IIO_MOD_X,
>>> +        .info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
>>> +        IIO_CHAN_INFO_SCALE_SHARED_BIT |
>>> +        IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
>>> +        IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
>>> +        .scan_index = CHANNEL_SCAN_INDEX_X,
>>> +    }, {
>>> +        .type = IIO_MAGN,
>>> +        .modified = 1,
>>> +        .channel2 = IIO_MOD_Y,
>>> +        .info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
>>> +        IIO_CHAN_INFO_SCALE_SHARED_BIT |
>>> +        IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
>>> +        IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
>>> +        .scan_index = CHANNEL_SCAN_INDEX_Y,
>>> +    }, {
>>> +        .type = IIO_MAGN,
>>> +        .modified = 1,
>>> +        .channel2 = IIO_MOD_Z,
>>> +        .info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
>>> +        IIO_CHAN_INFO_SCALE_SHARED_BIT |
>>> +        IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
>>> +        IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
>>> +        .scan_index = CHANNEL_SCAN_INDEX_Z,
>>> +    }
>>> +};
>>> +
>>> +/* Adjust channel real bits based on report descriptor */ static 
>>> +void magn_3d_adjust_channel_bit_mask(int channel, int size) {
>>> +    magn_3d_channels[channel].scan_type.sign = 's';
>>> +    /* Real storage bits will change based on the report desc. */
>>> +    magn_3d_channels[channel].scan_type.realbits = size * 8;
>>> +    /* Maximum size of a sample to capture is u32 */
>>> +    magn_3d_channels[channel].scan_type.storagebits = sizeof(u32) *
>
>>> +8; }
>>> +
>>> +/* Channel read_raw handler */
>>> +static int magn_3d_read_raw(struct iio_dev *indio_dev,
>>> +                  struct iio_chan_spec const *chan,
>>> +                  int *val, int *val2,
>>> +                  long mask)
>>> +{
>>> +    struct magn_3d_state *magn_state = iio_priv(indio_dev);
>>> +    int report_id = -1;
>>> +    u32 address;
>>> +    int ret;
>>> +
>>> +    *val = 0;
>>> +    *val2 = 0;
>>> +    switch (mask) {
>>> +    case 0:
>>> +        report_id =
>>> +            magn_state->magn[chan->scan_index].report_id;
>>> +        address = magn_3d_addresses[chan->scan_index];
>>> +        if (report_id >= 0)
>>> +            *val = sensor_hub_input_attr_get_raw_value(
>>> +                magn_state->common_attributes.hsdev,
>>> +                HID_USAGE_SENSOR_COMPASS_3D, address,
>>> +                report_id);
>>> +        else
>>> +            *val = 0;
>>> +        break;
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +        *val = magn_state->magn[CHANNEL_SCAN_INDEX_X].units;
>>> +        break;
>>> +    case IIO_CHAN_INFO_OFFSET:
>>> +        *val = hid_sensor_convert_exponent(
>>> +            magn_state->magn[CHANNEL_SCAN_INDEX_X].unit_expo);
>>> +        break;
>>> +    case IIO_CHAN_INFO_SAMP_FREQ:
>>> +        ret = hid_sensor_read_samp_freq_value(
>>> +            &magn_state->common_attributes, val, val2);
>>> +        break;
>>> +    case IIO_CHAN_INFO_HYSTERESIS:
>>> +        ret = hid_sensor_read_raw_hyst_value(
>>> +            &magn_state->common_attributes, val, val2);
>>> +        break;
>>> +    default:
>>> +        break;
>>> +    }
>>> +
>>> +    if (*val2)
>>> +        return IIO_VAL_INT_PLUS_MICRO;
>>> +    else
>>> +        return IIO_VAL_INT;
>>> +}
>>> +
>>> +/* Channel write_raw handler */
>>> +static int magn_3d_write_raw(struct iio_dev *indio_dev,
>>> +                   struct iio_chan_spec const *chan,
>>> +                   int val,
>>> +                   int val2,
>>> +                   long mask)
>>> +{
>>> +    struct magn_3d_state *magn_state = iio_priv(indio_dev);
>>> +    int ret = 0;
>>> +
>>> +    switch (mask) {
>>> +    case IIO_CHAN_INFO_SAMP_FREQ:
>>> +        ret = hid_sensor_write_samp_freq_value(
>>> +                &magn_state->common_attributes, val, val2);
>>> +        break;
>>> +    case IIO_CHAN_INFO_HYSTERESIS:
>>> +        ret = hid_sensor_write_raw_hyst_value(
>>> +                &magn_state->common_attributes, val, val2);
>>> +        break;
>>> +    default:
>>> +        ret = -EINVAL;
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> +static int magn_3d_write_raw_get_fmt(struct iio_dev *indio_dev,
>>> +                   struct iio_chan_spec const *chan,
>>> +                   long mask)
>>> +{
>>> +    return IIO_VAL_INT_PLUS_MICRO;
>>> +}
>>> +
>>> +static const struct iio_info magn_3d_info = {
>>> +    .driver_module = THIS_MODULE,
>>> +    .read_raw = &magn_3d_read_raw,
>>> +    .write_raw = &magn_3d_write_raw,
>>> +    .write_raw_get_fmt = &magn_3d_write_raw_get_fmt, };
>>> +
>>> +/* Function to push data to buffer */ void 
>>> +hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
>{
>>> +    struct iio_buffer *buffer = indio_dev->buffer;
>>> +    s64 timestamp = iio_get_time_ns();
>>> +    int datum_sz;
>>> +
>>> +    dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
>>> +    if (!buffer) {
>>> +        dev_err(&indio_dev->dev, "Buffer == NULL\n");
>>> +        return;
>>> +    }
>>> +    datum_sz = buffer->access->get_bytes_per_datum(buffer);
>>> +    if (len > datum_sz) {
>>> +        dev_err(&indio_dev->dev, "Datum size mismatch %d:%d\n",
>len,
>>> +                datum_sz);
>>> +        return;
>>> +    }
>>> +    buffer->access->store_to(buffer, (u8 *)data, timestamp); }
>>> +
>>> +/* Callback handler to send event after all samples are received
>and
>>> captured */
>>> +int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>unsigned
>>> usage_id,
>>> +            void *priv)
>>> +{
>>> +    struct iio_dev *indio_dev = platform_get_drvdata(priv);
>>> +    struct magn_3d_state *magn_state = iio_priv(indio_dev);
>>> +
>>> +    dev_dbg(&indio_dev->dev, "magn_3d_proc_event [%d]\n",
>>> +                magn_state->common_attributes.data_ready);
>>> +    if (magn_state->common_attributes.data_ready)
>>> +        hid_sensor_push_data(indio_dev,
>>> +                (u8 *)magn_state->magn_val,
>>> +                sizeof(magn_state->magn_val));
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/* Capture samples in local storage */ int 
>>> +magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>>> +                unsigned usage_id,
>>> +                size_t raw_len, char *raw_data,
>>> +                void *priv)
>>> +{
>>> +    struct iio_dev *indio_dev = platform_get_drvdata(priv);
>>> +    struct magn_3d_state *magn_state = iio_priv(indio_dev);
>>> +    int offset;
>>> +    int ret = -EINVAL;
>>> +
>>> +    switch (usage_id) {
>>> +    case HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_X_AXIS:
>>> +    case HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_Y_AXIS:
>>> +    case HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_Z_AXIS:
>>> +        offset = usage_id -
>HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_X_AXIS;
>>> +        magn_state->magn_val[CHANNEL_SCAN_INDEX_X + offset] =
>>> +                        *(u32 *)raw_data;
>>> +        ret = 0;
>>> +    break;
>>> +    default:
>>> +        break;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +/* Parse report which is specific to an usage id*/ static int 
>>> +magn_3d_parse_report(struct platform_device *pdev,
>>> +                struct hid_sensor_hub_device *hsdev,
>>> +                unsigned usage_id,
>>> +                struct magn_3d_state *st) {
>>> +    int ret;
>>> +    int i;
>>> +
>>> +    for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
>>> +        ret = sensor_hub_input_get_attribute_info(hsdev,
>>> HID_INPUT_REPORT,
>>> +                usage_id,
>>> +                HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_X_AXIS + i,
>>> +                &st->magn[CHANNEL_SCAN_INDEX_X + i]);
>>> +        magn_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_X + i,
>>> +                st->magn[CHANNEL_SCAN_INDEX_X + i].size);
>>> +        if (ret < 0)
>>> +            break;
>>> +    }
>>> +    dev_dbg(&pdev->dev, "magn_3d %x:%x, %x:%x, %x:%x\n",
>>> +            st->magn[0].index,
>>> +            st->magn[0].report_id,
>>> +            st->magn[1].index, st->magn[1].report_id,
>>> +            st->magn[2].index, st->magn[2].report_id);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +/* Function to initialize the processing for usage id */ static 
>>> +inline int magn_3d_init(struct platform_device *pdev,
>>> +            struct hid_sensor_hub_device *hsdev,
>>> +            unsigned usage_id)
>>> +{
>>> +    int ret = 0;
>>> +    static char *name = "magn_3d";
>>> +    struct iio_dev *indio_dev;
>>> +    struct magn_3d_state *magn_state;
>>> +
>>> +    indio_dev = iio_device_alloc(sizeof(struct magn_3d_state));
>>> +    if (indio_dev == NULL) {
>>> +        ret = -ENOMEM;
>>> +        goto error_ret;
>>> +    }
>>> +    platform_set_drvdata(pdev, indio_dev);
>>> +
>>> +    magn_state = iio_priv(indio_dev);
>>> +    magn_state->common_attributes.hsdev = hsdev;
>>> +    magn_state->common_attributes.pdev = pdev;
>>> +
>>> +    ret = hid_sensor_parse_common_attributes(hsdev,
>>> +                usage_id, &magn_state->common_attributes);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to setup common attributes\n");
>>> +        goto error_free_dev;
>>> +    }
>>> +
>>> +    ret = magn_3d_parse_report(pdev, hsdev, usage_id, magn_state);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to setup attributes\n");
>>> +        goto error_free_dev;
>>> +    }
>>> +
>>> +    indio_dev->channels = kmemdup(magn_3d_channels,
>>> +                    sizeof(magn_3d_channels),
>>> +                    GFP_KERNEL);
>>> +    if (!indio_dev->channels) {
>>> +        dev_err(&pdev->dev, "failed to duplicate channels\n");
>>> +        goto error_free_dev;
>>> +    }
>>> +
>>> +    indio_dev->num_channels =
>>> +                ARRAY_SIZE(magn_3d_channels);
>>> +    indio_dev->dev.parent = &pdev->dev;
>>> +    indio_dev->info = &magn_3d_info;
>>> +    indio_dev->name = name;
>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>> +
>>> +    ret = iio_triggered_buffer_setup(indio_dev,
>>> &iio_pollfunc_store_time,
>>> +        NULL, NULL);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to initialize trigger
>buffer\n");
>>> +        goto error_free_dev_mem;
>>> +    }
>>> +    magn_state->common_attributes.data_ready = false;
>>> +    ret = hid_sensor_setup_trigger(indio_dev, name,
>>> +                    &magn_state->common_attributes);
>>> +    if (ret < 0) {
>>> +        dev_err(&pdev->dev, "trigger setup failed\n");
>>> +        goto error_unreg_buffer_funcs;
>>> +    }
>>> +
>>> +    ret = iio_device_register(indio_dev);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "device register failed\n");
>>> +        goto error_remove_trigger;
>>> +    }
>>> +
>>> +    return ret;
>>> +
>>> +error_remove_trigger:
>>> +    hid_sensor_remove_trigger(indio_dev);
>>> +error_unreg_buffer_funcs:
>>> +    iio_triggered_buffer_cleanup(indio_dev);
>>> +error_free_dev_mem:
>>> +    kfree(indio_dev->channels);
>>> +error_free_dev:
>>> +    iio_device_free(indio_dev);
>>> +error_ret:
>>> +    return ret;
>>> +}
>>> +
>>> +/* Function to deinitialize the processing for usage id */ static 
>>> +inline void magn_3d_exit(struct platform_device *pdev) {
>>> +    struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +
>>> +    iio_device_unregister(indio_dev);
>>> +    hid_sensor_remove_trigger(indio_dev);
>>> +    iio_triggered_buffer_cleanup(indio_dev);
>>> +    kfree(indio_dev->channels);
>>> +    iio_device_free(indio_dev);
>>> +}
>>> +
>>> +static struct hid_sensor_hub_callbacks magn_3d_callbacks = {
>>> +    .send_event = magn_3d_proc_event,
>>> +    .capture_sample = magn_3d_capture_sample, };
>>> +
>>> +static int __devinit hid_magn_3d_probe(struct platform_device
>*pdev) 
>>> +{
>>> +    int ret;
>>> +    struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>>> +
>>> +    ret = magn_3d_init(pdev, hsdev, HID_USAGE_SENSOR_COMPASS_3D);
>>> +    if (ret < 0) {
>>> +        dev_err(&pdev->dev, "magn_3d_init failed\n");
>>> +        return ret;
>>> +    }
>>> +    magn_3d_callbacks.pdev = pdev;
>>> +    ret = sensor_hub_register_callback(hsdev,
>>> HID_USAGE_SENSOR_COMPASS_3D,
>>> +                    &magn_3d_callbacks);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int __devinit hid_magn_3d_remove(struct platform_device 
>>> +*pdev) {
>>> +    struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>>> +
>>> +    magn_3d_exit(pdev);
>>> +
>>> +    return sensor_hub_remove_callback(hsdev,
>>> HID_USAGE_SENSOR_COMPASS_3D);
>>> +}
>>> +
>>> +static struct platform_driver hid_magn_3d_platform_driver = {
>>> +    .driver = {
>>> +        .name    = DRIVER_NAME,
>>> +        .owner    = THIS_MODULE,
>>> +    },
>>> +    .probe        = hid_magn_3d_probe,
>>> +    .remove        = hid_magn_3d_remove,
>>> +};
>>> +module_platform_driver(hid_magn_3d_platform_driver);
>>> +
>>> +MODULE_DESCRIPTION("HID Sensor Magnetometer 3D"); 
>>> +MODULE_AUTHOR("Srinivas Pandruvada 
>>> +<srinivas.pandruvada@intel.com>");
>>> +MODULE_LICENSE("GPL");
>>>
>>

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
