Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33589 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdEBMXp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2017 08:23:45 -0400
Date: Tue, 2 May 2017 20:23:41 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
        michael.hennerich@analog.com, daniel.baluta@gmail.com,
        amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: accel: adxl345: Add support for triggered
 buffer
Message-ID: <20170502122340.GE3030@Socrates-UM>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <6b7ca7916924965c30e9e5abb4133663e5c7916d.1493450577.git.eraretuya@gmail.com>
 <5802a264-d991-7e61-cc9e-b08079c0a9eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5802a264-d991-7e61-cc9e-b08079c0a9eb@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 01, 2017 at 01:42:29AM +0100, Jonathan Cameron wrote:
[...]
> Few minor bits inline...  I'm a little bit in two minds about the 
> holding up waiting for new data when using another trigger...
> 
> Jonathan
[...]
> >  static int adxl345_read_raw(struct iio_dev *indio_dev,
> > @@ -127,6 +151,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> >  		mutex_lock(&data->lock);
> >  		ret = adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
> >  		if (ret < 0) {
> > @@ -148,12 +176,14 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
> >  		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
> >  				       sizeof(regval));
> >  		mutex_unlock(&data->lock);
> > +		iio_device_release_direct_mode(indio_dev);
> >  		if (ret < 0) {
> >  			adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
> >  			return ret;
> >  		}
> >  
> > -		*val = sign_extend32(le16_to_cpu(regval), 12);
> > +		*val = sign_extend32(le16_to_cpu(regval),
> > +				     chan->scan_type.realbits - 1)
> This change isn't really needed, but I suppose it does little harm...
> 
> >  		adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
> >  
> >  		return IIO_VAL_INT;
> > @@ -186,6 +216,64 @@ static irqreturn_t adxl345_irq(int irq, void *p)
> >  	return IRQ_NONE;
> >  }
> >  
> > +static irqreturn_t adxl345_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct adxl345_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->lock);
> > +	/* Make sure data is ready when using external trigger */
> I 'think' this is only really relevant for the very first one.
> After that general rule of thumb is that if an external trigger
> is too quick - bad luck you'll get repeated data.
> 
> One of the reasons we would want to use another trigger is to
> support capture in parallel from several sensors - if we 'hold'
> like this we'll get out of sync.
> 
> As such I wonder if a better strategy would be to 'hold' for the
> first reading in the buffer enable - thus guaranteeing valid
> data before we start.  After that we wouldn't need to check this
> here.
> 

Thanks for the explanation. If we are to go with this one, where to put
it, preenable or postenable? I'm assuming the latter but would like to
confirm.

> What do others think?
> 

Any other inputs are greatly appreciated.

Eva
