Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56828 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690AbcGSHOF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Jul 2016 03:14:05 -0400
Date: Tue, 19 Jul 2016 09:13:51 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Alison Schofield <amsfield22@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: light: isl29018/28: remove I2C_CLASS_HWMON
 .class setting
Message-ID: <20160719071343.GA2086@tetsubishi>
References: <20160716022831.GA7636@d830.WORKGROUP>
 <578C9843.10408@nvidia.com>
 <dff1e871-de49-654f-5e9b-c9b230a35b0a@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
In-Reply-To: <dff1e871-de49-654f-5e9b-c9b230a35b0a@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 02:30:46PM +0100, Jonathan Cameron wrote:
> On 18/07/16 09:50, Laxman Dewangan wrote:
> >=20
> > On Saturday 16 July 2016 07:58 AM, Alison Schofield wrote:
> >> I2C_CLASS_HWMON is for a hardware monitoring chip wanting
> >> auto-detection.  IIO drivers don't typically use .class.
> >> Remove it.
> >>
> >> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> >> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> >>
> >=20
> > Agree.
> > Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> Any resulting ABI change from dropping it?

What do you mean with ABI? This is only relevant for "automatic"
instantiation. From me:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjdMuAAoJEBQN5MwUoCm2TGsQALDVdnG4ebAv1h4u01UDFIrP
XOX7DMa3vznfDCi+FDQ7kBGI0kt2q/rwNKkVe468mtyFQHfzfVeHsgaEQ1XCoIkZ
e8U7nOhxLwgkSPy81jy0gij//gik5cw7AyMa3rNMxtNoWf0m+26Fk11L7WgcGbYP
s4qrZLRVdR/6VEXAI3vu7PBFXVI+Lf7dyA3gOMjUpo2lTv6caeUORhiTUjGbS/1g
moe01F0YXPaU+OMoiPHQ6t7y/AWpngGWn2aHWhERDjoMoe59GriMp9ExDIP5cJeo
jybS55IPmZwmciDfvJ105yFRtgN6xaAsuX50MbwCae9jFSZfwLYcUk6iKmulhZtm
ouG7vp3tnkn4P2GZNpTX0ZtaFSLc6OfLarANhyUmR/oInyZh0EOxZ2lgMfYkWnvK
XAsE0Gs17h2c9cws9yZJppzlWtdsoxP7wlEndmYdC5li90RiWHfeaZGQ2jaX7rCb
96pK7y1CTP7A6CIxs+LuIb0rcUredk+Q8ypswnn1HTyb1wj/YvUkih0sBPuS/XCC
WLu/Hc1ZQG0/PXj2gbwM4bfGwDbpQwpoaiIhwhGDwNoza7mV+1mj5SaTGUzNo4NS
2E1P2nxUOHFJpFp6u08wv4PDvDpD6orljpPXTTb/BVBn2OlTGS7BuY5gfOCpLzuY
2RySVuv5usvfTO80Jkm6
=WEHl
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
