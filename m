Return-Path: <lars@metafoo.de>
Message-ID: <5453C494.4030906@metafoo.de>
Date: Fri, 31 Oct 2014 18:19:16 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
 linux-iio@vger.kernel.org, jic23@kernel.org, Naidu.Tellapati@imgtec.com,
 james.hartley@imgtec.com, abrestic@chromium.org
CC: Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 1/2] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com> <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 10/29/2014 09:45 PM, Ezequiel Garcia wrote:
> From: Phani Movva <Phani.Movva@imgtec.com>
>
> This commit adds support for Cosmic Circuits 10001 10-bit ADC device.
>
> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> [Ezequiel: code style cleaning]
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Looks very good. Just a few very minor issues.

[...]
> +static int cc_adc_poll_done(struct iio_dev *dev, int channel,
> +			    unsigned int delay)
> +{
> +	struct cc_10001_adc_device *adc_dev = iio_priv(dev);
> +	int val = INVALID_SAMPLED_OUTPUT;

I'm not so sure that returning a fake sample is such a good idea. When 
reading from sysfs we should definitely return an error if there is one. For 
buffer reading dropping the sample is probably not such a good idea, but we 
should agree on and document a standard representation of invalid samples.

> +	int poll_count = 0;
> +
> +	while (!(cc_adc_read_reg(adc_dev, CC_10001_ADC_EOC) &
> +			CC_10001_ADC_EOC_SET)) {
> +
> +		ndelay(delay);
> +		if (poll_count++ == MAX_POLL_COUNT)
> +			return val;
> +	}
> +
> +	poll_count = 0;
> +	while ((cc_adc_read_reg(adc_dev, CC_10001_ADC_CHSEL_SAMPLED) &
> +			CC_10001_ADC_CH_MASK) != channel) {
> +
> +		ndelay(delay);
> +		if (poll_count++ == MAX_POLL_COUNT)
> +			return val;
> +	}
> +
> +	/* Read the 10 bit output register */
> +	return cc_adc_read_reg(adc_dev, CC_10001_ADC_DDATA_OUT);
> +}
> +
> +static irqreturn_t cc_10001_adc_trigger_h(int irq, void *p)
> +{
> +	u16 *data;
> +	u16 val = 0;
> +	unsigned int delay_ns = 0;
> +	struct iio_dev *dev;
> +	struct iio_poll_func *pf = p;
> +	struct cc_10001_adc_device *adc_dev;
> +
> +	dev = pf->indio_dev;
> +	adc_dev = iio_priv(dev);
> +
> +	data = kmalloc(dev->scan_bytes, GFP_KERNEL);
> +	if (!data)
> +		goto done;

If you want to avoid having to run malloc/free for each captured sample you 
can allocate the buffer in the update_scan_mode() callback.

> +
> +	mutex_lock(&adc_dev->lock);
> +
> +	/* Power-up ADC */
> +	cc_adc_write_reg(adc_dev, CC_10001_ADC_POWER_DOWN, 1);
> +
> +	/* Wait for 8 (6+2) clock cycles before activating START */
> +	ndelay(adc_dev->start_delay_ns);
> +
> +	/* Calculate delay step for eoc and sampled data */
> +	delay_ns = (adc_dev->eoc_delay_ns / MAX_POLL_COUNT);
> +
> +	if (!bitmap_empty(dev->active_scan_mask, dev->masklength)) {
> +		int i, j;
> +		for (i = 0, j = 0;
> +		     i < bitmap_weight(dev->active_scan_mask, dev->masklength);
> +		     i++, j++) {
> +

This looks like a open-coded for_each_set_bit()

> +			j = find_next_bit(dev->active_scan_mask,
> +					  dev->masklength, j);
> +
> +			cc_adc_start(adc_dev, j);
> +			val = cc_adc_poll_done(dev, j, delay_ns);
> +			data[i] = val & CC_10001_ADC_DATA_MASK;
> +		}
> +	}
> +
> +	/* Power-down ADC */
> +	cc_adc_write_reg(adc_dev, CC_10001_ADC_POWER_DOWN, 0);
> +
> +	mutex_unlock(&adc_dev->lock);
> +
> +	iio_push_to_buffers_with_timestamp(dev, data, iio_get_time_ns());
> +
> +	kfree(data);
> +done:
> +	/*
> +	 * Tell the core we are done with this trigger and ready for the
> +	 * next one.
> +	 */
> +	iio_trigger_notify_done(dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
[...]
> +static int cc_10001_adc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct cc_10001_adc_device *adc_dev;
> +	unsigned long adc_clk_rate;
> +	struct resource *res;
> +	struct iio_dev *dev;
> +	int ret;
> +
> +	dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
> +	if (dev == NULL)
> +		return -ENOMEM;
> +
> +	adc_dev = iio_priv(dev);
> +
> +	if (of_property_read_u32(node, "cosmic,adc-available-channels", &ret)) {

So, what does available channels in this case mean. Channels that are connected?

> +		dev_err(&dev->dev, "Missing adc-available-channels property\n");
> +		return -EINVAL;
> +	}
[...]
> +
> +	ret = iio_triggered_buffer_setup(dev, NULL,
> +					&cc_10001_adc_trigger_h, NULL);

ret is not checked.

> +
> +	ret = iio_device_register(dev);
> +	if (ret < 0)
> +		goto err_cleanup_buffer;
> +
> +	platform_set_drvdata(pdev, dev);
> +
> +	return 0;
> +
> +err_disable_reg:
> +	regulator_disable(adc_dev->reg);
> +err_disable_clk:
> +	clk_disable_unprepare(adc_dev->adc_clk);
> +err_cleanup_buffer:
> +	iio_triggered_buffer_cleanup(dev);
> +	return 0;
> +}
[...]
