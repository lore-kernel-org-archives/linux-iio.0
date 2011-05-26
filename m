Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:50402 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab1EZOuY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 May 2011 10:50:24 -0400
Message-ID: <4DDE6A8D.5000007@cam.ac.uk>
Date: Thu, 26 May 2011 15:58:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI
 ADC
References: <1306335750-428-1-git-send-email-michael.hennerich@analog.com> <4DDE28F4.5040705@cam.ac.uk> <4DDE63B1.2060301@analog.com>
In-Reply-To: <4DDE63B1.2060301@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


...
>> What would happen if this driver used any other trigger?  Would everything work?
> No. But other drivers can you the trigger. It's not really an trigger it's a data ready.
Most are.  As you say, it is useful to trigger other reads from this, but not to trigger
this to read from other sources...
>> I think it would do an immediate read which is going to be a problem.  Perhaps
>> we need a way of restricting triggers.  This one can be used by anyone, but the
>> part can only use it's own trigger (I think).
> Having the ability to reject alien triggers are nice to have.
True enough.  I guess the easiest is some sort of 'filter' callback on trigger connect.
Then drivers that care, can reject devices that don't match what they need.  Would
probably want one in each direction.  Trigggers can reject devices and devices can
reject triggers.

>> Looked is a bool really, might as well make it explicit. Reg can only be a couple
>> of bytes, so maybe a u8?  Doesn't really matter though.
>>> +static int __ad7793_write_reg(struct ad7793_state *st, unsigned locked,
>>> +                           unsigned cs_change, unsigned reg,
>>> +                           unsigned size, unsigned val)
>>> +{
>>> +     u8 data[4];
>> Worth putting in board state?
> I'll add data to the state structure.
> 
>>> +     struct spi_transfer t = {
>>> +             .tx_buf         = data,
>>> +             .len            = size + 1,
>>> +             .cs_change      = cs_change,
>>> +     };
>>> +     struct spi_message m;
>>> +
>>> +     data[0] = AD7793_COMM_WRITE | AD7793_COMM_ADDR(reg);
>>> +
>>> +     switch (size) {
>>> +     case 3:
>>> +             data[1] = val>>  16;
>>> +             data[2] = val>>  8;
>>> +             data[3] = val;
>>> +             break;
>>> +     case 2:
>>> +             data[1] = val>>  8;
>>> +             data[2] = val;
>>> +             break;
>>> +     case 1:
>>> +             data[1] = val;
>>> +             break;
>> This is a bit nasty, but I can see why you did it.  Though it would give
>> longer code, I'd be inclined to move the data[0] assignment for all of the
>> above cases into the switch statement.  Then this last element fits
>> in better with the rest.
> Actually I don't use this function with size=0, so I remove this part completely.
> Originally it was intended to allow access to the COMM register in order to enable CSREAD.
>
Good, that's even better.

...

>>> +     ret = ad7793_write_reg(st, AD7793_REG_MODE, sizeof(st->mode), st->mode);
>>> +     if (ret)
>>> +             goto out;
>>> +     /* write/read test for device presence */
>> Hmm.. this sort of test is always pretty hit and miss.  I'd just assume the
>> board config is correct and not bother with the test when there isn't a who_am_I
>> register available...
>>
> Actually there is an id register that we can query.
> 
Yeah, I noticed that when looking at the datasheet later in the review.
Much better idea ;)
>>> +static int ad7793_ring_postdisable(struct iio_dev *indio_dev)
>>> +{
>>> +     struct ad7793_state *st = iio_priv(indio_dev);
>>> +
>>> +     st->mode  = (st->mode&  ~AD7793_MODE_SEL(-1)) |
>>> +                 AD7793_MODE_SEL(AD7793_MODE_IDLE);
>>> +
>>> +     st->done = false;
>>> +     wait_event_interruptible(st->wq_data_avail, st->done);
>> So basically this is waiting for one last wakeup to occur before
>> disabling the irq?
> Yes - for CREAD mode is is mandatory that the device is RDY, when
> exiting the continuous conversion mode. For continuous conversion mode
> not using CREAD we can write to the mode register anytime.
>>> +
>>> +     if (!st->irq_dis)
>>> +             disable_irq_nosync(st->spi->irq);
>>> +
>>> +     __ad7793_write_reg(st, 1, 0, AD7793_REG_MODE,
>>> +                        sizeof(st->mode), st->mode);
>>> +
>>> +
>>> +     return spi_bus_unlock(st->spi->master);
>>> +}
>>> +
>>> +/**
>>> + * ad7793_trigger_handler() bh of trigger launched polling to ring buffer
>>> + **/
>>> +
>>> +static irqreturn_t ad7793_trigger_handler(int irq, void *p)
>>> +{
>>> +     struct iio_poll_func *pf = p;
>>> +     struct iio_dev *indio_dev = pf->private_data;
>>> +     struct iio_ring_buffer *ring = indio_dev->ring;
>>> +     struct ad7793_state *st = iio_priv(indio_dev);
>> I like this approach to alignment, nice and tidy ;)
>>> +     s64 dat64[2];
>>> +     s32 *dat32 = (s32 *)dat64;
>>> +
>> On this front, is it not worth using CREAD bit of the communications register?
>> Then if I understand correctly, there is no need to do the write element
>> of this read?
> Originally - I thought to use the CREAD, but exiting this mode is not 100% error prone.
> See my comment above.
Hmm.. That is somewhat awkward, so I guess what you have is pretty much the only option.
...
>>> +&iio_dev_attr_sampling_frequency.dev_attr.attr,
>>> +&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>> +&iio_dev_attr_range.dev_attr.attr,
>>> +&iio_dev_attr_range_available.dev_attr.attr,
>> hmm. I've always been keener on controlling range via 'scale' parameters.
>> Or does this mean something else for this part?
> Well - range implies the maximum input voltage that can be applied.
> Scale means something different for me - but I might be wrong.
They tend to be closely connected.  So many bits exist, and they apply over
a certain range.  That means the scale factor to be applied also changes
as one changes the range. Often it's just a matter of picking one of
scale and range to make controllable, and having the other change
explicitly.  We have to have scale available for raw attributes, whereas
range is optional, so I'd generally advocate changing scale to change
the range rather than the other way around..

