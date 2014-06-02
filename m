Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:60905 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbaFBSKv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Jun 2014 14:10:51 -0400
Date: Mon, 2 Jun 2014 20:10:40 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Paul Kocialkowski <contact@paulk.fr>, linux-iio@vger.kernel.org,
	j-keerthy@ti.com
Subject: Re: [PATCH] twl4030-madc: Request processed values in
 twl4030_get_madc_conversion
Message-ID: <20140602181039.GA2185@earth.universe>
References: <1400933398.2079.16.camel@aldrin>
 <538CBBA6.30203@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <538CBBA6.30203@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jun 02, 2014 at 07:00:06PM +0100, Jonathan Cameron wrote:
> On 24/05/14 13:09, Paul Kocialkowski wrote:
> >Not setting the raw parameter in the request causes it to be randomly
> >initialized to a value that might be different from zero or zero. This leads to
> >values that are randomly either raw or processed, making it very difficult to
> >make reliable use of the values.
> >
> >Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>
> This one seems obvious enough to me that I've applied it to the fixes-togreg
> branch. Note you should cc the author or if the log makes it clear someone
> else has been working with the driver recently, then cc them.
> In this case Sebastian.

The commit message looks a bit odd "[...] different from zero or
zero". In case this is still relevant:

Acked-By: Sebastian Reichel <sre@kernel.org>

> [...]

-- Sebastian

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTjL4fAAoJENju1/PIO/qaJoAP/iA6I0+H2KSkSMxHr79ha5DU
LAcx6PXTidvSbeA2Q0QkNDsRRCa+FOSIAfDev+a/pie5DVIzjCGcZg3oK9xBteZM
B+CrmPVmHWIAVWzoztOSuhqTO/z1szd/r8LenCk2DzvEdpc2LBvRD/f4+gj1WHac
WS/9i2XdQ47UgweNgRMi7s9zcG+YNjy1YRwxrh3XzWZoe2Ay2mT8m84Wx3g8GfXZ
xLpsbs/DO41+B5A/5YJw9BIXkCON7i6nYODh1OzqbL6aYM9wp8qFUUYQwXVtQ43l
F4j8ihXVVWaXdz10GqyLjkqrHVHEmGgIpR7j8beqzuC1rwywXkxQykW7FoWR3gTo
y3NrQKkBgsmYHqennY0XV9SFzhfnVfBHNtaib9SBuXbw5Du0sCE6fxaNDCYea00W
1a/ZwP+zn9m5a8n/D0ALWXdmt93ZGN/39yu1P0K1omp930zNMloImiKlXubSDNYu
pKcTK3qImOtzg9KFU+LMs95aUL5Ge0vdUfWhF+3UFr5f/trFVFAUXYAMe3uGIVfB
GdBXvqhPYdhV2SYCxa7wJE8LX+m3jQ/Hsn1aNNlUw4mYJMBINXT80cpZ3G4JRppG
BCQFn11YTKseW4Wp2VOYafynhrM3KHfuvjsYbKhgCGTNZvo2HFJfvxMFxnO3TS9o
xTc77zM5SNfXKD9nHeju
=zoRy
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
