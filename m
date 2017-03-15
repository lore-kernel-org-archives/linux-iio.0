Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34095 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdCOWHT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 18:07:19 -0400
Received: by mail-pg0-f67.google.com with SMTP id b5so3626810pgg.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Mar 2017 15:07:18 -0700 (PDT)
Date: Wed, 15 Mar 2017 15:00:11 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gargi Sharma <gs051095@gmail.com>,
        outreachy-kernel@googlegroups.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: Replace mlock with driver private
 lock
Message-ID: <20170315220010.GA4895@d830.WORKGROUP>
References: <1489584521-20788-1-git-send-email-gs051095@gmail.com>
 <f5547535-19fb-013f-9f74-9c13002bdb4e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f5547535-19fb-013f-9f74-9c13002bdb4e@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 15, 2017 at 07:38:33PM +0000, Jonathan Cameron wrote:
> On 15/03/17 13:28, Gargi Sharma wrote:
> > The IIO subsystem is redefining iio_dev->mlock to be used by
> > the IIO core only for protecting device operating mode changes.
> > ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> > 
> > In this driver, mlock was being used to protect hardware state
> > changes.  Replace it with a lock in the devices global data.
> > 
> > Signed-off-by: Gargi Sharma <gs051095@gmail.com>
> Was missing from Alison's original patch (since fixed), but
> we need to call mutex_init on the mutex somewhere suitable in probe.
> 
> Thanks,
> 
> Jonathan
Hi Gargi - please include the driver name in subject line when you rev it.  
alisons
> > ---
> > Changes in v2:
> > 	- Made the commit log clearer.
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index ee679ac..b482606 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -134,6 +134,7 @@ struct ad7280_state {
> >  	unsigned char			aux_threshhigh;
> >  	unsigned char			aux_threshlow;
> >  	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
> > +	struct mutex			lock; /* protect sensor state */
> >  
> >  	__be32				buf[2] ____cacheline_aligned;
> >  };
> > @@ -410,7 +411,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
> >  	devaddr = this_attr->address >> 8;
> >  	ch = this_attr->address & 0xFF;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	if (readin)
> >  		st->cb_mask[devaddr] |= 1 << (ch + 2);
> >  	else
> > @@ -418,7 +419,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
> >  
> >  	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE,
> >  			   0, st->cb_mask[devaddr]);
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  
> >  	return ret ? ret : len;
> >  }
> > @@ -433,10 +434,10 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
> >  	int ret;
> >  	unsigned int msecs;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	ret = ad7280_read(st, this_attr->address >> 8,
> >  			  this_attr->address & 0xFF);
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  
> >  	if (ret < 0)
> >  		return ret;
> > @@ -466,11 +467,11 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
> >  	if (val > 31)
> >  		return -EINVAL;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	ret = ad7280_write(st, this_attr->address >> 8,
> >  			   this_attr->address & 0xFF,
> >  			   0, (val & 0x1F) << 3);
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  
> >  	return ret ? ret : len;
> >  }
> > @@ -655,7 +656,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
> >  
> >  	val = clamp(val, 0L, 0xFFL);
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	switch ((u32)this_attr->address) {
> >  	case AD7280A_CELL_OVERVOLTAGE:
> >  		st->cell_threshhigh = val;
> > @@ -674,7 +675,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
> >  	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
> >  			   this_attr->address, 1, val);
> >  
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  
> >  	return ret ? ret : len;
> >  }
> > @@ -792,13 +793,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (m) {
> >  	case IIO_CHAN_INFO_RAW:
> > -		mutex_lock(&indio_dev->mlock);
> > +		mutex_lock(&st->lock);
> >  		if (chan->address == AD7280A_ALL_CELLS)
> >  			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
> >  		else
> >  			ret = ad7280_read_channel(st, chan->address >> 8,
> >  						  chan->address & 0xFF);
> > -		mutex_unlock(&indio_dev->mlock);
> > +		mutex_unlock(&st->lock);
> >  
> >  		if (ret < 0)
> >  			return ret;
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
