Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:40627 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbaAKPZX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 11 Jan 2014 10:25:23 -0500
Date: Sat, 11 Jan 2014 16:25:21 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, Kravchenko Oleksandr <x0199363@ti.com>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 1/2] iio:accel:bma180: Use modifier instead of index in
 channel specification
In-Reply-To: <52D12D6C.2020007@kernel.org>
Message-ID: <alpine.DEB.2.01.1401111602360.9334@pmeerw.net>
References: <1389389841-7389-1-git-send-email-pmeerw@pmeerw.net> <52D12D6C.2020007@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> > should use channel modifiers (X/Y/Z), not channel indices
> > timestamp channel has scan index 3, not 4
> > 
> Aag.  Whilst a correct fix, this is going to result in a userspace ABI
> change.  Driver has been in since 3.12.  We may need to maintain
> both ABI's for now and then deprecate it at some point.  Easiest way to do
> this
> will be to have two sets of iio_chan_specs pointing at the same underlying
> real channels.
> 
> Anyone have a strong opinion about this?
> Good spot by the way!

adding another email address of Oleksandr, x0199363@ti.com bounces

the IIO ABI is under "testing", not "stable" so the interface may be 
changed due to 'grave errors'

given the short timespan since 3.12 and the clear violation of the 
documented ABI, I think this should just be fixed

another suggestion:

often (at least for me) it is difficult to figure out what the user-space 
sysfs ABI is from reading the source code and I find it even more 
difficult to sometimes guess what a particular sysfs is supposed to do 
(e.g. what writing to a _scale actually sets in terms of the hardware); 

I'd like to suggest to ask for a listing of the sysfs entries relating 
to a new driver under review (e.g. the output of 'find 
/sys/bus/iio/devices/iio:deviceX'); it should be feasible to provide a
tool which compares the submitted listing against the sysfs-bus-iio 
documentation and output appropriate warnings

regards, p.
 
> > Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: Kravchenko Oleksandr <x0199363@ti.com>
> > ---
> >   drivers/iio/accel/bma180.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index 3bec922..bfec313 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -447,14 +447,14 @@ static const struct iio_chan_spec_ext_info
> > bma180_ext_info[] = {
> >   	{ },
> >   };
> > 
> > -#define BMA180_CHANNEL(_index) {					\
> > +#define BMA180_CHANNEL(_axis) {					\
> >   	.type = IIO_ACCEL,						\
> > -	.indexed = 1,							\
> > -	.channel = (_index),						\
> > +	.modified = 1,							\
> > +	.channel2 = IIO_MOD_##_axis,					\
> >   	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> >   		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
> >   	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> > -	.scan_index = (_index),						\
> > +	.scan_index = AXIS_##_axis,					\
> >   	.scan_type = {							\
> >   		.sign = 's',						\
> >   		.realbits = 14,						\
> > @@ -465,10 +465,10 @@ static const struct iio_chan_spec_ext_info
> > bma180_ext_info[] = {
> >   }
> > 
> >   static const struct iio_chan_spec bma180_channels[] = {
> > -	BMA180_CHANNEL(AXIS_X),
> > -	BMA180_CHANNEL(AXIS_Y),
> > -	BMA180_CHANNEL(AXIS_Z),
> > -	IIO_CHAN_SOFT_TIMESTAMP(4),
> > +	BMA180_CHANNEL(X),
> > +	BMA180_CHANNEL(Y),
> > +	BMA180_CHANNEL(Z),
> > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> >   };
> > 
> >   static irqreturn_t bma180_trigger_handler(int irq, void *p)
> > 
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
