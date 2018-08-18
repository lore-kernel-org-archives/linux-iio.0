Return-Path: <SRS0=xbG5=LB=gmail.com=marcus.folkesson@kernel.org>
Date: Sat, 18 Aug 2018 17:34:40 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20180818153416.GA3543@gmail.com>
References: <20180815163852.GA4910@embeddedor.com>
 <20180815172700.GA29039@gmail.com>
 <64cccc17-ebfe-205a-6b2c-2a72aae765b0@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
In-Reply-To: <64cccc17-ebfe-205a-6b2c-2a72aae765b0@embeddedor.com>
List-ID: <linux-iio@vger.kernel.org>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gutavo,

Sorry for the delay.

On Wed, Aug 15, 2018 at 12:50:10PM -0500, Gustavo A. R. Silva wrote:
> Hi Marcus,
>=20
> On 8/15/18 12:27 PM, Marcus Folkesson wrote:
> > Hi,
> >=20
> > On Wed, Aug 15, 2018 at 11:38:52AM -0500, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> >> where we are expecting to fall through.
> >>
> >> Addresses-Coverity-ID: 1462408 ("Missing break in switch")
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/ac=
cel/cros_ec_accel_legacy.c
> >> index 063e89e..d609654 100644
> >> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> >> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> >> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct plat=
form_device *pdev)
> >>  		switch (i) {
> >>  		case X:
> >>  			ec_accel_channels[X].scan_index =3D Y;
> >> +			/* fall through */
> >>  		case Y:
> >>  			ec_accel_channels[Y].scan_index =3D X;
> >> +			/* fall through */
> >>  		case Z:
> >>  			ec_accel_channels[Z].scan_index =3D Z;
> >>  		}
> >=20
> > Hum, I'm not sure we are supposed to fall through here, even if it does
> > not hurt to do so.
>=20
> Yeah. You're right. It doesn't hurt but is actually redundant. I think
> the original intention was to break instead of falling through.
>=20
> > I even think we can remove the switch and put that outside the for-loop,
> > e.g:
> >=20
> > 	ec_accel_channels[X].scan_index =3D Y;
> > 	ec_accel_channels[Y].scan_index =3D X;
> > 	ec_accel_channels[Z].scan_index =3D Z;
> >=20
> > 	for (i =3D X ; i < MAX_AXIS; i++) {
> > 		if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID && i !=3D Y)
> > 			state->sign[i] =3D -1;
> > 		else
> > 			state->sign[i] =3D 1;
> > 	}
> >=20
>=20
> I like this, but the code clearly depends on MAX_AXIS. So, if MAX_AXIS
> will be always 3, then the change you suggest is just fine. Otherwise,
> it seems that adding a break to each case is the right way to go.
>=20
> What do you think?

Well, I guess it is a matter of taste after all.
I don't think the number of axis will change, but just put the break in
place is good enough.

Anyway, If we choose to not use the switch, I think we should remove the
for-loop as well, eg:

	ec_accel_channels[X].scan_index =3D Y;
	ec_accel_channels[Y].scan_index =3D X;
	ec_accel_channels[Z].scan_index =3D Z;

	if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID) {
		state->sign[X] =3D -1;
		state->sign[Y] =3D 1;
		state->sign[Z] =3D -1;
	} else {
		state->sign[X] =3D 1;
		state->sign[Y] =3D 1;
		state->sign[Z] =3D 1;
	}

But someone else may like to give their point of view on this change.

>=20
> Thanks for the feedback.
> --
> Gustavo

Best regards
Marcus Folkesson

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt4PIwACgkQiIBOb1ld
UjLo7w//dweWmx/iH5AtCG4H8NpYy69PjgwBEayWNZtvQRLNq/vh4vUOWerkE+fQ
VprzIrn7rDki3ggrm1Sl7sO4pd0YCsxDw+ug+WjvgnYlc2sYqUw9yCnoirvDy2UR
7FTs5eAlt3zDwUGugwr6Xfb6utGlDu+pQ9gltaArc3hpk0xvSTiJiOhd+Se6NmWf
6171D+13WcWXO2i4FWK8N5B33TP/j4NDlnCvdzZ/Mp5sUW7RXq1zTx6CyxbETQKA
s2a4zgfv7V1C53Emxk0T7X/T9fNpniQDpNCoYjtTaeJuGmozt3M8gUh1k09IUYCr
yIrCB4y6ORipJV8NRjR4hMW2COxVOifvAUmsaFdV4Uyw2vnh9qgBtqMJLWyLEb2e
z3yQX5wMLIxB+lBnY+dczvSvn7ciUMrvPrIydhkPjWPkSP2FwdRMeGvWXjdkV7qX
/Qr51++Ux4+NINEOQbvVawsolpVyMbH5h7SQQ50MR+nsY9rV7D6V/IU70oM3j11K
98zgz2EzCgWKh5orBvbo5TtKmJhe+g28sca3W8Jeqv25dJ7etIuiutUvkhzz1OvT
ul8C4c2vi4HNGFba3YemenDaiZovMp/2LXNEspN4YFBIwaDd28N8ofhJKCzL6Vxl
VTEt5EUnYxRHoXB3wuiCCOfSBIecQKOK/2V0t73tLnHdV5ujVsg=
=XOY9
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
