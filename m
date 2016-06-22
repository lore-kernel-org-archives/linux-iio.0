Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34149 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbcFVH21 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 03:28:27 -0400
Received: by mail-lb0-f194.google.com with SMTP id w10so3340195lbo.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 00:28:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <77a1a974-2636-878b-742c-d624cc5fdc58@kernel.org>
References: <1464572270-29154-1-git-send-email-mranostay@gmail.com>
 <6e79df7d-4ac1-3a44-e303-af858f30e161@kernel.org> <77a1a974-2636-878b-742c-d624cc5fdc58@kernel.org>
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 22 Jun 2016 00:27:34 -0700
Message-ID: <CAKzfze9B0iNAHS6dxKKvXS4vg0drwcOn-3Vq7aV7EKgzm9QULA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: temperature: add support for Maxim thermocouple chips
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Marek Vasut <marex@denx.de>,
	Matt Porter <mporter@konsulko.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jun 11, 2016 at 9:48 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 03/06/16 13:33, Jonathan Cameron wrote:
>> On 30/05/16 02:37, Matt Ranostay wrote:
>>> Add initial driver support for MAX6675, and MAX31885 thermocouple chips.
>>>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: Matt Porter <mporter@konsulko.com>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> I'm going to let this sit for a sort while as I'd like some discussion
>> of the invalidate buffer bit.
>>
>> Cc'd a few more people for views.
> Hmm. Deadly silence.
>
> Daniel, Lars, Peter - this is a fairly fundamental abi question.
>
> What do we do to signify an 'invalid reading' in the buffer.
>
> Here the part is driven by a software trigger - and if we skip
> a reading we are obviously out of sync.
>
> Old and nasty trick we used in some (possibly only one)
> early driver was to set an invalid state for these cases.
>
> Anyone have a better idea?

So seems good to go? since nobody is complaining? :)

