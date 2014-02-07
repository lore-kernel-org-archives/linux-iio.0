Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37837 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbaBGNVN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2014 08:21:13 -0500
Date: Fri, 7 Feb 2014 13:20:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: John Syn <john3909@gmail.com>, linux-iio@vger.kernel.org,
	Matt Flax <flatmax@flatmax.org>
Message-ID: <20140207132058.GN32298@sirena.org.uk>
References: <CF17C5B7.1940A%john3909@gmail.com>
 <52F35C5B.7080409@metafoo.de>
 <CF19225A.196C9%john3909@gmail.com>
 <52F3FB6E.3070201@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0pBSE8Gehi89/9Xf"
In-Reply-To: <52F3FB6E.3070201@metafoo.de>
Subject: Re: DMA sampling and IIO
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--0pBSE8Gehi89/9Xf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2014 at 10:15:26PM +0100, Lars-Peter Clausen wrote:

> I guess this is because it is the traditional area where I2S is used and nobody
> cared so far about using it somewhere else in the context of the Linux kernel.
> Not having to have a extra layer of abstraction in the middle between ALSA/ASoC
> and the I2S peripheral driver helped to keep things simple.

Plus many of the uses actually found that the audio APIs were doing
useful things for them anyway - the DMA bit is reasonably useful way of
transferring continuous streams of data and nothing much cares if that
data is actually audio or not so long as the application on top doesn't
mind.

--0pBSE8Gehi89/9Xf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9N23AAoJELSic+t+oim9wQIP/iNnWfPPqkJdpPxTZpvIy6vK
vqduUw4EXGUaip/AHuu5dtHZuhYtFdxXc57Fi0PRGwJI+rPmPD2Llib5IqZDrSuk
PVrk6r+IVRjPYXad9gMQzVvIvGRizwLr6R7Mgpo+iC0mcYUhkSNiLfyxX1r1GAeY
HsTEYGvlc4ReYwZbt5EtDpvgK3LPkKGstAbSU/d6cbhNi1u4qD08X57TzpzfLJp/
GIb/Mzlqn/9ZClirCVDpuZ29UXTmLBa6gHskkQmP/Gb+/pR5ROTOBMlJ4HPQavc6
UJ7sHo4DpEPFEbrIrQq/bHK2BouBJpA3u17F2deQe4WWjta8m8BzK1BV1fbUZZLU
VAu0fDDsH11gLWdXw2fFOaWQ3Ote6vn1TKaprGQyojd2hjpLv4rleG6V1FkNrM0s
2lItPuRldOPQkuQ7uGL4mtH+mvsJ9ncq8qxkZ7y5mTsQQXkmvHXhVujH9kNWEt46
u6hnrKM2tMKAtsXbK4EYDLyL/SriCyeg7oS9dPGelg9RPPHbvGjdt983PKP1q9OD
QiVuyZw96LjbeAD5mnVKLp7s7Nw197AfMmUR+tABtZMPJgnwSKszR6RT9wB7tmDE
fGFxgMnW1DOJnabZsE9Da5+SItBNRauysaSbPhPaZLrlnvHDWTYMOZGD0fxof00k
7CSPSou3gkVbyUlQ3hR3
=V1EA
-----END PGP SIGNATURE-----

--0pBSE8Gehi89/9Xf--
