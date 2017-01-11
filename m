Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:52504 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966280AbdAKMxK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 07:53:10 -0500
Subject: Re: [PATCH v1 1/1] iio: adc: tlc4541: add support for TI tlc4541 adc
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1484117471-67082-1-git-send-email-preid@electromag.com.au>
 <5f800162-a404-09fa-ce1b-c95f5b73ac56@electromag.com.au>
 <alpine.DEB.2.02.1701111007240.12204@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
From: Phil Reid <preid@electromag.com.au>
Message-ID: <4a7d32dc-5d5a-9428-7b18-367850b130f6@electromag.com.au>
Date: Wed, 11 Jan 2017 20:53:00 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1701111007240.12204@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

G'day Peter,

Thanks for reviewing.

On 11/01/2017 17:17, Peter Meerwald-Stadler wrote:
> On Wed, 11 Jan 2017, Phil Reid wrote:
>
>> Oops, title should be PATCH V2.
>>
>> On 11/01/2017 14:51, Phil Reid wrote:
>>> This adds TI's tlc4541 16-bit ADC driver. Which is a single channel
>>> ADC. Supports raw and trigger buffer access.
>>> Also supports the tlc3541 14-bit device, which has not been tested.
>>> Implementation of the tlc3541 is fairly straight forward thou.
>
> comments below
>
>>
>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>>> ---
>>>
>>> Notes:
>>>     Changes from v1:
>>>     - Add tlc3541 support and chan spec.
>>>     - remove fields that where already 0 from TLC4541_V_CHAN macro
>>>     - Increase rx_buf size in tlc4541_state to avoid copy in
>>> tlc4541_trigger_handle
>>>     - Remove erroneous be16_to_cpu in tlc4541_trigger_handle
>>>     - Docs/binding: spi -> SPI & add ti,tlc3541
>>>
>>>     I haven't add Rob's Ack due to adding a new compatible string.
>>>
>>>     I tried to ".index = 1" from the spec as suggested by Peter, but that
>>> didn't
>>>     seem to work. Perhaps remove of .channel was the intended target.
>
> the only between index = 0/1 should be that the channel is called
> in_voltage0_raw vs in_voltage_raw in sysfs -- maybe there is an issue in
> iio_readdev?
I'll write something tomorrow to test this a bit more using libiio.

I did also notice iio_info reported the channel differently as well.
 From memory:
Without indexed it didn't output the format the same either.
  (input, index: 0, format: be:U16/16>>0)
became just
  (input)

I'll have to check what version of libiio I'm using as well.

