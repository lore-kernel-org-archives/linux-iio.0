Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:55629 "EHLO
	gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbaFBTSW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jun 2014 15:18:22 -0400
Message-ID: <1401736646.2083.2.camel@aldrin>
Subject: Re: [PATCH] twl4030-madc: Request processed values in
 twl4030_get_madc_conversion
From: Paul Kocialkowski <contact@paulk.fr>
To: Sebastian Reichel <sre@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	j-keerthy@ti.com
Date: Mon, 02 Jun 2014 21:17:26 +0200
In-Reply-To: <20140602181039.GA2185@earth.universe>
References: <1400933398.2079.16.camel@aldrin> <538CBBA6.30203@kernel.org>
	 <20140602181039.GA2185@earth.universe>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-OjipPxWHQfimJQLsQnPe"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-OjipPxWHQfimJQLsQnPe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 02 juin 2014 =C3=A0 20:10 +0200, Sebastian Reichel a =C3=A9crit :
> Hi,
>=20
> On Mon, Jun 02, 2014 at 07:00:06PM +0100, Jonathan Cameron wrote:
> > On 24/05/14 13:09, Paul Kocialkowski wrote:
> > >Not setting the raw parameter in the request causes it to be randomly
> > >initialized to a value that might be different from zero or zero. This=
 leads to
> > >values that are randomly either raw or processed, making it very diffi=
cult to
> > >make reliable use of the values.
> > >
> > >Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> >
> > This one seems obvious enough to me that I've applied it to the fixes-t=
ogreg
> > branch. Note you should cc the author or if the log makes it clear some=
one
> > else has been working with the driver recently, then cc them.
> > In this case Sebastian.

Thanks for your feedback and sorry that I didn't check the previous
contributors to the driver!

> The commit message looks a bit odd "[...] different from zero or
> zero".

How about replacing that with: "that may or may not be zero" and
inversing "processed" and "raw" in the next sentence (if that's not too
late)? The commit message would be:

Not setting the raw parameter in the request causes it to be randomly
initialized to a value that may or may not be zero. This leads to
values that are randomly either processed or raw, making it very
difficult to make reliable use of the values.

> In case this is still relevant:
>=20
> Acked-By: Sebastian Reichel <sre@kernel.org>

Paul

--=-OjipPxWHQfimJQLsQnPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJTjM3GAAoJEIT9weqP7pUMRvMP/ihsUbsheCCoF/yilv7rUbVw
rFQNz6itV6ZthyhrCoRn+cq92kb1apzgysUIsbs987gu0GT/sT/pI6Qig5Kxuvw4
N/pCQwC8RqSdYLjgpRVftH8wdUga9pdOz63kNgOkO/Iv7M99M2hgu8xX+oLFwXFH
GCCrBtoKX0rFxFMc3Q/DU0P+SDXos+yOM+wMyIUZohdAghB0RZoXqUm/ja+3W2p9
kwQE6lijdGi5eoLY+jgxwQjsUvi5Cqt8qJyLgMr8wkjeKCYz69zngcD6k16FMTFo
XfoHGFcAF+HY2gC2zGOOl/xpdqX35t5NO97V9J1Pxe74tW+5kuChIQzL0BgI6xuG
z9/m1WTxzRoFjHhqK9XCHGTBxTyKynwYvwZDVgDHQUjou9kPNUgx6q8cQ3zblIxw
4wD3uwg7cjqCQPaXe86rz4qL/SPevYkZbR/VLbpjUb1PhXvb/wJ3EBQcweJc1XO7
qqgg4lBexzGPqw7/7pFXjAFg1/7XAQDfXseBL6T9D/Ej7WDAYQ7MUO59FaDpDTMs
XgtaWOHYGjVwboIns8+0nxyGTbw2Y5sDY/eUypJhY7gpRttk50r31gNBj6qhk7Jf
Uqf6DjQ5LwUf0b/S0kKWF4mOobdrWPEY1Llx3lus8U23hx1TftcqJC80AHcf+mWs
N1JO0knyOx3DVnUx0LKT
=VtQt
-----END PGP SIGNATURE-----

--=-OjipPxWHQfimJQLsQnPe--

