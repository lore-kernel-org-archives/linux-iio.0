Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48790 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbdC0IcX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 04:32:23 -0400
Date: Mon, 27 Mar 2017 10:30:29 +0200
From: jacopo <jacopo@jmondi.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, lars@metafoo.de,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: Add Maxim max9611 ADC driver
Message-ID: <20170327083029.GA21392@w540>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
 <1490369323-13866-4-git-send-email-jacopo+renesas@jmondi.org>
 <a911f5d1-e019-772f-0889-849cf42e6827@kernel.org>
 <alpine.DEB.2.20.1703251706420.25208@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.DEB.2.20.1703251706420.25208@vps.pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan, Peter,

On Sat, Mar 25, 2017 at 05:13:38PM +0100, Peter Meerwald-Stadler wrote:
> 
> On Sat, 25 Mar 2017, Jonathan Cameron wrote:
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		mutex_lock(&dev->lock);
> > > +
> > > +		switch (chan->address) {
> > > +		case MAX9611_CHAN_TEMPERATURE:
> > > +			ret = max9611_read_single(dev, CONF_TEMP,
> > > +						  &adc_data);
> > > +			if (ret)
> > I'm not personally keen on jumping out of deep indentations like this
> > just save on repeating one line.  I'd pull the unlock back here and return
> > directly as I feel it'll improve readability.
> > Actually come to think of it, why does the lock need to be held for
> > the next line anyway?  adc_data is on the stack so doesn't matter if we
> > have concurrent readers, once the i2c transaction is finished.
> > Just unlock before checking ret.

[snip]

> > > +
> > > +			mutex_unlock(&dev->lock);
> > > +			return IIO_VAL_INT;
> > > +		}
> > > +
> 
> this falls through, no break?
> 
> I'd move
>                 mutex_unlock(&dev->lock);
>                 return IIO_VAL_INT;
> here
> 

On the two comments above: re-thinking on this a bit, the only part
that actually needs protection is gain selection routine, which
depends on consecutive reads of what is returned from the ADC bus.

All other variables (including the ones coming from outside, as val
and val2 are) are not shared and do no need protection at this level.

I should move the mutex in max9611_read_* functions (maybe even
read_single() does not need that, as I2c bus access is protected
already), and simplify the read_raw() one.
Just saying it out loud so there will be no surprises in v4.

Thanks
   j
