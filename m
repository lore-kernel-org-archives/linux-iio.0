Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44749 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab2LAQqz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 1 Dec 2012 11:46:55 -0500
MIME-Version: 1.0
In-Reply-To: <50B735D8.6000907@metafoo.de>
References: <CAHR064j_7Y3wYXVXmC4TqZHxkqa0Z2HK84-OaDTiC7oesB_TrQ@mail.gmail.com>
	<1354157205-2956-1-git-send-email-marxin.liska@gmail.com>
	<1354157205-2956-2-git-send-email-marxin.liska@gmail.com>
	<50B735D8.6000907@metafoo.de>
Date: Sat, 1 Dec 2012 17:46:54 +0100
Message-ID: <CAObPJ3M1yOtKTs0e7oi74+bVMjvPfe7Jn+EXVoVFzMc6cr43dQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI ALS driver for iio introduced.
From: =?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Corentin Chary <corentin.chary@gmail.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, linux-iio@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, joeyli <jlee@suse.com>,
	Len Brown <len.brown@intel.com>, pavel@denx.de,
	Jon Brenner <jbrenner@taosinc.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29 November 2012 11:15, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Hi,
>
> On 11/29/2012 03:46 AM, marxin.liska@gmail.com wrote:
>> From: marxin <marxin.liska@gmail.com>
>
> The from tag should contain your full name. Also you need to add a
> Signed-off-by tag. And a short description what the patch does wouldn't hurt
> either. And the subject line prefix should match that of the subsystem, in
> this case "iio:". Your subject line could for example be "iio: Add ACPI
> ambient light sensor driver".
>
> Also what's up with all the TODOs in the driver, shouldn't these be
> addressed first before the driver is merged upstream? The driver looks a bit
> as if it is only half finished, which is fine if you just want to get some
> initial feedback, but you should definitely state this somewhere.
>
>>
>> ---
>>  drivers/iio/industrialio-buffer.c    |    4 +-
>>  drivers/staging/iio/light/Kconfig    |    6 +
>>  drivers/staging/iio/light/Makefile   |    1 +
>>  drivers/staging/iio/light/acpi-als.c |  486 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 495 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/staging/iio/light/acpi-als.c
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index aaadd32..b8b377c 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -119,8 +119,8 @@ static ssize_t iio_scan_el_show(struct device *dev,
>>       int ret;
>>       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>
>> -     ret = test_bit(to_iio_dev_attr(attr)->address,
>> -                    indio_dev->buffer->scan_mask);
>> +     ret = !!(test_bit(to_iio_dev_attr(attr)->address,
>> +                    indio_dev->buffer->scan_mask));
>>
>>       return sprintf(buf, "%d\n", ret);
>>  }
>> diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
>> index 4bed30e..a164ecc 100644
>> --- a/drivers/staging/iio/light/Kconfig
>> +++ b/drivers/staging/iio/light/Kconfig
>
> Unless you have a really good reason we shouldn't add new iio drivers to
> staging. Just put it in drivers/iio/light/
>
>> @@ -50,4 +50,10 @@ config TSL2x7x
>>        tmd2672, tsl2772, tmd2772 devices.
>>        Provides iio_events and direct access via sysfs.
>>
>> +config ACPI_ALS
>> +     tristate "ACPI Ambient Light Sensor"
>
> I suspect that the driver depends on CONFIG_ACPI
>
>
>> +     help
>> +      Support for ACPI0008 Light Sensor.
>> +      Provides direct access via sysfs.
>> +
>>  endmenu
>> diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
>> index 141af1e..13090e6 100644
>> --- a/drivers/staging/iio/light/Makefile
>> +++ b/drivers/staging/iio/light/Makefile
>> @@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_ISL29018)        += isl29018.o
>>  obj-$(CONFIG_SENSORS_ISL29028)       += isl29028.o
>>  obj-$(CONFIG_TSL2583)        += tsl2583.o
>>  obj-$(CONFIG_TSL2x7x)        += tsl2x7x_core.o
>> +obj-$(CONFIG_ACPI_ALS)       += acpi-als.o
>> diff --git a/drivers/staging/iio/light/acpi-als.c b/drivers/staging/iio/light/acpi-als.c
>> new file mode 100644
>> index 0000000..9ba0fc4
>> --- /dev/null
>> +++ b/drivers/staging/iio/light/acpi-als.c
>> @@ -0,0 +1,486 @@
>> +/*
>> + * ACPI Ambient Light Sensor Driver
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <trace/events/printk.h>
>> +#include <acpi/acpi_bus.h>
>> +#include <acpi/acpi_drivers.h>
>> +#include <linux/err.h>
>> +#include <linux/mutex.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +
>> +#define PREFIX "ACPI: "
>> +
>> +#define ACPI_ALS_CLASS                       "als"
>> +#define ACPI_ALS_DEVICE_NAME         "acpi-als"
>> +#define ACPI_ALS_NOTIFY_ILLUMINANCE  0x80
>> +
>> +#define ACPI_ALS_OUTPUTS             1
>> +
>> +#define _COMPONENT                   ACPI_ALS_COMPONENT
>> +ACPI_MODULE_NAME("acpi-als");
>> +
>> +MODULE_AUTHOR("Martin Liska <marxin.liska@gmail.com>");
>> +MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
>> +MODULE_LICENSE("GPL");
>> +
>> +struct acpi_als_chip {
>> +    struct acpi_device               *device;
>> +    struct acpi_als_device   *acpi_als_sys;
>
> Neither the struct is defined nor the field is used.
>
>> +    struct mutex             lock;
>> +    struct iio_trigger               *trig;
>> +
>> +    int                              illuminance;
>> +    int                              polling;
>
> Polling is only ever assigned, but never read.
>
>> +
>> +    int                              count;
>> +    struct acpi_als_mapping  *mappings;
>> +};
>> +
>> +static int acpi_als_add(struct acpi_device *device);
>> +static int acpi_als_remove(struct acpi_device *device, int type);
>> +static void acpi_als_notify(struct acpi_device *device, u32 event);
>> +
>> +static const struct acpi_device_id acpi_als_device_ids[] = {
>> +    {"ACPI0008", 0},
>> +    {"", 0},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
>> +
>> +static struct acpi_driver acpi_als_driver = {
>> +    .name = "acpi_als",
>> +    .class = ACPI_ALS_CLASS,
>> +    .ids = acpi_als_device_ids,
>> +    .ops = {
>> +        .add = acpi_als_add,
>> +        .remove = acpi_als_remove,
>> +        .notify = acpi_als_notify,
>> +    },
>> +};
>> +
>> +struct acpi_als_mapping {
>> +    int adjustment;
>> +    int illuminance;
>> +};
>> +
>> +#define ALS_INVALID_VALUE_LOW                0
>> +#define ALS_INVALID_VALUE_HIGH               -1
>> +
>
> [...]
>> +/*
>> + * acpi_als_get_polling - get a recommended polling frequency
>> + *                     for the Ambient Light Sensor device
>> + */
>> +static int acpi_als_get_polling(struct acpi_als_chip *chip)
>> +{
>> +    acpi_status status;
>> +    unsigned long long polling;
>> +
>> +    status =
>> +        acpi_evaluate_integer(chip->device->handle, "_ALP", NULL, &polling);
>> +    if (ACPI_FAILURE(status)) {
>> +        ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALP not available\n"));
>> +        return -ENODEV;
>> +    }
>> +
>> +    chip->polling = polling;
>> +    return 0;
>> +}
>> +
>> +/*
>> + * get_illuminance - wrapper for getting the currect ambient light illuminance
>> + */
>
> Why is this wrapper necessary?
>
>> +static int get_illuminance(struct acpi_als_chip *als, int *illuminance)
>> +{
>> +    int result;
>> +
>> +    result = acpi_als_get_illuminance(als);
>> +    if (!result)
>> +        *illuminance = als->illuminance;
>> +
>> +    return result;
>> +}
>> +
>> +static void acpi_als_notify(struct acpi_device *device, u32 event)
>> +{
>> +     int illuminance;
>> +     struct iio_dev *indio_dev = acpi_driver_data(device);
>> +     struct acpi_als_chip *chip = iio_priv(indio_dev);
>> +
>> +     s64 time_ns = iio_get_time_ns();
>> +     int len = sizeof(int);
>> +     u8 data[sizeof(s64) + ACPI_ALS_OUTPUTS * len];
>> +
>> +     switch(event) {
>> +     case ACPI_ALS_NOTIFY_ILLUMINANCE:
>> +             get_illuminance(chip, &illuminance);
>> +             *(int *)((u8 *)data) = illuminance;
>> +             *(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) = time_ns;
>
> You don't have a timestamp channel in your channel spec.
>
>> +             break;
>> +     default:
>> +             return;
>> +     }
>> +
>> +     if (iio_buffer_enabled(indio_dev))
>> +             iio_push_to_buffers(indio_dev, data);
>> +
>> +     return;
>> +}
>> +
>> +static int acpi_als_read_raw(struct iio_dev *indio_dev,
>> +                             struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>> +{
>> +    struct acpi_als_chip *chip = iio_priv(indio_dev);
>> +    int ret = -EINVAL;
>> +
>> +    mutex_lock(&chip->lock);
>> +
>> +    switch (mask) {
>> +    case IIO_CHAN_INFO_RAW:
>
> You did not register a RAW attribute for this device.
>
>> +    case IIO_CHAN_INFO_PROCESSED:
>> +        switch(chan->type) {
>> +        case IIO_LIGHT:
>> +            ret = get_illuminance(chip, val);
>> +            break;
>> +        default:
>> +            break;
>> +        }
>> +
>> +        if(!ret)
>> +            ret = IIO_VAL_INT;
>> +
>> +        break;
>> +    default:
>> +        dev_err(&chip->device->dev, "mask value 0x%08lx not supported\n", mask);
>
> You did register a scale attribute for the device, so whenever somebody
> reads the scale attribute he will get this message. I don't think that makes
> much sense. Better just remove IIO_CHAN_INFO_SCALE_SEPARATE_BIT from the
> channel spec. And also remove this dev_err.
>
>> +        break;
>> +    }
>> +
>> +    mutex_unlock(&chip->lock);
>> +
>> +    return ret;
>> +}
>> +
>> +static const struct iio_chan_spec acpi_als_channels[] = {
>> +    {
>> +        .type = IIO_LIGHT,
>> +        .indexed = 1,
>> +        .channel = 1,
>> +        .scan_type.sign = 'u',
>> +        .scan_type.realbits = 10,
>> +        .scan_type.storagebits = 16,
>> +        .info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
>> +        IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>> +    },
>> +};
>> +
>> +static const struct iio_info acpi_als_info = {
>> +    .driver_module = THIS_MODULE,
>> +    .read_raw = &acpi_als_read_raw,
>> +    .write_raw = NULL,
>> +};
>> +
>> +static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
>> +{
>> +
>> +    struct iio_poll_func *pf = p;
>> +    struct iio_dev *idev = pf->indio_dev;
>> +
>> +
>> +    struct acpi_als_chip *chip = iio_priv(idev);
>> +
>> +    printk("XXX: TRIGGER handler called :)");
>
> Aha?
>
>> +    iio_trigger_notify_done(chip->trig);
>> +    return IRQ_HANDLED;
>> +}
>> +
> [...]
>> +
>> +static int acpi_als_add(struct acpi_device *device)
>> +{
>> +    int result;
>> +    struct acpi_als_chip *chip;
>> +    struct iio_dev *indio_dev;
>> +
>> +    /*
>> +    if (unlikely(als_id >= 10)) {
>> +     printk(KERN_WARNING PREFIX "Too many ALS device found\n");
>> +     return -ENODEV;
>> +    }
>> +    */
>
> What's with this?
>
>> +
>> +    indio_dev = iio_device_alloc(sizeof(*chip));
>> +    if (!indio_dev) {
>> +        dev_err(&device->dev, "iio allocation fails\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    chip = iio_priv(indio_dev);
>> +
>> +    device->driver_data = indio_dev;
>> +    chip->device = device;
>> +    mutex_init(&chip->lock);
>> +
>> +    indio_dev->info = &acpi_als_info;
>> +    indio_dev->channels = acpi_als_channels;
>> +    indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
>> +    indio_dev->name = ACPI_ALS_DEVICE_NAME;
>> +    indio_dev->dev.parent = &device->dev;
>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +    result = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
>> +                                        &acpi_als_trigger_handler, NULL);
>> +
>> +    if(result) {
>> +        printk("Could not setup buffer for iio device\n");
>
> dev_err
>
>> +        goto exit_iio_free;
>> +    }
>> +
>> +    result = acpi_als_trigger_init(indio_dev);
>> +    if (result) {
>> +        printk("Couldn't setup the triggers.\n");
>
> dev_err
>
>> +        // TODO
>> +        //goto error_unregister_buffer;
>> +    }
>> +
>> +    result = iio_device_register(indio_dev);
>> +    if (result < 0) {
>> +        dev_err(&chip->device->dev, "iio registration fails with error %d\n",
>> +                result);
>> +        goto exit_iio_free;
>> +    }
>> +
>> +    printk("ACPI ALS initialized");
>
> This is just noise, please remove it.
>
>> +    return 0;
>> +
>> +exit_iio_free:
>> +    iio_device_free(indio_dev);
>> +    return result;
>> +}
>> +
>> +static int acpi_als_remove(struct acpi_device *device, int type)
>> +{
>> +    struct iio_dev *indio_dev;
>> +
>> +    indio_dev = acpi_driver_data(device);
>> +    if(!indio_dev) {
>
> Can this ever happen? I suspect not.
>
>> +        dev_err(&device->dev, "could not get indio_dev for ACPI device\n");
>> +        return -1;
>> +    }
>> +
>> +    iio_device_unregister(indio_dev);
>> +    iio_device_free(indio_dev);
>> +
>> +    return 0;
>> +}
>> +
>> +static int __init acpi_als_init(void)
>> +{
>> +    return acpi_bus_register_driver(&acpi_als_driver);
>> +}
>> +
>> +static void __exit acpi_als_exit(void)
>> +{
>> +    acpi_bus_unregister_driver(&acpi_als_driver);
>> +}
>> +
>> +module_init(acpi_als_init);
>> +module_exit(acpi_als_exit);
>
> Hm, there is no module_acpi_driver? We should probably add one.
>

Hello,
   you are right. The patch is really just half finished patch (let's
call it draft). I will merge all comments you added to my patch. But
the major stuff is that I don't know how to handle iio trigger. As I
wrote before, I use acpi_notify callback for filling iio buffer.
Guideline for IIO says each iio buffer should be completed with
appropriate trigger. In my case makes not sense because I can fill the
buffer for ACPI event handler?

Thank you for advice,
Martin
