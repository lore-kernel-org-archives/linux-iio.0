Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 10 Jul 2012 23:29:51 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH v4] iio: add adjd_s311 I2C digital color sensor driver
In-Reply-To: <4FF9513A.3030205@kernel.org>
Message-ID: <alpine.DEB.2.01.1207102319290.19634@pmeerw.net>
References: <1341265402-1617-1-git-send-email-pmeerw@pmeerw.net> <4FF9513A.3030205@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> As stated above, I can't immediately see any real advantage to
> doing this allocation dynamically.
> > +static int adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
> > +	const unsigned long *scan_mask)
> > +{
> > +	struct adjd_s311_data *data = iio_priv(indio_dev);
> > +	data->buffer = krealloc(data->buffer, indio_dev->scan_bytes,
> > +				GFP_KERNEL);
> > +	if (!data->buffer)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}

one problem is to compute the maximum buffer size; for this driver it is 
easy: 4*2 + padding + timestamp -- padding turns out to be 0 assuming the 
padding rule is set in stone; I think IIO core should do that computation

iio_compute_scan_bytes() is not directly callable; I'd rather keep this as 
is

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