>
> Jonathan
>>
>>> ---
>>>
>>> Changes from v1:
>>> * switch to iio_device_*_direct_mode wrappers
>>> * add const to structs
>>> * removed useless cast
>>>
>>> Changes from v2:
>>> * mark buffer data invalid on disconnected thermocouple
>>> * add .address = 0 to be consistent
>>> * add missing scan_mask for the max31855 part
>>>
>>> .../iio/temperature/maxim_thermocouple.txt         |  21 ++
>>>  drivers/iio/temperature/Kconfig                    |  14 +
>>>  drivers/iio/temperature/Makefile                   |   1 +
>>>  drivers/iio/temperature/maxim_thermocouple.c       | 300 +++++++++++++++++++++
>>>  4 files changed, 336 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
>>>  create mode 100644 drivers/iio/temperature/maxim_thermocouple.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
>>> new file mode 100644
>>> index 0000000..44fb029
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
>>> @@ -0,0 +1,21 @@
>>> +Maxim thermocouple support
>>> +
>>> +* https://datasheets.maximintegrated.com/en/ds/MAX6675.pdf
>>> +* https://datasheets.maximintegrated.com/en/ds/MAX31855.pdf
>>> +
>>> +Required properties:
>>> +
>>> +    - compatible: must be "maxim,max31885" or "maxim,max6675"
>>> +    - reg: SPI chip select number for the device
>>> +    - spi-max-frequency: must be 4300000
>>> +    - spi-cpha: must be defined for max6675 to enable SPI mode 1
>>> +
>>> +    Refer to spi/spi-bus.txt for generic SPI slave bindings.
>>> +
>>> +Example:
>>> +
>>> +    max31885@0 {
>>> +            compatible = "maxim,max31885";
>>> +            reg = <0>;
>>> +            spi-max-frequency = <4300000>;
>>> +    };
>>> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
>>> index c4664e5..c9f5342 100644
>>> --- a/drivers/iio/temperature/Kconfig
>>> +++ b/drivers/iio/temperature/Kconfig
>>> @@ -3,6 +3,20 @@
>>>  #
>>>  menu "Temperature sensors"
>>>
>>> +config MAXIM_THERMOCOUPLE
>>> +    tristate "Maxim thermocouple sensors"
>>> +    depends on SPI
>>> +    help
>>> +      If you say yes here you get support for the Maxim series of
>>> +      thermocouple sensors connected via SPI.
>>> +
>>> +      Supported sensors:
>>> +       * MAX6675
>>> +       * MAX31885
>>> +
>>> +      This driver can also be built as a module. If so, the module will
>>> +      be called maxim_thermocouple.
>>> +
>>>  config MLX90614
>>>      tristate "MLX90614 contact-less infrared sensor"
>>>      depends on I2C
>>> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
>>> index 02bc79d..78c3de0 100644
>>> --- a/drivers/iio/temperature/Makefile
>>> +++ b/drivers/iio/temperature/Makefile
>>> @@ -2,6 +2,7 @@
>>>  # Makefile for industrial I/O temperature drivers
>>>  #
>>>
>>> +obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
>>>  obj-$(CONFIG_MLX90614) += mlx90614.o
>>>  obj-$(CONFIG_TMP006) += tmp006.o
>>>  obj-$(CONFIG_TSYS01) += tsys01.o
>>> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
>>> new file mode 100644
>>> index 0000000..59ef7fd
>>> --- /dev/null
>>> +++ b/drivers/iio/temperature/maxim_thermocouple.c
>>> @@ -0,0 +1,300 @@
>>> +/*
>>> + * maxim_thermocouple.c  - Support for Maxim thermocouple chips
>>> + *
>>> + * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/err.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/trigger.h>
>>> +#include <linux/iio/buffer.h>
>>> +#include <linux/iio/triggered_buffer.h>
>>> +#include <linux/iio/trigger_consumer.h>
>>> +
>>> +#define MAXIM_THERMOCOUPLE_DRV_NAME "maxim_thermocouple"
>>> +
>>> +enum {
>>> +    MAX6675,
>>> +    MAX31885,
>>> +};
>>> +
>>> +const struct iio_chan_spec max6675_channels[] = {
>>> +    {       /* thermocouple temperature */
>>> +            .type = IIO_TEMP,
>>> +            .info_mask_separate =
>>> +                    BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>>> +            .scan_index = 0,
>>> +            .scan_type = {
>>> +                    .sign = 's',
>>> +                    .realbits = 13,
>>> +                    .storagebits = 16,
>>> +                    .shift = 3,
>>> +                    .endianness = IIO_BE,
>>> +            },
>>> +    },
>>> +    IIO_CHAN_SOFT_TIMESTAMP(1),
>>> +};
>>> +
>>> +const struct iio_chan_spec max31885_channels[] = {
>>> +    {       /* thermocouple temperature */
>>> +            .type = IIO_TEMP,
>>> +            .address = 2,
>>> +            .info_mask_separate =
>>> +                    BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>>> +            .scan_index = 0,
>>> +            .scan_type = {
>>> +                    .sign = 's',
>>> +                    .realbits = 14,
>>> +                    .storagebits = 16,
>>> +                    .shift = 2,
>>> +                    .endianness = IIO_BE,
>>> +            },
>>> +    },
>>> +    {       /* cold junction temperature */
>>> +            .type = IIO_TEMP,
>>> +            .address = 0,
>>> +            .channel2 = IIO_MOD_TEMP_AMBIENT,
>>> +            .modified = 1,
>>> +            .info_mask_separate =
>>> +                    BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>>> +            .scan_index = 1,
>>> +            .scan_type = {
>>> +                    .sign = 's',
>>> +                    .realbits = 12,
>>> +                    .storagebits = 16,
>>> +                    .shift = 4,
>>> +                    .endianness = IIO_BE,
>>> +            },
>>> +    },
>>> +    IIO_CHAN_SOFT_TIMESTAMP(2),
>>> +};
>>> +
>>> +static const unsigned long max31885_scan_masks[] = {0x3, 0};
>>> +
>>> +struct maxim_thermocouple_chip {
>>> +    const struct iio_chan_spec *channels;
>>> +    const unsigned long *scan_masks;
>>> +    int num_channels;
>>> +    int read_size;
>>> +
>>> +    /* bit-check for valid input */
>>> +    int status_bit;
>>> +};
>>> +
>>> +const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
>>> +    [MAX6675] = {
>>> +                    .channels = max6675_channels,
>>> +                    .num_channels = ARRAY_SIZE(max6675_channels),
>>> +                    .read_size = 2,
>>> +                    .status_bit = BIT(2),
>>> +            },
>>> +    [MAX31885] = {
>>> +                    .channels = max31885_channels,
>>> +                    .num_channels = ARRAY_SIZE(max31885_channels),
>>> +                    .read_size = 4,
>>> +                    .scan_masks = max31885_scan_masks,
>>> +                    .status_bit = BIT(16),
>>> +            },
>>> +};
>>> +
>>> +struct maxim_thermocouple_data {
>>> +    struct spi_device *spi;
>>> +    const struct maxim_thermocouple_chip *chip;
>>> +
>>> +    u8 buffer[16]; /* 4 byte data + 4 byte padding + 8 byte timestamp */
>>> +};
>>> +
>>> +static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
>>> +                               struct iio_chan_spec const *chan, int *val)
>>> +{
>>> +    unsigned int storage_bytes = data->chip->read_size;
>>> +    unsigned int shift = chan->scan_type.shift + (chan->address * 8);
>>> +    unsigned int buf;
>>> +    int ret;
>>> +
>>> +    ret = spi_read(data->spi, (void *) &buf, storage_bytes);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    switch (storage_bytes) {
>>> +    case 2:
>>> +            *val = be16_to_cpu(buf);
>>> +            break;
>>> +    case 4:
>>> +            *val = be32_to_cpu(buf);
>>> +            break;
>>> +    }
>>> +
>>> +    /* check to be sure this is a valid reading */
>>> +    if (*val & data->chip->status_bit)
>>> +            return -EINVAL;
>>> +
>>> +    *val = sign_extend32(*val >> shift, chan->scan_type.realbits - 1);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void maxim_thermocouple_validate_buffer(struct maxim_thermocouple_data *data)
>>> +{
>>> +    unsigned int storage_bytes = data->chip->read_size;
>>> +    unsigned int *buf = (unsigned int *) data->buffer;
>>> +    int tmp = 0;
>>> +
>>> +    switch (storage_bytes) {
>>> +    case 2:
>>> +            tmp = be16_to_cpu(*buf);
>>> +            break;
>>> +    case 4:
>>> +            tmp = be32_to_cpu(*buf);
>>> +            break;
>>> +    }
>>> +
>>> +    /* check to be sure this is a valid reading, mark result -1 if not */
>>> +    if (tmp & data->chip->status_bit)
>>> +            memset(data->buffer, 0xff, storage_bytes);
>>> +}
>>> +
>>> +static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
>>> +{
>>> +    struct iio_poll_func *pf = private;
>>> +    struct iio_dev *indio_dev = pf->indio_dev;
>>> +    struct maxim_thermocouple_data *data = iio_priv(indio_dev);
>>> +    int ret;
>>> +
>>> +    ret = spi_read(data->spi, data->buffer, data->chip->read_size);
>>> +    if (!ret) {
>>> +            maxim_thermocouple_validate_buffer(data);
>>> +            iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>>> +                                               iio_get_time_ns());
>>> +    }
>>> +
>>> +    iio_trigger_notify_done(indio_dev->trig);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
>>> +                                   struct iio_chan_spec const *chan,
>>> +                                   int *val, int *val2, long mask)
>>> +{
>>> +    struct maxim_thermocouple_data *data = iio_priv(indio_dev);
>>> +    int ret = -EINVAL;
>>> +
>>> +    switch (mask) {
>>> +    case IIO_CHAN_INFO_RAW:
>>> +            if (iio_device_claim_direct_mode(indio_dev))
>>> +                    return -EBUSY;
>>> +
>>> +            ret = maxim_thermocouple_read(data, chan, val);
>>> +            if (!ret)
>>> +                    ret = IIO_VAL_INT;
>>> +
>>> +            iio_device_release_direct_mode(indio_dev);
>>> +            break;
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +            switch (chan->channel2) {
>>> +            case IIO_MOD_TEMP_AMBIENT:
>>> +                    *val = 62;
>>> +                    *val2 = 500000; /* 1000 * 0.0625 */
>>> +                    ret = IIO_VAL_INT_PLUS_MICRO;
>>> +                    break;
>>> +            default:
>>> +                    *val = 250; /* 1000 * 0.25 */
>>> +                    ret = IIO_VAL_INT;
>>> +            };
>>> +            break;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static const struct iio_info maxim_thermocouple_info = {
>>> +    .driver_module = THIS_MODULE,
>>> +    .read_raw = maxim_thermocouple_read_raw,
>>> +};
>>> +
>>> +static int maxim_thermocouple_probe(struct spi_device *spi)
>>> +{
>>> +    const struct spi_device_id *id = spi_get_device_id(spi);
>>> +    struct iio_dev *indio_dev;
>>> +    struct maxim_thermocouple_data *data;
>>> +    const struct maxim_thermocouple_chip *chip =
>>> +                    &maxim_thermocouple_chips[id->driver_data];
>>> +    int ret;
>>> +
>>> +    indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
>>> +    if (!indio_dev)
>>> +            return -ENOMEM;
>>> +
>>> +    indio_dev->info = &maxim_thermocouple_info;
>>> +    indio_dev->name = MAXIM_THERMOCOUPLE_DRV_NAME;
>>> +    indio_dev->channels = chip->channels;
>>> +    indio_dev->available_scan_masks = chip->scan_masks;
>>> +    indio_dev->num_channels = chip->num_channels;
>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>> +
>>> +    data = iio_priv(indio_dev);
>>> +    data->spi = spi;
>>> +    data->chip = chip;
>>> +
>>> +    ret = iio_triggered_buffer_setup(indio_dev, NULL,
>>> +                            maxim_thermocouple_trigger_handler, NULL);
>>> +    if (ret)
>>> +            return ret;
>>> +
>>> +    ret = iio_device_register(indio_dev);
>>> +    if (ret)
>>> +            goto error_unreg_buffer;
>>> +
>>> +    return 0;
>>> +
>>> +error_unreg_buffer:
>>> +    iio_triggered_buffer_cleanup(indio_dev);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int maxim_thermocouple_remove(struct spi_device *spi)
>>> +{
>>> +    struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>> +
>>> +    iio_device_unregister(indio_dev);
>>> +    iio_triggered_buffer_cleanup(indio_dev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct spi_device_id maxim_thermocouple_id[] = {
>>> +    {"max6675", MAX6675},
>>> +    {"max31885", MAX31885},
>>> +    {},
>>> +};
>>> +MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
>>> +
>>> +static struct spi_driver maxim_thermocouple_driver = {
>>> +    .driver = {
>>> +            .name   = MAXIM_THERMOCOUPLE_DRV_NAME,
>>> +    },
>>> +    .probe          = maxim_thermocouple_probe,
>>> +    .remove         = maxim_thermocouple_remove,
>>> +    .id_table       = maxim_thermocouple_id,
>>> +};
>>> +module_spi_driver(maxim_thermocouple_driver);
>>> +
>>> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>>> +MODULE_DESCRIPTION("Maxim thermocouple sensors");
>>> +MODULE_LICENSE("GPL");
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
