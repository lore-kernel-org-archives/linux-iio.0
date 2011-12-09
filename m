Return-Path: <jbrenner@TAOSinc.com>
Subject: Re: [PATCH v2] iio: light sensor: Improve granularity of tsl2583
 lux values.
From: Jon Brenner <jbrenner@taosinc.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Bryan Freed <bfreed@chromium.org>, linux-iio@vger.kernel.org,
 jic23@cam.ac.uk, gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <4EDBAC7F.50001@kernel.org>
References: <1322864370-15126-1-git-send-email-bfreed@chromium.org>
	 <4EDBAC7F.50001@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Dec 2011 10:29:56 -0600
Message-ID: <1323448196.14301.4.camel@jonz-ub2>
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


Acked-by: Jon Brenner <jbrenner@taosinc.com>

On Sun, 2011-12-04 at 17:23 +0000, Jonathan Cameron wrote:
> On 12/02/2011 10:19 PM, Bryan Freed wrote:
> > When illuminance0_calibbias gets 4000 (for a 4x multiplier), we see lux
> > granularity of 4.  Reversing the order of the right shift and multiplic=
ation
> > retains the precision of the unadjusted lux value.
> Looks sensible to me, but having said that, Greg, please leave a little
> while for Jon Brenner to get to it as he clearly knows this driver
> a lot better than me!
> >=20
> > Signed-off-by: Bryan Freed <bfreed@chromium.org>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> > ---
> >  drivers/staging/iio/light/tsl2583.c |   17 ++++++++++++++---
> >  1 files changed, 14 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/=
light/tsl2583.c
> > index 80f77cf..25f4c1d 100644
> > --- a/drivers/staging/iio/light/tsl2583.c
> > +++ b/drivers/staging/iio/light/tsl2583.c
> > @@ -194,6 +194,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
> >  {
> >  	u16 ch0, ch1; /* separated ch0/ch1 data from device */
> >  	u32 lux; /* raw lux calculated from device data */
> > +	u64 lux64;
> >  	u32 ratio;
> >  	u8 buf[5];
> >  	struct taos_lux *p;
> > @@ -297,9 +298,19 @@ static int taos_get_lux(struct iio_dev *indio_dev)
> >  		lux =3D (lux + (chip->als_time_scale >> 1)) /
> >  			chip->als_time_scale;
> > =20
> > -	/* adjust for active gain scale */
> > -	lux >>=3D 13; /* tables have factor of 8192 builtin for accuracy */
> > -	lux =3D (lux * chip->taos_settings.als_gain_trim + 500) / 1000;
> > +	/* Adjust for active gain scale.
> > +	 * The taos_device_lux tables above have a factor of 8192 built in,
> > +	 * so we need to shift right.
> > +	 * User-specified gain provides a multiplier.
> > +	 * Apply user-specified gain before shifting right to retain precisio=
n.
> > +	 * Use 64 bits to avoid overflow on multiplication.
> > +	 * Then go back to 32 bits before division to avoid using div_u64().
> > +	 */
> > +	lux64 =3D lux;
> > +	lux64 =3D lux64 * chip->taos_settings.als_gain_trim;
> > +	lux64 >>=3D 13;
> > +	lux =3D lux64;
> > +	lux =3D (lux + 500) / 1000;
> >  	if (lux > TSL258X_LUX_CALC_OVER_FLOW) { /* check for overflow */
> >  return_max:
> >  		lux =3D TSL258X_LUX_CALC_OVER_FLOW;
>=20
