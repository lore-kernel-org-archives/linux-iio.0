Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753099AbdICRhQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 13:37:16 -0400
Date: Sun, 3 Sep 2017 18:37:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: Introduce the generic counter interface
Message-ID: <20170903183711.5cffb9bd@archlinux>
In-Reply-To: <20170828155707.GB16755@sophia>
References: <cover.1501516678.git.vilhelm.gray@gmail.com>
        <e7ca230a62f6b850fd89205b38819bd7d5309693.1501516678.git.vilhelm.gray@gmail.com>
        <20170820124002.2b70b196@archlinux>
        <20170828155707.GB16755@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 28 Aug 2017 11:57:07 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sun, Aug 20, 2017 at 12:40:02PM +0100, Jonathan Cameron wrote:
> >On Mon, 31 Jul 2017 12:03:23 -0400
> >William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >  
> >> This patch introduces the IIO generic counter interface for supporting
> >> counter devices. The generic counter interface serves as a catch-all to
> >> enable rudimentary support for devices that qualify as counters. More
> >> specific and apt counter interfaces may be developed on top of the
> >> generic counter interface, and those interfaces should be used by
> >> drivers when possible rather than the generic counter interface.
> >> 
> >> In the context of the IIO generic counter interface, a counter is
> >> defined as a device that reports one or more "counter values" based on
> >> the state changes of one or more "counter signals" as evaluated by a
> >> defined "counter function."
> >> 
> >> The IIO generic counter interface piggybacks off of the IIO core. This
> >> is primarily used to leverage the existing sysfs setup: the IIO_COUNT
> >> channel attributes represent the "counter value," while the IIO_SIGNAL
> >> channel attributes represent the "counter signal;" auxilary IIO_COUNT
> >> attributes represent the "counter signal" connections and their
> >> respective state change configurations which trigger an associated
> >> "counter function" evaluation.
> >> 
> >> The iio_counter_ops structure serves as a container for driver callbacks
> >> to communicate with the device; function callbacks are provided to read
> >> and write various "counter signals" and "counter values," and set and
> >> get the "trigger mode" and "function mode" for various "counter signals"
> >> and "counter values" respectively.
> >> 
> >> To support a counter device, a driver must first allocate the available
> >> "counter signals" via iio_counter_signal structures. These "counter
> >> signals" should be stored as an array and set to the init_signals member
> >> of an allocated iio_counter structure before the counter is registered.
> >> 
> >> "Counter values" may be allocated via iio_counter_value structures, and
> >> respective "counter signal" associations made via iio_counter_trigger
> >> structures. Initial associated iio_counter_trigger structures may be
> >> stored as an array and set to the the init_triggers member of the
> >> respective iio_counter_value structure. These iio_counter_value
> >> structures may be set to the init_values member of an allocated
> >> iio_counter structure before the counter is registered if so desired.
> >> 
> >> A counter device is registered to the system by passing the respective
> >> initialized iio_counter structure to the iio_counter_register function;
> >> similarly, the iio_counter_unregister function unregisters the
> >> respective counter.
> >> 
> >> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> >
> >Hi William,
> >
> >A few minor points inline as a starting point.  I'm going to want to dig
> >into this in a lot more detail but don't have the time today (or possibly
> >for a few more weeks - sorry about that!)  
> 
> Thank you for the quick review. Looking over your review points and my
> code again, it's become rather apparent to me that my implementation is
> burdenly opaque with its lack of apt comments to document the rationale
> of certain sections of code. I'll repair to remedy that in version 2 of
> this patchset.
> 
> By the way, feel free to take your time reviewing, I'm in no particular
> rush myself. In fact, with the anticipated proper documentation coming I
> expect version 2 to a bit easily to digest for you than this intial
> patchset. As well, in general I prefer to get this interface committed
> late but correct, rather than soon but immature.

All sounds good.  There is a fair bit here, so not surprising that
it gets a bit complex :)

> 
> I've provided my responses inline to your specific review points.
> 
> Sincerely,
> 
> William Breathitt Gray
<snip>

