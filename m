Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36795 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803AbcDERls (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Apr 2016 13:41:48 -0400
Date: Tue, 5 Apr 2016 10:41:44 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de,
	Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7606: use
 iio_device_{claim|release}_direct_mode()
Message-ID: <20160405174143.GA2484@d830.WORKGROUP>
References: <20160401165349.GA2678@d830.WORKGROUP>
 <5700DDB9.5060100@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5700DDB9.5060100@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 03, 2016 at 10:09:13AM +0100, Jonathan Cameron wrote:
> On 01/04/16 17:53, Alison Schofield wrote:
> > Two instances are moved to the new claim/release API:
> > 
> > In the first instance, the driver was using mlock followed by
> > iio_buffer_enabled(). Replace that code with the new API to guarantee
> > the device stays in direct mode. There is no change in driver behavior.
> > 
> > In the second instance, the driver was not using mlock to hold the
> > device in direct mode, but should have been.  Here we introduce the
> > new API to guarantee direct mode. This is a change in driver behavior.
> > 
> > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7606_core.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> > index 6dbc811..f914b8d 100644
> > --- a/drivers/staging/iio/adc/ad7606_core.c
> > +++ b/drivers/staging/iio/adc/ad7606_core.c
> > @@ -88,12 +88,12 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (m) {
> >  	case IIO_CHAN_INFO_RAW:
> > -		mutex_lock(&indio_dev->mlock);
> > -		if (iio_buffer_enabled(indio_dev))
> > -			ret = -EBUSY;
> > -		else
> > -			ret = ad7606_scan_direct(indio_dev, chan->address);
> > -		mutex_unlock(&indio_dev->mlock);
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = ad7606_scan_direct(indio_dev, chan->address);
> > +		iio_device_release_direct_mode(indio_dev);
> >  
> >  		if (ret < 0)
> >  			return ret;
> > @@ -411,8 +411,9 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
> >  	struct iio_dev *indio_dev = dev_id;
> >  	struct ad7606_state *st = iio_priv(indio_dev);
> >  
> > -	if (iio_buffer_enabled(indio_dev)) {
> > +	if (!iio_device_claim_direct_mode(indio_dev))  {
> >  		schedule_work(&st->poll_work);
> > +		iio_device_release_direct_mode(indio_dev);
> Unfortunately this won't work.  That interrupt is still in traditional non
> threaded form.  This will take a mutex in a top half interrupt handler
> where a sleep cannot occur.
> 
> I'm just wondering how expensive it would be to fix this by moving that over
> to a threaded handler.  In the poll_work case (buffer) it would be cleaner to do
> so. I'm really confused what the intended interrupt handler
> is in here.  I 'think' the sequence is:
> 
> Trigger fires the convst pin whether in top half or the bottom half of
> a threaded interrupt, but not both - I guess this works, if it is rather
> 'unusual'.
> 
> We then get a interrupt to indicate that it has finished conversion and that
> filters through to actually fill the buffer via a traditional top half /
> bottom half interrupt handler.
> 
> So if we were to convert that to a threaded interrupt (with no top half / non
> threaded part), we could drop the schedule_work and just call
> ad7606_poll_bh_to_ring from the thread handler.
> 
> In the direct read case I doubt we care about the delay in dropping to a
> thread prior to signalling the data is ready.
> 
> Can't think why this driver is still in staging :)
> 
> Lars, any interest from Analog in getting this one cleaned up?  Also
> do you have any test hardware, if we mess around with this interrupt handling?
> 
> Jonathan

I see the problem. Thanks for the review and the details for the
redesign.  Plan to v2 this patch leaving out this piece. I'll keep
the interrupt handler rework on my radar pending Lars's comments.

alisons

> 
> 
> >  	} else {
> >  		st->done = true;
> >  		wake_up_interruptible(&st->wq_data_avail);
> > 
> 
