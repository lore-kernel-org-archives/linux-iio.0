Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60792 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbaKVNG7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 22 Nov 2014 08:06:59 -0500
Date: Sat, 22 Nov 2014 14:08:18 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	knaack.h@gmx.de, linux-iio@vger.kernel.org,
	Wolfram Sang <w.sang@pengutronix.de>,
	Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] iio: imu: inv_mpu6050: Add i2c mux for by pass
Message-ID: <20141122130818.GA2679@katana>
References: <1416333184-1367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1416333184-1367-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <54707A80.90809@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
In-Reply-To: <54707A80.90809@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sat, Nov 22, 2014 at 11:58:56AM +0000, Jonathan Cameron wrote:
> On 18/11/14 17:53, Srinivas Pandruvada wrote:
> > This chip has a mode in which this chipset can be i2c master. But

I don't think it is a master...

> > the current upstream driver doesn't support such mode as there is
> > some limited support of clients, which can be connected.
> >=20
> > To attach such clients to main i2c bus chip has to be set up in
> > bypass mode. Creates an i2c mux, which will enable/disable this mode.
> > This was discussed for a while in mailing list, this was the decision.

=2E.. but more a by-pass? What is the advantage of putting slaves behind
the by-pass instead of directly connecting it to the bus?

> > This change also provides an API, which allows clients to be created for
> > this mux adapter.
> >=20
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Still wants to go to Wolfram and linux-i2c, given we are adding an i2c mux
> deep in an IIO driver.
>=20
> Whilst Wolfram was happy (iirc) with the approach he might want to take
> a look at the implementation (and I'd rather have his ack before taking t=
his).

Thanks! Please notice my new email address.

> > +static struct i2c_adapter *inv_mux_adapter;

static??? And if I have multiple mpu6050 on the bus?

=2E..

> > +struct i2c_client *inv_mpu6050_add_mux_client(char *name, unsigned sho=
rt addr,
> > +					      int irq, void *plat_data)
> > +{

Huh? Why do we need that? Why can't we use the instantiation methods we
already have?

Rest looks okay from a first glimpse.

   Wolfram


--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcIrCAAoJEBQN5MwUoCm2AvAP/04wYpTQR62cHsryHFSfY/Yn
OtkNpw8CWrq2u7M9cwuZb7JOf8P0i/80qeSi8HMePp0VhAz+TgpDVjus3qCJ8BWs
wsjxSA29bI/32lqsJU3YNINxMayThJ/4ryCEJTPI+sH5wTjRu0I7hg5hfeHsNW2e
hLIhdS4QPDR5hwXRIR0NYVw6qe0il9JkbRQZ+ZbduYhg7pGqPc7VOqU+DIzqcJ4N
GGEGMda5U6YxgrYqMQc65Emy6bjxLyn+bH7r6LVSdUQN0bFMwxpJXhA2e8rWpwt5
IPj/4CSkcPZhidi7/5h+LlKSNOYh0BplACer3L1APf6iTGY0L9uwAyB5LrDzh4As
51zKOg6Ns2RVOudL/fOcz5ZSKpeBw3SmP6AQlM2uVJoD4LHMNU010jCqQMEq0oN1
h/aNsLxwZjJ7PdBIXoiNwEB+gxs+6b1PGHXnP6YRx4ADh7OL3zDxPan1Lo5ge55x
oiNUHMz9r9ivx2ngRj4DLPw5D2vWzIIMnlHmg6Ry683s53Iq/AmNcJlOdJ1Yl2gz
IopkLX3BHlIhgMxWMQE6QRQy8aKY4TEzsybm8OMBLxFov4O2FyHI95o1eJXvlzeY
58fU2iO9xn7nWcLHrx8v0ZcSrDSlw3bIK9xf7YMCVfeRBx+/omUvOk/zs7wpuhPe
XJoE4eFiiVk9I17zVx0B
=zUfW
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
