Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C2B54EF.9050707@cam.ac.uk>
Date: Wed, 30 Jun 2010 15:30:07 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
 jic23@hermes.cam.ac.uk
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com> 	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com> 	<4C065AE1.9090302@cam.ac.uk> <AANLkTikMRI4GgdJlOwtfDy_rMVGqn_A0vSRPIuASoLBP@mail.gmail.com> 	<4C24E4CC.6020508@cam.ac.uk> <AANLkTimTJyE4o0TwWshAaJyIS2lx_nLwdKS31Sw6jAMf@mail.gmail.com> 	<4C2878DC.7040908@cam.ac.uk> <AANLkTinwyLM-aInMNp8Z7haVER5-eYceIbrK1kq8vQZq@mail.gmail.com>
In-Reply-To: <AANLkTinwyLM-aInMNp8Z7haVER5-eYceIbrK1kq8vQZq@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 06/30/10 08:51, Barry Song wrote:
> For the moment, these should be common for sw ring:
Agreed.  Some of it is probably more general than that but we
will have wait a while to see which bits!

I've had a bit of a play with this and would like to suggest
moving things around to move to more of a 'helper' structure
and functions, there for convenience of the drivers rather
than your suggestion of a higher level structure which
the drivers extend.  Anyhow, RFC on that to follow shortly!
> 
> Index: drivers/staging/iio/ring_generic.h
> ===================================================================
> --- drivers/staging/iio/ring_generic.h	(revision 8933)
> +++ drivers/staging/iio/ring_generic.h	(working copy)
> @@ -98,6 +98,7 @@
>   * @access_id:		device id number
>   * @length:		[DEVICE] number of datums in ring
>   * @bpd:		[DEVICE] size of individual datum including timestamp

Good solution. May cause use issues with devices where this value is not
constant for all channels but there aren't any devices doing that in the tree
at the moment.
> + * @bpe:		[DEVICE] size of individual attribution value
>   * @loopcount:		[INTERN] number of times the ring has looped
>   * @access_handler:	[INTERN] chrdev access handling
>   * @ev_int:		[INTERN] chrdev interface for the event chrdev
> @@ -119,6 +120,7 @@
>  	int				access_id;
>  	int				length;
>  	int				bpd;
> +	int 				bpe;
>  	int				loopcount;
>  	struct iio_handler		access_handler;
>  	struct iio_event_interface	ev_int;
> Index: drivers/staging/iio/ring_sw.c
> ===================================================================
> --- drivers/staging/iio/ring_sw.c	(revision 8933)
> +++ drivers/staging/iio/ring_sw.c	(working copy)
> @@ -13,6 +13,7 @@
>  #include <linux/device.h>
>  #include <linux/workqueue.h>
>  #include "ring_sw.h"
> +#include "trigger.h"
> 
>  static inline int __iio_allocate_sw_ring_buffer(struct
> iio_sw_ring_buffer *ring,
>  						int bytes_per_datum, int length)
> @@ -431,5 +432,74 @@
>  		iio_put_ring_buffer(r);
>  }
>  EXPORT_SYMBOL(iio_sw_rb_free);
> +
> +void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
> +{
> +	struct iio_state *st
> +		= container_of(work_s, struct iio_state,
> +				work_trigger_to_ring);
> +	int len = 0;
> +	size_t datasize = st->indio_dev
> +		->ring->access.get_bpd(st->indio_dev->ring);
> +	char *data = kmalloc(datasize , GFP_KERNEL);
> +
> +	if (data == NULL) {
> +		dev_err(st->parent_dev, "memory alloc failed in ring bh");
> +		return;
> +	}
> +
> +	if (st->indio_dev->scan_count)
> +		len = st->get_ring_element(st, data);
> +
> +	/* Guaranteed to be aligned with 8 byte boundary */
> +	if (st->indio_dev->scan_timestamp)
> +		*(s64 *)(((u32)data + len + sizeof(s64) - 1) & ~(sizeof(s64) - 1))
> +			= st->last_timestamp;
> +
Not all users of sw ring get the timestamp from the trigger.  For devices
(max1363 for example) that use the bus read itself to trigger the capture
the timestamp comes from equivalent of your get_ring_element call.
Dealing with those devices is a job for another day!

> +	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> +			(u8 *)data,
> +			st->last_timestamp);
> +
> +	iio_trigger_notify_done(st->indio_dev->trig);
> +	kfree(data);
> +
> +	return;
> +}
> +EXPORT_SYMBOL(iio_sw_trigger_bh_to_ring);
> +

