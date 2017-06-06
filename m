Return-Path: <sre@kernel.org>
Date: Tue, 6 Jun 2017 10:23:40 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/7] twl4030-madc cleanup
Message-ID: <20170606082340.spij6xnhxp56sotw@earth>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170520165450.aet2oekjakzorcw3@earth>
 <2c9e59f1-6bf9-bdd8-eb03-4e46e5333883@kernel.org>
 <20170603104330.17a87ec0@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfjk3jdppcthfyw5"
In-Reply-To: <20170603104330.17a87ec0@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--lfjk3jdppcthfyw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Jun 03, 2017 at 10:43:30AM +0100, Jonathan Cameron wrote:
> On Sat, 20 May 2017 18:57:39 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On 20/05/17 17:54, Sebastian Reichel wrote:
> > >> Here are a few cleanup patches for the twl4030-madc
> > >> driver, that remove the last users of the driver's
> > >> legacy API and then remove it.
> > >>
> > >> Sebastian Reichel (7):
> > >>    hwmon: twl4030-madc: drop driver
> > >>    power: supply: avoid unused twl4030-madc.h
> > >>    iio: adc: twl4030: Drop twl4030_get_madc_conversion()
> > >>    iio: adc: twl4030: Unexport twl4030_madc_conversion()
> > >>    iio: adc: twl4030: Drop struct twl4030_madc_user_parms
> > >>    iio: adc: twl4030: Remove twl4030_madc_request.func_cb
> > >>    iio: adc: twl4030: Fold twl4030-madc.h into driver =20
> > >=20
> > > Just a reminder, that patch 1 & 2 have been merged into 4.12-rc1
> > > and Wolfram acked the changes to header in include/linux/i2c,
> > > so patch 3-7 can be queued by iio for 4.13 :)
> > >=20
> > > -- Sebastian
> > >  =20
> > Thanks for the reminder.  I'll have to wait until I've fast
> > forwarded my togreg branch of iio.git (possibly a week or
> > so) as I have a lot of stuff queued up from prior to and
> > during the merge window.  That'll pull in the driver drop at
> > which point the rest should go in nicely.
> >=20
> > Anyhow, please feel free to remind me again if I look
> > like I've forgotten this after the fast forward merge has
> > occurred.
> >=20
> All now applied

Thanks. I assume you also applied patch 6/7 and just did not reply to
it? I would have checked myself, but as far as I can see you did not
yet update togreg branch on git.kernel.org [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=3D=
togreg

-- Sebastian

--lfjk3jdppcthfyw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk2ZokACgkQ2O7X88g7
+ppD0w//eFm49QMuJ5RW7G1dLCs5hNPuUSc2Bs8q+e1bjYTke8ljiCGgRBndtY/E
K8siRFPvborpW1W2V0DHHyk7ScOJlm2P/rZw+cNZSwf1Wa195TYEhNR5qnsU4GvR
vstn0vngEOAZCXRH1Ij+DiZzKv8ScwFKP+l6qWjy6HtCIOVsWhCI4LXlYagCgVKU
A/6nqBdf5Z6Vv74lQ7zFXeFifHLUp4NKfdTGpGW7pmgCeNk09f3NMkW7cKhirRi9
/U5zAmVLNsU/jsNefHmW92etnJTBYt7EPuzaqa2eCgKSd1uictVBOOfcZPjqMQ+G
n223/88ltK3tm//57f9q4gu3GvlA6OIbhaJmE2j0IpmBBvXk7jdJcsRiHtnkG1mf
NENlNYqcyEOtGieFzlduBFpAyXLYkL1BjSEt/QBUJ6MnO6o5mcHZLjXQD6Jo1a75
TtrIAIhtsIHuFre5ZZQYrzTC6UjoKPL/f3CI5JhAQxOdcf8dYE5rlxX5kod/EiVt
JCeX5Ucm5UVlNphwmZrKvSZ0Sw3MM5C559kCdIkEsjiJd8VQSBLAGv1GzUSsLh/H
eyKTzjMrejRfrx+1IqR9gBiwxAasSQ9NDAWYCa/TUjIt+mM5cpMwlbuPHWamg8Hm
Ggs4Kk3Lspp/sl+OJefHUMPD1qej6rF6kyouwRUXYXZj8uKOXHk=
=rC0O
-----END PGP SIGNATURE-----

--lfjk3jdppcthfyw5--
