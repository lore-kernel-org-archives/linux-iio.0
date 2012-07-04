Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Thu, 5 Jul 2012 01:48:27 +0200
Cc: linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Wolfgang Denk <wd@denx.de>,
 Juergen Beisert <jbe@pengutronix.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de> <4FF40044.90904@metafoo.de>
In-Reply-To: <4FF40044.90904@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201207050148.27289.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Lars-Peter Clausen,

> On 07/04/2012 04:15 AM, Marek Vasut wrote:
> > This driver is very basic. It supports userland trigger, buffer and
> > raw access to channels. The support for delay channels is missing
> > altogether.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Wolfgang Denk <wd@denx.de>
> > Cc: Juergen Beisert <jbe@pengutronix.de>
> > [...]
> 
> The overall structure looks good, but a few things need to be addressed.
> I also think the driver doesn't have to go through staging and could be put
> in to the out-of-staging part of iio.

Come and rip me to shreds ;-)

[...]

> > +	wait_queue_head_t	wq_data_avail[LRADC_MAX_MAPPED_CHANS];
> > +	bool			wq_done[LRADC_MAX_MAPPED_CHANS];
> 
> This and it's usage looks a bit like an open-coded struct completion.

Indeed, completion is good for this :)

> > +};
> > +
> > +struct mxs_lradc_data {
> > +	struct mxs_lradc	*lradc;
> > +};
> 
> Is there any reason not to use the mxs_lradc struct directly has the iio
> data?

I explained it below in the patch. I hope we'll eventually support the delay 
triggers, which will need 4 separate IIO devices. And this is where this 
structure will be augmented by other components.

> >[...]
> >
> > +
> > +/*
> > + * Channel management
> > + *
> > + * This involves crazy mapping between 8 virtual channels the CTRL4
> > register + * can harbor and 16 channels total this hardware supports.
> > + */
> 
> I suppose this means only a maximum 8 channels can be active at a time.
> I've recently posted a patch which makes it easy to implement such a
> restriction. http://www.spinics.net/lists/linux-iio/msg05936.html and
> http://www.spinics.net/lists/linux-iio/msg05935.html for an example
> validate callback implementation. In your case you'd check for
> bitmap_weight(...) <= 8. Those patches are not yet in IIO though.

This is good. When do you expect this to hit linux-next possibly? Or at least 
linux-iio?

[..]

> > +static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> > +			const struct iio_chan_spec *chan,
> > +			int *val, int *val2, long m)
> > +{
> > +	struct mxs_lradc_data *data = iio_priv(iio_dev);
> > +	struct mxs_lradc *lradc = data->lradc;
> > +	int ret, slot;
> > +
> > +	if (m != 0)
> 
> I'd use the symbolic constant here IIO_CHAN_INFO_RAW
> 
> > +		return -EINVAL;
> > +
> > +	/* Map channel. */
> > +	slot = mxs_lradc_map_channel(lradc, chan->channel,
> > LRADC_CHAN_FLAG_RAW); +	if (slot < 0)
> > +		return slot;
> > +
> > +	/* Start sampling. */
> > +	mxs_lradc_run_slots(lradc, 1 << slot);
> > +
> > +	/* Wait for completion on the channel, 1 second max. */
> > +	lradc->wq_done[slot] = false;
> > +	ret = wait_event_interruptible_timeout(lradc->wq_data_avail[slot],
> > +					       lradc->wq_done[slot],
> > +					       msecs_to_jiffies(1000));
> > +	if (!ret) {
> > +		ret = -ETIMEDOUT;
> > +		goto err;
> > +	}
> > +
> 
> How well will this work if the device is currrently in buffered mode? Maybe
> it's better do disablow it by checking iio_buffer_enabled and return -EBUSY
> if it returns true;

I believe this should work perfectly OK, why won't it ? I tried to avoid such 
artificial limitation.

[...]

> > +	if (iio_buffer_enabled(lradc->iio)) {
> > +		disable_irq_nosync(irq);
> > +		lradc->idis = irq;
> 
> The whole disable_irq/enable_irq thing is a bit ugly, is it really
> necessary?

I was wondering myself, I'll investigate further. This was inspired by the AT91 
driver for the most part.

[...]

> > +static int mxs_lradc_configure_trigger(struct iio_trigger *trig, bool
> > state) +{
> > +	struct iio_dev *iio = trig->private_data;
> > +	struct mxs_lradc_data *data = iio_priv(iio);
> > +	struct mxs_lradc *lradc = data->lradc;
> > +	struct iio_buffer *buffer = iio->buffer;
> > +	int slot, bit, ret = 0;
> > +	uint8_t map = 0;
> > +	unsigned long chans = 0;
> > +
> > +	if (!state)
> > +		goto exit;
> > +
> > +	lradc->buffer = kmalloc(iio->scan_bytes, GFP_KERNEL);
> > +	if (!lradc->buffer)
> > +		return -ENOMEM;
> > +
> > +	for_each_set_bit(bit, buffer->scan_mask, LRADC_MAX_TOTAL_CHANS) {
> > +		slot = mxs_lradc_map_channel(lradc, bit, LRADC_CHAN_FLAG_BUF);
> > +
> > +		if (slot < 0) {
> > +			ret = -EINVAL;
> > +			goto exit;
> > +		}
> > +		map |= 1 << slot;
> > +		chans |= 1 << bit;
> > +	}
> 
> I think this should go into the buffer preenable and postdisable callbacks.

How much of it, only the slot mapping or the allocation too ?

> > +
> > +	mxs_lradc_run_slots(lradc, map);
> > +
> > +	return 0;
> > +
> > +exit:
> > +	for_each_set_bit(bit, &chans, LRADC_MAX_TOTAL_CHANS)
> > +		mxs_lradc_unmap_channel(lradc, bit, LRADC_CHAN_FLAG_BUF);
> > +
> > +	kfree(lradc->buffer);
> > +
> > +	return ret;
> > +}
> > +
> > [...]
> > +/*
> > + * Buffer ops
> > + */
> > +static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
> > +	.preenable = &iio_sw_buffer_preenable,
> > +	.postenable = &iio_triggered_buffer_postenable,
> > +	.predisable = &iio_triggered_buffer_predisable,
> > +};
> 
> This is unused.

Bah, you're right. Shame on me :-(

> > [...]
> > +static int __devinit mxs_lradc_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mxs_lradc_data *data;
> > +	struct mxs_lradc *lradc;
> > +	struct iio_dev *iio;
> > +	struct resource *iores;
> > +	int ret = 0;
> > +	int i;
> > +
> > +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> > +	if (!lradc)
> > +		return -ENOMEM;
> > +
> > +	/* Grab the memory area */
> > +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	lradc->base = devm_request_and_ioremap(dev, iores);
> > +	if (!lradc->base)
> > +		return -EADDRNOTAVAIL;
> 
> I think this is a network error code, NXIO would be more approriate.

Will fix.

Thanks for the review!
