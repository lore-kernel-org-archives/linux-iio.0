Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:34497 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753413AbcIFNcK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Sep 2016 09:32:10 -0400
Message-ID: <57CEC64E.1030608@parrot.com>
Date: Tue, 6 Sep 2016 15:36:14 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/3] iio:pressure: initial zpa2326 barometer support
References: <cover.1472841954.git.gregor.boirie@parrot.com> <53b4bcc7b2d5de2ed61a0aeebf0898fd7b5aa2cb.1472841954.git.gregor.boirie@parrot.com> <c9370190-1859-ab66-eaac-8e7e1dbdbf0d@kernel.org>
In-Reply-To: <c9370190-1859-ab66-eaac-8e7e1dbdbf0d@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 09/04/2016 06:22 PM, Jonathan Cameron wrote:

[...]
>
> If I read this correctly (more than possible I don't) we are dropping
> any earlier elements in the fifo (which is really a filo as it feeds
> latest first just to confuse matters).
>
> It's odd to have the fifo only storing the pressures as it may mean if we
> use these extra readings we will end up out of sync between temps and
> presure readings.
exactly.

>
> hmm. Tricky little bit of hardware.
>
> If we don't use the hardware fifo (which I think we aren't really using
> at the moment) then why not support the trigger use for this device.
> The only critical difference is whether we are in oneshot / continuous
> mode.  If we detect that the device is using 'our' trigger then
> run in continuous mode, if not then run in oneshot?  Bit fiddly in exactly
> where you read the data, but not too bad I think...
This would add an extra layer of "nested interrupt" handling. Given we
run at pace <= 23 Hz, this would not really matter from a performance
perspective.
Perhaps, a bit of additional software complexity but keeping it compliant
withusual ways of playing with triggers.

>
> In theory I'd like to see that fifo used though so you will end up with
> what you have now..  Issue is we can't make the switch later as it
> would involve ABI breakage for any existing users.  Ah. Just sanity
> checked the data rate.  Max 23 Hz! Don't worry about using the fifo
> to buffer data if you don't want to - it's more pain than it's worth perhaps.
>
> Right now we export a trigger on the back of any read.. You would have
> to stop doing that and instead do it on the back of the dataready interrupt.
>
> So I'd propose (and this may not work so feel free to point out why).
>
> * A conventional dataready interrupt trigger. If its used by this device, then
> the pollfunc would do the actual read.
I would need to ensure the pollfunc is not dispatched as long as no real
data are available. This is feasible at the cost of an extra threaded 
interrupt
handler I think.

>
> The nasty here is that we need to validate that the trigger is associate
> with this device 'before' allowing others to associate.  Could be done I
> think in a slightly more than average complexity validate call.
>
> * If another trigger is used then pollfunc would have to initialize a oneshot
> read as you already have it doing.
>
> I'd ignore the fifo entirely except as somewhere to get the latest reading
> from.  It's slow enough and short enough to not matter much.
>
> This ends up rather like Linus Waleij did in his invense gyro driver which
> is another device with fairly similar hardware to this...
> Short fifo, only tells us when it's got something or not rather than allowing
> a threshold...
>
> Anyhow, this wouldn't (I think) be too major a chance and crucially it'd
> get rid of the 'confusing' userspace interface of not setting the trigger
> to the one provided by the device.
I thought you would say this :) I'll give it a try.

[...]

