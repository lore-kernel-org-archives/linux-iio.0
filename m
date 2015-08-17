Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56883 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbbHQJJt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 05:09:49 -0400
Date: Mon, 17 Aug 2015 11:09:43 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 6/8] iio: gyro: bmg160: optimize i2c transfers in
 trigger handler
Message-ID: <20150817090943.GO19600@pengutronix.de>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-7-git-send-email-irina.tirdea@intel.com>
 <55D056DF.5020201@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LFcBmrHMV+//QdlE"
In-Reply-To: <55D056DF.5020201@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--LFcBmrHMV+//QdlE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2015 at 10:24:47AM +0100, Jonathan Cameron wrote:
> On 12/08/15 15:31, Irina Tirdea wrote:
> > Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> > enable/disable the bus at each i2c transfer and must wait for
> > the enable/disable to happen before sending the data.
> >=20
> > When reading data in the trigger handler, the bmg160 driver does
> > one i2c transfer for each axis. This has an impact on the frequency
> > of the gyroscope at high sample rates due to additional delays
> > introduced by the i2c bus at each transfer.
> >=20
> > Reading all axis values in one i2c transfer reduces the delays
> > introduced by the i2c bus. Uses i2c_smbus_read_i2c_block_data_or_emulat=
ed
> > that will fallback to reading each axis as a separate word in case i2c
> > block read is not supported.
> >=20
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Note, that in the meantime the bmg160 driver just went all regmap
> on us (as part of adding SPI support - though that step hasn't
> happened yet).  Hence we'll need a means of telling regmap about this
> possibility.

Perhaps this is covered by a regmap_bulk_read()?

The series[1] I am working on implements a i2c smbus block data regmap
bus driver. Regmap should then automatically do a block read in
regmap_bulk_read.

Patch 15 introduces the i2c block data regmap bus driver[2].
I am only implementing this so I don't break bmc150 behavior. I do not
have the hardware available to test this regmap driver so it would be great
if someone else could test one of the next versions of this bus driver.

Best regards,

Markus

[1] http://thread.gmane.org/gmane.linux.kernel/2018643
[2] http://thread.gmane.org/gmane.linux.kernel/2018639

>=20
> > ---
> >  drivers/iio/gyro/bmg160.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> > index b2a6ccb..1ff306d 100644
> > --- a/drivers/iio/gyro/bmg160.c
> > +++ b/drivers/iio/gyro/bmg160.c
> > @@ -772,6 +772,7 @@ static const struct iio_event_spec bmg160_event =3D=
 {
> >  		.sign =3D 's',						\
> >  		.realbits =3D 16,					\
> >  		.storagebits =3D 16,					\
> > +		.endianness =3D IIO_LE,					\
> >  	},								\
> >  	.event_spec =3D &bmg160_event,					\
> >  	.num_event_specs =3D 1						\
> > @@ -809,19 +810,16 @@ static irqreturn_t bmg160_trigger_handler(int irq=
, void *p)
> >  	struct iio_poll_func *pf =3D p;
> >  	struct iio_dev *indio_dev =3D pf->indio_dev;
> >  	struct bmg160_data *data =3D iio_priv(indio_dev);
> > -	int bit, ret, i =3D 0;
> > +	int ret =3D 0;
> > =20
> >  	mutex_lock(&data->mutex);
> > -	for (bit =3D 0; bit < AXIS_MAX; bit++) {
> > -		ret =3D i2c_smbus_read_word_data(data->client,
> > -					       BMG160_AXIS_TO_REG(bit));
> > -		if (ret < 0) {
> > -			mutex_unlock(&data->mutex);
> > -			goto err;
> > -		}
> > -		data->buffer[i++] =3D ret;
> > -	}
> > +	ret =3D i2c_smbus_read_i2c_block_data_or_emulated(data->client,
> > +							BMG160_REG_XOUT_L,
> > +							AXIS_MAX * 2,
> > +							(u8 *)data->buffer);
> >  	mutex_unlock(&data->mutex);
> > +	if (ret < 0)
> > +		goto err;
> > =20
> >  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> >  					   pf->timestamp);
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--LFcBmrHMV+//QdlE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0aTXAAoJEEpcgKtcEGQQKS4QAJE8VlnnJRdZGz44H+IDAGUx
Bb8iJtbys0r/ituswkfHbo2WJqVSQA+z5hsKkfzJjvpBLjbrQhj62uhVk8IEqPig
uJ+2QBmaDSTMVQTpoz7S39H8/msRd0xN23vmMA7G5t1koV1zAEJxQaP2p4WQb/cK
uyM3NYsaBiOVNEM7ceQFRDIcQ+wOoioin61kxn4y31tC6gBc082q7EkYvXKC62Cu
q79d9PvGz6pZ1ESNlSNBzul8VfU1JxUQmGa8qLko4ejtDnI5jVcUztZiEQ83eECs
OWLJi4CZQWzhxCw/5SdRxO7hQ6TbFZOT83vRiLWn545HT4bNKdvxLkzJMnfCiye7
2xopO9LYZRVU0cWoYpDV6kuTdHqpcUuGdPm0fYwmZUCz6fEeKIw1RhEmbKXcAF6p
CegzSEF9KngQEQTK0vDXjIeK/xnRjmBzbSMVna9TdbY+YYte2k+gSollkhtoxtjh
0b3F1YNjQKTUwim+WS/rmybapdb+rfZRusSYt8/ro1Nrls7aoBmr2RzcJMFCm+Zr
q6H7kkLaFrc/zXgdc5XORjil5GKMw5d5yQUYwtz0Bkmc1gOhcm/xWCXrBSJlAFLV
NNZgxpdN3tpzoJJ8CMMF9w+VfWRSI8KAepY38GwaiALsBr+LaJVW3XhAwwFvuOqe
HumsJs3z3OEdagkC0EgP
=2Ocl
-----END PGP SIGNATURE-----

--LFcBmrHMV+//QdlE--
