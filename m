Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A0430E0DC;
	Mon,  1 Jun 2026 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311538; cv=none; b=pgPGFxCIy9WybKv/fTCYwDhvO6R+wfIfaHA5bYtieh3E+p+dU2QGhbmVIbS8h+S4DfXvVrPyTZ/REcKq9nC9A8ISLP2KMy5j/tbWqK6AnhVQDjMl9hdeY/0IXjqd4C711yl1eWDsvZw6g+wILIImuLFpGnqCVkACA8TFr6onY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311538; c=relaxed/simple;
	bh=ClByjCOq2WlbyOSqv0KRT+7uuZ8dxprqdTcSSRDV7ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVvoVX5SIsilF7EH6KRsc3vEaN4LVH0jhUkPrSYSWkHGWCKPow0vtkSzg9SCRM+UzsUl8Yl3/GrKbXNUQKSH0tRBlH5vwm6PALPZy1mr6t/3QKp7lnkHZcKFUwh/gGF1wM2+jDdcw36lr594eGsaUQol0Z30lGlyBtxtFNbTX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYYEQ39R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYYEQ39R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30DD1F00893;
	Mon,  1 Jun 2026 10:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780311536;
	bh=wha5nBMrWzJ0FhRTsE4v2aErw0mekdzOJMKKRc+sg/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jYYEQ39R1HQWyuJw+FejZLaoLSH8vGF54jAvYZPnG6uyfYu8280NlMYDcwBUorNxT
	 XqtwmjHYrFKXyj9N5+WUpii4C7QCp2U2nRS0+iN7yv5WBWbyRBUn1lGkKGndjx2/v3
	 q6/PdvqDBLYJ6Uc6s3d5lixJhzoWyXTmrV/qUCB/QEh9P3M6e6N0xf84xhVGf1wDML
	 lTmkL6mCSyJlPxvFbPSnCzPi7Yte4rHunRnMVKVA0vAarDuMWtmMn3DRoOl54tNzNB
	 rDXnlswJkDpR8MkiuMPupQhwP8RyG4O8C8zYwZZPxz7prHRtcFuGoHhfeXk2+lq+Hx
	 aBgaereGcs+mg==
Date: Mon, 1 Jun 2026 11:58:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: <sashiko-reviews@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <20260601115849.77564328@jic23-huawei>
In-Reply-To: <DIXMJH3581S0.5DHXMLATTOV1@gmail.com>
References: <20260531-veml6031x00-v4-4-e64f7fdce38d@gmail.com>
	<20260531204345.1C2A41F00893@smtp.kernel.org>
	<DIXMJH3581S0.5DHXMLATTOV1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Jun 2026 12:01:10 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> My view about the issues Sashiko reported.
> 
> On Sun May 31, 2026 at 10:43 PM CEST, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> >
> > New issues:
> > - [High] Missing `.validate_device` in trigger operations allows other devices to attach to a sensor-specific trigger.  
> 
> Tested with no real issues, but the trigger is mean for this device
> only.

We've always been a bit vague on whether the expectation is that a trigger
can be used by another device when not being used by this one.  It shouldn't
crash, but you may well not get data ;)

> 
> > - [High] PM runtime usage count is leaked if the device is unbound while events are enabled.  
> 
> The usage count is set to 0 by the devres action.

Rather than decrementing?

> 
> > - [High] Stale values in the regmap cache for the hardware-cleared `AF_TRIG` bit cause unintended triggers.  
> 
> Real issue, I forgot to set CONF0 as a volatile register.

If you set it volatile, I assume the dance around marking the cache as
wrong is not needed?

> 
> > - [Medium] Mixing `goto` error handling with `guard()` scope-based cleanup in the same function.  
> 
> Not a real issue because the goto's happen after the guard, but it's easy to
> get rid of them.
Please do.  Those rules are about code fragility rather than just bugs.


> 
> > - [Medium] Non-functional event sysfs attributes are exposed to userspace when the device lacks an IRQ.  
> 
> Missing fix to be added to V5.
> 
> >
> > Pre-existing issues:
> > - [High] Unbalanced PM runtime usage counter due to mixing devm action with manual put.  
> 
> Not a real issue because an underflow is not possible.

True, but still nice to balance if easily done.

