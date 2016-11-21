Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:33787 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753700AbcKUWy0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Nov 2016 17:54:26 -0500
Date: Mon, 21 Nov 2016 23:54:24 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: David Lechner <david@lechnology.com>
cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: New driver for TI ADS7950 chips
In-Reply-To: <d1d05bf8-f4e7-0bf1-66a7-56683cb69d65@lechnology.com>
Message-ID: <alpine.DEB.2.02.1611212350550.15526@pmeerw.net>
References: <1479666484-2582-1-git-send-email-david@lechnology.com> <d1d05bf8-f4e7-0bf1-66a7-56683cb69d65@lechnology.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > +static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       int *val, int *val2, long m)
> > +{
> > +	struct ti_ads7950_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (m) {
> > +	case IIO_CHAN_INFO_RAW:
> > +
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = ti_ads7950_scan_direct(st, chan->address);
> > +		iio_device_release_direct_mode(indio_dev);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (chan->address != TI_ADS7950_EXTRACT(ret, 12, 4))
> > +			return -EIO;
> > +
> > +		*val = TI_ADS7950_EXTRACT(ret, 0, 12);
> 
> I'm not sure if I am doing this right. There are 8- 10- and 12-bit versions of
> this chip. The 8- and 10-bit versions still return a 12-bit number where the
> last 4 or 2 bits are always 0. Should I be shifting the 12-bit value here
> based on the chip being used so that *val is 0-255 for 8-bit and 0-1023 for
> 10-bit? Or should this be *really* raw and not even use TI_ADS7950_EXTRACT()
> to mask the channel address bits?

I'd shift and adjust _SCALE so that *val * scale gives mV
 
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		ret = ti_ads7950_get_range(st);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = ret;
> > +		*val2 = chan->scan_type.realbits;
> > +
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	}
> > +
> > +	return -EINVAL;
> > +}

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