Acked this one (I have put together a patch series using
this in all by max1363 as things are currently a fair bit different
in there)

Will post shortly.

> +int iio_sw_ring_preenable(struct iio_dev *indio_dev)
> +{
> +	size_t size;
> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
> +	/* Check if there are any scan elements enabled, if not fail*/
> +	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
> +		return -EINVAL;
> +	if (indio_dev->ring->access.set_bpd) {
> +		if (indio_dev->scan_timestamp)
> +			if (indio_dev->scan_count)
> +				/* Timestamp (aligned to s64) and data */
> +				size = (((indio_dev->scan_count * indio_dev->ring->bpe)
> +							+ sizeof(s64) - 1)
> +						& ~(sizeof(s64) - 1))
> +					+ sizeof(s64);
> +			else /* Timestamp only  */
> +				size = sizeof(s64);
> +		else /* Data only */
> +			size = indio_dev->scan_count * indio_dev->ring->bpe;
> +		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(iio_sw_ring_preenable);
> +

Where do we set dev data?  If at all possible I'd like state
to be in the device_state structure rather than the other way around.
That way around it acts as a helper class without adding an intermediate
layer to these drivers.  Also reduces us to a single allocation call
rather than allocate an iio_state then allocate the device_state.
As you have done here, the iio devdata then points to the iio_state
and we use container_of to get to the device_state elements.

I've done a quick implementation of the equivalent of this with
your iio_state moved into the device specific structure.  Will post
shortly.


> +void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time)
> +{
> +	struct iio_state *st = iio_dev_get_devdata(indio_dev);
> +	st->last_timestamp = time;
> +	schedule_work(&st->work_trigger_to_ring);
> +}
> +EXPORT_SYMBOL(iio_sw_poll_func_th);
> +
>  MODULE_DESCRIPTION("Industrialio I/O software ring buffer");
>  MODULE_LICENSE("GPL");
> Index: drivers/staging/iio/iio.h
> ===================================================================
> --- drivers/staging/iio/iio.h	(revision 8933)
> +++ drivers/staging/iio/iio.h	(working copy)
> @@ -447,4 +447,34 @@
> 
>  int iio_get_new_idr_val(struct idr *this_idr);
>  void iio_free_idr_val(struct idr *this_idr, int id);
> +
> +/**
> + * struct iio_state - hardware level hooks for iio device
> + * @work_trigger_to_ring: bh for triggered event handling
> + * @indio_dev:		industrial I/O device structure
> + * @trig:		data ready trigger registered with iio
> + * @get_ring_element:   read ring data from hardware by spi/i2c and
> fill buffer.
> + * @last_timestamp:     time stamp the last data for ring is read
> + * @priv:               hold private data special to chips
> + **/
> +struct iio_state {

This is only used for a single error message.  Do we care enough
about the detail of that message?  This exists deep in iio_dev
anyway so lets get it from there.
> +	struct device		        *parent_dev;

> +	struct work_struct		work_trigger_to_ring;
> +	struct iio_dev			*indio_dev;

This isn't used in this patch.  Might fall in a later one but
it doesn't want
> +	struct iio_trigger		*trig;

> +	int (*get_ring_element)(struct iio_state *st, u8 *buf);
> +	s64 				last_timestamp;

This goes as well if we embedded it the other way around.
> +	void *priv;
> +};
> +
> +static inline void iio_state_set_privdata(struct iio_state *st, void *data)
> +{
> +	st->priv = data;
> +}
> +
> +static inline void * iio_state_get_privdata(struct iio_state *st)
> +{
> +	return st->priv;
> +}
> +
>  #endif /* _INDUSTRIAL_IO_H_ */
> 
> 
> 
