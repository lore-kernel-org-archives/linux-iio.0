Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 10 Feb 2012 23:47:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/4] staging:iio: Add missing event code extract macros
Message-ID: <20120210204740.GA13116@mwanda>
References: <1328897701-24032-1-git-send-email-lars@metafoo.de>
 <1328897701-24032-3-git-send-email-lars@metafoo.de>
 <20120210204531.GI4141@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <20120210204531.GI4141@mwanda>
List-ID: <linux-iio@vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 11:45:31PM +0300, Dan Carpenter wrote:
> On Fri, Feb 10, 2012 at 07:15:00PM +0100, Lars-Peter Clausen wrote:
> > Add macros for extracting whether the event is for a differential chann=
el and
> > the second channel number from the event code. These were the only two =
fields
> > which did not have such an macro yet.
> >=20
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > ---
> >  drivers/staging/iio/events.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> > index 416800e..c25f0e3 100644
> > --- a/drivers/staging/iio/events.h
> > +++ b/drivers/staging/iio/events.h
> > @@ -97,7 +97,9 @@ enum iio_event_direction {
> >  /* Event code number extraction depends on which type of event we have.
> >   * Perhaps review this function in the future*/
> >  #define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
> > +#define IIO_EVENT_CODE_EXTRACT_CHAN2(mask) ((__s16)(((mask) >> 16) & 0=
xFFFF))
> > =20
> >  #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
> > +#define IIO_EVENT_CODE_EXTRACT_DIFF(mask) (((mask) >> 55) & 0x1)
> > =20
>=20
> Breaks the build.
>=20

Oops.  This isn't a rename.  It doesn't break the build.  Why are
we adding macros which nobody uses?

regards,
dan carpenter


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNYJsAAoJEOnZkXI/YHqRV6MQAIes8/cnvprl2/dDF0gHuGrK
lKOsJOM21jcWuq3rbLOJnrdVCwV7DFQV9lG+7VNMDLB+03D2Qxe6uRGYFebNnVlF
1u8JrjC4b3x1Q8XHZ8NCcnIwbVkp6qpQpWzTP2gqbbxCa+gLPYqSkFGDkE7YF1Hf
d3UAM/KnJBOIv5xuDvQviC2Osa+yApurwOt6qF0CXi6Ts3nl3YMEJU7ajbVogOkt
kfMSPIuDDQjbQCSHSps1obaRdgd+6PYyyqBEntlMBiJkSkOdWnBNT0mJdBKehiwM
+fiBHLkhu73SxvdTi6KkuuTjuVk62/cmn6svcD/iGyb5Xer8gwTlcsQp7CiIo+DV
y0kJzPIsgd8vTNq010G+hnkAq4cyR0D23W+2ZoPpAowrLRaK0XBbHPXPdX0REM3E
YAfiaE1heKdkQue+jNVBNyqGf4Dp9Sh7L3vjAiR/PcT+n3NiEddnPpecerETsaUp
ojAK6tGiL5+d6wlKsfK4TFV3mJMy6oPB8oFjDa/gG7AkagpBwslbSSBuUapBwJGX
/OKg+IMr9b+qBaY848IJPAlepyQhIgT/fqyfDvg5PaAJg3a0jJyfqGTbBVsfNNEf
avZC7QF5GZUR2X6dPCBRnsrKt+XcBvPEGAXkT3W1NEFBctyOvtXBfJHpGTAsBNd8
E3Sr71rdB4lf+iHSR17T
=CY08
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
