Return-Path: <shubhrajyoti@ti.com>
From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
To: Jonathan Cameron <jic23@cam.ac.uk>,
        Manuel Stahl
	<manuel.stahl@iis.fraunhofer.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 31 Aug 2010 17:46:31 +0530
Subject: RE: [PATCH 3/3] staging:iio:hmc5843 change ABI to comply with
 documentation
Message-ID: <0680EC522D0CC943BC586913CF3768C003C1CA4BC2@dbde02.ent.ti.com>
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <1283177032-7014-3-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <4C7BC70E.6090901@cam.ac.uk>
In-Reply-To: <4C7BC70E.6090901@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> Sent: Monday, August 30, 2010 8:28 PM
> To: Manuel Stahl
> Cc: linux-iio@vger.kernel.org; Datta, Shubhrajyoti
> Subject: Re: [PATCH 3/3] staging:iio:hmc5843 change ABI to comply with
> documentation
>=20
> This one would benefit from an ack from Shubhrajyoti Datta (cc'd)
>=20
Looks good to me feel free to add my appreciations/ack
Thanks for the patch.
> It's his driver and whilst to my eye this looks fine it would
> be good to have his input on the scale numbers.
>=20
> If he doesn't reply for a bit send it on anyway ;)  (as it is
> fairly trivial)
>=20
> I actually promised to fix this myself in the original review
> but I'm happy you beat me to it ;)
>=20
> One issue inline...  Fix that and feel free to add my sign-off.
>=20
> Thanks,
>=20
> Jonathan
>=20
> On 08/30/10 15:03, Manuel Stahl wrote:
> > Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>=20
> > ---
> >  drivers/staging/iio/magnetometer/hmc5843.c |   32 ++++++++++++++------=
-
> -------
> >  1 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/staging/iio/magnetometer/hmc5843.c
> b/drivers/staging/iio/magnetometer/hmc5843.c
> > index 92f6c6f..66aab5a 100644
> > --- a/drivers/staging/iio/magnetometer/hmc5843.c
> > +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> > @@ -95,15 +95,15 @@
> >  #define	CONF_NOT_USED				0x03
> >  #define	MEAS_CONF_MASK				0x03
> >
> > -static const int regval_to_counts_per_mg[] =3D {
> > -	1620,
> > -	1300,
> > -	970,
> > -	780,
> > -	530,
> > -	460,
> > -	390,
> > -	280
> > +static const char *regval_to_scale[] =3D {
> > +	"0.0000006173",
> > +	"0.0000007692",
> > +	"0.0000010309",
> > +	"0.0000012821",
> > +	"0.0000018868",
> > +	"0.0000021739",
> > +	"0.0000025641",
> > +	"0.0000035714",
> >  };
> >  static const int regval_to_input_field_mg[] =3D {
> >  	700,
> > @@ -322,7 +322,7 @@ static IIO_DEVICE_ATTR(meas_conf,
> >   * 6		| 50
> >   * 7		| Not used
> >   */
> > -static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("0.5 1 2 5 10 20 50");
> > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 10 20 50");
> >
> >  static s32 hmc5843_set_rate(struct i2c_client *client,
> >  				u8 rate)
> > @@ -459,17 +459,17 @@ static IIO_DEVICE_ATTR(magn_range,
> >  			set_range,
> >  			HMC5843_CONFIG_REG_B);
> >
> > -static ssize_t show_gain(struct device *dev,
> > +static ssize_t show_scale(struct device *dev,
> >  			struct device_attribute *attr,
> >  			char *buf)
> >  {
> >  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct hmc5843_data *data =3D indio_dev->dev_data;
> > -	return sprintf(buf, "%d\n", regval_to_counts_per_mg[data->range]);
> > +	return strlen(strcpy(buf, regval_to_scale[data->range]));
>=20
> That leaves us without a trailing "\n".  Makes for messy use of cat ;)
> Probably easier to use
>=20
> return sprintf(buf, "%s\n", regval_to_scale[data->range]);
> >  }
> > -static IIO_DEVICE_ATTR(magn_gain,
> > +static IIO_DEVICE_ATTR(magn_scale,
> >  			S_IRUGO,
> > -			show_gain,
> > +			show_scale,
> >  			NULL , 0);
> >
> >  static struct attribute *hmc5843_attributes[] =3D {
> > @@ -477,11 +477,11 @@ static struct attribute *hmc5843_attributes[] =3D=
 {
> >  	&iio_dev_attr_operating_mode.dev_attr.attr,
> >  	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> >  	&iio_dev_attr_magn_range.dev_attr.attr,
> > -	&iio_dev_attr_magn_gain.dev_attr.attr,
> > +	&iio_dev_attr_magn_scale.dev_attr.attr,
> >  	&iio_dev_attr_magn_x_raw.dev_attr.attr,
> >  	&iio_dev_attr_magn_y_raw.dev_attr.attr,
> >  	&iio_dev_attr_magn_z_raw.dev_attr.attr,
> > -	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> >  	NULL
> >  };
> >
