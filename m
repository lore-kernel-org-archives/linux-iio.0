Return-Path: <SRS0=3L/s=YZ=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Wed, 11 Jan 2017 14:47:57 +0000
In-Reply-To: <alpine.DEB.2.02.1701111007240.12204@pmeerw.net>
References: <1484117471-67082-1-git-send-email-preid@electromag.com.au> <5f800162-a404-09fa-ce1b-c95f5b73ac56@electromag.com.au> <alpine.DEB.2.02.1701111007240.12204@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v1 1/1] iio: adc: tlc4541: add support for TI tlc4541 adc
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Phil Reid <preid@electromag.com.au>
CC: jic23@kernel.org,knaack.h@gmx.de,lars@metafoo.de,robh+dt@kernel.org,mark.rutland@arm.com,linux-iio@vger.kernel.org,devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <07E14965-FAC8-4C75-9458-5752318F2C95@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 11 January 2017 09:17:11 GMT+00:00, Peter Meerwald-Stadler <pmeerw@pmee=
rw=2Enet> wrote:
>On Wed, 11 Jan 2017, Phil Reid wrote:
>
>> Oops, title should be PATCH V2=2E
>>=20
>> On 11/01/2017 14:51, Phil Reid wrote:
>> > This adds TI's tlc4541 16-bit ADC driver=2E Which is a single channel
>> > ADC=2E Supports raw and trigger buffer access=2E
>> > Also supports the tlc3541 14-bit device, which has not been tested=2E
>> > Implementation of the tlc3541 is fairly straight forward thou=2E
>
>comments below
>
>>=20
>> > Signed-off-by: Phil Reid <preid@electromag=2Ecom=2Eau>
>> > ---
>> >=20
>> > Notes:
>> >     Changes from v1:
>> >     - Add tlc3541 support and chan spec=2E
>> >     - remove fields that where already 0 from TLC4541_V_CHAN macro
>> >     - Increase rx_buf size in tlc4541_state to avoid copy in
>> > tlc4541_trigger_handle
>> >     - Remove erroneous be16_to_cpu in tlc4541_trigger_handle
>> >     - Docs/binding: spi -> SPI & add ti,tlc3541
>> >=20
>> >     I haven't add Rob's Ack due to adding a new compatible string=2E
>> >=20
>> >     I tried to "=2Eindex =3D 1" from the spec as suggested by Peter,
>but that
>> > didn't
>> >     seem to work=2E Perhaps remove of =2Echannel was the intended
>target=2E
>
>the only between index =3D 0/1 should be that the channel is called
>in_voltage0_raw vs in_voltage_raw in sysfs -- maybe there is an issue
>in=20
>iio_readdev?
>=20
>> >     Example output from iio_readdev
>> >=20
>> >     with "=2Eindex =3D 1"
>> >     root@cyclone5:~# mkdir
>/sys/kernel/config/iio/triggers/hrtimer/hr1
>> >     root@cyclone5:~# iio_readdev -t hr1 -b 32 -s 10 tlc4541 |
>hexdump
>> >     WARNING: High-speed mode not enabled
>> >     0000000 af00 0000 0000 0000 b922 ca99 93da 1492
>> >     0000010 a800 00ff 0000 0000 b246 cb30 93da 1492
>> >     0000020 a900 0000 0000 0000 4f9c cbc9 93da 1492
>> >     0000030 aa00 00ff 0000 0000 bd2c cc61 93da 1492
>> >     0000040 aa00 00ff 0000 0000 544c ccfa 93da 1492
>> >     0000050 ab00 00ff 0000 0000 e806 cd92 93da 1492
>> >     0000060 a900 00ff 0000 0000 846c ce2b 93da 1492
>> >     0000070 ab00 0000 0000 0000 2efc cec8 93da 1492
>> >     0000080 a800 00ff 0000 0000 b090 cf5c 93da 1492
>> >     0000090 a900 00ff 0000 0000 476a cff5 93da 1492
>> >=20
>> >     without =2Eindex
>> >     root@cyclone5:~# mkdir
>/sys/kernel/config/iio/triggers/hrtimer/hr1
>> >     root@cyclone5:~# iio_readdev -t hr1 -b 32 -s 10 tlc4541 |
>hexdump
>> >     WARNING: High-speed mode not enabled
>> >     0000000 6db0 eeb6 93e3 1492 35e0 ef4f 93e3 1492
>> >     0000010 4b34 efe5 93e3 1492 e9f2 f07d 93e3 1492
>> >     0000020 6182 f116 93e3 1492 090a f1af 93e3 1492
>> >     0000030 409c f249 93e3 1492 6c1a f2e0 93e3 1492
>> >     0000040 cd02 f378 93e3 1492 9582 f411 93e3 1492
>> >=20
>> >  =2E=2E=2E/devicetree/bindings/iio/adc/ti-tlc4541=2Etxt     |  17 ++
>> >  drivers/iio/adc/Kconfig                            |  11 +
>> >  drivers/iio/adc/Makefile                           |   1 +
>> >  drivers/iio/adc/ti-tlc4541=2Ec                       | 276
>> > +++++++++++++++++++++
>> >  4 files changed, 305 insertions(+)
>> >  create mode 100644
>Documentation/devicetree/bindings/iio/adc/ti-tlc4541=2Etxt
>> >  create mode 100644 drivers/iio/adc/ti-tlc4541=2Ec
>> >=20
>> > diff --git
>a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541=2Etxt
>> > b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541=2Etxt
>> > new file mode 100644
>> > index 0000000=2E=2Ee1de2bd
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541=2Etxt
>> > @@ -0,0 +1,17 @@
>> > +* Texas Instruments' TLC4541
>> > +
>> > +Required properties:
>> > + - compatible: Should be one of
>> > +	* "ti,tlc4541"
>> > +	* "ti,tlc3541"
>> > +	- reg: SPI chip select number for the device
>> > + - vref-supply: The regulator supply for ADC reference voltage
>> > + - spi-max-frequency: Max SPI frequency to use (<=3D 200000)
>> > +
>> > +Example:
>> > +adc@0 {
>> > +	compatible =3D "ti,adc0832";
>
>pasto here, should be ti,tlc4541 probably
>
>> > +	reg =3D <0>;
>> > +	vref-supply =3D <&vdd_supply>;
>> > +	spi-max-frequency =3D <200000>;
>> > +};
>> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> > index 99c0514=2E=2E4dda3f0 100644
>> > --- a/drivers/iio/adc/Kconfig
>> > +++ b/drivers/iio/adc/Kconfig
>> > @@ -525,6 +525,17 @@ config TI_AM335X_ADC
>> >  	  To compile this driver as a module, choose M here: the module
>will
>> > be
>> >  	  called ti_am335x_adc=2E
>> >=20
>> > +config TI_TLC4541
>> > +	tristate "Texas Instruments TLC4541 ADC driver"
>> > +	depends on SPI
>> > +	select IIO_BUFFER
>> > +	select IIO_TRIGGERED_BUFFER
>> > +	help
>> > +	  Say yes here to build support for Texas Instruments TLC4541 ADC
>
>mention TLC3541 here as well?
>
>> > chip=2E
>> > +
>> > +	  This driver can also be built as a module=2E If so, the module
>will be
>> > +	  called ti-tlc4541=2E
>> > +
>> >  config TWL4030_MADC
>> >  	tristate "TWL4030 MADC (Monitoring A/D Converter)"
>> >  	depends on TWL4030_CORE
>> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> > index 7a40c04=2E=2E9bf2377 100644
>> > --- a/drivers/iio/adc/Makefile
>> > +++ b/drivers/iio/adc/Makefile
>> > @@ -49,6 +49,7 @@ obj-$(CONFIG_TI_ADC161S626) +=3D ti-adc161s626=2Eo
>> >  obj-$(CONFIG_TI_ADS1015) +=3D ti-ads1015=2Eo
>> >  obj-$(CONFIG_TI_ADS8688) +=3D ti-ads8688=2Eo
>> >  obj-$(CONFIG_TI_AM335X_ADC) +=3D ti_am335x_adc=2Eo
>> > +obj-$(CONFIG_TI_TLC4541) +=3D ti-tlc4541=2Eo
>> >  obj-$(CONFIG_TWL4030_MADC) +=3D twl4030-madc=2Eo
>> >  obj-$(CONFIG_TWL6030_GPADC) +=3D twl6030-gpadc=2Eo
>> >  obj-$(CONFIG_VF610_ADC) +=3D vf610_adc=2Eo
>> > diff --git a/drivers/iio/adc/ti-tlc4541=2Ec
>b/drivers/iio/adc/ti-tlc4541=2Ec
>> > new file mode 100644
>> > index 0000000=2E=2Ea0cd5e1
>> > --- /dev/null
>> > +++ b/drivers/iio/adc/ti-tlc4541=2Ec
>> > @@ -0,0 +1,276 @@
>> > +/*
>> > + * TI tlc4541 ADC Driver
>> > + *
>> > + * Copyright (C) 2017 Phil Reid
>> > + *
>> > + * Datasheets can be found here:
>> > + * http://www=2Eti=2Ecom/lit/gpn/tlc3541
>> > + * http://www=2Eti=2Ecom/lit/gpn/tlc4541
>> > + *
>> > + * This program is free software; you can redistribute it and/or
>modify
>> > + * it under the terms of the GNU General Public License version 2
>as
>> > + * published by the Free Software Foundation=2E
>> > + *
>> > + * The tlc4541 requires 24 clock cycles to start a transfer=2E
>> > + * Conversion then takes 2=2E94us to complete before data is ready
>> > + * Data is returned MSB first=2E
>> > + */
>> > +
>> > +#include <linux/delay=2Eh>
>> > +#include <linux/device=2Eh>
>> > +#include <linux/err=2Eh>
>> > +#include <linux/interrupt=2Eh>
>> > +#include <linux/iio/iio=2Eh>
>> > +#include <linux/iio/sysfs=2Eh>
>> > +#include <linux/iio/buffer=2Eh>
>> > +#include <linux/iio/trigger_consumer=2Eh>
>> > +#include <linux/iio/triggered_buffer=2Eh>
>> > +#include <linux/kernel=2Eh>
>> > +#include <linux/module=2Eh>
>> > +#include <linux/regulator/consumer=2Eh>
>> > +#include <linux/slab=2Eh>
>> > +#include <linux/spi/spi=2Eh>
>> > +#include <linux/sysfs=2Eh>
>> > +
>> > +struct tlc4541_state {
>> > +	struct spi_device               *spi;
>> > +	struct regulator                *reg;
>> > +	struct spi_transfer             scan_single_xfer[3];
>> > +	struct spi_message              scan_single_msg;
>> > +
>> > +	/*
>> > +	 * DMA (thus cache coherency maintenance) requires the
>> > +	 * transfer buffers to live in their own cache lines=2E
>> > +	 * 2 bytes data + 6 bytes padding + 8 bytes timestamp when
>> > +	 * call iio_push_to_buffers_with_timestamp=2E
>> > +	 */
>> > +	__be16                          rx_buf[8] ____cacheline_aligned;
>> > +};
>> > +
>> > +struct tlc4541_chip_info {
>> > +	const struct iio_chan_spec *channels;
>> > +	unsigned int num_channels;
>> > +};
>> > +
>> > +enum tlc4541_id {
>> > +	TLC3541,
>> > +	TLC4541,
>> > +};
>> > +
>> > +#define TLC4541_V_CHAN(bits, bitshift) {                         =20
>   \
>> > +		=2Etype =3D IIO_VOLTAGE,                                  \
>> > +		=2Eindexed =3D 1,                                         \
>
>shouldn't be needed
>
>> > +		=2Einfo_mask_separate       =3D BIT(IIO_CHAN_INFO_RAW),   \
>> > +		=2Einfo_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
>> > +		=2Escan_type =3D {                                        \
>> > +			=2Esign =3D 'u',                                  \
>> > +			=2Erealbits =3D (bits),                           \
>> > +			=2Estoragebits =3D 16,                            \
>> > +			=2Eshift =3D bitshift,                            \
>
>(bitshift)
>
>> > +			=2Eendianness =3D IIO_BE,                         \
>> > +		},                                                    \
>> > +	}
>> > +
>> > +#define DECLARE_TLC4541_CHANNELS(name, bits, bitshift) \
>> > +const struct iio_chan_spec name ## _channels[] =3D { \
>> > +	TLC4541_V_CHAN(bits, bitshift), \
>> > +	IIO_CHAN_SOFT_TIMESTAMP(1), \
>> > +}
>> > +
>> > +static DECLARE_TLC4541_CHANNELS(tlc4541, 16, 0);
>> > +static DECLARE_TLC4541_CHANNELS(tlc3541, 14, 2);
>
>maybe always keep the chip variants in the same order, the enum has
>3541=20
>first
>
>> > +
>> > +static const struct tlc4541_chip_info tlc4541_chip_info[] =3D {
>> > +	[TLC4541] =3D {
>> > +		=2Echannels =3D tlc4541_channels,
>> > +		=2Enum_channels =3D ARRAY_SIZE(tlc4541_channels),
>> > +	},
>> > +	[TLC3541] =3D {
>> > +		=2Echannels =3D tlc3541_channels,
>> > +		=2Enum_channels =3D ARRAY_SIZE(tlc3541_channels),
>> > +	},
>> > +};
>> > +
>> > +static irqreturn_t tlc4541_trigger_handler(int irq, void *p)
>> > +{
>> > +	struct iio_poll_func *pf =3D p;
>> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
>> > +	struct tlc4541_state *st =3D iio_priv(indio_dev);
>> > +	int ret;
>> > +
>> > +	ret =3D spi_sync(st->spi, &st->scan_single_msg);
>> > +	if (ret < 0)
>> > +		goto done;
>> > +
>> > +	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
>> > +					   iio_get_time_ns(indio_dev));
>> > +
>> > +done:
>> > +	iio_trigger_notify_done(indio_dev->trig);
>> > +	return IRQ_HANDLED;
>> > +}
>> > +
>> > +static int tlc4541_get_range(struct tlc4541_state *st)
>> > +{
>> > +	int vref;
>> > +
>> > +	vref =3D regulator_get_voltage(st->reg);
>> > +	if (vref < 0)
>> > +		return vref;
>> > +
>> > +	vref /=3D 1000;
>> > +
>> > +	return vref;
>> > +}
>> > +
>> > +static int tlc4541_read_raw(struct iio_dev *indio_dev,
>> > +			    struct iio_chan_spec const *chan,
>> > +			    int *val,
>> > +			    int *val2,
>> > +			    long m)
>> > +{
>> > +	int ret =3D 0;
>> > +	struct tlc4541_state *st =3D iio_priv(indio_dev);
>> > +
>> > +	switch (m) {
>> > +	case IIO_CHAN_INFO_RAW:
>> > +		ret =3D iio_device_claim_direct_mode(indio_dev);
>> > +		if (ret)
>> > +			return ret;
>> > +		ret =3D spi_sync(st->spi, &st->scan_single_msg);
>> > +		iio_device_release_direct_mode(indio_dev);
>> > +		if (ret < 0)
>> > +			return ret;
>> > +		*val =3D be16_to_cpu(st->rx_buf[0]);
>> > +		*val =3D *val >> chan->scan_type=2Eshift;
>> > +		*val &=3D GENMASK(chan->scan_type=2Erealbits - 1, 0);
>
>is the GENMASK() necessary?, the trigger handler doesn't do it
>
>> > +		return IIO_VAL_INT;
>> > +	case IIO_CHAN_INFO_SCALE:
>> > +		ret =3D tlc4541_get_range(st);
>> > +		if (ret < 0)
>> > +			return ret;
>> > +		*val =3D ret;
>> > +		*val2 =3D chan->scan_type=2Erealbits;
>> > +		return IIO_VAL_FRACTIONAL_LOG2;
>> > +	}
>> > +	return -EINVAL;
>> > +}
>> > +
>> > +static const struct iio_info tlc4541_info =3D {
>> > +	=2Eread_raw =3D &tlc4541_read_raw,
>> > +	=2Edriver_module =3D THIS_MODULE,
>> > +};
>> > +
>> > +static int tlc4541_probe(struct spi_device *spi)
>> > +{
>> > +	struct tlc4541_state *st;
>> > +	struct iio_dev *indio_dev;
>> > +	const struct tlc4541_chip_info *info;
>> > +	int ret;
>> > +	int8_t device_init =3D 0;
>> > +
>> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
>
>wondering what happens to the cache aligned rx_buf here?
Fine as we are careful to also align the private data so this works=2E
>
>> > +	if (indio_dev =3D=3D NULL)
>> > +		return -ENOMEM;
>> > +
>> > +	st =3D iio_priv(indio_dev);
>> > +
>> > +	spi_set_drvdata(spi, indio_dev);
>> > +
>> > +	st->spi =3D spi;
>> > +
>> > +	info =3D &tlc4541_chip_info[spi_get_device_id(spi)->driver_data];
>> > +
>> > +	indio_dev->name =3D spi_get_device_id(spi)->name;
>> > +	indio_dev->dev=2Eparent =3D &spi->dev;
>> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> > +	indio_dev->channels =3D info->channels;
>> > +	indio_dev->num_channels =3D info->num_channels;
>> > +	indio_dev->info =3D &tlc4541_info;
>> > +
>> > +	/* perform reset */
>> > +	spi_write(spi, &device_init, 1);
>> > +
>> > +	/* Setup default message */
>> > +	st->scan_single_xfer[0]=2Erx_buf =3D &st->rx_buf[0];
>> > +	st->scan_single_xfer[0]=2Elen =3D 3;
>> > +	st->scan_single_xfer[1]=2Edelay_usecs =3D 3;
>> > +	st->scan_single_xfer[2]=2Erx_buf =3D &st->rx_buf[0];
>> > +	st->scan_single_xfer[2]=2Elen =3D 2;
>> > +
>> > +	spi_message_init(&st->scan_single_msg);
>> > +	spi_message_add_tail(&st->scan_single_xfer[0],
>&st->scan_single_msg);
>> > +	spi_message_add_tail(&st->scan_single_xfer[1],
>&st->scan_single_msg);
>> > +	spi_message_add_tail(&st->scan_single_xfer[2],
>&st->scan_single_msg);
>> > +
>> > +	st->reg =3D devm_regulator_get(&spi->dev, "vref");
>> > +	if (IS_ERR(st->reg))
>> > +		return PTR_ERR(st->reg);
>> > +
>> > +	ret =3D regulator_enable(st->reg);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
>> > +			&tlc4541_trigger_handler, NULL);
>> > +	if (ret)
>> > +		goto error_disable_reg;
>> > +
>> > +	ret =3D iio_device_register(indio_dev);
>> > +	if (ret)
>> > +		goto error_cleanup_buffer;
>> > +
>> > +	return 0;
>> > +
>> > +error_cleanup_buffer:
>> > +	iio_triggered_buffer_cleanup(indio_dev);
>> > +error_disable_reg:
>> > +	regulator_disable(st->reg);
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +static int tlc4541_remove(struct spi_device *spi)
>> > +{
>> > +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
>> > +	struct tlc4541_state *st =3D iio_priv(indio_dev);
>> > +
>> > +	iio_device_unregister(indio_dev);
>> > +	iio_triggered_buffer_cleanup(indio_dev);
>> > +	regulator_disable(st->reg);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +#ifdef CONFIG_OF
>
>maybe drop the newlines here?
>
>> > +
>> > +static const struct of_device_id tlc4541_dt_ids[] =3D {
>> > +	{ =2Ecompatible =3D "ti,tlc3541", },
>> > +	{ =2Ecompatible =3D "ti,tlc4541", },
>> > +	{}
>> > +};
>> > +MODULE_DEVICE_TABLE(of, tlc4541_dt_ids);
>> > +
>> > +#endif
>> > +
>> > +static const struct spi_device_id tlc4541_id[] =3D {
>> > +	{"tlc3541", TLC3541},
>> > +	{"tlc4541", TLC4541},
>> > +	{}
>> > +};
>> > +MODULE_DEVICE_TABLE(spi, tlc4541_id);
>> > +
>> > +static struct spi_driver tlc4541_driver =3D {
>> > +	=2Edriver =3D {
>> > +		=2Ename   =3D "tlc4541",
>> > +		=2Eof_match_table =3D of_match_ptr(tlc4541_dt_ids),
>> > +	},
>> > +	=2Eprobe          =3D tlc4541_probe,
>> > +	=2Eremove         =3D tlc4541_remove,
>> > +	=2Eid_table       =3D tlc4541_id,
>> > +};
>> > +module_spi_driver(tlc4541_driver);
>> > +
>> > +MODULE_AUTHOR("Phil Reid <preid@electromag=2Ecom=2Eau>");
>> > +MODULE_DESCRIPTION("Texas Instruments TLC4541 ADC");
>> > +MODULE_LICENSE("GPL v2");
>> >=20
>>=20
>>=20
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
