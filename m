Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron
	<jic23@kernel.org>
Subject: RE: [PATCH 2/2] iio: accel: Add triggered buffer support for BMA220
Date: Fri, 29 Apr 2016 12:41:24 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F402358932C@IRSMSX109.ger.corp.intel.com>
References: <1461928076-22076-1-git-send-email-tiberiu.a.breana@intel.com>
 <1461928076-22076-3-git-send-email-tiberiu.a.breana@intel.com>
 <alpine.DEB.2.02.1604291320170.23132@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1604291320170.23132@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> owner@vger.kernel.org] On Behalf Of Peter Meerwald-Stadler
> Sent: Friday, April 29, 2016 2:25 PM
> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>
> Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>
> Subject: Re: [PATCH 2/2] iio: accel: Add triggered buffer support for BMA=
220
>=20
>=20
> > Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
>=20
> comments below
>=20
> > ---
> >  drivers/iio/accel/bma220_spi.c | 67
> > ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 65 insertions(+), 2 deletions(-)
> >

<snip>

> > -70,6 +84,42 @@ static inline int bma220_read_reg(struct spi_device *sp=
i,
> u8 reg)
> >  	return spi_w8r8(spi, reg | BMA220_READ_MASK);  }
> >
> > +static irqreturn_t bma220_trigger_handler(int irq, void *p) {
> > +	int i;
> > +	int ret;
> > +	int bit;
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct bma220_data *data =3D iio_priv(indio_dev);
> > +	struct spi_device *spi =3D data->spi_device;
> > +	u8 tx_buf =3D BMA220_REG_ACCEL_X | BMA220_READ_MASK;
> > +	u8 rx_buf[3];
>=20
> alignment requirements for SPI?

I'm not sure what you mean by this. The chip seems to respond correctly
to the testing I've done so far.

Tiberiu
