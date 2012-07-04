Return-Path: <lars@metafoo.de>
Message-ID: <4FF40044.90904@metafoo.de>
Date: Wed, 04 Jul 2012 10:35:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Wolfgang Denk <wd@denx.de>, Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
References: <1341368129-20468-1-git-send-email-marex@denx.de>
In-Reply-To: <1341368129-20468-1-git-send-email-marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/04/2012 04:15 AM, Marek Vasut wrote:
> This driver is very basic. It supports userland trigger, buffer and
> raw access to channels. The support for delay channels is missing
> altogether.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> [...]

The overall structure looks good, but a few things need to be addressed.
I also think the driver doesn't have to go through staging and could be put
in to the out-of-staging part of iio.


> +struct mxs_lradc {
> +	struct iio_dev		*iio;
> +	struct device		*dev;
> +	void __iomem		*base;
> +	int			irq[13];
> +	int			idis;
> +
> +	uint32_t		*buffer;
> +	struct iio_trigger	*trig;
> +
> +	struct mutex		map_lock;
> +	struct mxs_lradc_chan	channel[LRADC_MAX_TOTAL_CHANS];
> +	unsigned long		slot_map;
> +
> +	wait_queue_head_t	wq_data_avail[LRADC_MAX_MAPPED_CHANS];
> +	bool			wq_done[LRADC_MAX_MAPPED_CHANS];

This and it's usage looks a bit like an open-coded struct completion.

> +};
> +
> +struct mxs_lradc_data {
> +	struct mxs_lradc	*lradc;
> +};

Is there any reason not to use the mxs_lradc struct directly has the iio data?

>[...]
> +
> +/*
> + * Channel management
> + *
> + * This involves crazy mapping between 8 virtual channels the CTRL4 register
> + * can harbor and 16 channels total this hardware supports.
> + */

I suppose this means only a maximum 8 channels can be active at a time. I've
recently posted a patch which makes it easy to implement such a restriction.
http://www.spinics.net/lists/linux-iio/msg05936.html and
http://www.spinics.net/lists/linux-iio/msg05935.html for an example validate
callback implementation. In your case you'd check for bitmap_weight(...) <=
8. Those patches are not yet in IIO though.

