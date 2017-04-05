Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36486 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdDECfA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2017 22:35:00 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so56744pgh.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2017 19:34:59 -0700 (PDT)
Date: Tue, 4 Apr 2017 19:34:56 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Cc: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad5933: Protect DIRECT mode using
 claim/release helpers
Message-ID: <20170405023454.GA20027@d830.WORKGROUP>
References: <1490290603-9115-1-git-send-email-narcisaanamaria12@gmail.com>
 <2ea7b2ea-a09a-2e43-23b3-bd77f2541c6f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2ea7b2ea-a09a-2e43-23b3-bd77f2541c6f@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 25, 2017 at 05:56:54PM +0000, Jonathan Cameron wrote:
> On 23/03/17 17:36, Narcisa Ana Maria Vasile wrote:
> > This device operates in DIRECT_MODE and BUFFER_HARDWARE mode.
> > Replace usages of iio_dev->mlock with iio_device_{claim|release}_direct_mode()
> > helper functions to guarantee DIRECT mode and consequently protect
> > BUFFER mode too.
> > 
> > Add and use a device private lock to protect against conflicting access of the
> > state data.
> > This helps with IIO subsystem redefining iio_dev->mlock to be used by
> > the IIO core only for protecting device operating mode changes.
> > ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> > 
> > Remove lock from ad5933_work() because buffer mode should be enabled
> > when we reach this, and claiming DIRECT mode in all the other places
> > should protect it.
> Well presented. I was wondering about the logic behind that...
> > 
> > Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> This is certainly a fiddly one so I'd like some more eyes on it.
> 
> Lars - could you take a look? (he gets all the analog devices stuff ;)

Lars - Your thoughts?  

Narcisa traced through the callbacks carefully since was the
only/first driver in IIO setting INDIO_BUFFER_HARDWARE.

thanks,
alisons

