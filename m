Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:38442 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab3HURzD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2013 13:55:03 -0400
Date: Wed, 21 Aug 2013 18:54:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Pawel Moll <pawel.moll@arm.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"l.czerwinski@samsung.com" <l.czerwinski@samsung.com>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	"ian.campbell@citrix.com" <ian.campbell@citrix.com>,
	"s.nawrocki@samsung.com" <s.nawrocki@samsung.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Message-ID: <20130821175446.GI26118@sirena.org.uk>
References: <520E3B8F.9010800@samsung.com>
 <520E7417.3090606@wwwdotorg.org>
 <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
 <5214AA52.2060209@samsung.com>
 <1377088624.10707.23.camel@hornet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
In-Reply-To: <1377088624.10707.23.camel@hornet>
Subject: Re: passing two interrupts two an I2C driver
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2013 at 01:37:04PM +0100, Pawel Moll wrote:

> So let me ask such question... If Device Tree didn't exist, how would
> you make drive such device? I guess it would require some custom code,

It's always done using platform data, same for SPI - if we update one we
should probably update both.

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFP7jAAoJELSic+t+oim9OJwP/j+jGqBR9P5yVIbWS1qfHx8q
4nErg1/sUNwOm9SsbWgK1o0xQZ9t6lmFEhqlqHbcn9r18bU75GjDjEUdRZBuUDqO
oEfb0DRl3wPG7uHbPCSDI+Wzo/RcbRi8dpegtWWrs+xSSZlRn1VDnKSNLtyd+wfV
NkaAPiDUVfeMJXb8fyT+5hUNAU0O9OCB7sYV5nRyFPPQVxUlsgMIHHjYXali50IT
vWYGzo0UTpfxuiVWsnRkfEnEsqxt6yCq12zWqN/WBgrPHim7ft0XHwLtDb185HDe
9uda3dGZfV9dzGNjc6wCl2d5qcRyJEZ/u7PQEz/R4UKTA+mtnwk4A6X/4JorQ63E
Yh82XGdzLuTQkUlErhMek1LfrsQCGN7SjeJtUtcZnb8k6hNus/6XedyQ9hN92Y0+
kcIctoTH05CwZCbnD+EF3cfWw5V+KeTRCdzTEjzJ3tqhGeFJrcxYNZ61/af7x2iu
pEl+E1TCLSOrMYGonoMqqvLJ8Kba/BeKc1vz7l1BGCztkFdH0TTJ9OdiuSQdK7If
FckS+QZhYT79SF9W0lMFsGsbzJhtzDptjnNxVQOsz2yRIjpBL0PJ6MZ8pdM+2MSz
bcHKmlQwOafDSHFCkJQebw/JPf8I2nStIMUI4Xefss7oVM+1nmwSlzgGZ4DVyBlV
a4n2UEhTQMMbdNN+YhMf
=FIw4
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
