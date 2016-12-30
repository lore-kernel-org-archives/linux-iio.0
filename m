Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33383 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753414AbcL3Uwl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 15:52:41 -0500
Subject: Re: [PATCH] iio: adc: Add Renesas GyroADC driver
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161230191800.2532-1-marek.vasut@gmail.com>
 <alpine.DEB.2.02.1612302027480.3977@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <442f8085-110c-659d-d097-add788b8f291@gmail.com>
Date: Fri, 30 Dec 2016 21:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1612302027480.3977@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/30/2016 08:50 PM, Peter Meerwald-Stadler wrote:
> 
>> Add IIO driver for the Renesas RCar GyroADC block. This block is a
>> simple 4/8-channel ADC which samples 12/15/24 bits of data every
>> cycle from all channels.
> 
> comments below
>  
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>  .../bindings/iio/adc/renesas,gyroadc.txt           |  38 +++
>>  MAINTAINERS                                        |   6 +
>>  drivers/iio/adc/Kconfig                            |  10 +
>>  drivers/iio/adc/Makefile                           |   1 +
>>  drivers/iio/adc/rcar_gyro_adc.c                    | 379 +++++++++++++++++++++
>>  5 files changed, 434 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>  create mode 100644 drivers/iio/adc/rcar_gyro_adc.c
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>> new file mode 100644
>> index 0000000..3fd5f57
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>> @@ -0,0 +1,38 @@
>> +* Renesas RCar GyroADC device driver
>> +
>> +Required properties:
>> +- compatible:	Should be "renesas,rcar-gyroadc" for regular GyroADC or
>> +		"renesas,rcar-gyroadc-r8a7792" for GyroADC without interrupt
>> +		block found in R8A7792.
>> +- reg:		Address and length of the register set for the device
>> +- clocks:	References to all the clocks specified in the clock-names
>> +		property as specified in
>> +		Documentation/devicetree/bindings/clock/clock-bindings.txt.
>> +- clock-names:	Shall contain "fck" and "if". The "fck" are the GyroADC block
> 
> "fck" is...
> 
>> +		clock, the "if" are the interface clock.
> 
> "if" is ...
> 
>> +		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
> 
> this is just an example and not appropriate here?

Oh, copy-paste error, thanks :)

>> +- power-domains: Must contain a reference to the PM domain, if available.
>> +- renesas,gyroadc-mode:	GyroADC mode of operation, must be either of:
>> +			1 - MB88101A mode, 12bit sampling, 4 channels
>> +			2 - ADCS7476 mode, 15bit sampling, 8 channels
>> +			3 - MAX1162 mode,  16bit sampling, 8 channels
>> +- renesas,gyroadc-vref:	Array of reference voltage values for each input to
>> +			the GyroADC, in uV. Array must have 4 elemenets for
> 
> elements

All spelling fixed.

[...]

>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 99c0514..4a4cac7 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -408,6 +408,16 @@ config QCOM_SPMI_VADC
>>  	  To compile this driver as a module, choose M here: the module will
>>  	  be called qcom-spmi-vadc.
>>  
>> +config RCAR_GYRO_ADC
>> +	tristate "Renesas RCAR GyroADC driver"
>> +	depends on ARCH_RCAR_GEN2 || (ARM && COMPILE_TEST)
>> +	help
>> +	  Say yes here to build support for the GyroADC found in Renesas
>> +	  RCar Gen2 SoCs.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called rcar-gyroadc.
> 
> called rcar_gyro_adc?

Why so ? The driver is really named rcar-gyroadc , I guess I should
rename either the file or the driver to keep things consistent. So
probably the file .

>> +
>>  config ROCKCHIP_SARADC
>>  	tristate "Rockchip SARADC driver"
>>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile

[...]

>> +
>> +#define RCAR_GYROADC_CLOCK_LENGTH		0x08
>> +#define RCAR_GYROADC_1_25MS_LENGTH		0x0c
>> +
>> +#define RCAR_GYROADC_REALTIME_DATA(ch)		(0x10 + ((ch) * 4))
>> +#define RCAR_GYROADC_100MS_ADDED_DATA(ch)	(0x30 + ((ch) * 4))
>> +#define RCAR_GYROADC_10MS_AVG_DATA(ch)		(0x50 + ((ch) * 4))
>> +
>> +#define RCAR_GYROADC_FIFO_STATUS		0x70
>> +#define RCAR_GYROADC_FIFO_STATUS_EMPTY(ch)	BIT(0 + (4 * (ch)))
> 
> FIFO_STATUS_... is not used (yet)

Is it a problem to have a complete register layout here ?

> 4*ch looks suspicious for ch==8??

Well yes, channel is in range 0..7 :)