> +/**
> + * zpa2326_dequeue_pressure() - Retrieve the most recent pressure sample from
> + *                              hardware FIFO.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @pressure:  Sampled pressure output.
> + *
> + * Note that ZPA2326 hardware FIFO stores pressure samples only.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_dequeue_pressure(const struct iio_dev *indio_dev,
> +				    u32                  *pressure)
> +{
> +	int err = zpa2326_read_byte(indio_dev, ZPA2326_STATUS_REG);
> +	int cleared = -1;
> +
> +	if (err < 0)
> +		return err;
> +
> +	*pressure = 0;
> +
> +	if (err & ZPA2326_STATUS_P_OR) {
> +		/*
> +		 * Fifo overrun : first sample dequeued from FIFO is the
> +		 * newest.
> +		 */
> +		zpa2326_warn(indio_dev, "FIFO overflow");
> +
> +		err = zpa2326_read_block(indio_dev, ZPA2326_PRESS_OUT_XL_REG, 3,
> +					 (u8 *)pressure);
> +		if (err)
> +			return err;
> +
> +#define ZPA2326_FIFO_DEPTH (16U)
> +		/* Hardware FIFO may hold no more than 16 pressure samples. */
> +		return zpa2326_clear_fifo(indio_dev, ZPA2326_FIFO_DEPTH - 1);
> +	}
> +
> +	/*
> +	 * Fifo has not overflown : retrieve newest sample. We need to pop
> +	 * values out until FIFO is empty : last fetched pressure is the newest.
> +	 * In nominal cases, we should find a single queued sample only.
> +	 */
> +	do {
> +		err = zpa2326_read_block(indio_dev, ZPA2326_PRESS_OUT_XL_REG, 3,
> +					 (u8 *)pressure);
> +		if (err)
> +			return err;
> +
> +		err = zpa2326_read_byte(indio_dev, ZPA2326_STATUS_REG);
> +		if (err < 0)
> +			return err;
> +
> +		cleared++;
> +	} while (!(err & ZPA2326_STATUS_FIFO_E));
> +
> +	if (cleared)
> When running without trigger we could push these into the software fifo?
> (or am I just confused which is more than likely!)
zpa2326_dequeue_pressure() is currently used in INDIO_BUFFER_SOFTWARE and
INDIO_BUFFER_TRIGGERED modes only. Pushing a pressure sample acquired during
previous round in INDIO_BUFFER_SOFTWARE mode would imply:
* no related timestamp unless an intermediate software fifo be populated 
at hard
interrupt time (something like mpu6050 I think)
* no consistent related temperature sample.
Within our application context, this seems rather useless (heavy 
temporal and
frequential filtering is done in userspace).

Moreover, implementing an intermediate fifo layer would require an 
additional
recover strategy to aggregate timestamp/temperature/pressure samples in 
a coherent
manner. As you told before. Doesit really worth the pain ?

