Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56065 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755316Ab2CUT7o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Mar 2012 15:59:44 -0400
Date: Wed, 21 Mar 2012 19:59:42 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [RFC] iio: amplifiers: New driver for AD8366 Dual-Digital
 Variable Gain Amplifier
Message-ID: <20120321195942.GO3226@opensource.wolfsonmicro.com>
References: <1329914182-5428-1-git-send-email-michael.hennerich@analog.com>
 <4F6A2D2B.9050400@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmZU9S7l/XJx5q9b"
In-Reply-To: <4F6A2D2B.9050400@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ZmZU9S7l/XJx5q9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 07:34:03PM +0000, Jonathan Cameron wrote:

> I've pulled Mark into the cc as he might have come across similar
> devices from the audio side of things and hence have some experience
> around this question...

How to represent gains from amplifiers?  Audio specifies gains as dB
between input and output; generic stuff like IIO may want to do that
using a linear scale (or have the option).

--ZmZU9S7l/XJx5q9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPajLhAAoJEBus8iNuMP3dspsP+wWpNTA7zsnw+Yet7aTkPL9T
og2WXyZXj8S8r5yZRNbwX6fG0gzlyQtjcsswp2LX7tk8q7nK2VZFrCOzIVv1EwM4
CK9NcFjE4SVE6kAVCz3AJ204UnQEpvaZY/JHW8olIgt8SiJkpb5Tqgb9eXGypHCP
YRDZB0GxJvh/dbJCCPU1zrfpQfhJ1Cwtj0HPhnao2ermz2HY+BU+IhGiM2VFtwzn
bhC8pwgOaxS+jnUW3W+z8c0QrTgoEUj4UUcNtOsVFZdwXdYW9uDHSyaGloS8uNVS
Rpik0ApCPiRQgKJ8WP7TH5+s9SO5yjZwVatDCOkFJ9Fu3DXpe9fEjSlo9erjMTEz
IAlYa/cOYK5y4nT6bdT0PcX7ihtsY1Hi5yEpyk8jMEfGvqtD1jELa6ejYUw9UCy8
GtH6Xyugp8d3fN/3vKeU4NLJiaBS5CdESF9TuBYu0JpDXo4tjDcuNV64BrTfeJ+j
XKGV7rRfkAzAZb9SASWpFROceuCyBbQazUGnWj5KigSP5T8XPquxyqUjlWGaKy3/
OcxbkIU9tbTW+Rw+X8eiZ06qlRm1h/3bMXvgrnx6LZui0lTUhH66mBr4kjQs45Iv
yFlMIR8tE4XtqdTse2/QVG4nRB+3ke+5K+v/EBFuFSyYGYRe+Sf7Efrp1CCOAqOi
GmheHAWAed6JdVpHjzd8
=oqAV
-----END PGP SIGNATURE-----

--ZmZU9S7l/XJx5q9b--