>> +#define RCAR_GYROADC_FIFO_STATUS_FULL(ch)	BIT(1 + (4 * (ch)))
>> +#define RCAR_GYROADC_FIFO_STATUS_ERROR(ch)	BIT(2 + (4 * (ch)))
>> +
>> +#define RCAR_GYROADC_INTR			0x74
>> +#define RCAR_GYROADC_INTR_INT			BIT(0)
>> +
>> +#define RCAR_GYROADC_INTENR			0x78
>> +#define RCAR_GYROADC_INTENR_INTEN		BIT(0)
>> +
>> +#define RCAR_GYROADC_SAMPLE_RATE		800	/* Hz */

[...]

>> +#define RCAR_GYROADC_CHAN(_idx, _chan_type, _realbits) {	\
>> +	.type			= (_chan_type),			\
> 
> _chan_type is IIO_VOLTAGE always?

Yep, fixed.

>> +	.indexed		= 1,				\
>> +	.channel		= (_idx),			\
>> +	.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),	\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>> +	.scan_index		= (_idx),			\
> 
> no buffered mode yet, so strictly no need for a scan_index and scan_type

OK

>> +	.scan_type	= {					\
>> +		.sign		= 'u',				\
>> +		.realbits	= (_realbits),			\
>> +		.storagebits	= 16,				\
>> +	},							\
>> +}
>> +
>> +static const struct iio_chan_spec rcar_gyroadc_iio_channels_1[] = {
>> +	RCAR_GYROADC_CHAN(0, IIO_VOLTAGE, 12),
>> +	RCAR_GYROADC_CHAN(1, IIO_VOLTAGE, 12),
>> +	RCAR_GYROADC_CHAN(2, IIO_VOLTAGE, 12),
>> +	RCAR_GYROADC_CHAN(3, IIO_VOLTAGE, 12),
>> +};
>> +
>> +static const struct iio_chan_spec rcar_gyroadc_iio_channels_2[] = {
>> +	RCAR_GYROADC_CHAN(0, IIO_VOLTAGE, 15),
>> +	RCAR_GYROADC_CHAN(1, IIO_VOLTAGE, 15),
>> +	RCAR_GYROADC_CHAN(2, IIO_VOLTAGE, 15),
>> +	RCAR_GYROADC_CHAN(3, IIO_VOLTAGE, 15),
>> +	RCAR_GYROADC_CHAN(4, IIO_VOLTAGE, 15),
>> +	RCAR_GYROADC_CHAN(5, IIO_VOLTAGE, 15),
>> +	RCAR_GYROADC_CHAN(6, IIO_VOLTAGE, 15),
>> +	RCAR_GYROADC_CHAN(7, IIO_VOLTAGE, 15),
>> +};
>> +
>> +/*
>> + * NOTE: The data we receive in mode 3 from MAX1162 have MSByte = 0,
>> + *       therefore we only use 16bit realbits here instead of 24.
>> + */
>> +static const struct iio_chan_spec rcar_gyroadc_iio_channels_3[] = {
>> +	RCAR_GYROADC_CHAN(0, IIO_VOLTAGE, 16),
>> +	RCAR_GYROADC_CHAN(1, IIO_VOLTAGE, 16),
>> +	RCAR_GYROADC_CHAN(2, IIO_VOLTAGE, 16),
>> +	RCAR_GYROADC_CHAN(3, IIO_VOLTAGE, 16),
>> +	RCAR_GYROADC_CHAN(4, IIO_VOLTAGE, 16),
>> +	RCAR_GYROADC_CHAN(5, IIO_VOLTAGE, 16),
>> +	RCAR_GYROADC_CHAN(6, IIO_VOLTAGE, 16),
>> +	RCAR_GYROADC_CHAN(7, IIO_VOLTAGE, 16),
>> +};
>> +
>> +static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
>> +				 struct iio_chan_spec const *chan,
>> +				 int *val, int *val2, long mask)
>> +{
>> +	struct rcar_gyroadc *priv = iio_priv(indio_dev);
>> +	unsigned int datareg = RCAR_GYROADC_REALTIME_DATA(chan->channel);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		if (chan->type != IIO_VOLTAGE)
>> +			return -EINVAL;
>> +
>> +		if (iio_buffer_enabled(indio_dev))
>> +			return -EBUSY;
> 
> use iio_device_claim_direct_mode()

Why ? Do I really need the mutex locking here ?

>> +
>> +		*val = readl(priv->regs + datareg);
>> +		*val &= BIT(chan->scan_type.realbits) - 1;
>> +
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 0;
>> +		*val2 = (priv->vref_uv[chan->channel] * 1000) / 0x10000;
>> +		return IIO_VAL_INT_PLUS_NANO;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val = RCAR_GYROADC_SAMPLE_RATE;
>> +		*val2 = 0;
> 
> *val2 = 0 not needed

OK

[...]

>> +	indio_dev->name = dev_name(dev);
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->dev.of_node = pdev->dev.of_node;
>> +	indio_dev->info = &rcar_gyroadc_iio_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	if (mode == 1) {
> 
> maybe do the mode differentiation only once, any with a switch?

Done

[...]

-- 
Best regards,
Marek Vasut