>> +		/*
>> +		 * Samples were pushed by hardware during previous rounds but we
>> +		 * didn't consume them fast enough: inform user.
>> +		 */
>> +		zpa2326_warn(indio_dev, "cleared %d FIFO entries", cleared);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * zpa2326_fill_sample_buffer() - Enqueue new channel samples to IIO buffer.
>> + * @indio_dev: The IIO device associated with the sampling hardware.
>> + * @private:   Internal private state related to @indio_dev.
>> + *
>> + * Return: Zero when successful, a negative error code otherwise.
>> + */
>> +static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
>> +				      const struct zpa2326_private *private)
>> +{
>> +	struct {
>> +		u32 pressure;
>> +		u16 temperature;
>> +		u64 timestamp;
>> +	}   sample;
>> +	int err;
>> +
>> +	if (test_bit(0, indio_dev->active_scan_mask)) {
>> +		/* Get current pressure from hardware FIFO. */
>> +		err = zpa2326_dequeue_pressure(indio_dev, &sample.pressure);
>> +		if (err) {
>> +			zpa2326_warn(indio_dev, "failed to fetch pressure (%d)",
>> +				     err);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	if (test_bit(1, indio_dev->active_scan_mask)) {
>> +		/* Get current temperature. */
>> +		err = zpa2326_read_block(indio_dev, ZPA2326_TEMP_OUT_L_REG, 2,
>> +					 (u8 *)&sample.temperature);
> Could this lead to the situation where we are feeding newer temps out
> alongside old pressure readings?
>
> Wonderfully inconsistent and confusing hardware here ;)
Unlikely but may happen. Temperature samples are always available before 
pressure
ones. In theory, I suppose that when missing an interrupt we could end 
up with a
pressure sample from previous round with associated timestamp, and a 
temperature
sample from current one...

The only way to prevent this is to implement one-shot mode only. 
However, all
experiments showed that we cannot get more than 10 samples/sec in this mode
(compared to the 23/sec in continuous mode). Mostly because of the 
additional
bus overhead and the lower device data conversion rate.

[...]

> +/**
> + * zpa2326_handle_threaded_irq() - Interrupt bottom-half handler.
> + * @irq:  Interrupt line the hardware uses to notify new data has arrived.
> + * @data: The IIO device associated with the sampling hardware.
> + *
> + * Mainly ensures interrupt is caused by a real "new sample available"
> + * condition. This relies upon the ability to perform blocking / sleeping bus
> + * accesses to slave's registers. This is why zpa2326_handle_threaded_irq() is
> + * called from within a thread, i.e. not called from hard interrupt context.
> + *
> + * Return:
> + *   %IRQ_NONE - no consistent interrupt happened ;
> + *   %IRQ_HANDLED - there was new samples available.
> + */
> +static irqreturn_t zpa2326_handle_threaded_irq(int irq, void *data)
> +{
> +	struct iio_dev         *indio_dev = (struct iio_dev *)data;
> +	struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
> +	irqreturn_t             ret = IRQ_NONE;
> +
> +	/*
> +	 * Device works according to a level interrupt scheme: reading interrupt
> +	 * status de-asserts interrupt line.
> +	 */
> +	priv->result = zpa2326_read_byte(indio_dev, ZPA2326_INT_SOURCE_REG);
> +	if (priv->result < 0) {
> +		if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE)
> +			return IRQ_NONE;
> +
> +		goto complete;
> +	}
> +
> +	/* Data ready is the only interrupt source we requested. */
> +	if (!(priv->result & ZPA2326_INT_SOURCE_DATA_RDY)) {
> +		/*
> +		 * Interrupt happened but no new sample available: likely caused
> +		 * by spurious interrupts, in which case, returning IRQ_NONE
> +		 * allows to benefit from the generic spurious interrupts
> +		 * handling.
> +		 */
> +		zpa2326_warn(indio_dev, "unexpected interrupt status %02x",
> +			     priv->result);
> +
> +		if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE)
> +			return IRQ_NONE;
> +
> +		priv->result = -ENODATA;
> +		goto complete;
> +	}
> +
> +	/* New sample available: dispatch internal trigger consumers. */
> +	iio_trigger_poll_chained(priv->trigger);
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE) {
> +		/* Continuous sampling enabled: populate IIO buffer. */
> +		zpa2326_fill_sample_buffer(indio_dev, priv);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> This has me a little confused. This path is basically the completion of
> a oneshot read when in triggered buffer mode using say a hrt trigger?
It is. Currently, triggered buffer mode relies upon one-shot mode only.

[...]
>> +static irqreturn_t zpa2326_trigger_oneshot(int irq, void *data)
>> +{
>> +	struct iio_poll_func   *pf = data;
>> +	struct iio_dev         *indio_dev = pf->indio_dev;
>> +	struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
>> +
>> +	/* Start a one shot sampling cycle. */
>> +	if (zpa2326_start_oneshot(indio_dev))
>> +		goto err;
>> +
>> +	if (priv->irq <= 0) {
>> +		/* No interrupt available: poll for sampling completion. */
>> +		if (zpa2326_poll_oneshot_completion(indio_dev))
>> +			goto disable;
>> +
>> +		/* Only timestamp sample once it is ready. */
>> +		priv->timestamp = iio_get_time_ns(indio_dev);
>> +
>> +		/* Enqueue to IIO buffer / userspace. */
>> +		zpa2326_fill_sample_buffer(indio_dev, priv);
>> +	} else {
>> +		/* Interrupt handlers will timestamp and get samples for us. */
>> +		if (zpa2326_wait_oneshot_completion(indio_dev, priv))
>> +			goto disable;
>> +	}
>> +
>> +	/* Inform attached trigger we are done. */
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +	return IRQ_HANDLED;
>> +
>> +disable:
>> +	zpa2326_disable_device(indio_dev);
>> +err:
>> +	iio_trigger_notify_done(indio_dev->trig);
> Hmm. Not really the right return value - will result in a 'no one claimed
> this interrupt' problem.  It isn't really possible to return an error from
> an interrupt handler to anywhere useful.  I'd just return IRQ_HANDLED I think..
Agreed. Moreover this might have been caused by I2C bus transaction 
errors...

[...]
>> +static int zpa2326_postenable_ring(struct iio_dev *indio_dev)
>> +{
>> +	const struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
>> +	int                           err;
>> +
>> +	if (!priv->waken) {
>> +		/*
>> +		 * We were already power supplied. Just clear hardware FIFO to
>> +		 * get rid of samples acquired during previous rounds (if any).
>> +		 */
>> +		err = zpa2326_clear_fifo(indio_dev, 0);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
>> +		/* Prepare device for triggered buffering usage. */
>> +
>> +		if (priv->waken) {
>> +			/*
>> +			 * We have just been power supplied, i.e. device is in
>> +			 * default "out of reset" state, meaning we need to
>> +			 * properly reconfigure it for on trigger demand usage.
>> +			 */
>> +			err = zpa2326_config_oneshot(indio_dev, priv->irq);
>> +			if (err)
>> +				return err;
>> +		}
>> +
>> +		/* Plug our own trigger event handler. */
>> +		err = iio_triggered_buffer_postenable(indio_dev);
>> +		if (err)
>> +			return err;
>> +
>> +		/*
>> +		 * Switch back to low power. A complete one shot sampling cycle
>> +		 * will be started upon trigger notification.
>> +		 */
>> +		return zpa2326_disable_device(indio_dev);
>> +	}
>> +
>> +	/* Prepare then start continuous sampling session. */
> Hmm. adds to indentation but I'd prefer this to be under an else to
> raise it to an alternative to the above...
>> +
>> +	if (priv->waken) {
>> +		/*
>> +		 * We have just been power supplied, i.e. device is in default
>> +		 * "out of reset" state, meaning we need to unmask data ready
>> +		 * interrupt to process new samples.
>> +		 */
>> +		err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG1_REG,
>> +					 (u8)~ZPA2326_CTRL_REG1_MASK_DATA_RDY);
> Ah that suprised me.  So if I understand you correctly, it won't put stuff
> in the fifo unless dataready interrupt is on?  Would explain why you don't
> have a set_state for the trigger.
Well, not sure to understand you correctly there. The unmasking of interrupt
is there because we've just got out of reset and default reset state has
interrupt disabled.
Interrupt is used in all modes when available. It notifies software that a
hardware samplinground has just completed and that data are available :
* into the hardware fifo in continuous hardware mode 
(INDIO_BUFFER_SOFTWARE).
* into the top word of hardware fifo in one-shot 
mode(INDIO_BUFFER_TRIGGERED and
   INDIO_DIRECT_MODE).

If no interrupts are available, the hardware fifo will still be used as 
described above.
However, in continuoushardware mode we would have to continuously poll 
status register
to detect end of hardware sampling cycle.
This is why it is not implemented as it would put I2C bus under heavy load.

>
> +static int zpa2326_validate_device(struct iio_trigger *trigger,
> +				   struct iio_dev     *indio_dev)
> +{
> +	/*
> +	 * Using our own interrupt driven trigger to start a triggered buffer
> +	 * sampling round is pure nonsense: use continuous hardware sampling
> +	 * mode instead, i.e. %INDIO_BUFFER_SOFTWARE.
> +	 * Synchronize against an external trigger / device otherwise.
> +	 */
> +	if (indio_dev == (struct iio_dev *)iio_trigger_get_drvdata(trigger))
> +		return -EINVAL;
> Wow, this is the first driver I've seen that rejects it's own trigger.
> Can see your logic, but this may create some 'surprises' for userspace ;)
> Hmm. Not sure how we would provide an indication of applicability.
> Maybe we need some sort of attribute for triggers to give some indication
> of when they will work....  Job for another day but this definitely
> turned up expectations upsidedown!
>
> My initial thought would be to drop the trigger support entirely as too
> 'weird'.  Are you using it to drive other sensors?
That was the original idea yes. For synchronization purposes.
misunderstanding ? creativity ? hijack ? Choice is yours :)

[...]

>
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_trigger_ops zpa2326_trigger_ops = {
>> +	.owner           = THIS_MODULE,
>> +	.validate_device = zpa2326_validate_device,
> No set_trigger_state?  You can, I think, mask the interrupt.
Yes. Missing if relying upon traditional (own) trigger driven acquisition.
Rework ongoing.

[...]

>> +static int zpa2326_set_frequency(struct iio_dev *indio_dev, int hz)
>> +{
>> +	struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
>> +	int                     freq, err;
>> +
>> +	/* Check if requested frequency is supported. */
>> +	for (freq = 0; freq < ARRAY_SIZE(zpa2326_sampling_frequencies); freq++)
>> +		if (zpa2326_sampling_frequencies[freq].hz == hz)
>> +			break;
>> +	if (freq == ARRAY_SIZE(zpa2326_sampling_frequencies))
>> +		return -EINVAL;
>> +
>> +	/* Don't allow changing frequency if buffered sampling is ongoing. */
>> +	err = iio_device_claim_direct_mode(indio_dev);
>> +	if (err)
>> +		return err;
> No harm in doing the claim earlier in the function and makes it more
> obvious we aren't going to try under those circumstances. (slightly!)
You mean including local parameters checking block into critical section ?

[...]

Regards,
Grégor.
