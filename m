Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Tue, 31 Jan 2012 11:09:35 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	greg@kroah.com, guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 5/5] stargate2: example of map configuration for iio to
 hwmon example.
Message-ID: <20120131110935.GA18444@opensource.wolfsonmicro.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
 <1327837614-24176-6-git-send-email-jic23@kernel.org>
 <20120130193350.GA9672@opensource.wolfsonmicro.com>
 <4F26FCE2.1030705@kernel.org>
 <20120130212253.GC9672@opensource.wolfsonmicro.com>
 <CACRpkdbeMWRwJtUVT5xS7FrsvPZg4tSCVQq6eh9JAjq6_3QYQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
In-Reply-To: <CACRpkdbeMWRwJtUVT5xS7FrsvPZg4tSCVQq6eh9JAjq6_3QYQg@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 09:39:31AM +0100, Linus Walleij wrote:
> On Mon, Jan 30, 2012 at 10:22 PM, Mark Brown

> > You avoid user confusion from having two ways of doing the same thing
> > and you save a little complexity in the implementation. =A0The user
> > confusion does happen in practice.

> So I guess this pattern comes from the regulator framework
> struct regulator_consumer_supply design pattern initially.

Yes, and the only reason the regulator API does this is historical.

> But we should then try to rid it from the kernel at large, no big deal,
> I have only one in-kernel user of this ATM I think so I can kill it off f=
rom
> the pin control API if you think you can kill it from regulators.

Well volunteered :)

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJ8vaAAoJEBus8iNuMP3dPNgP/RkvYKBHQrCU7V+jHPwUw/Nm
g6IMpJV4z1DBetk4UGeMoUNcuYw6EGhGoQoubeZYaBh5NtLrxV0GrQORP2gFj3GT
qcx8TQ60TzCvV49DaKM60tiFhKeYesFHcgdgftmYN3pNfTaFo05CTeuBdmosBSli
/PpyaOaUdmKGHLpOzoR6RKqBeeXeTGPGFL487DrUsfCcYezmbawsuBxi/4JSs7hX
CyvSX7aEAs2to4EkSWOofG6vRSC/qpAU1bYuxQPSHNGgz55Mhp5BGnidRh95B6cM
UPsDVIWqYqqRbBEm5l/pQB7z4gpZEswr82GyjQZ0jbXKDlxQsRDUOTvhq2RYjQcx
Tnp/uB3rsXACNzBGiy7+nG7sbVonsu6/Pd+xCU586NvwlGo4yTF9SyRRC7P/eHED
YBHXsDcrH0uBqrx1IDxxeAS5tF/m0O99SS5y6jGMDZBCADXcenzFKGXX9okf8FJi
KXP43ecGslLvUxzfwJC1u1KYuCa3bs+32Kotor+AdRNIpuLp3Q9jeReJeniqK+54
uBwtXGpVN0QNqD+RuqeHUOIxE+5j6wr1jJd2AfzWymYT5LuULzEIq635gvFpqtIL
+7FktrZN/wzlJcgTTvHHjnsRXnrmyRHyxug413MadIh5NEN+jMI/+CoXOSLxIkan
KtAnH38EnaA0+qVGhTPM
=eaeS
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
