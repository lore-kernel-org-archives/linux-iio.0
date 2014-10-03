Return-Path: <pmeerw@pmeerw.net>
Date: Fri, 3 Oct 2014 16:44:17 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Vlad Dogaru <vlad.dogaru@intel.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH] iio: add bmp280 pressure and temperature driver
In-Reply-To: <20141003101619.GA17511@vdogaru>
Message-ID: <alpine.DEB.2.01.1410031641190.17977@pmeerw.net>
References: <1412278823-10870-1-git-send-email-vlad.dogaru@intel.com> <alpine.DEB.2.01.1410022146100.8592@pmeerw.net> <20141003101619.GA17511@vdogaru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> > > +static int bmp280_read_raw(struct iio_dev *indio_dev,
> > > +			   struct iio_chan_spec const *chan,
> > > +			   int *val, int *val2, long mask)
> > > +{
> > > +	int ret;
> > > +	struct bmp280_data *data = iio_priv(indio_dev);
> > > +
> > > +	mutex_lock(&data->lock);
> > 
> > locking is only needed for _RAW
> > 
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > 
> > I think this should be _PROCESSED, not _RAW;
> > there is calibration and all kind of scaling done internally
> 
> Just to make sure here:  If I use _PROCESSED, I need to apply scale in
> kernel space and remove _SCALE, correct?

yes

since pressure is using a temperature read and calibration data, it hardly 
qualifies as 'raw'

> I will address the rest of your observations in v2, once I get a chance
> to test using the device on Monday.
> 
> Thank you for the review.

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
