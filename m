Return-Path: <SRS0=Y7Or=4V=siemens.com=jan.kiszka@kernel.org>
Subject: Re: [PATCH v5] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
References: <9d7366c4-7965-d92a-e806-f20a8d63242e@siemens.com>
 <e24fb9b7-3b0f-c7e2-0c20-6c964770705c@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3e2b5478-6b8c-efcf-0064-be00f30e2580@siemens.com>
Date: Mon, 15 May 2017 07:20:53 +0200
MIME-Version: 1.0
In-Reply-To: <e24fb9b7-3b0f-c7e2-0c20-6c964770705c@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-iio@vger.kernel.org>

On 2017-05-14 17:50, Jonathan Cameron wrote:
> On 08/05/17 09:46, Jan Kiszka wrote:
>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>> included.
>>
>> Due to the lack of regulators under ACPI, we hard-code the voltage
>> provided to the VA pin of the ADC to 5 V, the value used on Galileo and
>> IOT2000. For DT usage, the regulator "vref-supply" provides this
>> information. Note that DT usage has not been tested.
>>
>> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
>> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
>> Todor Minchev <todor@minchev.co.uk>.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> A small race issue in remove, but otherwise looking very nice.
> 
> I'm on the edge of just cleaning that up and applying this,
> but with the reordering I'm suggesting it's probably best you
> give it some thought rather than me just assuming it'll be fine ;)
> 
> Jonathan
>> ---
>>
>> Changes in v5:
>>   - refactor error handling in adc108s102_read_raw
>>   - removed no longer needed checks before regulator_disable
>>     (v3 left-over)
>>
>>   .../devicetree/bindings/iio/adc/ti-adc108s102.txt  |  18 ++
>>   drivers/iio/adc/Kconfig                            |  12 +
>>   drivers/iio/adc/Makefile                           |   1 +
>>   drivers/iio/adc/ti-adc108s102.c                    | 342
>> +++++++++++++++++++++
>>   4 files changed, 373 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
>>   create mode 100644 drivers/iio/adc/ti-adc108s102.c
>>
>> diff --git
>> a/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
>> b/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
>> new file mode 100644
>> index 000000000000..bbbbb4a9f58f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
>> @@ -0,0 +1,18 @@
>> +* Texas Instruments' ADC108S102 and ADC128S102 ADC chip
>> +
>> +Required properties:
>> + - compatible: Should be "ti,adc108s102"
>> + - reg: spi chip select number for the device
>> + - vref-supply: The regulator supply for ADC reference voltage
>> +
>> +Recommended properties:
>> + - spi-max-frequency: Definition as per
>> +        Documentation/devicetree/bindings/spi/spi-bus.txt
>> +
>> +Example:
>> +adc@0 {
>> +    compatible = "ti,adc108s102";
>> +    reg = <0>;
>> +    vref-supply = <&vdd_supply>;
>> +    spi-max-frequency = <1000000>;
>> +};
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index dedae7adbce9..8b7dae5604f2 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -572,6 +572,18 @@ config TI_ADC12138
>>         This driver can also be built as a module. If so, the module
>> will be
>>         called ti-adc12138.
>>   +config TI_ADC108S102
>> +    tristate "Texas Instruments ADC108S102 and ADC128S102 driver"
>> +    depends on SPI
>> +    select IIO_BUFFER
>> +    select IIO_TRIGGERED_BUFFER
>> +    help
>> +      Say yes here to build support for Texas Instruments ADC108S102 and
>> +      ADC128S102 ADC.
>> +
>> +      To compile this driver as a module, choose M here: the module will
>> +      be called ti-adc108s102.
>> +
>>   config TI_ADC128S052
>>       tristate "Texas Instruments ADC128S052/ADC122S021/ADC124S021"
>>       depends on SPI
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index d0012620cd1c..e6c20fe3d4eb 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -52,6 +52,7 @@ obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>>   obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>   obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>>   obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
>> +obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
>>   obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>>   obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>>   obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>> diff --git a/drivers/iio/adc/ti-adc108s102.c
>> b/drivers/iio/adc/ti-adc108s102.c
>> new file mode 100644
>> index 000000000000..bdf3254619a3
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-adc108s102.c
>> @@ -0,0 +1,342 @@
>> +/*
>> + * TI ADC108S102 SPI ADC driver
>> + *
>> + * Copyright (c) 2013-2015 Intel Corporation.
>> + * Copyright (c) 2017 Siemens AG
>> + *
>> + * This program is free software; you can redistribute it and/or
>> modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>> License for
>> + * more details.
>> + *
>> + * This IIO device driver is designed to work with the following
>> + * analog to digital converters from Texas Instruments:
>> + *  ADC108S102
>> + *  ADC128S102
>> + * The communication with ADC chip is via the SPI bus (mode 3).
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/types.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/property.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/spi/spi.h>
>> +
>> +/*
>> + * In case of ACPI, we use the hard-wired 5000 mV of the Galileo and
>> IOT2000
>> + * boards as default for the reference pin VA. Device tree users
>> encode that
>> + * via the vref-supply regulator.
>> + */
>> +#define ADC108S102_VA_MV_ACPI_DEFAULT    5000
>> +
>> +/*
>> + * Defining the ADC resolution being 12 bits, we can use the same
>> driver for
>> + * both ADC108S102 (10 bits resolution) and ADC128S102 (12 bits
>> resolution)
>> + * chips. The ADC108S102 effectively returns a 12-bit result with the 2
>> + * least-significant bits unset.
>> + */
>> +#define ADC108S102_BITS        12
>> +#define ADC108S102_MAX_CHANNELS    8
>> +
>> +/*
>> + * 16-bit SPI command format:
>> + *   [15:14] Ignored
>> + *   [13:11] 3-bit channel address
>> + *   [10:0]  Ignored
>> + */
>> +#define ADC108S102_CMD(ch)        ((u16)(ch) << 11)
>> +
>> +/*
>> + * 16-bit SPI response format:
>> + *   [15:12] Zeros
>> + *   [11:0]  12-bit ADC sample (for ADC108S102, [1:0] will always be 0).
>> + */
>> +#define ADC108S102_RES_DATA(res)    ((u16)res & GENMASK(11, 0))
>> +
>> +struct adc108s102_state {
>> +    struct spi_device        *spi;
>> +    struct regulator        *reg;
>> +    u32                va_millivolt;
>> +    /* SPI transfer used by triggered buffer handler*/
>> +    struct spi_transfer        ring_xfer;
>> +    /* SPI transfer used by direct scan */
>> +    struct spi_transfer        scan_single_xfer;
>> +    /* SPI message used by ring_xfer SPI transfer */
>> +    struct spi_message        ring_msg;
>> +    /* SPI message used by scan_single_xfer SPI transfer */
>> +    struct spi_message        scan_single_msg;
>> +
>> +    /*
>> +     * SPI message buffers:
>> +     *  tx_buf: |C0|C1|C2|C3|C4|C5|C6|C7|XX|
>> +     *  rx_buf: |XX|R0|R1|R2|R3|R4|R5|R6|R7|tt|tt|tt|tt|
>> +     *
>> +     *  tx_buf: 8 channel read commands, plus 1 dummy command
>> +     *  rx_buf: 1 dummy response, 8 channel responses, plus 64-bit
>> timestamp
>> +     */
>> +    __be16                rx_buf[13] ____cacheline_aligned;
>> +    __be16                tx_buf[9] ____cacheline_aligned;
>> +};
>> +
>> +#define ADC108S102_V_CHAN(index)                    \
>> +    {                                \
>> +        .type = IIO_VOLTAGE,                    \
>> +        .indexed = 1,                        \
>> +        .channel = index,                    \
>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |        \
>> +            BIT(IIO_CHAN_INFO_SCALE),            \
>> +        .address = index,                    \
>> +        .scan_index = index,                    \
>> +        .scan_type = {                        \
>> +            .sign = 'u',                    \
>> +            .realbits = ADC108S102_BITS,            \
>> +            .storagebits = 16,                \
>> +            .endianness = IIO_BE,                \
>> +        },                            \
>> +    }
>> +
>> +static const struct iio_chan_spec adc108s102_channels[] = {
>> +    ADC108S102_V_CHAN(0),
>> +    ADC108S102_V_CHAN(1),
>> +    ADC108S102_V_CHAN(2),
>> +    ADC108S102_V_CHAN(3),
>> +    ADC108S102_V_CHAN(4),
>> +    ADC108S102_V_CHAN(5),
>> +    ADC108S102_V_CHAN(6),
>> +    ADC108S102_V_CHAN(7),
>> +    IIO_CHAN_SOFT_TIMESTAMP(8),
>> +};
>> +
>> +static int adc108s102_update_scan_mode(struct iio_dev *indio_dev,
>> +        unsigned long const *active_scan_mask)
>> +{
>> +    struct adc108s102_state *st = iio_priv(indio_dev);
>> +    unsigned int bit, cmds;
>> +
>> +    /*
>> +     * Fill in the first x shorts of tx_buf with the number of channels
>> +     * enabled for sampling by the triggered buffer.
>> +     */
>> +    cmds = 0;
>> +    for_each_set_bit(bit, active_scan_mask, ADC108S102_MAX_CHANNELS)
>> +        st->tx_buf[cmds++] = cpu_to_be16(ADC108S102_CMD(bit));
>> +
>> +    /* One dummy command added, to clock in the last response */
>> +    st->tx_buf[cmds++] = 0x00;
>> +
>> +    /* build SPI ring message */
>> +    st->ring_xfer.tx_buf = &st->tx_buf[0];
>> +    st->ring_xfer.rx_buf = &st->rx_buf[0];
>> +    st->ring_xfer.len = cmds * sizeof(st->tx_buf[0]);
>> +
>> +    spi_message_init_with_transfers(&st->ring_msg, &st->ring_xfer, 1);
>> +
>> +    return 0;
>> +}
>> +
>> +static irqreturn_t adc108s102_trigger_handler(int irq, void *p)
>> +{
>> +    struct iio_poll_func *pf = p;
>> +    struct iio_dev *indio_dev = pf->indio_dev;
>> +    struct adc108s102_state *st = iio_priv(indio_dev);
>> +    int ret;
>> +
>> +    ret = spi_sync(st->spi, &st->ring_msg);
>> +    if (ret < 0)
>> +        goto out_notify;
>> +
>> +    /* Skip the dummy response in the first slot */
>> +    iio_push_to_buffers_with_timestamp(indio_dev,
>> +                       (u8 *)&st->rx_buf[1],
>> +                       iio_get_time_ns(indio_dev));
>> +
>> +out_notify:
>> +    iio_trigger_notify_done(indio_dev->trig);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static int adc108s102_scan_direct(struct adc108s102_state *st,
>> unsigned int ch)
>> +{
>> +    int ret;
>> +
>> +    st->tx_buf[0] = cpu_to_be16(ADC108S102_CMD(ch));
>> +    ret = spi_sync(st->spi, &st->scan_single_msg);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Skip the dummy response in the first slot */
>> +    return be16_to_cpu(st->rx_buf[1]);
>> +}
>> +
>> +static int adc108s102_read_raw(struct iio_dev *indio_dev,
>> +                   struct iio_chan_spec const *chan,
>> +                   int *val, int *val2, long m)
>> +{
>> +    struct adc108s102_state *st = iio_priv(indio_dev);
>> +    int ret;
>> +
>> +    switch (m) {
>> +    case IIO_CHAN_INFO_RAW:
>> +        ret = iio_device_claim_direct_mode(indio_dev);
>> +        if (ret)
>> +            return ret;
>> +
>> +        ret = adc108s102_scan_direct(st, chan->address);
>> +
>> +        iio_device_release_direct_mode(indio_dev);
>> +
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        *val = ADC108S102_RES_DATA(ret);
>> +
>> +        return IIO_VAL_INT;
>> +    case IIO_CHAN_INFO_SCALE:
>> +        if (chan->type != IIO_VOLTAGE)
>> +            break;
>> +
>> +        *val = st->va_millivolt;
>> +        *val2 = chan->scan_type.realbits;
>> +
>> +        return IIO_VAL_FRACTIONAL_LOG2;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static const struct iio_info adc108s102_info = {
>> +    .read_raw        = &adc108s102_read_raw,
>> +    .update_scan_mode    = &adc108s102_update_scan_mode,
>> +    .driver_module        = THIS_MODULE,
>> +};
>> +
>> +static int adc108s102_probe(struct spi_device *spi)
>> +{
>> +    struct adc108s102_state *st;
>> +    struct iio_dev *indio_dev;
>> +    int ret;
>> +
>> +    indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +    if (!indio_dev)
>> +        return -ENOMEM;
>> +
>> +    st = iio_priv(indio_dev);
>> +
>> +    if (ACPI_COMPANION(&spi->dev)) {
>> +        st->va_millivolt = ADC108S102_VA_MV_ACPI_DEFAULT;
>> +    } else {
>> +        st->reg = devm_regulator_get(&spi->dev, "vref");
>> +        if (IS_ERR(st->reg))
>> +            return PTR_ERR(st->reg);
>> +
>> +        ret = regulator_enable(st->reg);
>> +        if (ret < 0) {
>> +            dev_err(&spi->dev, "Cannot enable vref regulator\n");
>> +            return ret;
>> +        }
>> +
>> +        ret = regulator_get_voltage(st->reg);
>> +        if (ret < 0) {
>> +            dev_err(&spi->dev, "vref get voltage failed\n");
>> +            return ret;
>> +        }
>> +
>> +        st->va_millivolt = ret / 1000;
>> +    }
>> +
>> +    spi_set_drvdata(spi, indio_dev);
>> +    st->spi = spi;
>> +
>> +    indio_dev->name = spi->modalias;
>> +    indio_dev->dev.parent = &spi->dev;
>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>> +    indio_dev->channels = adc108s102_channels;
>> +    indio_dev->num_channels = ARRAY_SIZE(adc108s102_channels);
>> +    indio_dev->info = &adc108s102_info;
>> +
>> +    /* Setup default message */
>> +    st->scan_single_xfer.tx_buf = st->tx_buf;
>> +    st->scan_single_xfer.rx_buf = st->rx_buf;
>> +    st->scan_single_xfer.len = 2 * sizeof(st->tx_buf[0]);
>> +
>> +    spi_message_init_with_transfers(&st->scan_single_msg,
>> +                    &st->scan_single_xfer, 1);
>> +
>> +    ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
>> +            &adc108s102_trigger_handler, NULL);
>> +    if (ret)
>> +        goto error_disable_reg;
>> +
>> +    ret = devm_iio_device_register(&spi->dev, indio_dev);
>> +    if (ret) {
>> +        dev_err(&spi->dev, "Failed to register IIO device\n");
>> +        goto error_disable_reg;
>> +    }
>> +    return 0;
>> +
>> +error_disable_reg:
>> +    regulator_disable(st->reg);
>> +
>> +    return ret;
>> +}
>> +
>> +static int adc108s102_remove(struct spi_device *spi)
>> +{
>> +    struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> +    struct adc108s102_state *st = iio_priv(indio_dev);
>> +
>> +    regulator_disable(st->reg);
> This turns off the regulator before we remove the user space interfaces
> unfortunately.  Please use iio_device_register then explicitly call
> the unregister before this to ensure the unwind order is the
> reverse of that in probe.  Technically you should do the same
> for iio_triggered_buffer setup but neater to just reorder
> probe to do the regulator enable after that then we are in the
> obviously correct category which reviewers always like.

I'll look into this later this week and send out a tested update.

Thanks!
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
