Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48740 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbcLJSEO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 13:04:14 -0500
Subject: Re: [PATCH] iio: Add Maxim MAX11100 driver
To: "jacopo@jmondi.org" <jacopo@jmondi.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org>
 <alpine.DEB.2.02.1612062143480.10644@pmeerw.net>
 <adc93632-e487-0251-1d27-a56e9215e9f6@jmondi.org>
Cc: wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b9a7ac4d-4c48-b540-bfe9-91529567371a@kernel.org>
Date: Sat, 10 Dec 2016 18:04:11 +0000
MIME-Version: 1.0
In-Reply-To: <adc93632-e487-0251-1d27-a56e9215e9f6@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/12/16 08:29, jacopo@jmondi.org wrote:
> Hi Peter,
>    thanks for review
> 
> On 06/12/2016 22:00, Peter Meerwald-Stadler wrote:
>> On Tue, 6 Dec 2016, Jacopo Mondi wrote:
>>
>>> Add IIO driver for Maxim MAX11100 single-channel ADC.
>>> Support raw_read mode only.
>>
>> comments below; very minimal driver, but several easy issues...
>>
>> the read_raw() is supposed to return millivolts (after application of
>> offset and scale); maybe need _SCALE?
> 
> How can I return millivolts here? They vary in function of the supplied Vref as ( V = val * Vref / (2 ^ 16 - 1)) where "val" is digital value output by the ADC.
> Since Vref can range from 3.8V to 5.25V, while it's typically 4.096V, isn't it more appropriate to let userspace perform conversion to millivolts, as it knows what Vref value is supplied to the ADC?
> 
>>
>>> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
>>> ---
>>>  drivers/iio/adc/Kconfig    |   9 +++
>>>  drivers/iio/adc/Makefile   |   1 +
>>>  drivers/iio/adc/max11100.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 175 insertions(+)
>>>  create mode 100644 drivers/iio/adc/max11100.c
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 99c0514..e2f3340 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -285,6 +285,15 @@ config MAX1027
>>>        To compile this driver as a module, choose M here: the module will be
>>>        called max1027.
>>>
>>> +config MAX11100
>>> +    tristate "Maxim max11100 ADC driver"
>>> +    depends on SPI
>>> +    help
>>> +      Say yes here to build support for Maxim 11100 SPI ADC
>>
>> Maxim max11100
>>
>>> +
>>> +      To compile this driver as a module, choose M here: the module will be
>>> +      called max11100.
>>> +
>>>  config MAX1363
>>>      tristate "Maxim max1363 ADC driver"
>>>      depends on I2C
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index 7a40c04..1463044 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -29,6 +29,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>>>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>>>  obj-$(CONFIG_LTC2485) += ltc2485.o
>>>  obj-$(CONFIG_MAX1027) += max1027.o
>>> +obj-$(CONFIG_MAX11100) += max11100.o
>>>  obj-$(CONFIG_MAX1363) += max1363.o
>>>  obj-$(CONFIG_MCP320X) += mcp320x.o
>>>  obj-$(CONFIG_MCP3422) += mcp3422.o
>>> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
>>> new file mode 100644
>>> index 0000000..fbce287
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/max11100.c
>>> @@ -0,0 +1,165 @@
>>> +/*
>>> + * iio/adc/max11100.c
>>> + * Maxim MAX11100 ADC Driver with IIO interface
>>
>> MAX11100 or max11100
>>
>>> + *
>>> + * Copyright (C) 2016 Renesas Electronics Corporation
>>> + * Copyright (C) 2016 Jacopo Mondi
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/delay.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/buffer.h>
>>> +
>>> +struct max11100_state {
>>> +    const struct max11100_chip_desc *desc;
>>> +    struct spi_device *spi;
>>> +    struct mutex lock;
>>> +};
>>> +
>>> +static struct iio_chan_spec max11100_channels[] = {
>>> +    { /* [0] */
>>> +        .type = IIO_VOLTAGE,
>>> +        .channel = 0,
>>
>> not indexed, so channel = 0 not needed
>>
>>> +        .address = 0,
>>
>> address not needed (and no need to initialize to 0 anyway)
>>
>>> +        .scan_index = 0,
>>
>> scan_index and scan_type not needed since no buffered support (yet); add
>> this when needed
>>
>>> +        .scan_type = {
>>> +            .sign = 'u',
>>> +            .realbits = 16,
>>> +            .storagebits = 24,
>>> +            .shift = 8,
>>> +            .repeat = 1,
>>> +            .endianness = IIO_BE,
>>> +        },
>>> +        .output = 1,
>>
>> no, ADC is typically not an output channel
>>
>>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> +    },
>>> +};
>>> +
>>> +static const unsigned long max11100_scan_masks[] = {
>>
>> scan_masks not needed since no buffered support
>>
>>> +    0xffff,
>>> +};
>>> +
>>> +static struct max11100_chip_desc {
>>> +    uint32_t num_chan;
>>
>> why not just unsigned?
>>
>>> +    const unsigned long *scanmasks;
>>
>> not needed (yet)
>>
>>> +    const struct iio_chan_spec *channels;
>>> +} max11100_desc = {
>>> +    .num_chan = 1,
>>
>> ARRAY_SIZE(max11100_channels)
>>
>>> +    .scanmasks = max11100_scan_masks,
>>> +    .channels = max11100_channels,
>>> +};
>>> +
>>> +static int max11100_read_raw(struct iio_dev *indio_dev,
>>> +                 struct iio_chan_spec const *chan,
>>> +                 int *val, int *val2, long mask)
>>> +{
>>> +    int ret;
>>> +    struct max11100_state *state = iio_priv(indio_dev);
>>> +    uint8_t buffer[3] = { 0, 0, 0 };
>>
>> no need to initialize buffer; consider alignment requirements for SPI
>>
>>> +
>>> +    mutex_lock(&state->lock);
>>
>> what is the mutex protecting?
>> must the spi_read() by protected? then the unlock can be placed right
>> after the call...
>>
>>> +
>>> +    ret = spi_read(state->spi, (void *) buffer, 3);
>>
>> sizeof(buffer)
>>
>>> +    if (ret) {
>>> +        dev_err(&indio_dev->dev, "SPI transfer failed\n");
>>
>> mutex_unlock()!?
>>
>>> +        return ret;
>>> +    }
>>> +
>>> +    dev_dbg(&indio_dev->dev, "ADC output values: "    \
>>> +        "[0]: 0x%2x [1]: 0x%2x [2]: 0x%2x\n",
>>
>> probably 0x%02x if really needed
>>
>>> +        buffer[0], buffer[1], buffer[2]);
>>> +
>>> +    /* the first 8 bits sent out from ADC must be 0s */
>>> +    if (buffer[0]) {
>>> +        dev_err(&indio_dev->dev, "Invalid value: buffer[0] != 0\n");
>>
>> mutex_unlock()!?
> 
> This is embarrassing. It got lost during last rebase, sorry about that.
> 
>>
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    *val = (buffer[1] << 8) | buffer[2];
>>> +    mutex_unlock(&state->lock);
>>> +
>>
>> shouldn't this return IIO_VAL_INT?
>>
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct iio_info max11100_info = {
>>> +    .driver_module = THIS_MODULE,
>>> +    .read_raw = max11100_read_raw,
>>> +};
>>> +
>>> +static int max11100_probe(struct spi_device *spi)
>>> +{
>>> +    int ret;
>>> +    struct iio_dev *indio_dev;
>>> +    struct max11100_state *state;
>>> +
>>> +    indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
>>> +    if (!indio_dev) {
>>> +        pr_err("Can't allocate iio device\n");
>>
>> error message really needed?
>>
>>> +        return -ENOMEM;
>>> +    }
>>> +    dev_dbg(&indio_dev->dev, "probe max11100 IIO SPI\n");
>>
>> message really needed?
>>
>>> +
>>> +    spi_set_drvdata(spi, indio_dev);
>>> +
>>> +    state = iio_priv(indio_dev);
>>> +    state->spi = spi;
>>> +    state->desc = &max11100_desc;
>>> +
>>> +    mutex_init(&state->lock);
>>> +
>>> +    indio_dev->dev.parent = &spi->dev;
>>> +    indio_dev->dev.of_node = spi->dev.of_node;
>>> +    indio_dev->info = &max11100_info;
>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>> +    indio_dev->channels = state->desc->channels;
>>> +    indio_dev->num_channels = state->desc->num_chan;
>>> +    indio_dev->available_scan_masks = state->desc->scanmasks;
>>> +
>>> +    ret = iio_device_register(indio_dev);
>>
>> could use devm_ variant...
>>
>>> +    if (ret) {
>>> +        dev_err(&indio_dev->dev, "Failed to register iio device\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int max11100_remove(struct spi_device *spi)
>>
>> function not needed if using devm_iio_device_register()
>>
>>> +{
>>> +    struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>> +
>>> +    dev_dbg(&indio_dev->dev, "remove max11100 IIO SPI\n");
>>> +
>>> +    iio_device_unregister(indio_dev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct of_device_id max11100_ids[] = {
>>> +    {.compatible = "maxim,max11100"},
>>> +    { },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, max11100_ids);
>>> +
>>> +static struct spi_driver max11100_driver = {
>>> +    .driver = {
>>> +        .name    = "max11100",
>>> +        .owner    = THIS_MODULE,
>>> +        .of_match_table = of_match_ptr(max11100_ids),
>>> +    },
>>> +    .probe        = max11100_probe,
>>> +    .remove        = max11100_remove,
>>> +};
>>> +
>>> +module_spi_driver(max11100_driver);
>>> +
>>> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
>>> +MODULE_DESCRIPTION("Maxim MAX11100 ADC Driver");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
> 
> This driver is so minimal, I wonder if there are not drivers for
> similar devices to which I can add support for MAX11100 instead of
> writing a new one from scratch. Anyone with more expertise than me in
> IIO codebase maybe can suggest something here...
Could possibly blugeon it into the ad7476 code, but it wouldn't be pretty...
Some of the SPI TI parts perhaps, but again you'll end up with a fair refactoring of
the existing drivers to get it in.

Seems simple I agree, but somehow there are an awful lot of simple ways to interface
and ADC via a couple of spi transfers!

Jonathan
> Thanks
>    j
> 
> 

