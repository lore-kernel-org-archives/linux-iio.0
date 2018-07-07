Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753572AbeGGQXN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Jul 2018 12:23:13 -0400
Date: Sat, 7 Jul 2018 17:23:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Parthiban Nallathambi <pn@denx.de>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH 1/2] iio: light: Add support for vishay vcnl4035
Message-ID: <20180707172306.7a4a9d55@archlinux>
In-Reply-To: <03abc2a3-82dd-c2fd-bbae-adc320319428@denx.de>
References: <20180628123021.1628338-1-pn@denx.de>
        <20180629185950.00005c54@huawei.com>
        <03abc2a3-82dd-c2fd-bbae-adc320319428@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 3 Jul 2018 15:35:05 +0200
Parthiban Nallathambi <pn@denx.de> wrote:

> Hello Jonathan,
Hi Parthiban,

Comments inline.
...
> >> +static irqreturn_t vcnl4035_drdy_irq_handler(int irq, void *private)
> >> +{
> >> +	struct iio_dev *indio_dev = private;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	data->irq_timestamp = iio_get_time_ns(indio_dev);  
> > 
> > This all seems a bit more complex that I'd expect.
> > I would like some comments on why it is so complex..
> > 
> > Only reason I can come up with quickly is to handle shared interrupts?
> > But if that is the case you'll sometimes get the wrong timestamp here.
> > 
> > Otherwise, right now we only have one cause of interrupts and
> > might as well just set pf->timestamp directly here.
> >   
> 
> Based on Peter's comments, timestamp is ignored as the driver only
> supports ALS measurement. So I will remove this part of handling and
> will have only bottom half checking the INT flag and trigger the
> consumer, thanks.
> 
> >> +	return IRQ_WAKE_THREAD;
> >> +}
> >> +
> >> +static irqreturn_t vcnl4035_drdy_irq_thread(int irq, void *private)
> >> +{
> >> +	struct iio_dev *indio_dev = private;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	if (vcnl4035_is_triggered(data)) {
> >> +		iio_trigger_poll_chained(data->drdy_trigger0);
> >> +		return IRQ_HANDLED;
> >> +	}
> >> +
> >> +	return IRQ_NONE;
> >> +}
> >> +
> >> +/* Triggered buffer */
> >> +static irqreturn_t vcnl4035_trigger_consumer_store_time(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +
> >> +	if (!iio_trigger_using_own(indio_dev))
> >> +		pf->timestamp = iio_get_time_ns(indio_dev);
> >> +
> >> +	return IRQ_WAKE_THREAD;
> >> +}
> >> +
> >> +static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +	int als_data;
> >> +	int ret;
> >> +
> >> +	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
> >> +		pf->timestamp = data->irq_timestamp;
> >> +		data->irq_timestamp = 0;  
> > 
> > If we get here and the path was anything other than via our top half
> > handler that set this then something odd is going on.  
> 
> As mentioned above, timestamp is removed.
> 
> >   
> >> +	}
> >> +
> >> +	if (!pf->timestamp)
> >> +		pf->timestamp = iio_get_time_ns(indio_dev);  
> > 
> > Hmm. Why would we hit here when using our own trigger?  If not make this
> > a simple else and it will be less confusing.  
> 
> As mentioned above, timestamp is removed.
> 
> >   
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &als_data);
> >> +	mutex_unlock(&data->lock);
> >> +	if (!ret) {
> >> +		als_data = le16_to_cpu(als_data);  
> > As the autobuilder pointed out, use a local variable of the correct
> > endianess.  
> 
> Fixed it in v2 already. Will remove the timestamp part and use
> iio_push_to_buffers in v3, thanks.
> 

I'll look at v3 later. I'm not totally sure why supporting ALS only
means we shouldn't have a timestamp - perhaps the code will make it clear!

...
> >> +
> >> +/* No direct ABI for persistence and threshold, so eventing */
> >> +static int vcnl4035_read_thresh(struct iio_dev *indio_dev,
> >> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> >> +		enum iio_event_direction dir, enum iio_event_info info,
> >> +		int *val, int *val2)
> >> +{
> >> +	struct vcnl4035_data *data = iio_priv(indio_dev);
> >> +
> >> +	switch (info) {
> >> +	case IIO_EV_INFO_VALUE:
> >> +		switch (dir) {
> >> +		case IIO_EV_DIR_RISING:
> >> +			mutex_lock(&data->lock);
> >> +			*val = data->als_thresh_high;
> >> +			mutex_unlock(&data->lock);
> >> +			break;
> >> +		case IIO_EV_DIR_FALLING:
> >> +			mutex_lock(&data->lock);
> >> +			*val = data->als_thresh_low;
> >> +			mutex_unlock(&data->lock);
> >> +			break;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +		break;
> >> +	case IIO_EV_INFO_PERIOD:
> >> +		mutex_lock(&data->lock);
> >> +		*val = data->als_persistence;
> >> +		mutex_unlock(&data->lock);  
> > 
> > Given mutex is taken in all paths, why not take it outside
> > the switch?  Mind you I'm not totally sure why we need to take
> > the lock at all.  We don't take it whilst setting these values.  
> 
> Lock is introduced to protect the device parameters as both integration
> time and scaling factor is proportionally calculated. This makes raw
> read and INT read sync with the new/latest updated value of device.

All we ensure here is that we don't get a transient value.  It's still
possible for the read raw or interrupt to occur on either side
of this.  I'm not seeing how the lock is preventing us getting an
incorrect state (i.e. a different one from what we are expecting)?

All of these assignments are single value that will be atomic anyway.
You'll only see one value or the other when reading - never a mixture
of the two!
> 
> I will move the locking outside the switch.
> 
> > 
...
> >> +static IIO_CONST_ATTR(als_available_integration_time, "50 100 200 400 800");
> >> +/* device ALS persistence 1 2 4 8 mapped to users 0 1 2 3 */
> >> +static IIO_CONST_ATTR(als_available_persistence, "0 1 2 3");
> >> +static IIO_CONST_ATTR(als_available_threshold_range, "0 65535");
> >> +
> >> +static struct attribute *vcnl4035_attributes[] = {
> >> +	&iio_const_attr_als_available_integration_time.dev_attr.attr,  
> > 
> > These don't comply with the abi which has available at the end not the start.  
> 
> Sorry, so this needs to be moved to begining or start of the file.
Sorry, I was unclear.  The issue is that _available is always a postfix.

So even if we accept the rest of the naming it should be
als_persistence_available etc.

Note these are non standard abi however..

> 
> >   
> >> +	&iio_const_attr_als_available_threshold_range.dev_attr.attr,  
> > 
> > I'm not even sure what these two are...
> > 
> > All new ABI or ABI that is currently specific to too narrow a range of
> > parts must be documented in /Documentation/ABI/testing/sysfs-bus-iio-*  
> 
> Threshold range: Defines the lower and upper threshold ALS value. This
> internally used by the device before triggering the interrupt i.e,
> interrupt will be triggered only of the ALS values falls below or above
> the threshold range here.

So in reality this device is generate threshold events, we are just using
them to indicate new data ready?   Please handle as explicit events
in IIO.  If you want to also use them as a trigger, then that can be
done by basically disabling the events if the trigger is enabled and
the other way around.

> 
> Persistence value: How many intergration cycle the ALS values stays
> lower or uppers then the threshold value.

This is very much an event property.  See the existing ABI defined
for those.  It might need extending, I haven't checked.

> 
> Should I need to include a new ABI to handle this case or introduce a
> driver specific sysfs entry to control theses values is fine.

It depends.  The vast majority of the time, for something fairly generic
we want to bring it into the main ABI.  That makes it useful for generic
userspace code.   Just occasionally we'll have something so far from
standard that generic code is never going to use it (often around wierd
calibration requirements) so in those cases, just a properly defined
(documented) sysfs interface is fine.

> 
> I have seen your comments about TSL2591 in the ML. So adding a new ABI
> for the time PERIOD (in different form - persistence) does not make
> sense. But this value lowers the amount of interrupt which is generated
> by the device.

This depends on whether you are intending it to be a 'data ready trigger'
in which case what you are actually controlling is the effective sampling
rate (so present it as that) or you are intending it as a threshold
interrupt control, in which case present it as a control on the generated
event, not the data capture itself.
> 
> >   
> >> +	&iio_const_attr_als_available_persistence.dev_attr.attr,
> >> +	NULL,
> >> +};
> >> +
...
