Return-Path: <shubhrajyoti@ti.com>
From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 6 Sep 2010 12:19:08 +0530
Subject: RE: [PATCH] iio: hmc5843 : trivial changes to the way scale is
 reported
Message-ID: <0680EC522D0CC943BC586913CF3768C003C2018420@dbde02.ent.ti.com>
References: <1283508448-19664-1-git-send-email-shubhrajyoti@ti.com>
 <4C826D71.7050405@cam.ac.uk>
In-Reply-To: <4C826D71.7050405@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> Sent: Saturday, September 04, 2010 9:32 PM
> To: Datta, Shubhrajyoti
> Cc: linux-iio@vger.kernel.org
> Subject: Re: [PATCH] iio: hmc5843 : trivial changes to the way scale is
> reported
>=20
> On 09/03/10 11:07, Shubhrajyoti D wrote:
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>=20
> Thanks.
> Please forward to Greg KH <greg@kroah.com>
> (or I can add it to my next series if you prefer.)
>=20
Ya thanks feel free to take line it in the next series.
> Jonathan
> > ---
> >  drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/staging/iio/magnetometer/hmc5843.c
> b/drivers/staging/iio/magnetometer/hmc5843.c
> > index 66aab5a..b35b443 100644
> > --- a/drivers/staging/iio/magnetometer/hmc5843.c
> > +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> > @@ -465,7 +465,7 @@ static ssize_t show_scale(struct device *dev,
> >  {
> >  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct hmc5843_data *data =3D indio_dev->dev_data;
> > -	return strlen(strcpy(buf, regval_to_scale[data->range]));
> > +	return sprintf(buf, "%s\n", regval_to_scale[data->range]);
> >  }
> >  static IIO_DEVICE_ATTR(magn_scale,
> >  			S_IRUGO,
