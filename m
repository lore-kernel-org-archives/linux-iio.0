Return-Path: <SRS0=Cu3G=52=sang-engineering.com=wsa-dev@kernel.org>
Date: Wed, 21 Jun 2017 09:15:21 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: DMA safe buffers for I2C.
Message-ID: <20170621071521.GA1574@katana>
References: <5e4f022e-9434-2892-4fac-94cadd1f8f43@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
In-Reply-To: <5e4f022e-9434-2892-4fac-94cadd1f8f43@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jonathan,

> Just looking to get up to date info on whether we need to be careful
> with cachelines on buffers passed to i2c function calls or not.
> i.e. do they need to DMA safe buffers.

I did document this recently and forgot to add you to CC. Please check
https://lkml.org/lkml/2017/6/6/189 (or I can bounce you the mails if you
are interested) and kindly let me know what you think.

Kind regards,

   Wolfram


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllKHQUACgkQFA3kzBSg
KbZT8g/+PcmBCRuu6baHyDFfK1TyZtSCtVJiZa2GzZty698mKHBjDqfThz2p1OsS
grRedV4JCQO9o/6xDcdV2POHchg5D7T+HSgxisWQI5tEKVfgD+9zuQ8cv5OyuKtw
tHwfKgiKTkfJBR4nmPtRbYbQ849855fi4bhfopsmHouDk0qdDRYBV0nPv2FPh6so
4Ifa3rBrgCil8p9kofrcWu/FZ4QYp+R+9mnsS02TrWExpzO5ym6cAd59NNlRcGHC
WOLMZW3wGbEyehlnClJUaZQWwC9d8PMCdyWFTSkx/XRoW50U8s8UkMzgS+eFXO4B
Jf5Dqoo8XH01W9P5ESJx/9etZManxaK/G57GrJ9vmzukoph1wrDaWd9SwNIGVU5P
pvYaZC+SKEurTeFAB6q9DX3UYGO0Obg6H3miMzAqEtqQih7ivkIJHj0ScKgSapA7
HFQZpc+VxAGg9ZvxYPbr827A4Yx+gbzCF+yQHJ1aeWUKmaMve9tmK1srv9Pi9QHk
fKRcT393C3T/nRH0zRsgcX3GKOp6wfPbk2IGve7UA9ozseRl7h1idn+vxg3xTzJE
YOZT0MiIatJ9EUgBTI4ZapPsozVY3RYGRN7ceonrdrAy5T6+60JSf26EfUHsX2K4
3Dm6CQDMAsU1lSjpGaezROWhHAhUW7+/bgYld9gDu/GCkqw2VP0=
=5bbS
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
