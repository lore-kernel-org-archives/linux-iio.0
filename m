Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35779 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbdCKVEh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 16:04:37 -0500
Received: by mail-pf0-f195.google.com with SMTP id 67so14688008pfg.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2017 13:04:11 -0800 (PST)
Date: Sat, 11 Mar 2017 13:04:09 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, daniel.baluta@gmail.com,
        Michael.Hennerich@analog.com
Subject: Re: [PATCH] staging: iio: ad9832: replace mlock with driver private
 lock
Message-ID: <20170311210409.GA26850@d830.WORKGROUP>
References: <20170309204617.GA9281@d830.WORKGROUP>
 <085bee39-31b3-2317-80b5-5694c948c918@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <085bee39-31b3-2317-80b5-5694c948c918@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 11, 2017 at 06:28:50PM +0000, Jonathan Cameron wrote:
> On 09/03/17 20:46, Alison Schofield wrote:
> > The IIO subsystem is redefining iio_dev->mlock to be used by
> > the IIO core only for protecting device operating mode changes.
> > ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> > 
> > In this driver, mlock was being used to protect hardware state
> > changes.  Replace it with a lock in the devices global data.
> > 
> > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Applied to the togreg branch of iio.git and pushed out as
> testing for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> > ---
> > 
> > Jonathan et al,
> > 
> > If you still want to do this change, is it time to change the
> > iio_dev->mlock comment back to [INTERN] in iio.h so that it
> > doesn't get any new uses whilst we are migrating. Yes?
> > 
> > I'd like to give this as a task to the outreachy applicants.  There
> > are ~70 mlock usages spread amongst ~15 iio drivers in staging. 
> > Are you ready for a wave of these?
> Yes. That was an easy question ;)
> 
> Make sure that they fully review the locking whilst at it though
> as chances are some of it may be less than ideal!
> 
> Jonathan

Thanks Jonathan!
I hear you and I saw it when I selected this easy example ;)
I'll certainly forewarn in the task description.
alisons

> > 
> > 
> >  drivers/staging/iio/frequency/ad9832.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index 8d40c8e..c992648 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -84,6 +84,7 @@
> >   * @freq_msg:		tuning word spi message
> >   * @phase_xfer:		tuning word spi transfer
> >   * @phase_msg:		tuning word spi message
> > + * @lock		protect sensor state
> >   * @data:		spi transmit buffer
> >   * @phase_data:		tuning word spi transmit buffer
> >   * @freq_data:		tuning word spi transmit buffer
> > @@ -103,6 +104,7 @@ struct ad9832_state {
> >  	struct spi_message		freq_msg;
> >  	struct spi_transfer		phase_xfer[2];
> >  	struct spi_message		phase_msg;
> > +	struct mutex			lock;	/* protect sensor state */
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) requires the
> >  	 * transfer buffers to live in their own cache lines.
> > @@ -177,7 +179,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
> >  	if (ret)
> >  		goto error_ret;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	switch ((u32)this_attr->address) {
> >  	case AD9832_FREQ0HM:
> >  	case AD9832_FREQ1HM:
> > @@ -238,7 +240,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
> >  	default:
> >  		ret = -ENODEV;
> >  	}
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  
> >  error_ret:
> >  	return ret ? ret : len;
> > 
> 
