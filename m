Return-Path: <SRS0=FHXd=KG=gmail.com=marcus.folkesson@kernel.org>
Date: Sun, 22 Jul 2018 18:20:39 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: add support for mcp3911
Message-ID: <20180722162039.GA27516@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
 <alpine.DEB.2.21.1807212259480.13457@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
In-Reply-To: <alpine.DEB.2.21.1807212259480.13457@vps.pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thanks for the comments!

On Sat, Jul 21, 2018 at 11:19:48PM +0200, Peter Meerwald-Stadler wrote:
> Hello,
>=20
> > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
>=20
> some comments below...
> =20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Signed-off-by: Kent Gustavsson <kent@minoris.se>
> > ---
> >  drivers/iio/adc/Kconfig   |  10 ++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/mcp3911.c | 444 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 455 insertions(+)
> >  create mode 100644 drivers/iio/adc/mcp3911.c
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 15606f237480..f9a41fa96fcc 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -501,6 +501,16 @@ config MCP3422
> >  	  This driver can also be built as a module. If so, the module will be
> >  	  called mcp3422.
> > =20
> > +config MCP3911
> > +	tristate "Microchip Technology MCP3911 driver"
> > +	depends on SPI
> > +	help
> > +	  Say yes here to build support for Microchip Technology's MCP3911
> > +	  analog to digital converter.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called mcp3911.
> > +
> >  config MEDIATEK_MT6577_AUXADC
> >          tristate "MediaTek AUXADC driver"
> >          depends on ARCH_MEDIATEK || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 28a9423997f3..3cfebfff7d26 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_MAX1363) +=3D max1363.o
> >  obj-$(CONFIG_MAX9611) +=3D max9611.o
> >  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
> >  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> > +obj-$(CONFIG_MCP3911) +=3D mcp3911.o
> >  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) +=3D mt6577_auxadc.o
> >  obj-$(CONFIG_MEN_Z188_ADC) +=3D men_z188_adc.o
> >  obj-$(CONFIG_MESON_SARADC) +=3D meson_saradc.o
> > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > new file mode 100644
> > index 000000000000..be74cb15827b
> > --- /dev/null
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -0,0 +1,444 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Microchip MCP3911, Two-channel Analog Front End
> > + *
> > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> > + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
> > + *
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define MCP3911_REG_CHANNEL0		0x00
> > +#define MCP3911_REG_CHANNEL1		0x03
> > +#define MCP3911_REG_MOD			0x06
> > +#define MCP3911_REG_PHASE		0x07
> > +
> > +#define MCP3911_REG_GAIN		0x09
> > +#define MCP3911_GAIN_MASK(ch)		(0x7 << 3*ch)
>=20
> space around * operator, maybe parenthesis around variable, i.e
> (0x07 << (3 * (ch)))
>=20

Will do

> > +#define MCP3911_GAIN_VAL(ch, val)	((val << 3*ch) & MCP3911_GAIN_MASK(c=
h))
> > +
> > +#define MCP3911_REG_STATUSCOM		0x0a
> > +#define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
> > +#define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
> > +#define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
> > +#define MCP3911_STATUSCOM_EN_GAINCAL	BIT(1)
> > +
> > +#define MCP3911_REG_CONFIG		0x0c
> > +#define MCP3911_CONFIG_CLKEXT		BIT(1)
> > +#define MCP3911_CONFIG_VREFEXT		BIT(2)
> > +
> > +#define MCP3911_REG_OFFCAL_CH0		0x0e
> > +#define MCP3911_REG_GAINCAL_CH0		0x11
> > +#define MCP3911_REG_OFFCAL_CH1		0x14
> > +#define MCP3911_REG_GAINCAL_CH1		0x17
> > +#define MCP3911_REG_VREFCAL		0x1a
> > +
> > +#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
> > +#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
> > +#define MCP3911_GAINCAL(x)		(MCP3911_REG_GAINCAL_CH0 + x * 6)
> > +
>=20
> delete newline
>=20

Will do

> > +
> > +/* Internal voltage reference in uV */
> > +#define MCP3911_INT_VREF_UV		1200000
> > +
> > +#define REG_READ(reg, id)	(((reg << 1) | (id << 5) | (1 << 0)) & 0xff)
> > +#define REG_WRITE(reg, id)	(((reg << 1) | (id << 5) | (0 << 0)) & 0xff)
>=20
> MCP3911_ prefix please
> parenthesis around variables

Will do

