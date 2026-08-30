Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE423264EA;
	Sun, 30 Aug 2026 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128669; cv=none; b=oeyVGlMKx0scgoTeRgQIionPDKr1ceQgkvhJhd8RrxDnzkvldvBgdigJS7E4EN/Ce3Cw24dVsUz3M8PJwNZ7SMOxySUh03fiFaloqy9/TGckCDEPKboGuk3uYG7YsclQ3unRzbNARK+kkMKZq/8EjZeDxNO1pW7/6PGreo5ANag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128669; c=relaxed/simple;
	bh=7mlg592UKo4irG4pfdYiml3muHCQSKGwIZiZ6ryFJaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahxPPNrMNN83LgWitP4WYPr25Jfj/KRRo+2C9G7Lu2GAYKzFZ5QzUyqk6Sn2S84IKiW2Sfdtv5Kc1KLB1PZMT9YqvHP9nmiidQCyKijmnqWkv/adXkfFANTDzfW14C7qbp0Y4lRzqLweDIQwQqkRDw4ta3faAC6HovxJKkNfrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izn9r6pZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izn9r6pZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891B51F000E9;
	Sun, 30 Aug 2026 22:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788128663;
	bh=WzzoMoO1mOMpYrg6uZqi+d+FYmE5d1injl9uO4DBT+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Izn9r6pZ3M0J87vzsU5T0Emluhs9nzHlknu4+PYl5cLVZ4jqz5jK18xgCR08Zjyxl
	 JsbHJOcqDW3+O5mIb1xupdZH0uQxr4WnSbdeB2qn7qOWcd2TpvtNY9kyS6Tjzy5Aii
	 Hy/7Mc4IvstKP4rrkd0m/fNy4+3Lulj+CzQZYOrCxd3dScHtIA9hMQ99qLW6jUiML0
	 sJ9A8KacmC7zb01RosdHjLdVBnRmIxek8/VO+z+q1Dq0mw99kAoANnqkEqPwQzBitv
	 TKboEbi/YLecMmXActNiNEroE1N6fb+922GuqlYxeX/qxe8fvrsC5eOhPEEaTT4yPk
	 J83alm3urLGWw==
Date: Sun, 30 Aug 2026 23:24:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
Message-ID: <20260830232418.10f23462@jic23-huawei>
In-Reply-To: <178812363490.2788519.7648614173312615575.b4-review@b4>
References: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
	<20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com>
	<178812363490.2788519.7648614173312615575.b4-review@b4>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 22:00:34 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > Add support for continuous mode in the TI ADS112C14 ADC driver. In this
> > mode the ADC itself is starting each conversion, so we add a trigger
> > based on the DRDY interrupt to read each sample. This mode is also
> > limited in that only one channel can be enabled at a time since the
> > chip does not have a sequencer or simultaneous sampling capability.
> > Continuous mode will only be used when this new trigger is the current
> > trigger.
> > 
> > Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>  
> Sashiko caught some interesting things in this one.
> 
> See inline.

Sorry - messed up my use of b4 review tui and failed to include the
sashiko blobs I was talking about. I can't work out how to reply to review
I already did in there, so doing this via cut and paste.

