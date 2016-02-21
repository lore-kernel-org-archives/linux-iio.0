Return-Path: <wsa@the-dreams.de>
Date: Mon, 22 Feb 2016 00:17:51 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, lucas.demarchi@intel.com,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
Subject: Re: [RFC PATCH 0/9] iio: Fix ABBA deadlock in inv-mpu6050
Message-ID: <20160221231751.GC1386@katana>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
In-Reply-To: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2016 at 05:53:05PM +0200, Daniel Baluta wrote:
> Sending this as an RFC because I don't know if style fixes are appropriate
> for this driver and also not sure if deadlock fix is the best solution.
>=20
> I2C people should only look at patches 8/9 and 9/9.
>=20
> The mpu6050 accel+gyro combo has an auxiliary I2C bus, allowing for
> an auxiliary sensor to be connected (eg. a magnetometer).
>=20
> The mpu can either act as an I2C master (functionality not currently
> implemented in the driver) or it can use a bypass multiplexer which
> directly connects the auxiliary I2C bus pins to the main I2C bus pins [1]
> Currently the driver implements the bypass mode via an I2C mux.
>=20
> This patchset fixes a deadlock in inv-mpu6050 IMU which happens when
> magnetometer (on auxiliary I2C bus) runs in parallel with accel or gyro.
>=20
> First 7 patches do some cleanup in order to make INV MPU6050 code easier
> to read.
>=20
> Patch number 8 allows passing NULL select callbacks to i2c_mux_master_xfer
> and i2c_mux_smbus_xfer.
>=20
> Patch number 9 actually fixes the deadlock.

We recently had a bigger patch series fixing locking problems related to
muxes. I sadly didn't have the time to review it. Can you have a look if
it helps your case?

http://thread.gmane.org/gmane.linux.drivers.i2c/26169

Thanks,

   Wolfram


--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWykWfAAoJEBQN5MwUoCm2qOkP/jKGqpHffps8ssgicIW8TKCt
T/f9Xf4mGFJ5v/KNIEtqc7xlumEysU50wCEeD9mox2AFjdMb+UICAtaR7si/TM8n
gIzVGGA4/UHrnVfTW4aah+cqZ+wkwTL9KcZjBzNXLi6kCqMExAct2ilArvZLJCkQ
CJyxjTU9kMyc64m9hEmXzAsgWsyzL5RlNLnD7O8paZ7iEDJwjqmNosZBa4TEzM+B
ZoZE/sG5Sv+COLkcQgIe9BQmk7wsQyuCGYO7q2SPj/iCyvDUD7O7rI/2BZp4WhHy
iDuBtLPnTfMEy+tO8euPcQBcaGp9b4gDX5H9z5OIH0gOCgLMes3mexuli3/bZ4VH
Kin/F/tHubUQZ5gT3o12QWYS08w1btOhLtwflIamfFfrgwQDZaFo24dhrNhtzKLR
hrwvbVbOPstP4rHgRzO4yUkUkxfWUdYP/aJTSrzIzfgRibzqej8odN48uBfLvDY7
SLxZIKNvnPktjzuBQyKeIegQuy2V+ZSPtJYuE848yz9stmfG0ODgozANVJXmPYPy
Zov2RJgkqEKnlEal1vLrSQwJ4juN0GLlAmCN5jVpOm2RAhSd38od0VBzBkALgvbl
8Im6RmC5RlR3MkfcPDwvwkPhNt+d6yHgfbyxtc0brz6dW7lrDo/jc13v9JMOOIlc
Hsw/Tuat+UsdVqnWOR1e
=sKxT
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
