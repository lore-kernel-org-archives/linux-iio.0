Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50341 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeACMX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jan 2018 07:23:28 -0500
Date: Wed, 3 Jan 2018 13:23:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: linux-leds@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Paul Fertser <fercerpav@gmail.com>
Subject: Re: proper framework for meter sink?
Message-ID: <20180103122326.GB28083@amd>
References: <649fa764-6598-8f05-90c0-e10a4d36b08f@rempel-privat.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
In-Reply-To: <649fa764-6598-8f05-90c0-e10a4d36b08f@rempel-privat.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I wont to use existing LED triggers by setting multiple LEDs on trigger.
> The triggers should use brightness value by different trigger intensity
> and the driver should set different amount of LEDs depending on
> brightness value.

Well... we don't really have "trigger intensities" inside the kernel.

Are you sure this is something kernel should do?

> With other words LED meter controller by kernel LED framework. It should
> be possible to configure LED arrays by Device Tree.
> Initially i was thinking about some kind of extended leds-gpio.c driver
> which will convert brightness value to LED position. But one my friend
> pointed me that metes exist in different configurations and it make no
> sense to bind it to LED framework.
>=20
> Do you have any ideas, suggestions, tips? I know there are lot of user
> space based variants. On other hand kernel already have almost every
> thing what I need.


We could have triggers like "on if value is above X", and then you
could use few of them to implement a meter.

But I guess this would be better done in userspace... Why not do it there?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpMyz4ACgkQMOfwapXb+vKg2ACgtxQ8CUOsZWhW/qSNkZYb6Fse
gHkAoIcT+NOac4gNX91gPWMP/qBRYB5k
=xUFR
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