> > ---
> >  drivers/staging/iio/impedance-analyzer/ad5933.c | 50 ++++++++++++++-----------
> >  1 file changed, 28 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > index 297665d..3d539ee 100644
> > --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> > +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > @@ -98,6 +98,7 @@ struct ad5933_state {
> >  	struct i2c_client		*client;
> >  	struct regulator		*reg;
> >  	struct delayed_work		work;
> > +	struct mutex			lock; /* Protect sensor state */
> >  	unsigned long			mclk_hz;
> >  	unsigned char			ctrl_hb;
> >  	unsigned char			ctrl_lb;
> > @@ -306,9 +307,11 @@ static ssize_t ad5933_show_frequency(struct device *dev,
> >  		u8 d8[4];
> >  	} dat;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return ret;
> >  	ret = ad5933_i2c_read(st->client, this_attr->address, 3, &dat.d8[1]);
> > -	mutex_unlock(&indio_dev->mlock);
> > +	iio_device_release_direct_mode(indio_dev);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -338,9 +341,11 @@ static ssize_t ad5933_store_frequency(struct device *dev,
> >  	if (val > AD5933_MAX_OUTPUT_FREQ_Hz)
> >  		return -EINVAL;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return ret;
> >  	ret = ad5933_set_freq(st, this_attr->address, val);
> This is the one case that standas out where we aren't taking the new lock..
> It is setting a few internal state variables (st->freq_start and st->freq_inc)
> but this is safe because those aren't actually read anywhere..
> Presumably they were going to be cached, but the original author decided
> against at some point later...
> > -	mutex_unlock(&indio_dev->mlock);
> > +	iio_device_release_direct_mode(indio_dev);
> >  
> >  	return ret ? ret : len;
> >  }
> > @@ -364,7 +369,7 @@ static ssize_t ad5933_show(struct device *dev,
> >  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> >  	int ret = 0, len = 0;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	switch ((u32)this_attr->address) {
> >  	case AD5933_OUT_RANGE:
> >  		len = sprintf(buf, "%u\n",
> > @@ -393,7 +398,7 @@ static ssize_t ad5933_show(struct device *dev,
> >  		ret = -EINVAL;
> >  	}
> >  
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  	return ret ? ret : len;
> >  }
> >  
> > @@ -415,7 +420,10 @@ static ssize_t ad5933_store(struct device *dev,
> >  			return ret;
> >  	}
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +	mutex_lock(&st->lock);
> >  	switch ((u32)this_attr->address) {
> >  	case AD5933_OUT_RANGE:
> >  		ret = -EINVAL;
> > @@ -465,7 +473,8 @@ static ssize_t ad5933_store(struct device *dev,
> >  		ret = -EINVAL;
> >  	}
> >  
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> > +	iio_device_release_direct_mode(indio_dev);
> >  	return ret ? ret : len;
> >  }
> >  
> > @@ -532,11 +541,9 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (m) {
> >  	case IIO_CHAN_INFO_RAW:
> > -		mutex_lock(&indio_dev->mlock);
> > -		if (iio_buffer_enabled(indio_dev)) {
> > -			ret = -EBUSY;
> > -			goto out;
> > -		}
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> >  		ret = ad5933_cmd(st, AD5933_CTRL_MEASURE_TEMP);
> >  		if (ret < 0)
> >  			goto out;
> > @@ -549,7 +556,7 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
> >  				      2, (u8 *)&dat);
> >  		if (ret < 0)
> >  			goto out;
> > -		mutex_unlock(&indio_dev->mlock);
> > +		iio_device_release_direct_mode(indio_dev);
> >  		*val = sign_extend32(be16_to_cpu(dat), 13);
> >  
> >  		return IIO_VAL_INT;
> > @@ -561,7 +568,7 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
> >  
> >  	return -EINVAL;
> >  out:
> > -	mutex_unlock(&indio_dev->mlock);
> > +	iio_device_release_direct_mode(indio_dev);
> >  	return ret;
> >  }
> >  
> > @@ -657,18 +664,17 @@ static void ad5933_work(struct work_struct *work)
> >  	unsigned char status;
> >  	int ret;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> >  	if (st->state == AD5933_CTRL_INIT_START_FREQ) {
> >  		/* start sweep */
> >  		ad5933_cmd(st, AD5933_CTRL_START_SWEEP);
> >  		st->state = AD5933_CTRL_START_SWEEP;
> >  		schedule_delayed_work(&st->work, st->poll_time_jiffies);
> > -		goto out;
> > +		return;
> >  	}
> >  
> >  	ret = ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status);
> >  	if (ret)
> > -		goto out;
> > +		return;
> >  
> >  	if (status & AD5933_STAT_DATA_VALID) {
> >  		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
> > @@ -678,7 +684,7 @@ static void ad5933_work(struct work_struct *work)
> >  				AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
> >  				scan_count * 2, (u8 *)buf);
> >  		if (ret)
> > -			goto out;
> > +			return;
> >  
> >  		if (scan_count == 2) {
> >  			val[0] = be16_to_cpu(buf[0]);
> > @@ -690,7 +696,7 @@ static void ad5933_work(struct work_struct *work)
> >  	} else {
> >  		/* no data available - try again later */
> >  		schedule_delayed_work(&st->work, st->poll_time_jiffies);
> > -		goto out;
> > +		return;
> >  	}
> >  
> >  	if (status & AD5933_STAT_SWEEP_DONE) {
> > @@ -703,8 +709,6 @@ static void ad5933_work(struct work_struct *work)
> >  		ad5933_cmd(st, AD5933_CTRL_INC_FREQ);
> >  		schedule_delayed_work(&st->work, st->poll_time_jiffies);
> >  	}
> > -out:
> > -	mutex_unlock(&indio_dev->mlock);
> >  }
> >  
> >  static int ad5933_probe(struct i2c_client *client,
> > @@ -723,6 +727,8 @@ static int ad5933_probe(struct i2c_client *client,
> >  	i2c_set_clientdata(client, indio_dev);
> >  	st->client = client;
> >  
> > +	mutex_init(&st->lock);
> > +
> >  	if (!pdata)
> >  		pdata = &ad5933_default_pdata;
> >  
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