> 
> > --
> >
> > commit c0654b1fbfc516c85d27a7c169844b649c2a1077
> > Author: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >
> > iio: light: veml6031x00: add support for events and trigger
> >
> > The device provides a shared interrupt line for to notify events and
> > data ready, which can be used as a trigger. The interrupt line is not a
> > requirement for the device to work. Implement variants for the cases
> > whether the interrupt line is provided or not.
> >  
> >> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> >> index facb1b8e42418..5e79eb942f09c 100644
> >> --- a/drivers/iio/light/veml6031x00.c
> >> +++ b/drivers/iio/light/veml6031x00.c  
> >
> > [ ... ]
> >  
> >> @@ -144,6 +197,8 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
> >>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> >>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> >>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> >> +		.event_spec = veml6031x00_event_spec,
> >> +		.num_event_specs = ARRAY_SIZE(veml6031x00_event_spec),  
> >
> > [Severity: Medium]
> > Will this unconditionally expose event sysfs attributes even when the device
> > lacks an IRQ?
> >
> > If i2c->irq is 0, the driver uses veml6031x00_info_no_irq to omit event
> > callbacks. However, the IIO core checks num_event_specs during
> > iio_check_for_dynamic_events() and creates sysfs attributes anyway. If these
> > attributes are accessed from userspace without the callbacks, will they
> > return -EINVAL?
> >  
> 
> This fix is also missing. I will add it to V5.
> 
> > [ ... ]
> >  
> >> +static int veml6031x00_set_af_trig(struct veml6031x00_data *data, bool state)
> >> +{
> >> +	regcache_drop_region(data->regmap, VEML6031X00_REG_CONF0,
> >> +			     VEML6031X00_REG_CONF0);
> >> +
> >> +	return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> >> +				  VEML6031X00_CONF0_AF_TRIG,
> >> +				  FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
> >> +}  
> >
> > [Severity: High]
> > Does this leave a stale AF_TRIG value in the non-volatile regmap cache?
> >
> > The AF_TRIG bit is cleared automatically by hardware. While this function
> > drops the cache region before setting the bit, VEML6031X00_REG_CONF0 is not
> > marked as volatile in veml6031x00_volatile_ranges. Because of this,
> > regmap_update_bits() writes the new value to hardware and also caches it.
> >
> > Would any subsequent updates to CONF0 (such as changing AF or SD bits) read
> > the cached AF_TRIG=1 and write it back, causing an unintended measurement
> > trigger?
> >  
> 
> Absolutely right, I forgot to update this although I said I would do it.
> 
> > [ ... ]
> >  
> >> +static int veml6031x00_write_event_config(struct iio_dev *iio,
> >> +					  const struct iio_chan_spec *chan,
> >> +					  enum iio_event_type type,
> >> +					  enum iio_event_direction dir,
> >> +					  bool state)
> >> +{
> >> +	struct veml6031x00_data *data = iio_priv(iio);
> >> +	int ret;
> >> +
> >> +	guard(mutex)(&data->irq_lock);
> >> +
> >> +	/* avoid multiple increments/decrements from one source */
> >> +	if (state == data->ev_en)
> >> +		return 0;
> >> +
> >> +	if (state) {
> >> +		ret = pm_runtime_resume_and_get(data->dev);
> >> +		if (ret)
> >> +			return ret;
> >> +	}  
> >
> > [Severity: High]
> > Is the PM runtime usage count leaked if the device is unbound while events
> > are enabled?
> >
> > The pm_runtime_resume_and_get() call keeps the device powered on, but there
> > does not appear to be a custom devres action or remove callback to disable
> > the event and drop this reference if the driver is unbound. Could this
> > prevent the parent I2C controller from ever entering runtime suspend?
> >  
> 
> The devres action that was registered in the probe function will
> decrement the counter if the driver is unbound. I explained the
> mechanism at the end of the mail.
> 
> > [ ... ]
> >  
> >> +static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool state)
> >> +{
> >> +	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
> >> +	struct veml6031x00_data *data = iio_priv(iio);
> >> +	int ret;
> >> +
> >> +	guard(mutex)(&data->irq_lock);
> >> +
> >> +	if (state == data->trig_en)
> >> +		return 0;
> >> +
> >> +	ret = veml6031x00_set_interrupt(data, state);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* The AF bit must be set before setting AF_TRIG */
> >> +	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> >> +				 VEML6031X00_CONF0_AF,
> >> +				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
> >> +	if (ret)
> >> +		goto err_disable_interrupt;
> >> +
> >> +	ret = veml6031x00_set_af_trig(data, state);
> >> +	if (ret)
> >> +		goto err_clear_af;  
> >
> > [Severity: Medium]
> > Is it safe to mix goto-based error handling with guard() scope-based cleanup
> > in this function?
> >
> > According to the cleanup subsystem guidelines, mixing goto with guard() or
> > __free() in the same function can create confusing ownership semantics.
> > Should this function either use goto entirely or be fully converted to
> > scoped cleanups?
> >  
> 
> The real issue arises when there are goto calls before the cleanup, but
> I think it is cleaner to get rid of all goto calls where cleanup magic
> is used. I will remove them and add function calls and error return
> in the error paths.
> 
> > [ ... ]
> >  
> >> +static const struct iio_trigger_ops veml6031x00_trigger_ops = {
> >> +	.set_trigger_state = veml6031x00_set_trigger_state,
> >> +};  
> >
> > [Severity: High]
> > Is a .validate_device callback needed here to prevent other devices from
> > attaching to this sensor-specific trigger?
> >
> > Without setting .validate_device to iio_trigger_validate_own_device, another
> > IIO device could attach to it. If that happens, veml6031x00_set_trigger_state()
> > would enable the DRDY interrupt while the sensor is PM runtime suspended
> > (since its own buffer_preenable isn't called). Would this cause the dependent
> > device's buffer captures to hang?
> >  
> 
> This trigger is intented to be used by its own device. I will add
> iio_trigger_validate_own_device to iio_trigger_ops.
> 
> > [ ... ]
> >  
> >> +static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *iio = pf->indio_dev;
> >> +	struct veml6031x00_data *data = iio_priv(iio);
> >> +	int ch, ret, i = 0;
> >> +	struct {
> >> +		__le16 chans[2];
> >> +		aligned_s64 timestamp;
> >> +	} scan = { };
> >> +
> >> +	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
> >> +	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
> >> +		ret = regmap_bulk_read(data->regmap,
> >> +				       VEML6031X00_REG_ALS_L,
> >> +				       &scan.chans, sizeof(scan.chans));
> >> +		if (ret)
> >> +			goto done;
> >> +	} else {
> >> +		iio_for_each_active_channel(iio, ch) {
> >> +			ret = regmap_bulk_read(data->regmap,
> >> +					       iio->channels[ch].address,
> >> +					       &scan.chans[i++],
> >> +					       sizeof(*scan.chans));  
> >
> > [Severity: High]
> > Does this loop inadvertently perform an I2C read from address 0 for the
> > software timestamp channel?
> >
> > When IIO_CHAN_SOFT_TIMESTAMP is active and the fast-path isn't taken, it
> > iterates over all active channels. Since the timestamp channel does not define
> > a hardware address, its .address is 0.
> >
> > Would regmap_bulk_read() read VEML6031X00_REG_CONF0 instead of data,
> > wasting I2C bandwidth and writing the configuration register's value into
> > the scan buffer just before the timestamp?
> >  
> 
> We have mentioned before that Sashiko is wrong about this. Is there any
> way to tell Sashiko why this is ok?
> 
> > [ ... ]
> >  
> >> @@ -677,12 +1102,21 @@ static int veml6031x00_probe(struct i2c_client *i2c)
> >>  	iio->channels = veml6031x00_channels;
> >>  	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
> >>  	iio->modes = INDIO_DIRECT_MODE;
> >>
> >>  	ret = veml6031x00_hw_init(iio);
> >>  	if (ret)
> >>  		return ret;
> >>
> >> +	if (i2c->irq) {
> >> +		ret = veml6031x00_setup_irq(i2c, iio);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		iio->info = &veml6031x00_info;
> >> +	} else {
> >> +		iio->info = &veml6031x00_info_no_irq;
> >> +	}
> >> +
> >>  	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
> >>  					      veml6031x00_trig_handler,
> >>  					      &veml6031x00_buffer_setup_ops);  
> >
> > [Severity: High]
> > This isn't a bug introduced by this patch, but is the PM runtime usage
> > counter unbalanced at the end of veml6031x00_probe()?
> >
> > The driver acquires a reference using devm_pm_runtime_get_noresume() which
> > associates a devres cleanup action. If pm_runtime_put_autosuspend() is
> > called manually at the end of probe (immediately after this buffer setup),
> > the devres cleanup will still fire when the device is unbound, performing a
> > second put. Could this cause the PM runtime usage counter to underflow
> > to -1?  
> 
> This cannot happen because the devres action uses pm_runtime_put_noidle(),
> which in turns uses atomic_add_unless(usage_count, -1, 0) to avoid
> decrementing the usage_count if it is already 0.
> 
> Best regards,
> Javier

