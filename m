Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55893 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbcDQM0C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 17 Apr 2016 08:26:02 -0400
Date: Sun, 17 Apr 2016 14:25:49 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Rosin <peda@lysator.liu.se>
Subject: Re: [RFC] iio: st: Add lsm9ds0 support for gyro accel and magn
Message-ID: <20160417122548.GA4954@katana>
References: <2bcce23e64d53f542a9436b11509b107d63cb8dc.1460573498.git.leonard.crestez@intel.com>
 <57137732.40507@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
In-Reply-To: <57137732.40507@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> To bring you two up to date, we have effectively two separate devices
> (very nearly) sat behind a single i2c address.  They have non overlapping
> register maps.

I think the MFD subsystem should have a few multifunction I2C devices
handled already. You migh get ideas there. Never needed it myself yet,
though.


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXE4DMAAoJEBQN5MwUoCm2FKQP/38O58yVUOfkSwVkjZbQk1OU
gGP86q/vDiAvHbIJQ7E4G9mHO9VXkLeXGdVewCqJYw5QE/p/8qBmqV3/EwanKpvv
6aWu2Zhgg1pVb9Xc/GFsgQV5SqBFxuFNouZUfRvy0k0bKRD4gdUafA0SI8Zag3wB
h0rWUOAF0SmL4dYEPy6+y9HIsmC78upJn9kBUkvHS7J7Jf0h313kxEvhYbY/2qPx
7jU2Ir7xKh/r2mXKt0BhtgxoHvjkxMYU0ncVYfjeSXmdq3HroZd9rWKCC5LkSPNQ
WR1IPR/LiQSOCQJRXA8qBLLyqvBlBcX82LUYd4gURP57xPMLjZnMMuzVDWnxuNKv
8DzD0SJsZy59IwI92V1+Cl95ifgUcnLdz7xWkU4dZMOf7RsWl8iAg160rV3V9E/l
tg1+wCvklHYibvzBuZqC4L6scX80+WbgS9jaDB6JlIMaLcnpy6tWXNhTQ6GIeZpM
c/snxEC1ca4P41AgtAoqymSJHSwBdiTTLGekzXG11EHhZYkUDxu9A2o3rjIqAfV+
4E1UxrPXym4IfWbqKNRSQCFi6oYOkF0iP7rwLcHmkcvQfuebm62Aj/u+aNEyS5Pn
pS5DtjKBBQk0cdDrUPS9gUZ87KwZbZFmuXUMdIYDBtz0NJbmzTnFTulyFaGSMb93
uajpt6f4zGLlcO6D5Rrk
=YbAu
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
