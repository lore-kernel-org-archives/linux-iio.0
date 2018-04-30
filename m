Return-Path: <SRS0=ySyy=HT=canonical.com=shrirang.bagul@kernel.org>
Message-ID: <1525077563.10678.3.camel@canonical.com>
Subject: Re: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor
 reads after resume
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date: Mon, 30 Apr 2018 16:39:23 +0800
In-Reply-To: <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
References: <20180430051658.9856-1-shrirang.bagul@canonical.com>
	 <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-5Behnhh449I6agYQ78z+"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


--=-5Behnhh449I6agYQ78z+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Mon, 2018-04-30 at 09:48 +0200, Lorenzo Bianconi wrote:
> > CTRL1 register (ODR & BDU settings) gets reset after system comes back
> > from suspend, causing subsequent reads from the sensor to fail.
> >=20
> > This patch restores the CTRL1 register after resume.
> >=20
>=20
> Hi Shrirang,
>=20
> is just CTRL1 reset after suspend/resume or also other registers? are
I have checked, contents of other registers survive the suspend/resume=20
(both suspend-to-ram & suspend-to-disk)cycle. It's only CTRL1 which resets.
> IIO triggers enabled before the suspend or
No IIO triggers are enabled.
> are you reading data from sysfs?
Yes.
>=20
> > Based on:
> > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-for-4.1=
7b
> >=20
> > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfigu=
ration)
> > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> > ---
> >  drivers/iio/humidity/hts221_core.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/=
hts221_core.c
> > index 166946d4978d..5d7a652aa6d9 100644
> > --- a/drivers/iio/humidity/hts221_core.c
> > +++ b/drivers/iio/humidity/hts221_core.c
> > @@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume(struct de=
vice *dev)
> >         struct hts221_hw *hw =3D iio_priv(iio_dev);
> >         int err =3D 0;
> >=20
> > -       if (hw->enabled)
> > -               err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL=
1_ADDR,
> > -                                        HTS221_ENABLE_MASK,
> > -                                        FIELD_PREP(HTS221_ENABLE_MASK,
> > -                                                   true));
> > -       return err;
> > +       err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> > +                                HTS221_BDU_MASK,
> > +                                FIELD_PREP(HTS221_BDU_MASK, 1));
> > +       if (err < 0)
> > +               return err;
> > +
> > +       return hts221_update_odr(hw, hw->odr);
> >  }
> >=20
>=20
> Here you need to re-enable the sensor if it was running before the
> suspend operation.
> Regards,
>=20
> Lorenzo
>=20
> >  const struct dev_pm_ops hts221_pm_ops =3D {
> > --
> > 2.14.1
> >=20
>=20
>=20
>=20
--=-5Behnhh449I6agYQ78z+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa5tY7AAoJELlj3b/+u+hkvN8P/jXgKk9z9yBQQO73TXb09FL3
3fTegtiY+uWdg1hXfX/FMVmvj6TFN6q+2jKcLQDAbD+AC5K/1CR5qp86dyQMUlyF
XJnMXv5uMRIuG4PEs4UYHfN8+rCzyLwGbDPM0IVyx8X8LBGa63kpkH2l38Mm+f2j
EJzHIJD4uFOVmJiYlulae4NoLyW7MBjn/ZJ8bWwhpwS1B1E+Y7Yz4NcP/kPd1Ei6
Qij9XCF5476pM76Swl+O4h/EL3M3MrvtwBzzmSBxtw4qm5wf8lD5JUNxOyNwZXNp
amGWoA1SzRf0HhpwQkLLeyKxllDbQ8FjyYFETTISWaZc05uAHPzjFG3YO1MbMxHh
FX2CLc85O/nU1qi2HrK8AaR4qVxQH0OXTfJ+sz8/bLnj9U/xwE1AfLdRJ+a57D8r
wmxLBQnHm/3NCx8GUIHXs0hLeplx86Ab9AN6JufIlAiHQGrRlm4Z0gB69lmOkbjJ
7sa/yayW7OqYNQ8oHeUZSw50jBdzv/4HUM6L6NrRMxq2OA3K2dUWZ11JbimBOSBE
h4FN8P/PdyGvc7XEwAS8jREFnuqT8utGelTfZ6gms7P+qFTz45yD2rK2WHAyxyoT
yFWn6FddXSpDQb3S1g8dFdsVJZ3rw+ZFhTZlxVqwAX7cIsVgyhm9yNLp6AjHFDP6
ZwdeagxUJ1H5UVyPAgBC
=NaYG
-----END PGP SIGNATURE-----

--=-5Behnhh449I6agYQ78z+--
