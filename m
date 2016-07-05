Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42524 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbcGETwr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2016 15:52:47 -0400
Subject: Re: [RFC 1/2] iio: adc: ti-adc1x1s: add support for TI 1-channel
 differential ADCs
To: Matt Ranostay <mranostay@gmail.com>
References: <1467497127-32431-1-git-send-email-mranostay@gmail.com>
 <1467497127-32431-2-git-send-email-mranostay@gmail.com>
 <83382690-9dbf-5678-6598-d32a25fb803c@kernel.org>
 <CAKzfze-Wpbii==qKbKgJjor4j6Hvj2JXCbDWcB0QqbKYFmRttw@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <94e18c71-0c57-5675-bd48-a45b2cc0b11a@kernel.org>
Date: Tue, 5 Jul 2016 20:52:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze-Wpbii==qKbKgJjor4j6Hvj2JXCbDWcB0QqbKYFmRttw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/16 22:34, Matt Ranostay wrote:
> On Sun, Jul 3, 2016 at 6:04 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 02/07/16 23:05, Matt Ranostay wrote:
>>> Add support for Texas Instruments ADC141S626, and ADC161S626 chips.
>>>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> Few little points inline and: No wild cards in driver names!
>> (though I'm occasionally half asleep and let one in).
>>
>> Storage bits should always be a power of 2.  (I let some
>> of those slip in as well in the past... oops).
>>
>> Otherwise a few tiny corners where things could, I think,
>> be a little more readable at the cost of slightly more code.
>>
>> Basically a nice little driver.
>>
>> Jonathan
>>> ---
>>>  .../devicetree/bindings/iio/adc/ti-adc1x1s.txt     |  16 ++
>>>  drivers/iio/adc/Kconfig                            |  12 ++
>>>  drivers/iio/adc/Makefile                           |   1 +
>>>  drivers/iio/adc/ti-adc1x1s.c                       | 233 +++++++++++++++++++++
>>>  4 files changed, 262 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc1x1s.txt
>>>  create mode 100644 drivers/iio/adc/ti-adc1x1s.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc1x1s.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc1x1s.txt
>>> new file mode 100644
>>> index 000000000000..9cf7db434aee
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc1x1s.txt
>> Arguably could go in spi trivial devices binding file (unless you are going
>> to suplement this soon anyway in which case it may be less churn to keep it
>> here).
>>> @@ -0,0 +1,16 @@
>>> +* Texas Instruments' ADC141S626, and ADC161S626 chip
>>> +
>>> +Required properties:
>>> + - compatible: Should be "ti,adc141s626" or "ti,ac161s626"
>>> + - reg: spi chip select number for the device
>>> +
>>> +Recommended properties:
>>> + - spi-max-frequency: Definition as per
>>> +             Documentation/devicetree/bindings/spi/spi-bus.txt
>>> +
>>> +Example:
>>> +adc@0 {
>>> +     compatible = "ti,adc161s626";
>>> +     reg = <0>;
>>> +     spi-max-frequency = <4300000>;
>>> +};
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 25378c5882e2..cb5e4ae3279d 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -414,6 +414,18 @@ config TI_ADC128S052
>>>         This driver can also be built as a module. If so, the module will be
>>>         called ti-adc128s052.
>>>
>>> +config TI_ADC1X1S
>>> +     tristate "Texas Instruments ADC1X1S 1-channel differential ADCs"
>>> +     depends on SPI
>>> +     select IIO_BUFFER
>>> +     select IIO_TRIGGERED_BUFFER
>>> +     help
>>> +       If you say yes here you get support for Texas Instruments ADC141S626,
>>> +       and ADC161S626 chips.
>>> +
>>> +       This driver can also be build as a module. If so, the module will be
>>> +       called ti-adc1x1s.
>>> +
>>>  config TI_ADS1015
>>>       tristate "Texas Instruments ADS1015 ADC"
>>>       depends on I2C && !SENSORS_ADS1015
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index 38638d46f972..855ff407fd0d 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -40,6 +40,7 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>>>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>>> +obj-$(CONFIG_TI_ADC1X1S) += ti-adc1x1s.o
>>>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>>>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>>>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>>> diff --git a/drivers/iio/adc/ti-adc1x1s.c b/drivers/iio/adc/ti-adc1x1s.c
>>> new file mode 100644
>>> index 000000000000..889399968694
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/ti-adc1x1s.c
>>> @@ -0,0 +1,233 @@
>>> +/*
>>> + * ti-adc1x1s.c - Support for the Texas Instruments 1-channel differential ADCs
>>> + *
>>> + * ADC Devices Supported:
>>> + *  adc141s626 - 14-bit ADC
>>> + *  adc161s626 - 16-bit ADC
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
>>> +#include <linux/err.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/trigger.h>
>>> +#include <linux/iio/buffer.h>
>>> +#include <linux/iio/trigger_consumer.h>
>>> +#include <linux/iio/triggered_buffer.h>
>>> +
>>> +#define TI_ADC_DRV_NAME      "adc1x1s"
>> I really dislike wild cards.... Just pick a part and name it after that.
>>
>>> +
>>> +enum {
>>> +     TI_ADC141S626,
>>> +     TI_ADC161S626,
>>> +};
>>> +
>>> +static const struct iio_chan_spec ti_adc141s626_channels[] = {
>>> +     {
>>> +             .type = IIO_VOLTAGE,
>>> +             .channel = 0,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> +             .scan_index = 0,
>>> +             .scan_type = {
>>> +                     .sign = 's',
>>> +                     .realbits = 14,
>>> +                     .storagebits = 16,
>>> +             },
>>> +     },
>>> +     IIO_CHAN_SOFT_TIMESTAMP(1),
>>> +};
>>> +
>>> +static const struct iio_chan_spec ti_adc161s626_channels[] = {
>>> +     {
>>> +             .type = IIO_VOLTAGE,
>>> +             .channel = 0,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> +             .scan_index = 0,
>>> +             .scan_type = {
>>> +                     .sign = 's',
>>> +                     .realbits = 16,
>>> +                     .storagebits = 24,
>> Storage bits should be a power of 2.
>>> +                     .shift = 6,
>>> +             },
>>> +     },
>>> +     IIO_CHAN_SOFT_TIMESTAMP(1),
>>> +};
>>> +
>>> +struct ti_adc_data {
>>> +     struct iio_dev *indio_dev;
>>> +     struct spi_device *spi;
>>> +     int read_size;
>>> +
>> enforce cacheline alignment or this is going to cause possible fun on
>> dma using spi devices.
>>> +     u8 buffer[16]; /* 3 byte data + 5 byte pad + 8 byte timestamp */
> 
> Thought only tx buffers need to cache aligned?
As far as I know it's either.  Certainly fits with the explanation in:
https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt

> 
>>> +};
>>> +
>>> +static irqreturn_t ti_adc_trigger_handler(int irq, void *private)
>>> +{
>>> +     struct iio_poll_func *pf = private;
>>> +     struct iio_dev *indio_dev = pf->indio_dev;
>>> +     struct ti_adc_data *data = iio_priv(indio_dev);
>>> +     int ret;
>>> +
>>> +     ret = spi_read(data->spi, &data->buffer, data->read_size);
>>> +     if (!ret)
>>> +             iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>>> +                                                iio_get_time_ns());
>>> +
>>> +     iio_trigger_notify_done(indio_dev->trig);
>>> +
>>> +     return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int ti_adc_read_measurement(struct ti_adc_data *data,
>>> +                                struct iio_chan_spec const *chan, int *val)
>>> +{
>>> +     __be32 buf;
>>> +     int ret;
>>> +
>>> +     ret = spi_read(data->spi, (void *) &buf, data->read_size);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     switch (data->read_size) {
>>> +     case 2:
>>> +             *val = be16_to_cpu(buf);
>> Inelegant as buf is clearly marked as 32 bit by it's type. I'd move the
>> read into the switch statement then read into the appropriate sized
>> local variable.  More code but easier to read (slightly)
> 
> Okay.
> 
>>> +             break;
>>> +     case 3:
>>> +             *val = be32_to_cpu(buf) >> 8;
>>> +             break;
>>> +     }
>>> +
>>> +     *val = sign_extend32(*val >> chan->scan_type.shift,
>>> +                          chan->scan_type.realbits - 1);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int ti_adc_read_raw(struct iio_dev *indio_dev,
>>> +                        struct iio_chan_spec const *chan,
>>> +                        int *val, int *val2, long mask)
>>> +{
>>> +     struct ti_adc_data *data = iio_priv(indio_dev);
>>> +     int ret;
>>> +
>>> +     if (mask != IIO_CHAN_INFO_RAW)
>>> +             return -EINVAL;
>>> +
>>> +     if (iio_device_claim_direct_mode(indio_dev))
>>> +             return -EBUSY;
>> Should technically store and return the result of iio_device_claim_direct_mode.
>> It could in future return something else..
>>> +
>>> +     ret = ti_adc_read_measurement(data, chan, val);
>>> +     if (!ret)
>>> +             ret = IIO_VAL_INT;
>> I'd make ti_adc_read_measurement return IIO_VAL_INT if successful. Then
>> the slightly odd good path handling goes away.
> 
> Okay.
> 
>>> +
>>> +     iio_device_release_direct_mode(indio_dev);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static const struct iio_info ti_adc_info = {
>>> +     .driver_module = THIS_MODULE,
>>> +     .read_raw = ti_adc_read_raw,
>>> +};
>>> +
>>> +static int ti_adc_probe(struct spi_device *spi)
>>> +{
>>> +     struct iio_dev *indio_dev;
>>> +     struct ti_adc_data *data;
>>> +     int ret;
>>> +
>>> +     indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
>>> +     if (!indio_dev)
>>> +             return -ENOMEM;
>>> +
>>> +     indio_dev->info = &ti_adc_info;
>>> +     indio_dev->dev.parent = &spi->dev;
>>> +     indio_dev->dev.of_node = spi->dev.of_node;
>>> +     indio_dev->name = TI_ADC_DRV_NAME;
>>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>>> +     spi_set_drvdata(spi, indio_dev);
>>> +
>>> +     data = iio_priv(indio_dev);
>>> +     data->spi = spi;
>>> +
>>> +     switch (spi_get_device_id(spi)->driver_data) {
>>> +     case TI_ADC141S626:
>>> +             indio_dev->channels = ti_adc141s626_channels;
>>> +             indio_dev->num_channels = ARRAY_SIZE(ti_adc141s626_channels);
>>> +             data->read_size = 2;
>>> +             break;
>>> +     case TI_ADC161S626:
>>> +             indio_dev->channels = ti_adc161s626_channels;
>>> +             indio_dev->num_channels = ARRAY_SIZE(ti_adc161s626_channels);
>>> +             data->read_size = 3;
>>> +             break;
>>> +     }
>>> +
>>> +     ret = iio_triggered_buffer_setup(indio_dev, NULL,
>>> +                                      ti_adc_trigger_handler, NULL);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = iio_device_register(indio_dev);
>>> +     if (ret)
>>> +             goto error_unreg_buffer;
>>> +
>>> +     return 0;
>>> +
>>> +error_unreg_buffer:
>>> +     iio_triggered_buffer_cleanup(indio_dev);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int ti_adc_remove(struct spi_device *spi)
>>> +{
>>> +     struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>> +
>>> +     iio_device_unregister(indio_dev);
>>> +     iio_triggered_buffer_cleanup(indio_dev);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct of_device_id ti_adc_dt_ids[] = {
>>> +     { .compatible = "ti,adc141s626", },
>>> +     { .compatible = "ti,adc161s626", },
>>> +     {}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);
>>> +
>>> +static const struct spi_device_id ti_adc_id[] = {
>>> +     {"adc141s626", TI_ADC141S626},
>>> +     {"adc161s626", TI_ADC161S626},
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(spi, ti_adc_id);
>>> +
>>> +static struct spi_driver ti_adc_driver = {
>>> +     .driver = {
>>> +             .name   = TI_ADC_DRV_NAME,
>>> +             .of_match_table = of_match_ptr(ti_adc_dt_ids),
>>> +     },
>>> +     .probe          = ti_adc_probe,
>>> +     .remove         = ti_adc_remove,
>>> +     .id_table       = ti_adc_id,
>>> +};
>>> +module_spi_driver(ti_adc_driver);
>>> +
>>> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>>> +MODULE_DESCRIPTION("Texas Instruments ADC1x1S 1-channel differential ADC");
>>> +MODULE_LICENSE("GPL");
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

