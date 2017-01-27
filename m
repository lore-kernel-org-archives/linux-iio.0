Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34696 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdA0UES (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 15:04:18 -0500
Date: Fri, 27 Jan 2017 21:02:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Loic Poulain <loic.poulain@intel.com>,
        NeilBrown <neil@brown.name>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: GPS drivers (was Re: [PATCH v2 0/9] Serial slave device bus)
Message-ID: <20170127200222.GF20571@amd>
References: <20170116225436.17505-1-robh@kernel.org>
 <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
 <20170120142242.GC5241@amd>
 <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
 <1484928971.2133.273.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
In-Reply-To: <1484928971.2133.273.camel@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-01-20 18:16:11, Andy Shevchenko wrote:
> On Fri, 2017-01-20 at 16:26 +0100, Linus Walleij wrote:
>=20
> > > Now, NMEA knows about some of the complexity (not AGPS), but gets
> > > the
> > > details wrong. In particular, it would be good to have error
> > > estimates
> > > and velocities from the same moment you get position estimates.
> >=20
> > NMEA if it is this:
> > https://en.wikipedia.org/wiki/NMEA_0183
> >=20
> > Seems to be a high-level format such as XML or CSV or any other
> > $FAVOURITE_ASCII_TRANSPORT format.
>=20
> Not exactly. It depends on device settings.
> Old GPS I used to play with have AT command to switch between ASCII and
> binary format. Some of the devices might use non-standard binary
> protocols (however, representable as NMEA), etc.

Apparently NMEA has some serious limitations. gpsd authors have some
good docs about that.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLp04ACgkQMOfwapXb+vJJ6QCfeLvNm8AIS/6hE+MKowxarVxh
V1sAoK0XVkZDRCEkyG1SG/EcJ9o1gKAp
=4GUX
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