>
>>>     Example output from iio_readdev
>>>
>>>     with ".index = 1"
>>>     root@cyclone5:~# mkdir /sys/kernel/config/iio/triggers/hrtimer/hr1
>>>     root@cyclone5:~# iio_readdev -t hr1 -b 32 -s 10 tlc4541 | hexdump
>>>     WARNING: High-speed mode not enabled
>>>     0000000 af00 0000 0000 0000 b922 ca99 93da 1492
>>>     0000010 a800 00ff 0000 0000 b246 cb30 93da 1492
>>>     0000020 a900 0000 0000 0000 4f9c cbc9 93da 1492
>>>     0000030 aa00 00ff 0000 0000 bd2c cc61 93da 1492
>>>     0000040 aa00 00ff 0000 0000 544c ccfa 93da 1492
>>>     0000050 ab00 00ff 0000 0000 e806 cd92 93da 1492
>>>     0000060 a900 00ff 0000 0000 846c ce2b 93da 1492
>>>     0000070 ab00 0000 0000 0000 2efc cec8 93da 1492
>>>     0000080 a800 00ff 0000 0000 b090 cf5c 93da 1492
>>>     0000090 a900 00ff 0000 0000 476a cff5 93da 1492
>>>
>>>     without .index
>>>     root@cyclone5:~# mkdir /sys/kernel/config/iio/triggers/hrtimer/hr1
>>>     root@cyclone5:~# iio_readdev -t hr1 -b 32 -s 10 tlc4541 | hexdump
>>>     WARNING: High-speed mode not enabled
>>>     0000000 6db0 eeb6 93e3 1492 35e0 ef4f 93e3 1492
>>>     0000010 4b34 efe5 93e3 1492 e9f2 f07d 93e3 1492
>>>     0000020 6182 f116 93e3 1492 090a f1af 93e3 1492
>>>     0000030 409c f249 93e3 1492 6c1a f2e0 93e3 1492
>>>     0000040 cd02 f378 93e3 1492 9582 f411 93e3 1492
>>>
>>>  .../devicetree/bindings/iio/adc/ti-tlc4541.txt     |  17 ++
>>>  drivers/iio/adc/Kconfig                            |  11 +
>>>  drivers/iio/adc/Makefile                           |   1 +
>>>  drivers/iio/adc/ti-tlc4541.c                       | 276
>>> +++++++++++++++++++++
>>>  4 files changed, 305 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
>>>  create mode 100644 drivers/iio/adc/ti-tlc4541.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
>>> b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
>>> new file mode 100644
>>> index 0000000..e1de2bd
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
>>> @@ -0,0 +1,17 @@
>>> +* Texas Instruments' TLC4541
>>> +
>>> +Required properties:
>>> + - compatible: Should be one of
>>> +	* "ti,tlc4541"
>>> +	* "ti,tlc3541"
>>> +	- reg: SPI chip select number for the device
>>> + - vref-supply: The regulator supply for ADC reference voltage
>>> + - spi-max-frequency: Max SPI frequency to use (<= 200000)
>>> +
>>> +Example:
>>> +adc@0 {
>>> +	compatible = "ti,adc0832";
>
> pasto here, should be ti,tlc4541 probably
yes

>
>>> +	reg = <0>;
>>> +	vref-supply = <&vdd_supply>;
>>> +	spi-max-frequency = <200000>;
>>> +};
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 99c0514..4dda3f0 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -525,6 +525,17 @@ config TI_AM335X_ADC
>>>  	  To compile this driver as a module, choose M here: the module will
>>> be
>>>  	  called ti_am335x_adc.
>>>
>>> +config TI_TLC4541
>>> +	tristate "Texas Instruments TLC4541 ADC driver"
>>> +	depends on SPI
>>> +	select IIO_BUFFER
>>> +	select IIO_TRIGGERED_BUFFER
>>> +	help
>>> +	  Say yes here to build support for Texas Instruments TLC4541 ADC
>
> mention TLC3541 here as well?
ok
>
>>> chip.
>>> +
>>> +	  This driver can also be built as a module. If so, the module will be
>>> +	  called ti-tlc4541.
>>> +
>>>  config TWL4030_MADC
>>>  	tristate "TWL4030 MADC (Monitoring A/D Converter)"
>>>  	depends on TWL4030_CORE
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index 7a40c04..9bf2377 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -49,6 +49,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>>>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>>>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>>>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>>> +obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
>>>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>>>  obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>>>  obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>>> diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
>>> new file mode 100644
>>> index 0000000..a0cd5e1
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/ti-tlc4541.c
>>> @@ -0,0 +1,276 @@
>>> +/*
>>> + * TI tlc4541 ADC Driver
>>> + *
>>> + * Copyright (C) 2017 Phil Reid
>>> + *
>>> + * Datasheets can be found here:
>>> + * http://www.ti.com/lit/gpn/tlc3541
>>> + * http://www.ti.com/lit/gpn/tlc4541
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * The tlc4541 requires 24 clock cycles to start a transfer.
>>> + * Conversion then takes 2.94us to complete before data is ready
>>> + * Data is returned MSB first.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/device.h>
>>> +#include <linux/err.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/iio/buffer.h>
>>> +#include <linux/iio/trigger_consumer.h>
>>> +#include <linux/iio/triggered_buffer.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/sysfs.h>
>>> +
>>> +struct tlc4541_state {
>>> +	struct spi_device               *spi;
>>> +	struct regulator                *reg;
>>> +	struct spi_transfer             scan_single_xfer[3];
>>> +	struct spi_message              scan_single_msg;
>>> +
>>> +	/*
>>> +	 * DMA (thus cache coherency maintenance) requires the
>>> +	 * transfer buffers to live in their own cache lines.
>>> +	 * 2 bytes data + 6 bytes padding + 8 bytes timestamp when
>>> +	 * call iio_push_to_buffers_with_timestamp.
>>> +	 */
>>> +	__be16                          rx_buf[8] ____cacheline_aligned;
>>> +};
>>> +
>>> +struct tlc4541_chip_info {
>>> +	const struct iio_chan_spec *channels;
>>> +	unsigned int num_channels;
>>> +};
>>> +
>>> +enum tlc4541_id {
>>> +	TLC3541,
>>> +	TLC4541,
>>> +};
>>> +
>>> +#define TLC4541_V_CHAN(bits, bitshift) {                              \
>>> +		.type = IIO_VOLTAGE,                                  \
>>> +		.indexed = 1,                                         \
>
> shouldn't be needed
>
>>> +		.info_mask_separate       = BIT(IIO_CHAN_INFO_RAW),   \
>>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>>> +		.scan_type = {                                        \
>>> +			.sign = 'u',                                  \
>>> +			.realbits = (bits),                           \
>>> +			.storagebits = 16,                            \
>>> +			.shift = bitshift,                            \
>
> (bitshift)
ok
>
>>> +			.endianness = IIO_BE,                         \
>>> +		},                                                    \
>>> +	}
>>> +
>>> +#define DECLARE_TLC4541_CHANNELS(name, bits, bitshift) \
>>> +const struct iio_chan_spec name ## _channels[] = { \
>>> +	TLC4541_V_CHAN(bits, bitshift), \
>>> +	IIO_CHAN_SOFT_TIMESTAMP(1), \
>>> +}
>>> +
>>> +static DECLARE_TLC4541_CHANNELS(tlc4541, 16, 0);
>>> +static DECLARE_TLC4541_CHANNELS(tlc3541, 14, 2);
>
> maybe always keep the chip variants in the same order, the enum has 3541
> first
ok
>
>>> +
>>> +static const struct tlc4541_chip_info tlc4541_chip_info[] = {
>>> +	[TLC4541] = {
>>> +		.channels = tlc4541_channels,
>>> +		.num_channels = ARRAY_SIZE(tlc4541_channels),
>>> +	},
>>> +	[TLC3541] = {
>>> +		.channels = tlc3541_channels,
>>> +		.num_channels = ARRAY_SIZE(tlc3541_channels),
>>> +	},
>>> +};
>>> +
>>> +static irqreturn_t tlc4541_trigger_handler(int irq, void *p)
>>> +{
>>> +	struct iio_poll_func *pf = p;
>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>> +	struct tlc4541_state *st = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	ret = spi_sync(st->spi, &st->scan_single_msg);
>>> +	if (ret < 0)
>>> +		goto done;
>>> +
>>> +	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
>>> +					   iio_get_time_ns(indio_dev));
>>> +
>>> +done:
>>> +	iio_trigger_notify_done(indio_dev->trig);
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int tlc4541_get_range(struct tlc4541_state *st)
>>> +{
>>> +	int vref;
>>> +
>>> +	vref = regulator_get_voltage(st->reg);
>>> +	if (vref < 0)
>>> +		return vref;
>>> +
>>> +	vref /= 1000;
>>> +
>>> +	return vref;
>>> +}
>>> +
>>> +static int tlc4541_read_raw(struct iio_dev *indio_dev,
>>> +			    struct iio_chan_spec const *chan,
>>> +			    int *val,
>>> +			    int *val2,
>>> +			    long m)
>>> +{
>>> +	int ret = 0;
>>> +	struct tlc4541_state *st = iio_priv(indio_dev);
>>> +
>>> +	switch (m) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		ret = iio_device_claim_direct_mode(indio_dev);
>>> +		if (ret)
>>> +			return ret;
>>> +		ret = spi_sync(st->spi, &st->scan_single_msg);
>>> +		iio_device_release_direct_mode(indio_dev);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		*val = be16_to_cpu(st->rx_buf[0]);
>>> +		*val = *val >> chan->scan_type.shift;
>>> +		*val &= GENMASK(chan->scan_type.realbits - 1, 0);
>
> is the GENMASK() necessary?, the trigger handler doesn't do it
Copied behaviour from another driver. eg ad7887.c

Looking at iio_channel_convert in libiio I think it looks to be doing the same
thing to the data from the trigger handle.


>
>>> +		return IIO_VAL_INT;
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		ret = tlc4541_get_range(st);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		*val = ret;
>>> +		*val2 = chan->scan_type.realbits;
>>> +		return IIO_VAL_FRACTIONAL_LOG2;
>>> +	}
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static const struct iio_info tlc4541_info = {
>>> +	.read_raw = &tlc4541_read_raw,
>>> +	.driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +static int tlc4541_probe(struct spi_device *spi)
>>> +{
>>> +	struct tlc4541_state *st;
>>> +	struct iio_dev *indio_dev;
>>> +	const struct tlc4541_chip_info *info;
>>> +	int ret;
>>> +	int8_t device_init = 0;
>>> +
>>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>
> wondering what happens to the cache aligned rx_buf here?
I don't know I just copied cache align from one of the other iio drivers.
There's multiple hits with the ____cacheline_aligned keyword.

>
>>> +	if (indio_dev == NULL)
>>> +		return -ENOMEM;
>>> +
>>> +	st = iio_priv(indio_dev);
>>> +
>>> +	spi_set_drvdata(spi, indio_dev);
>>> +
>>> +	st->spi = spi;
>>> +
>>> +	info = &tlc4541_chip_info[spi_get_device_id(spi)->driver_data];
>>> +
>>> +	indio_dev->name = spi_get_device_id(spi)->name;
>>> +	indio_dev->dev.parent = &spi->dev;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->channels = info->channels;
>>> +	indio_dev->num_channels = info->num_channels;
>>> +	indio_dev->info = &tlc4541_info;
>>> +
>>> +	/* perform reset */
>>> +	spi_write(spi, &device_init, 1);
>>> +
>>> +	/* Setup default message */
>>> +	st->scan_single_xfer[0].rx_buf = &st->rx_buf[0];
>>> +	st->scan_single_xfer[0].len = 3;
>>> +	st->scan_single_xfer[1].delay_usecs = 3;
>>> +	st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
>>> +	st->scan_single_xfer[2].len = 2;
>>> +
>>> +	spi_message_init(&st->scan_single_msg);
>>> +	spi_message_add_tail(&st->scan_single_xfer[0], &st->scan_single_msg);
>>> +	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
>>> +	spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
>>> +
>>> +	st->reg = devm_regulator_get(&spi->dev, "vref");
>>> +	if (IS_ERR(st->reg))
>>> +		return PTR_ERR(st->reg);
>>> +
>>> +	ret = regulator_enable(st->reg);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>>> +			&tlc4541_trigger_handler, NULL);
>>> +	if (ret)
>>> +		goto error_disable_reg;
>>> +
>>> +	ret = iio_device_register(indio_dev);
>>> +	if (ret)
>>> +		goto error_cleanup_buffer;
>>> +
>>> +	return 0;
>>> +
>>> +error_cleanup_buffer:
>>> +	iio_triggered_buffer_cleanup(indio_dev);
>>> +error_disable_reg:
>>> +	regulator_disable(st->reg);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int tlc4541_remove(struct spi_device *spi)
>>> +{
>>> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>> +	struct tlc4541_state *st = iio_priv(indio_dev);
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +	iio_triggered_buffer_cleanup(indio_dev);
>>> +	regulator_disable(st->reg);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_OF
>
> maybe drop the newlines here?
ok
>
>>> +
>>> +static const struct of_device_id tlc4541_dt_ids[] = {
>>> +	{ .compatible = "ti,tlc3541", },
>>> +	{ .compatible = "ti,tlc4541", },
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, tlc4541_dt_ids);
>>> +
>>> +#endif
>>> +
>>> +static const struct spi_device_id tlc4541_id[] = {
>>> +	{"tlc3541", TLC3541},
>>> +	{"tlc4541", TLC4541},
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(spi, tlc4541_id);
>>> +
>>> +static struct spi_driver tlc4541_driver = {
>>> +	.driver = {
>>> +		.name   = "tlc4541",
>>> +		.of_match_table = of_match_ptr(tlc4541_dt_ids),
>>> +	},
>>> +	.probe          = tlc4541_probe,
>>> +	.remove         = tlc4541_remove,
>>> +	.id_table       = tlc4541_id,
>>> +};
>>> +module_spi_driver(tlc4541_driver);
>>> +
>>> +MODULE_AUTHOR("Phil Reid <preid@electromag.com.au>");
>>> +MODULE_DESCRIPTION("Texas Instruments TLC4541 ADC");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
>>
>>
>


-- 
Regards
Phil Reid