> >> +
> >> +static ssize_t __iio_counter_trigger_mode_write(struct iio_dev *indio_dev,
> >> +	uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
> >> +	size_t len)
> >> +{
> >> +	struct iio_counter *const counter = iio_priv(indio_dev);
> >> +	struct iio_counter_value *value;
> >> +	ssize_t err;
> >> +	struct iio_counter_trigger *trigger;
> >> +	const int signal_id = *(int *)((void *)priv);  
> >Given you don't go through the void * cast in _read I'm thinking it's not
> >needed here either.  
> 
> I'm aware that we typically do not follow the C99 standard in the Linux
> kernel code, but since the uintptr_t typedef is modeled after the C99
> uintptr_t, I considered it appropriate to follow C99 in this case: the
> C99 standard requires an explicit conversion to void * from intptr_t
> before converting to another pointer type for dereferencing.

Fair enough.

> 
> Despite the standard requirement, I agree that it is awkward to see the
> explicit cast to void * (likely because uintptr_t is not intended to be
> dereferenced in the context of the standard), so I'll be willing to
> remove it in this case if you believe it'll make the code clearer to
> understand.
> 
> Just out of curiousity: why was uintptr_t choosen for this parameter
> rather than void *?

I'd imagine it's about explicitly tracking userspace pointers rather than
kernel ones.  They could probably have have a uvoidptr_t but for some
reason decided not to...

<snip>

> >> +
> >> +static int __iio_counter_write_raw(struct iio_dev *indio_dev,
> >> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
> >> +{
> >> +	struct iio_counter *const counter = iio_priv(indio_dev);
> >> +	struct iio_counter_signal *signal;
> >> +	int retval;
> >> +	struct iio_counter_value *value;
> >> +
> >> +	if (mask != IIO_CHAN_INFO_RAW)
> >> +		return -EINVAL;
> >> +
> >> +	switch (chan->type) {
> >> +	case IIO_SIGNAL:
> >> +		if (!counter->ops->signal_write)
> >> +			return -EINVAL;
> >> +
> >> +		mutex_lock(&counter->signal_list_lock);
> >> +		signal = __iio_counter_signal_find_by_id(counter,
> >> +			chan->channel2);
> >> +		if (!signal) {
> >> +			mutex_unlock(&counter->signal_list_lock);
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		retval = counter->ops->signal_write(counter, signal, val, val2);
> >> +		mutex_unlock(&counter->signal_list_lock);
> >> +
> >> +		return retval;
> >> +	case IIO_COUNT:
> >> +		if (!counter->ops->value_write)
> >> +			return -EINVAL;
> >> +
> >> +		mutex_lock(&counter->value_list_lock);
> >> +		value = __iio_counter_value_find_by_id(counter, chan->channel2);
> >> +		if (!value) {
> >> +			mutex_unlock(&counter->value_list_lock);
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		retval = counter->ops->value_write(counter, value, val, val2);
> >> +		mutex_unlock(&counter->value_list_lock);
> >> +
> >> +		return retval;
> >> +	default:  
> >
> >This case definitely needs a comment!
> >I think you overwrite any write_raw callbacks passed in and hence this
> >is a infinite recursion...
> >Could be wrong though ;)  
> 
> I apologize, this looks like one of those cases where I should have
> provided some better documentation about the architecture of generic
> counter interface implementation. I'll make sure to make this clearer in
> the version 2 documentation and comments.
> 
> However, I'll try to explain what's going on. The generic counter
> interface sits a layer above the IIO core, so drivers which use the
> generic counter interface do not directly supply IIO core write_raw
> callbacks, but rather provide generic counter signal_write/value_write
> callbacks (a passed write_raw callback is possible for non-counter IIO
> channels).
> 
> The generic counter interface hooks itself via __iio_counter_write_raw
> to the IIO core write_raw. The __iio_counter_write_raw function handles
> the mapping to ensure that signal_write gets called for a generic
> counter Signal, value_write gets called for a generic counter Value, and
> a passed write_raw gets called for a passed non-counter IIO channel.
> 
> The reason for this __iio_counter_write_raw function is to provide an
> abstraction for the signal_write/value_write functions to have access to
> generic counter interface parameters not available via the regular
> write_raw parameters. In theory, a driver utilizing the generic counter
> interface for a counter device does not need to know that it's utilizing
> IIO core under the hood since to it can handle all its counter device
> needs via the signal_write/value_write callbacks.

Thanks for the explanation. I'd somehow missed that entirely.

<snip>
