Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36898 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268AbaHFVnD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 Aug 2014 17:43:03 -0400
Date: Wed, 6 Aug 2014 16:42:22 -0500
From: Felipe Balbi <balbi@ti.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Felipe Balbi <balbi@ti.com>, <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140806214222.GB3556@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.01.1408061815140.29646@pmeerw.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
In-Reply-To: <alpine.DEB.2.01.1408061815140.29646@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2014 at 11:11:52PM +0200, Peter Meerwald wrote:
> Hello Felipe,
>=20
> in subject: light sensor
>=20
> please see my minor comments below
>=20
> p.
>=20
> > TI's opt3001 light sensor is a simple and yet powerful
> > little device. The device provides 99% IR rejection,
> > Automatic full-scale, very low power consumption and
> > measurements from 0.01 to 83k lux.
> >=20
> > This patch adds support for that device using the IIO
> > framework.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > Jonathan, I have a few doubts on how can I test buffered
> > mode properly. I can see my IRQs triggering now problem,
> > but where is the data pushed ? Can it be read from sysfs
> > or /dev somehwere ?
>=20
> there should be /dev/iio:deviceX=20
>=20
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index bf05ca5..e4582d7 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -128,6 +128,18 @@ config LTR501
> >  	 This driver can also be built as a module.  If so, the module
> >           will be called ltr501.
> > =20
> > +config OPT3001
> > +	tristate "Texas Instruments OPT3001 Light Sensor"
> > +	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  If you say Y or M here, you get support for Texas Instruments
> > +	  OPT3001 Ambient Light Sensor.
> > +
> > +	  If built as a dynamically linked module, it will be called
> > +	  opt3001.
> > +
> >  config TCS3414
> >  	tristate "TAOS TCS3414 digital color sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index 8b8c09f..898ef13 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_HID_SENSOR_PROX)	+=3D hid-sensor-prox.o
> >  obj-$(CONFIG_ISL29125)		+=3D isl29125.o
> >  obj-$(CONFIG_SENSORS_LM3533)	+=3D lm3533-als.o
> >  obj-$(CONFIG_LTR501)		+=3D ltr501.o
> > +obj-$(CONFIG_OPT3001)		+=3D opt3001.o
> >  obj-$(CONFIG_SENSORS_TSL2563)	+=3D tsl2563.o
> >  obj-$(CONFIG_TCS3414)		+=3D tcs3414.o
> >  obj-$(CONFIG_TCS3472)		+=3D tcs3472.o
> > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > new file mode 100644
> > index 0000000..1d925fd1
> > --- /dev/null
> > +++ b/drivers/iio/light/opt3001.c
> > @@ -0,0 +1,765 @@
> > +/**
> > + * opt3001.c - Texas Instruments OPT3001 Light Sensor
> > + *
> > + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.c=
om
> > + *
> > + * Author: Felipe Balbi <balbi@ti.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License version 2 of the =
License
> > + * as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define OPT3001_RESULT		0x00
> > +#define OPT3001_CONFIGURATION	0x01
> > +#define OPT3001_LOW_LIMIT	0x02
> > +#define OPT3001_HIGH_LIMIT	0x03
> > +#define OPT3001_MANUFACTURER_ID	0x7e
> > +#define OPT3001_DEVICE_ID	0x7f
> > +
> > +#define OPT3001_CONFIGURATION_RN_MASK (0xf << 12)
> > +#define OPT3001_CONFIGURATION_RN_AUTO (0xc << 12)
> > +
> > +#define OPT3001_CONFIGURATION_CT	(1 << 11)
>=20
> could use BIT() from bitops.h

sure, easy enough.

> > +static int opt3001_read(const struct opt3001 *opt, u8 reg)
> > +{
> > +	return i2c_smbus_read_word_swapped(opt->client, reg);
> > +}
> > +
> > +static int opt3001_write(const struct opt3001 *opt, u8 reg, u16 value)
> > +{
> > +	return i2c_smbus_write_word_swapped(opt->client, reg, value);
> > +}
> > +
>=20
> many small helper function; worth it to wrap a one-liner?

why not ? I think it looks better and it'll get inlined anyway. It also
helps a lot when using kernel function tracer.

> > +		.scan_type =3D {
> > +			.sign =3D 'u',
>=20
> .realbits / .storagebits missing?

yeah, couldn't figure this out. The HW gives me a 16-bit value where
12-bits are the mantissa and 4-bits are for the exponent. Should I call
realbits 16 and storagebits 32 ?

>=20
> > +			.endianness =3D IIO_BE,
> > +		},
> > +		.scan_index =3D 0,
> > +		.event_spec =3D opt3001_event_spec,
> > +		.num_event_specs =3D ARRAY_SIZE(opt3001_event_spec),
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(1),
> > +};
> > +
> > +static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
> > +{
> > +	int ret;
> > +	u16 mantissa;
> > +	u16 reg;
> > +	u8 exponent;
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_CONFIGURATION);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_CONFIGURATION);
> > +		return ret;
> > +	}
> > +
> > +	reg =3D ret;
> > +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
> > +
> > +	ret =3D opt3001_write(opt, OPT3001_CONFIGURATION, reg);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
>=20
> "failed to write register ..."

yeah thanks. copy&paste error.

> > +				OPT3001_CONFIGURATION);
> > +		return ret;
> > +	}
> > +
> > +	/* wait for conversion and give it an extra 5ms */
> > +	usleep_range(opt->int_time + 5000, opt->int_time + 10000);
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_CONFIGURATION);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_CONFIGURATION);
> > +		return ret;
> > +	}
> > +
> > +	reg =3D ret;
> > +	if (!(reg & OPT3001_CONFIGURATION_CRF))
> > +		return -EPIPE;
> > +
> > +	ret =3D opt3001_read(opt, OPT3001_RESULT);
> > +	if (ret < 0) {
> > +		dev_err(opt->dev, "failed to read register %02x\n",
> > +				OPT3001_RESULT);
> > +		return ret;
> > +	}
> > +
> > +	exponent =3D OPT3001_REG_EXPONENT(ret);
> > +	mantissa =3D OPT3001_REG_MANTISSA(ret);
> > +
> > +	opt3001_to_iio_ret(opt, exponent, mantissa, val, val2);
> > +
> > +	return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int opt3001_get_scale(struct opt3001 *opt, int *val, int *val2)
> > +{
> > +	int ret;
> > +	u8 exponent;
> > +
>=20
> I guess OPT3001_RESULT is only valid AFTER performing opt3001_get_lux()

right. I'm only interested in the exponent part. It'll latch the
exponent from last conversion, 0 being default.

> > +static int opt3001_read_raw(struct iio_dev *iio,
> > +		struct iio_chan_spec const *chan, int *val, int *val2,
> > +		long mask)
> > +{
> > +	struct opt3001 *opt =3D iio_priv(iio);
> > +	int ret =3D 0;
>=20
> initialization not needed

I'll drop

> > +static int opt3001_write_raw(struct iio_dev *iio,
> > +		struct iio_chan_spec const *chan, int val, int val2,
> > +		long mask)
> > +{
> > +	struct opt3001 *opt =3D iio_priv(iio);
> > +	int ret =3D 0;
>=20
> initialization not needed

I'll drop

> > +
> > +	if (opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS)
> > +		return -EBUSY;
> > +
> > +	if (chan->type !=3D IIO_LIGHT)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&opt->lock);
> > +
> > +	switch (mask) {
>=20
> is there no way to control the scale?

yeah, but the HW does auto-scaling which works pretty well. Why would
you want to control the scale manually ?

> > +static int opt3001_write_event_value(struct iio_dev *iio,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir, enum iio_event_info info,
> > +		int val, int val2)
> > +{
> > +	struct opt3001 *opt =3D iio_priv(iio);
> > +	int ret =3D 0;
> > +
> > +	u16 *thresh_mantissa;
> > +	u16 mantissa;
> > +	u16 value;
> > +	u16 reg;
> > +
> > +	u8 *thresh_exp;
>=20
> why extra newlines?

why not ? I generally separate the types as it aids readability.

> > +static int opt3001_remove(struct i2c_client *client)
> > +{
> > +	/* nothing to do here */
>=20
> shutdown the device probably?

it's always in shutdown unless it's doing a transfer. The only exception
being if we enable continuous mode and remove the module. Might be
better to check that and shut it down, sure.

--=20
balbi

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4qE+AAoJEIaOsuA1yqRE4zcP/Rg8u6gCWkQyqCJUGv3YoSH6
mzxwLIP7LZsHmDBrBRXIvuzARNfOAhN4GALW8/tQLUh+8LAT/iNLAiamF/SmD0na
vnZaaCZ3Xkrs8kgCFWwXTe606Yw3b1dmZZz0Rmus8fNLA/e2p/5bDuL/WxbBjYvd
6ohfDWoJpPzoBc7GSDBRyIfqClEGlOMVP7rzeukRNXRZZ9YHbKctlgyMcJJL2sdp
DZeUglX7ZshyR8jDEp1kT+LNrhAKDi1MetlWMslwIq+j8/2v28uzUcuG2NE+mZnF
kyId+I486m3plMqJ9utQATtPzbxMk6W8xsik50iVcWLdvjV+oyYHz97HY6KPHDCi
Fmal7Nru8lfhdWIsHQeML5uLKmiCPkglDT8lcBeJlIKa6BRcTzlNIABoDHtZLZn3
OJIOGBPHY5SY0Pnw6Gu6jx0cL6Iklcs1+6k30yt7wMduVEu5uqTBDOfXrcOKAPbu
TxM8w+G3ZeCfZIRPpog+ouNZPusumJwJOu2M6QJPP9gpuXWbrrYL8mLqBbPIxmhs
j1IGMC2Oisl4+oC1wZAJN2ah3tvNqaLGfHVPihzcUu0ZERguqG7IN5h2nvRCAWXc
06QaHOWE/olaY3sFW+ZbNbhsgrLGihCddoO44B09sCVBgXRvgIDgrlF9NLU7LdHC
DZ0is//2UF7/6p8Plo7h
=ZNz4
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
