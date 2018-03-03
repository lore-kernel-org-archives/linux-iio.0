Return-Path: <SRS0=etB7=FZ=gmail.com=shreeya.patel23498@kernel.org>
Message-ID: <1520091212.3137.1.camel@gmail.com>
Subject: Re: [PATCH 5/6] Staging: iio: adis16209: Add some informatic
 comments
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Date: Sat, 03 Mar 2018 21:03:32 +0530
In-Reply-To: <20180303160155.67113206@archlinux>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
	 <11a9db0dda77749c865e864c81924c0ec578dd86.1519995673.git.shreeya.patel23498@gmail.com>
	 <20180303160155.67113206@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2018-03-03 at 16:01 +0000, Jonathan Cameron wrote:
> On Fri,  2 Mar 2018 19:02:48 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
> > 
> > Some of the register names does not make it's puporse
> > very clear and hence, add some comments for more
> > information.
> > Also there are certain unit based comments which are not
> > providing sufficient information, so expand those comments.
> Ah - serves me right for not reading on before commenting on the
> previous
> patch.  It would have been preferable to have merged at least some of
> this
> in there as they needed to be read together.
> 
> One comment in here doesn't quite cover everything I think should
> be explained.
> 
> Please fix that and merge this down with the previous patch
> (interactive rebase and marking it as a fixup makes this easy).
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> >  drivers/staging/iio/accel/adis16209.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/accel/adis16209.c
> > b/drivers/staging/iio/accel/adis16209.c
> > index d2d1254..7363fd0 100644
> > --- a/drivers/staging/iio/accel/adis16209.c
> > +++ b/drivers/staging/iio/accel/adis16209.c
> > @@ -27,13 +27,18 @@
> >  #define ADIS16209_SUPPLY_OUT_REG	0x02
> >  #define ADIS16209_XACCL_OUT_REG		0x04
> >  #define ADIS16209_YACCL_OUT_REG		0x06
> > +/* Output, auxiliary ADC */
> >  #define ADIS16209_AUX_ADC_REG		0x08
> > +/* Output, temperature */
> >  #define ADIS16209_TEMP_OUT_REG		0x0A
> > +/* Output, +/- 90 degrees X-axis inclination */
> >  #define ADIS16209_XINCL_OUT_REG		0x0C
> >  #define ADIS16209_YINCL_OUT_REG		0x0E
> >  #define ADIS16209_ROT_OUT_REG		0x10
> >  
> > -/* Calibration Register Definitions */
> > +/* Calibration Register Definitions.
> > + * Acceleration, inclination or rotation offset null.
> > + */
> >  #define ADIS16209_XACCL_NULL_REG	0x12
> >  #define ADIS16209_YACCL_NULL_REG	0x14
> >  #define ADIS16209_XINCL_NULL_REG	0x16
> > @@ -155,19 +160,29 @@ static int adis16209_read_raw(struct iio_dev
> > *indio_dev,
> >  			*val2 = 0;
> >  			return IIO_VAL_INT_PLUS_MICRO;
> >  		case IIO_ACCEL:
> > +			/*
> > +			 * IIO base unit for sensitivity of
> > accelerometer
> > +			 * is milligram.
> > +			 * 1 LSB represents 0.244 milligrams.
> Not miligrams. Milli g where 1 g is the 'standard' acceleration due
> to gravity.

Ah!!
Should have used my common sense here :(
Sorry for such mistake.

> 
> > 
> > +			 */
> >  			*val = 0;
> > -			*val2 = IIO_G_TO_M_S_2(244140); /*
> > 0.244140 mg */
> > +			*val2 = IIO_G_TO_M_S_2(244140);
> >  			return IIO_VAL_INT_PLUS_NANO;
> >  		case IIO_INCLI:
> >  		case IIO_ROT:
> > +			/*
> > +			 * IIO base units for rotation are
> > degrees.
> > +			 * 1 LSB represents 0.025 milli degrees.
> > +			 */
> >  			*val = 0;
> > -			*val2 = 25000; /* 0.025 degree */
> > +			*val2 = 25000;
> >  			return IIO_VAL_INT_PLUS_MICRO;
> >  		default:
> >  			return -EINVAL;
> >  		}
> >  		break;
> >  	case IIO_CHAN_INFO_OFFSET:
> > +		/* TEMP_OUT_REG has a scale factor of -0.47
> > degrees celcius. */
> This doesn't explain the magic 0x4FE so that needs doing as well.
> 
> > 
> >  		*val = 25000 / -470 - 0x4FE;
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_CALIBBIAS:
