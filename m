Return-Path: <vlad.dogaru@intel.com>
Date: Fri, 3 Oct 2014 13:16:19 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH] iio: add bmp280 pressure and temperature driver
Message-ID: <20141003101619.GA17511@vdogaru>
References: <1412278823-10870-1-git-send-email-vlad.dogaru@intel.com>
 <alpine.DEB.2.01.1410022146100.8592@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.01.1410022146100.8592@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 02, 2014 at 10:04:45PM +0200, Peter Meerwald wrote:
<snip>
> > +/*
> > + * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
> > + * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
> > + * value.
> > + *
> > + * Taken from datasheet, Section 3.11.3, "Compensation formula".
> > + */
> > +static s32 bmp280_compensate_temp(struct bmp280_data *data,
> > +				  s32 adc_temp)
> > +{
> > +	s32 var1, var2, T;
> 
> use lowercase t?

I snatched this from the datasheet, which used capital T.  I'll use
lowercase in v2.

<snip>

> > +static int bmp280_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	int ret;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&data->lock);
> 
> locking is only needed for _RAW
> 
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> 
> I think this should be _PROCESSED, not _RAW;
> there is calibration and all kind of scaling done internally

Just to make sure here:  If I use _PROCESSED, I need to apply scale in
kernel space and remove _SCALE, correct?

I will address the rest of your observations in v2, once I get a chance
to test using the device on Monday.

Thank you for the review.