> +static int mxs_lradc_map_channel(struct mxs_lradc *lradc,
> +				uint8_t channel, uint8_t flags)
> +{
> +	int ret;
> +
> +	/* Invalid channel */
> +	if (channel > LRADC_MAX_TOTAL_CHANS)
> +		return -EINVAL;
> +
> +	mutex_lock(&lradc->map_lock);
> +
> +	/* Channel is already mapped */
> +	if (lradc->channel[channel].flags) {
> +
> +		/* Channel is mapped to requested delay slot */
> +		lradc->channel[channel].flags |= flags;
> +		ret = lradc->channel[channel].slot;
> +		goto exit;
> +
> +	} else {	/* Channel isn't mapped yet */
> +		/* 8 channels already mapped, can't map any more */
> +		if (bitmap_full(&lradc->slot_map, LRADC_MAX_MAPPED_CHANS)) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		ret = find_first_zero_bit(&lradc->slot_map,
> +					LRADC_MAX_MAPPED_CHANS);
> +
> +		lradc->channel[channel].slot = ret;
> +		lradc->channel[channel].flags |= flags;
> +		lradc->slot_map |= 1 << ret;
> +
> +		writel(LRADC_CTRL4_LRADCSELECT_MASK(ret),
> +			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
> +		writel(channel << LRADC_CTRL4_LRADCSELECT_OFFSET(ret),
> +			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
> +
> +		writel(LRADC_CTRL1_LRADC_IRQ_EN(ret),
> +			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
> +
> +		writel(0, lradc->base + LRADC_CH(ret));
> +	}
> +
> +exit:
> +	mutex_unlock(&lradc->map_lock);
> +
> +	/* Return the slot the channel was mapped to */
> +	return ret;
> +}
> +
[...]
> +/*
> + * Raw I/O operations
> + */
> +static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> +			const struct iio_chan_spec *chan,
> +			int *val, int *val2, long m)
> +{
> +	struct mxs_lradc_data *data = iio_priv(iio_dev);
> +	struct mxs_lradc *lradc = data->lradc;
> +	int ret, slot;
> +
> +	if (m != 0)

I'd use the symbolic constant here IIO_CHAN_INFO_RAW

> +		return -EINVAL;
> +
> +	/* Map channel. */
> +	slot = mxs_lradc_map_channel(lradc, chan->channel, LRADC_CHAN_FLAG_RAW);
> +	if (slot < 0)
> +		return slot;
> +
> +	/* Start sampling. */
> +	mxs_lradc_run_slots(lradc, 1 << slot);
> +
> +	/* Wait for completion on the channel, 1 second max. */
> +	lradc->wq_done[slot] = false;
> +	ret = wait_event_interruptible_timeout(lradc->wq_data_avail[slot],
> +					       lradc->wq_done[slot],
> +					       msecs_to_jiffies(1000));
> +	if (!ret) {
> +		ret = -ETIMEDOUT;
> +		goto err;
> +	}
> +

How well will this work if the device is currrently in buffered mode? Maybe
it's better do disablow it by checking iio_buffer_enabled and return -EBUSY
if it returns true;

> +	/* Read the data. */
> +	*val = readl(lradc->base + LRADC_CH(slot)) & LRADC_CH_VALUE_MASK;
> +	ret = IIO_VAL_INT;
> +
> +err:
> +	/* Unmap the channel. */
> +	mxs_lradc_unmap_channel(lradc, chan->channel, LRADC_CHAN_FLAG_RAW);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info mxs_lradc_iio_info = {
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= mxs_lradc_read_raw,
> +};
> +
> +/*
> + * IRQ Handling
> + */
> +static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
> +{
> +	struct mxs_lradc *lradc = data;
> +	int bit;
> +	unsigned long reg = readl(lradc->base + LRADC_CTRL1);
> +
> +	/*
> +	 * Touchscreen IRQ handling code shall probably have priority
> +	 * and therefore shall be placed here.
> +	 */
> +
> +	/* Wake up each LRADC channel. */
> +	for_each_set_bit(bit, &reg, 8) {
> +		lradc->wq_done[bit] = true;
> +		wake_up_interruptible(&lradc->wq_data_avail[bit]);
> +	}
> +
> +	if (iio_buffer_enabled(lradc->iio)) {
> +		disable_irq_nosync(irq);
> +		lradc->idis = irq;

The whole disable_irq/enable_irq thing is a bit ugly, is it really necessary?

> +		iio_trigger_poll(lradc->iio->trig, iio_get_time_ns());
> +	}
> +
> +	writel(0x1fff, lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Trigger handling
> + */
> +static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct mxs_lradc_data *data = iio_priv(iio);
> +	struct mxs_lradc *lradc = data->lradc;
> +	struct iio_buffer *buffer = iio->buffer;
> +	int i, j = 0, slot;
> +
> +	for (i = 0; i < iio->masklength; i++) {
> +		if (!test_bit(i, iio->active_scan_mask))
> +			continue;

for_each_set_bit

> +
> +		slot = lradc->channel[i].slot;
> +
> +		lradc->buffer[j] = readl(lradc->base + LRADC_CH(slot));
> +		lradc->buffer[j] &= LRADC_CH_VALUE_MASK;
> +
> +		j++;
> +	}
> +
> +	if (iio->scan_timestamp) {
> +		s64 *timestamp = (s64 *)((u8 *)lradc->buffer +
> +					ALIGN(j, sizeof(s64)));
> +		*timestamp = pf->timestamp;
> +	}
> +
> +	iio_push_to_buffer(buffer, (u8 *)lradc->buffer, pf->timestamp);
> +
> +	iio_trigger_notify_done(iio->trig);
> +
> +	enable_irq(lradc->idis);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mxs_lradc_configure_trigger(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *iio = trig->private_data;
> +	struct mxs_lradc_data *data = iio_priv(iio);
> +	struct mxs_lradc *lradc = data->lradc;
> +	struct iio_buffer *buffer = iio->buffer;
> +	int slot, bit, ret = 0;
> +	uint8_t map = 0;
> +	unsigned long chans = 0;
> +
> +	if (!state)
> +		goto exit;
> +
> +	lradc->buffer = kmalloc(iio->scan_bytes, GFP_KERNEL);
> +	if (!lradc->buffer)
> +		return -ENOMEM;
> +
> +	for_each_set_bit(bit, buffer->scan_mask, LRADC_MAX_TOTAL_CHANS) {
> +		slot = mxs_lradc_map_channel(lradc, bit, LRADC_CHAN_FLAG_BUF);
> +
> +		if (slot < 0) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +		map |= 1 << slot;
> +		chans |= 1 << bit;
> +	}

I think this should go into the buffer preenable and postdisable callbacks.

> +
> +	mxs_lradc_run_slots(lradc, map);
> +
> +	return 0;
> +
> +exit:
> +	for_each_set_bit(bit, &chans, LRADC_MAX_TOTAL_CHANS)
> +		mxs_lradc_unmap_channel(lradc, bit, LRADC_CHAN_FLAG_BUF);
> +
> +	kfree(lradc->buffer);
> +
> +	return ret;
> +}
> +
> [...]
> +/*
> + * Buffer ops
> + */
> +static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
> +	.preenable = &iio_sw_buffer_preenable,
> +	.postenable = &iio_triggered_buffer_postenable,
> +	.predisable = &iio_triggered_buffer_predisable,
> +};

This is unused.

> +
> [...]
> +static int __devinit mxs_lradc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mxs_lradc_data *data;
> +	struct mxs_lradc *lradc;
> +	struct iio_dev *iio;
> +	struct resource *iores;
> +	int ret = 0;
> +	int i;
> +
> +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> +	if (!lradc)
> +		return -ENOMEM;
> +
> +	/* Grab the memory area */
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	lradc->base = devm_request_and_ioremap(dev, iores);
> +	if (!lradc->base)
> +		return -EADDRNOTAVAIL;

I think this is a network error code, NXIO would be more approriate.

[...]
> +	return ret;
> +}
> +
> [...]