> 
> >
> > diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> > index 23f15be303fb..878764deffc5 100644
> > --- a/drivers/iio/adc/ti-ads112c14.c
> > +++ b/drivers/iio/adc/ti-ads112c14.c
> > @@ -9,6 +9,7 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/bitmap.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/completion.h>
> >  #include <linux/crc8.h>
> > @@ -18,6 +19,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/trigger.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/interrupt.h>
> > @@ -257,6 +259,7 @@ struct ads112c14_measurement {
> >  struct ads112c14_data {
> >  	const struct ads112c14_chip_info *chip_info;
> >  	struct regmap *regmap;
> > +	struct iio_trigger *drdy_trig;
> >  	/* Synchronizes access to register value fields. */
> >  	struct mutex lock;
> >  	int drdy_irq;
> > @@ -280,11 +283,18 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
> >  	struct iio_dev *indio_dev = private;
> >  	struct ads112c14_data *data = iio_priv(indio_dev);
> >  
> > -	complete(&data->drdy_completion);
> > +	if (indio_dev->trig && iio_trigger_using_own(indio_dev))  
> 
> 
 | sashiko.dev <sashiko@sashiko.dev>:
 |
 | [Severity: Critical]
 | Can this sequence race with a concurrent sysfs write?
 |
 | If a direct read is initiated and indio_dev->trig is checked without a lock,
 | could a concurrent sysfs write to current_trigger nullify or free the
 | trigger right before iio_trigger_using_own() dereferences it, leading to a
 | NULL pointer dereference or use-after-free crash?

> This indeed needs more guarding given we hit these interrupts for
> a normal read (to get to the completion)
> 
> 
 |
 | [Severity: High]
 | Does this logic cause direct reads to hang?
 |
 | During a direct read (e.g., via sysfs) while the buffer is disabled but a
 | trigger is assigned, this condition evaluates to true. Will this route the
 | interrupt completion to iio_trigger_poll(), leaving the direct read waiting
 | indefinitely for data->drdy_completion and resulting in a timeout?
 |
 | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com

> Likewise seems valid.
> 
> > +		iio_trigger_poll(data->drdy_trig);
> > +	else
> > +		complete(&data->drdy_completion);
> >  
> >  	return IRQ_HANDLED;
> >  }  
> 
> ...
> 
> >  static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
> >  {
> >  	struct iio_poll_func *pf = private;
> > @@ -961,6 +984,26 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
> >  	u32 i;
> >  	int ret;
> >  
> > +	if (iio_trigger_using_own(indio_dev)) {  
> 
>  | sashiko.dev <sashiko@sashiko.dev>:
>  |
>  | [Severity: High]
>  | Will this check incorrectly enable continuous mode processing for any
>  | external trigger that belongs to its own device?
>  |
>  | If a user assigns an external trigger that sets its attached_own_device
>  | property to true, iio_trigger_using_own() will evaluate to true. Could this
>  | misroute the interrupt handler into assuming continuous mode when it should
>  | not?
>  |
>  | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com
> 
> I think this is triggered by the more complex handling you have
> to detect use of the dataready trigger below.  There is only one trigger
> currently so they end up the same, but perhaps we should make the handling
> more similar?
> 
> > +		const struct iio_chan_spec *chan;
> > +
> > +		chan = ads112c14_first_active_channel(indio_dev);
> > +		if (!chan)
> > +			goto out;
> > +
> > +		ret = ads112c14_scan_read(data, (u8 *)&data->scan[0]);  
> 
>  | sashiko.dev <sashiko@sashiko.dev>:
>  |
>  | [Severity: High]
>  | This is a pre-existing issue, but is there a missing length check in the
>  | underlying I2C block read that leaves stack memory partially uninitialized?
>  |
>  | If i2c_smbus_read_i2c_block_data() (called by ads112c14_scan_read()) returns
>  | a positive value smaller than the requested length, the condition if (ret < 0)
>  | fails to catch the short read. Does this leak uninitialized stack memory to
>  | userspace when data->scan is later pushed to the IIO buffers?
>  |
>  | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com
> 
> I haven't chased this one through - but in a similar example in a review
> I did yesterday I suggested just initializing the memory anyway
> so we don't have to care one way or the other.
> 
> > +		if (ret) {
> > +			dev_err_once(indio_dev->dev.parent,
> > +				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
> > +				     chan->channel, ERR_PTR(ret));
> > +			goto out;
> > +		}
> > +
> > +		iio_push_to_buffers_with_ts(indio_dev, data->scan,
> > +					    sizeof(data->scan), pf->timestamp);
> > +		goto out;
> > +	}
> > +
> >  	iio_for_each_active_channel(indio_dev, i) {
> >  		const struct iio_chan_spec *chan = &indio_dev->channels[i];
> >  
> > @@ -992,6 +1035,88 @@ static const struct iio_info ads112c14_info = {
> >  	.read_label = ads112c14_read_label,
> >  };
> >    
> 
> ...
> 
> > +static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ads112c14_data *data = iio_priv(indio_dev);
> > +	const struct iio_chan_spec *chan;
> > +	int ret;
> > +
> > +	if (!ads112c14_using_drdy_trigger(indio_dev))
> > +		return 0;
> > +
> > +	chan = ads112c14_first_active_channel(indio_dev);
> > +	if (!chan)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = ads112c14_prepare_channel(data, chan);  
> 
 | sashiko.dev <sashiko@sashiko.dev>:
 |
 | [Severity: High]
 | Can a user bypass the single-channel limitation and push corrupted data
 | to the ring buffer here?
 |
 | Since ads112c14_validate_scan_mask() allows multiple channels if a non-DRDY
 | trigger is currently selected, a user could enable multiple channels via
 | scan_elements, then switch current_trigger to the DRDY trigger before
 | enabling the IIO buffer.

> 
> Hmm. Indeed an interesting corner...  From a quick look it is correct.
> I'm not sure if this is in practice an existing bug - do other
> drivers change acceptable channels based on another change such as
> which trigger is in use?   Either way we need to close this.
> 
> We can't just go clearing the set bits on setting the trigger as
> that might cause a regression.  So I think all we can do is add
> a well commented additional check early in the buffer enable path.
> 
> Given the behaviour that is causing problems is present in this
> driver we could either add the protection in fix and rely on that
> going upstream first, or add it as first patch in this series and
> let it work its way upstream with this patch.
> 
> Nice catch to sashiko!
> 

 |
 | Because this driver does not provide an available_scan_masks array, the
 | mask isn't re-validated during buffer enablement. Since
 | ads112c14_buffer_postenable() only configures the first active channel,
 | will the trigger handler push uninitialized heap memory for the remaining
 | channels when the full array is sent to userspace?
 |
 | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com

I think that's all the feedback I replied to...

J
