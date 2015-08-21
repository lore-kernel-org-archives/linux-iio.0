Return-Path: <wsa@the-dreams.de>
Date: Fri, 21 Aug 2015 12:21:25 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 6/8] iio: gyro: bmg160: optimize i2c transfers in
 trigger handler
Message-ID: <20150821102125.GA1656@katana>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-7-git-send-email-irina.tirdea@intel.com>
 <55D056DF.5020201@kernel.org>
 <20150817090943.GO19600@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
In-Reply-To: <20150817090943.GO19600@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 11:09:43AM +0200, Markus Pargmann wrote:
> On Sun, Aug 16, 2015 at 10:24:47AM +0100, Jonathan Cameron wrote:
> > On 12/08/15 15:31, Irina Tirdea wrote:
> > > Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> > > enable/disable the bus at each i2c transfer and must wait for
> > > the enable/disable to happen before sending the data.
> > >=20
> > > When reading data in the trigger handler, the bmg160 driver does
> > > one i2c transfer for each axis. This has an impact on the frequency
> > > of the gyroscope at high sample rates due to additional delays
> > > introduced by the i2c bus at each transfer.
> > >=20
> > > Reading all axis values in one i2c transfer reduces the delays
> > > introduced by the i2c bus. Uses i2c_smbus_read_i2c_block_data_or_emul=
ated
> > > that will fallback to reading each axis as a separate word in case i2c
> > > block read is not supported.
> > >=20
> > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Note, that in the meantime the bmg160 driver just went all regmap
> > on us (as part of adding SPI support - though that step hasn't
> > happened yet).  Hence we'll need a means of telling regmap about this
> > possibility.
>=20
> Perhaps this is covered by a regmap_bulk_read()?
>=20
> The series[1] I am working on implements a i2c smbus block data regmap
> bus driver. Regmap should then automatically do a block read in
> regmap_bulk_read.

Hmm, so doesn't your series make Irina's series obsolete? It addresses
the same problem only at a different layer (i2c core vs. regmap), or? It
would mean that i2c client drivers which want to support byte, word, or
block transfers should be converted to regmap. I assume most of the
potential candidates are register based devices anyhow. Then, regmap
would be the proper abstraction layer. Have I overlooked something?

Thanks,

   Wolfram


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1vulAAoJEBQN5MwUoCm2xwgP/RFR33g5ljIF455p2gWLM0DM
xAuO3AN6WEPymGCUztOI42kpoDH/vc37D6DVEbLH+K7o8gn+e51S0XS+kQqRpo/F
5hZ60wp01SbmJ5R5i0uwyYL6yA4avXj6/5jSZeDvz01Jd70BLMdf3kNEezkcW0hm
5yiVOxL/TpAEgXMDnpeYa8WTLuGE2HRfLwcF2iOwVHHOW+bHZK8dLB4foh+BXowp
WgqlPHnZcWS6/iSQ5BZ/Il7lbcTRto6LfxTRmx3d9TvlvNGXAVGPYOUVDc82pN+l
DYzykrZOQ1dlV7h8+gmpZwEkSg8+OkyHTziI7CkidMUtYPn1Lt51FunaTqmyUQDy
za2hKW0hEdsLrhAUYoMbWUPZ7nJnSUMH4wnQiuGvucKzw7eGxvCDjInPZaMAkSV3
fN1W00foAA1F0PEEb4+KPBYhnqeDh7QddmycKilIzEbpw14/9Z9UmXynZMc/bqfO
TCNW/d/2Fm5sMMd32p6V6wrdpCqnoZCywHLVxvNJ5VIKIBuJa4UghOYqdzJnWtz7
wbfebXYZY/kEJoa34g4s952SmUiBK1Bul0CNgXYQ0oFi6py8H+CFKfT6jBX5QQe6
2GYpGktj8xzuQpS+pEa1ro9LhJdw3hzjMtH6/dZY3i0mlGZ/bjadyxG4fiNsR+6P
fVVfkKaeieC8iSwdopUl
=gEBN
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
