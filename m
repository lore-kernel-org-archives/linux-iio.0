Return-Path: <wsa@the-dreams.de>
Date: Sat, 15 Feb 2014 14:39:34 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ge Gao <GGao@invensense.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: imu: inv_mpu6050: Add basic support for mpu9150
Message-ID: <20140215133934.GA2579@katana>
References: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <52F623AA.6020905@kernel.org>
 <E7747D604FBC9F43A71AA431AFF44762104C3FB8@IUSEXCH01.invcorp.invensense.com>
 <201402101939.46467.manuel.stahl@iis.fraunhofer.de>
 <E7747D604FBC9F43A71AA431AFF44762104C57AF@IUSEXCH01.invcorp.invensense.com>
 <52FF5D61.4080506@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <52FF5D61.4080506@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Wolfram, what do you think?
>=20
> In short we have a device that sits on an i2c bus and supports its own
> i2c bus (mainly so that the internal processor can use data from devices
> on that bus) including support for passing the bus straight through.
> The issues is the dependencies when the intermediate device is sleeping
> for example.

Just judging from the paragraph above and not digging into the topic
deeper, I think the idea of an 1-1 multiplexer is suitable. Would the
pass-throu device then be a MFD? Are the alternative ideas?


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS/24WAAoJEBQN5MwUoCm2vHoP/3iGh5Gu9Ue9tUYO3RK+YEdy
TCbDsR7tjLYwzO4AEV1mrGQ6MxZbkrOeoekpw3CCLRCu9BvnSngRX4MGn/tEELIn
X0JXBpN0Yq3F/N9EZRmUhCK6285FuNt69XjOZHOln9RLZjsA3vB8ZTnPuO+UC86l
GRJZbJfz5Bso56MXFSj1LXtA9NqoEwep1vyVhbkTDpQoRcaXrvfSLnHSxZL0bFxx
thqlSNlyemEPSON3ZqrFAEPluWQMBn/cA+K3CaL0aRcMK6UFs6XccM4899+R31nk
D1FxhOP3Wl22BRRfGwu1YgbExOCebWNIvMdaLrA+6D6tFB6RFfZeD/GZv/HmrWfZ
ipIr9bw0G7xQACMwSKCk2szLG6z9IMzLCWS+ToFrO/IvIgqCkWDwYk0Oi2MI1Lxi
Ov3POWhklVw3PiN5hEiaZ/saE4Fnmr5odPt+r6Mm9hLzFEAKXV1uylQWidiz/D1U
GpBfbqHzjvcuDmaL/OHzOxw8vvGp6C4cduSACMpKNBO+HONgYF5XMcnOi34KAe+3
e+CYZwAVaW1xdXTNkLIuBkk7JwQh3QbS7PLONzRETT3YtDjuXQBOY3G+HuOEVVeh
5/xE35a+OyhNSEuqgYLTUAphI6oxV57+TSrOqPGhukk1lOwuoeycb3IZ+p5gGY4C
zgEpnCxPhSKfgZRreNqd
=vP8p
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