>=20
> > +
> > +#define MCP3911_NUM_CHANNELS		2
> > +
> > +
> > +struct mcp3911 {
> > +	struct spi_device *spi;
> > +	struct device_node *np;
> > +	struct mutex lock;
> > +
> > +	u32 gain[MCP3911_NUM_CHANNELS];
> > +	u32 width[MCP3911_NUM_CHANNELS];
> > +
> > +	u32 dev_addr;
> > +	bool vrefext;
> > +	struct regulator *vref;
> > +};
> > +
> > +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> > +{
> > +	int ret;
> > +
> > +	reg =3D REG_READ(reg, adc->dev_addr);
> > +	ret =3D spi_write_then_read(adc->spi, &reg, 1, val, len);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val <<=3D ((4-len)*8);
>=20
> space around - and * operator, here and elsewhere

Will do

>=20
> shouldn't the endiness conversion happen before the value is shifted?=20
> (here and below)?
>=20

You are right


> > +	be32_to_cpus(val);
> > +	dev_dbg(&adc->spi->dev, "Reading 0x%x from register 0x%x\n", *val,
> > +			reg>>1);
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
> > +{
> > +	dev_dbg(&adc->spi->dev, "Writing 0x%x to register 0x%x\n", val, reg);
> > +
> > +	cpu_to_be32s(&val);
> > +	val >>=3D (3-len)*8;
> > +	val |=3D REG_WRITE(reg, adc->dev_addr);
> > +
> > +	return spi_write(adc->spi, &val, len+1);
> > +}
> > +
> > +static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
> > +		u32 val, u8 len)
> > +{
> > +	u32 tmp;
> > +	int ret;
> > +
> > +	ret =3D mcp3911_read(adc, reg, &tmp, len);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val &=3D mask;
> > +	val |=3D tmp & ~mask;
> > +	return mcp3911_write(adc, reg, val, len);
> > +}
> > +
> > +static int mcp3911_get_hwgain(struct mcp3911 *adc, u8 channel, u32 *va=
l)
> > +{
> > +	int ret =3D mcp3911_read(adc, MCP3911_REG_GAIN, val, 1);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val >>=3D channel*3;
> > +	*val &=3D 0x07;
> > +	*val =3D (1 << *val);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mcp3911_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *channel, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > +	int ret =3D -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D mcp3911_read(adc,
> > +				MCP3911_CHANNEL(channel->channel), val, 3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret =3D IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		ret =3D mcp3911_read(adc,
> > +				MCP3911_OFFCAL(channel->channel), val, 3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret =3D IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > +		ret =3D mcp3911_get_hwgain(adc, channel->channel, val);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret =3D IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (adc->vrefext) {
> > +			ret =3D regulator_get_voltage(adc->vref);
> > +			if (ret < 0) {
> > +				dev_err(indio_dev->dev.parent,
> > +					"failed to get vref voltage:%d\n", ret);
>=20
> start message consistently with upper/lowercase
> maybe space before :
>=20

I will consistently use lowercase, thanks.

> > +				goto out;
> > +			}
> > +
> > +			*val =3D ret / 1000;
> > +		} else {
> > +			*val =3D MCP3911_INT_VREF_UV;
> > +		}
> > +
> > +		/* apply with gain value */
> > +		*val /=3D adc->gain[channel->channel];
> > +		*val2 =3D adc->width[channel->channel];
> > +
> > +		ret =3D IIO_VAL_FRACTIONAL_LOG2;
> > +		break;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *channel, int val,
> > +			    int val2, long mask)
> > +{
> > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > +	int ret =3D -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_OFFSET:
> > +
>=20
> val2 should probably be zero and checked?
>=20

Will do

> > +		/* Write offset */
> > +		ret =3D mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
> > +				3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		/* Enable offset*/
> > +		ret =3D mcp3911_update(adc, MCP3911_REG_STATUSCOM,
> > +				MCP3911_STATUSCOM_EN_OFFCAL,
> > +				MCP3911_STATUSCOM_EN_OFFCAL, 2);
> > +		if (ret)
> > +			goto out;
> > +
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
>=20
> val2?

Will do
>=20
> > +		if (!is_power_of_2(val) && val <=3D 32) {
>=20
> the check looks suspicious, maybe || val > 32

Yep, much better :-)

>=20
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		adc->gain[channel->channel] =3D val;
> > +
> > +		val =3D ilog2(val);
> > +		ret =3D mcp3911_update(adc, MCP3911_REG_GAIN,
> > +					MCP3911_GAIN_MASK(channel->channel),
> > +					MCP3911_GAIN_VAL(channel->channel,
> > +						val), 1);
> > +		break;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_chan_spec mcp3911_channels[] =3D {
> > +	{
>=20
> maybe use a MACRO(), e.g. MCP3911_CHANNEL(idx) ...

I will create a macro for this, thanks
>=20
> > +		.type =3D IIO_VOLTAGE,
> > +		.indexed =3D 1,
> > +		.channel =3D 0,
> > +		.address =3D MCP3911_REG_CHANNEL0,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +			BIT(IIO_CHAN_INFO_OFFSET) |
> > +			BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +	},
> > +	{
> > +		.type =3D IIO_VOLTAGE,
> > +		.indexed =3D 1,
> > +		.channel =3D 1,
> > +		.address =3D MCP3911_REG_CHANNEL1,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +			BIT(IIO_CHAN_INFO_OFFSET) |
> > +			BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +	},
> > +};
> > +
> > +static const struct iio_info mcp3911_info =3D {
> > +	.read_raw =3D mcp3911_read_raw,
> > +	.write_raw =3D mcp3911_write_raw,
> > +};
> > +
> > +static int mcp3911_config_of(struct mcp3911 *adc)
> > +{
> > +	u32 configreg;
> > +	u32 statuscomreg;
> > +	int ret;
> > +
> > +	of_property_read_u32(adc->np, "device-addr", &adc->dev_addr);
> > +	if (adc->dev_addr > 3) {
> > +		dev_err(&adc->spi->dev,
> > +				"invalid device address (%i). Must be in range 0-3.\n",
> > +				adc->dev_addr);
> > +		return -EINVAL;
> > +	}
> > +	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
> > +
> > +	ret =3D mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	adc->vrefext =3D of_property_read_bool(adc->np, "external-vref");
> > +	if (adc->vrefext) {
> > +		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
> > +		configreg |=3D MCP3911_CONFIG_VREFEXT;
> > +
> > +	} else {
> > +		dev_dbg(&adc->spi->dev, "use internal voltage reference (1.2V)\n");
> > +		configreg &=3D ~MCP3911_CONFIG_VREFEXT;
> > +	}
> > +
> > +	if (of_property_read_bool(adc->np, "external-clock")) {
> > +		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
> > +		configreg |=3D MCP3911_CONFIG_CLKEXT;
> > +	} else {
> > +		dev_dbg(&adc->spi->dev, "use crystal oscillator as clocksource\n");
> > +		configreg &=3D ~MCP3911_CONFIG_CLKEXT;
> > +	}
> > +
> > +	ret =3D  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +
> > +	ret =3D mcp3911_read(adc, MCP3911_REG_STATUSCOM, &statuscomreg, 2);
> > +	if (ret)
> > +		return ret;
> > +
>=20
> no duplicate newlines (here and elsewhere)
>=20

Ok

> > +
> > +	of_property_read_u32(adc->np, "ch0-width", &adc->width[0]);
> > +	switch (adc->width[0]) {
> > +	case 24:
> > +		statuscomreg &=3D ~MCP3911_STATUSCOM_CH0_24WIDTH;
> > +		dev_dbg(&adc->spi->dev, "set channel 0 into 24bit mode\n");
> > +		break;
> > +	case 16:
> > +		statuscomreg |=3D MCP3911_STATUSCOM_CH0_24WIDTH;
> > +		dev_dbg(&adc->spi->dev, "set channel 0 into 16bit mode\n");
> > +		break;
> > +	default:
> > +		adc->width[0] =3D 24;
> > +		dev_info(&adc->spi->dev, "invalid width for channel 0. Use 24bit.\n"=
);
> > +		break;
> > +	}
> > +
> > +	of_property_read_u32(adc->np, "ch1-width", &adc->width[1]);
> > +	switch (adc->width[1]) {
> > +	case 24:
> > +		statuscomreg &=3D ~MCP3911_STATUSCOM_CH1_24WIDTH;
> > +		dev_dbg(&adc->spi->dev, "set channel 1 into 24bit mode\n");
> > +		break;
> > +	case 16:
> > +		statuscomreg |=3D MCP3911_STATUSCOM_CH1_24WIDTH;
> > +		dev_dbg(&adc->spi->dev, "set channel 1 into 16bit mode\n");
> > +		break;
> > +	default:
> > +		adc->width[1] =3D 24;
> > +		dev_info(&adc->spi->dev, "invalid width for channel 1. Use 24bit.\n"=
);
> > +		break;
> > +	}
> > +
> > +	return mcp3911_write(adc, MCP3911_REG_STATUSCOM, statuscomreg, 2);
> > +}
> > +
> > +static int mcp3911_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct mcp3911 *adc;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	adc =3D iio_priv(indio_dev);
> > +	adc->spi =3D spi;
> > +	adc->np =3D spi->dev.of_node;
> > +
> > +	ret =3D mcp3911_config_of(adc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (adc->vrefext) {
> > +		adc->vref =3D devm_regulator_get(&adc->spi->dev, "vref");
> > +		if (IS_ERR(adc->vref))
> > +			return PTR_ERR(adc->vref);
> > +
> > +		ret =3D regulator_enable(adc->vref);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	/* Store gain values to better calculate scale values */
> > +	mcp3911_get_hwgain(adc, 0, &adc->gain[0]);
> > +	mcp3911_get_hwgain(adc, 1, &adc->gain[1]);
> > +
> > +	indio_dev->dev.parent =3D &spi->dev;
> > +	indio_dev->dev.of_node =3D spi->dev.of_node;
> > +	indio_dev->name =3D spi_get_device_id(spi)->name;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->info =3D &mcp3911_info;
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	indio_dev->channels =3D mcp3911_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(mcp3911_channels);
> > +
> > +	mutex_init(&adc->lock);
> > +
> > +	ret =3D iio_device_register(indio_dev);
> > +	if (ret)
> > +		goto reg_disable;
> > +
> > +	return ret;
> > +
> > +reg_disable:
> > +	if (adc->vref)
> > +		regulator_disable(adc->vref);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	if (adc->vref)
> > +		regulator_disable(adc->vref);
> > +
> > +	return 0;
> > +}
> > +
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id mcp3911_dt_ids[] =3D {
> > +	{ .compatible =3D "microchip,mcp3911" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mcp3911_dt_ids);
> > +#endif
> > +
> > +static const struct spi_device_id mcp3911_id[] =3D {
> > +	{ "mcp3911", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, mcp3911_id);
> > +
> > +static struct spi_driver mcp3911_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "mcp3911",
> > +		.of_match_table =3D of_match_ptr(mcp3911_dt_ids),
> > +	},
> > +	.probe =3D mcp3911_probe,
> > +	.remove =3D mcp3911_remove,
> > +	.id_table =3D mcp3911_id,
> > +};
> > +module_spi_driver(mcp3911_driver);
> > +
> > +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> > +MODULE_AUTHOR("Kent Gustavsson <kent@minoris.se>");
> > +MODULE_DESCRIPTION("Microchip Technology MCP3911");
> > +MODULE_LICENSE("GPL v2");
> >=20
>=20
> --=20
>=20
> Peter Meerwald-Stadler
> Mobile: +43 664 24 44 418

Thanks,
Marcus Folkesson

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltUrtIACgkQiIBOb1ld
UjITAhAAyI5HHt+C3uSemEDKRf3pB6Gin+Ut1wwUkXd/N1QqoN6Y1QkywBbL7ZhD
j8wHvKbdKH/WmCEf5RlyTGt7meTnwCqvUI3wVWRdmSuH1G42CWkc9A4+W77xZSFW
ZhXrMOlsvipVjMN4N3lO8kwTctMgumpKBmJ7H5CahsDeHkJbh4oNBFiONAaHeAh9
/92PypdexlQxMnckHscMbN+OPh5nAkcUEWL9IwPUpfeZ3c3g7JuqXAvH5kIG7PZR
MH90I2A9iaDRjHzJkA+KoBIZvVoCNCVzw2PmSRfNojhevt9+9objOjhreHuXw212
Ya+dqb2Ua3frL7iD/fc6BhomZn3pX8km/QGtlwd1utoU4v6A5IJ5J9C3LZmzln5H
w0eqiiZpENjWPdqBaSyU0Cz8HQEswAk1wQgPfm8QDfMo/xmaOA330J9liuEXPTZM
t4ZP5Q+E2qNa9VucRAKE52VPO8+6QuooosWd4Rt9Ptht9NflGV0r6Y5IkYDkALlt
ectLaLcPvl9cDug+N0WLS68JPaZqispK0qeZp4MQdtkVOLMQkhMh0cPFNQY7nfKM
UgeLTtTZu0NW4yaT1sYCz6LKgwW9doOgIcV09d9GYLyF2b9uPXQWdMQTuHieO2DQ
QnYaBFWntjth0mRTJEuOjQTZSbqrThXJv/dNW9VoQ7s4pcKMR28=
=aId1
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
