Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:51507 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3HVNT5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 09:19:57 -0400
Date: Thu, 22 Aug 2013 14:19:23 +0100
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
	Wolfram Sang <wsa@the-dreams.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Message-ID: <20130822131923.GJ26118@sirena.org.uk>
References: <520E3B8F.9010800@samsung.com>
 <520E7417.3090606@wwwdotorg.org>
 <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
 <5214AA52.2060209@samsung.com>
 <1377088624.10707.23.camel@hornet>
 <20130821175446.GI26118@sirena.org.uk>
 <1377163408.10707.29.camel@hornet>
 <20130822112619.GD26118@sirena.org.uk>
 <1377171844.10707.32.camel@hornet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3NJww9yp20AXRsxZ"
In-Reply-To: <1377171844.10707.32.camel@hornet>
Subject: Re: passing two interrupts two an I2C driver
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--3NJww9yp20AXRsxZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2013 at 12:44:04PM +0100, Pawel Moll wrote:
> On Thu, 2013-08-22 at 12:26 +0100, Mark Brown wrote:

> > Yes, that's probably the most straightforward thing - we'd need to
> > either have the bindings specify which interrupt must be first for
> > reading i2c->irq or just have the drivers always do a name based lookup
> > if there's more than one interrupt.

> ... or make sure that of_i2c_register_devices() does *not* set i2c->irq
> (or rather: set it to 0) when there is more than one interrupt in the
> tree...

Yes, that'd be a really good idea if the drivers are always getting the
interrupts by name, provides a backup.

--3NJww9yp20AXRsxZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFg/YAAoJELSic+t+oim9gbEQAJoZoZ4nn5LOR9tEPktUmhcD
eV1kgDY9q0lJse4NQyJp9rzid+6pqqWhUnmA1h38MhDX+UQWHlrAQE6jhjH4wL/T
mwZQDTXvt8YN8g3iMrW6kaZhpwXg3tqcKF2GSICL2eTwdS1gIVb039Z9dfjKqeFt
UG+JplhBpfDgQm+qN3JfxYwhVAjLISzx6EMcB7YxNECrlXj4uJiiunGhTb+TNhSi
gsTUumMcJDtNlkV03pfBK8KQBHaGCnPZpg7Xojz8Y3+rQW0s2e5zz2Htqu9RVD8U
Ttx1Y3sX/OF8XVR6bOWooWmPTU7Zj3ZoeRwURZXUdgE3gcoxrTMwATkcF1WSbcr2
TRP4i+jgknCgt8AeqZkQe8W0TTdW6ftQkks5fn9e+INsxbfymmJD+dRv+48j5HBu
3gwXxquDgj1KMNF62EDabD/bCW3PReVFoo79QPlYrUT2EPGES9v8dmdkvxDp8zM0
B+RijOluu729Ey3tW2dsii4dOpTrPt4YWkuvR2xCMVUeuE5DL18DYQ74Iu1HrF7K
RUlarGOMGx5jnCVKzrR2UWvkGoovQROIZ8XEQxY5Uf8lv9exiQf/Wdk3DN65GG7e
q72+LxBWj7viwPikSeN+XOvzAiv2MJLGMQSdgEFWDKFtQ44Na4YYQrCWzgAqXjCE
pe0i87kl5mhHCBHmzp3/
=BMWY
-----END PGP SIGNATURE-----

--3NJww9yp20AXRsxZ--
