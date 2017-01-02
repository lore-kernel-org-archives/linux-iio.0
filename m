Return-Path: <SRS0=V5wQ=YQ=jmondi.org=jacopo@kernel.org>
Subject: Re: [PATCHv2] iio: adc: Add Maxim MAX11100 driver
To: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org>
 <1481632629-18826-1-git-send-email-jacopo@jmondi.org>
 <alpine.DEB.2.02.1612132128010.8653@pmeerw.net>
 <c63a1544-5d04-cce9-3103-e05bcacbe530@jmondi.org>
 <11bb8f81-1c50-f063-6e40-e3b559458ddd@kernel.org>
Cc: wsa+renesas@sang-engineering.com, magnus.damm@gmail.com, knaack.h@gmx.de,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: jacopo mondi <jacopo@jmondi.org>
Message-ID: <6d91c0b8-c8e6-bf80-e729-6ca90ddc12bb@jmondi.org>
Date: Mon, 2 Jan 2017 10:19:20 +0100
MIME-Version: 1.0
In-Reply-To: <11bb8f81-1c50-f063-6e40-e3b559458ddd@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,
    thanks for review

On 30/12/2016 17:31, Jonathan Cameron wrote:
> On 14/12/16 12:00, jacopo@jmondi.org wrote:
>> Hello Peter,
>>    thanks for review
>>
>> On 13/12/2016 21:33, Peter Meerwald-Stadler wrote:
>>>
>>>> Add IIO driver for Maxim MAX11100 single-channel ADC.
>>>> Add DT bindings documentation.
>>>
>>> some more comments
>>>
>>>> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
>>>> ---
>>>>
>>>> v1 -> v2:
>>>>     - incorporated pmeerw's review comments
>>>>     - retrieve vref from dts and use that to convert read_raw result
>>>>       to mV
>>>>     - add device tree bindings documentation
>>>>
>>>> ---
>>>>  .../devicetree/bindings/iio/adc/max11100.txt       |  17 +++
>>>>  drivers/iio/adc/Kconfig                            |   9 ++
>>>>  drivers/iio/adc/Makefile                           |   1 +
>>>>  drivers/iio/adc/max11100.c                         | 166 +++++++++++++++++++++
>>>>  4 files changed, 193 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
>>>>  create mode 100644 drivers/iio/adc/max11100.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/max11100.txt b/Documentation/devicetree/bindings/iio/adc/max11100.txt
>>>> new file mode 100644
>>>> index 0000000..6877c11
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/max11100.txt
>>>> @@ -0,0 +1,17 @@
>>>> +* Maxim max11100 Analog to Digital Converter (ADC)
>>>> +
>>>> +Required properties:
>>>> +  - compatible: Should be "maxim,max11100"
>>>> +  - vref-supply: phandle to the regulator that provides reference voltage
>>>> +
>>>> +Optional properties:
>>>> +  - spi-max-frequency: SPI maximum frequency
>>>> +
>>>> +Example:
>>>> +
>>>> +adc0: max11100@0 {
>>>> +        compatible = "maxim,max11100";
>>>> +        vref-supply = <&adc0_vref>;
>>>> +        spi-max-frequency = <240000>;
>>>> +};
>>>> +
>>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>>> index 99c0514..a909484 100644
>>>> --- a/drivers/iio/adc/Kconfig
>>>> +++ b/drivers/iio/adc/Kconfig
>>>> @@ -285,6 +285,15 @@ config MAX1027
>>>>        To compile this driver as a module, choose M here: the module will be
>>>>        called max1027.
>>>>
>>>> +config MAX11100
>>>> +    tristate "Maxim max11100 ADC driver"
>>>> +    depends on SPI
>>>
>>> SPI_MASTER is more precise I think
>>>
>>>> +    help
>>>> +      Say yes here to build support for Maxim max11100 SPI ADC
>>>> +
>>>> +      To compile this driver as a module, choose M here: the module will be
>>>> +      called max11100.
>>>> +
>>>>  config MAX1363
>>>>      tristate "Maxim max1363 ADC driver"
>>>>      depends on I2C
>>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>>> index 7a40c04..1463044 100644
>>>> --- a/drivers/iio/adc/Makefile
>>>> +++ b/drivers/iio/adc/Makefile
>>>> @@ -29,6 +29,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>>>>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>>>>  obj-$(CONFIG_LTC2485) += ltc2485.o
>>>>  obj-$(CONFIG_MAX1027) += max1027.o
>>>> +obj-$(CONFIG_MAX11100) += max11100.o
>>>>  obj-$(CONFIG_MAX1363) += max1363.o
>>>>  obj-$(CONFIG_MCP320X) += mcp320x.o
>>>>  obj-$(CONFIG_MCP3422) += mcp3422.o
>>>> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
>>>> new file mode 100644
>>>> index 0000000..f372ad8
>>>> --- /dev/null
>>>> +++ b/drivers/iio/adc/max11100.c
>>>> @@ -0,0 +1,166 @@
>>>> +/*
>>>> + * iio/adc/max11100.c
>>>> + * Maxim max11100 ADC Driver with IIO interface
>>>> + *
>>>> + * Copyright (C) 2016 Renesas Electronics Corporation
>>>> + * Copyright (C) 2016 Jacopo Mondi
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +#include <linux/delay.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/regulator/consumer.h>
>>>> +#include <linux/spi/spi.h>
>>>> +
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/buffer.h>
>>>> +#include <linux/iio/driver.h>
>>>> +
>>>> +/*
>>>> + * LSB is the ADC single digital step
>>>> + * 1 LSB = (vref / 2 ^ 16)
>>>> + * AIN = (DIN * LSB)
>>>> + */
>>>> +#define MAX11100_LSB_DIV        (1 << 16)
>>>> +#define MAX11100_LSB(vref)         (vref / MAX11100_LSB_DIV)
>>>
>>> maybe parenthesis around vref
>>>
>>>> +
>>>> +struct max11100_state {
>>>> +    const struct max11100_chip_desc *desc;
>>>> +    struct spi_device *spi;
>>>> +    int vref_uv;
>>>> +    struct mutex lock;
>>>> +};
>>>> +
>>>> +static struct iio_chan_spec max11100_channels[] = {
>>>> +    { /* [0] */
>>>> +        .type = IIO_VOLTAGE,
>>>> +        .scan_type = {
>>>
>>> scan_type not needed since driver does not support buffered reads
>>>
>>>> +            .sign = 'u',
>>>> +            .realbits = 16,
>>>> +            .storagebits = 24,
>>>> +            .shift = 8,
>>>> +            .repeat = 1,
>>>> +            .endianness = IIO_BE,
>>>> +        },
>>>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>> +    },
>>>> +};
>>>> +
>>>> +static struct max11100_chip_desc {
>>>> +    unsigned int num_chan;
>>>> +    const struct iio_chan_spec *channels;
>>>> +} max11100_desc = {
>>>> +    .num_chan = ARRAY_SIZE(max11100_channels),
>>>> +    .channels = max11100_channels,
>>>> +};
>>>> +
>>>> +static int max11100_read_raw(struct iio_dev *indio_dev,
>>>> +                 struct iio_chan_spec const *chan,
>>>> +                 int *val, int *val2, long mask)
>>>> +{
>>>> +    int ret;
>>>> +    struct max11100_state *state = iio_priv(indio_dev);
>>>> +    uint8_t buffer[3];
>>>> +
>>>> +    mutex_lock(&state->lock);
>>>> +
>>>> +    ret = spi_read(state->spi, buffer, sizeof(buffer));
>>>> +    if (ret) {
>>>> +        mutex_unlock(&state->lock);
>>>> +        dev_err(&indio_dev->dev, "SPI transfer failed\n");
>>>> +        return ret;
>>>> +    }
>>>> +    mutex_unlock(&state->lock);
>>>> +
>>>> +    /* the first 8 bits sent out from ADC must be 0s */
>>>> +    if (buffer[0]) {
>>>> +        dev_err(&indio_dev->dev, "Invalid value: buffer[0] != 0\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    *val = be16_to_cpu(*(uint16_t *)&buffer[1]);
>>>> +    *val = *val * MAX11100_LSB(state->vref_uv) / 1000;
>>>
>>> no, INFO_RAW shall not perform such scaling, use _PROCESSED or add an
>>> INFO_SCALE to indicate the scaling
>>
>> Here I am not scaling the result, just converting the digital value read from ADC into millivolts.
>> The transfer function from Din to Ain depends on vref, in the form reported in comments in file header:
>>
>> Ain = Din * (vref / 2^16)
>>
>> I am using microvolts as "vref" unit otherwise I would have been forced to deal with floating point arithmetic.
> That's what the _scale elements of the IIO ABI meant for.  Make even this simple
> conversion the job of userspace which is better placed to do any magic it wishes
> to do with how it does the conversion (or whether it does depending on the
> application).  So expectation is that raw means whatever came from the ADC so
> ADC 'counts' not mV or similar.
>

Ok, fine, I now get it.
Userspace perform conversion using values returned from _RAW and _SCALE.

As the conversion process is device-specific (in my case is the simple 
transfer function reported some lines above), should it be documented 
somewhere?

Thanks
    j

> Jonathan
>>
>> Thanks
>>    j
>>
>>>
>>>> +
>>>> +    return IIO_VAL_INT;
>>>> +}
>>>> +
>>>> +static const struct iio_info max11100_info = {
>>>> +    .driver_module = THIS_MODULE,
>>>> +    .read_raw = max11100_read_raw,
>>>> +};
>>>> +
>>>> +static int max11100_probe(struct spi_device *spi)
>>>> +{
>>>> +    int ret;
>>>> +    struct iio_dev *indio_dev;
>>>> +    struct regulator *vref_reg;
>>>> +    struct max11100_state *state;
>>>> +
>>>> +    indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
>>>> +    if (!indio_dev)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    spi_set_drvdata(spi, indio_dev);
>>>> +
>>>> +    state = iio_priv(indio_dev);
>>>> +    state->spi = spi;
>>>> +    state->desc = &max11100_desc;
>>>> +
>>>> +    mutex_init(&state->lock);
>>>> +
>>>> +    indio_dev->dev.parent = &spi->dev;
>>>> +    indio_dev->dev.of_node = spi->dev.of_node;
>>>> +    indio_dev->info = &max11100_info;
>>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>>> +    indio_dev->channels = state->desc->channels;
>>>> +    indio_dev->num_channels = state->desc->num_chan;
>>>> +
>>>> +    vref_reg = devm_regulator_get(&spi->dev, "vref");
>>>> +    if (IS_ERR(vref_reg))
>>>> +        return PTR_ERR(vref_reg);
>>>> +
>>>> +    ret = regulator_enable(vref_reg);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    state->vref_uv = regulator_get_voltage(vref_reg);
>>>> +    if (state->vref_uv < 0) {
>>>> +        /* dummy regulator "get_voltage" returns -EINVAL as well */
>>>> +        ret = -EINVAL;
>>>> +        goto disable_regulator;
>>>> +    }
>>>> +
>>>> +    ret = devm_iio_device_register(&spi->dev, indio_dev);
>>>
>>> the regulator needs to be disabled in a _remove() function and since you
>>> need a remove function, devm_iio_device_register() should not be used
>>>
>>>> +    if (ret)
>>>> +        goto disable_regulator;
>>>> +
>>>> +    return 0;
>>>> +
>>>> +disable_regulator:
>>>> +    regulator_disable(vref_reg);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static const struct of_device_id max11100_ids[] = {
>>>> +    {.compatible = "maxim,max11100"},
>>>> +    { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, max11100_ids);
>>>> +
>>>> +static struct spi_driver max11100_driver = {
>>>> +    .driver = {
>>>> +        .name    = "max11100",
>>>> +        .owner    = THIS_MODULE,
>>>> +        .of_match_table = of_match_ptr(max11100_ids),
>>>> +    },
>>>> +    .probe        = max11100_probe,
>>>> +};
>>>> +
>>>> +module_spi_driver(max11100_driver);
>>>> +
>>>> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
>>>> +MODULE_DESCRIPTION("Maxim max11100 ADC Driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
