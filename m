Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA23FF8B9
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815198; cv=none; b=myKcp+TRgMgyVWdFoyP65tCq2B3M/uaa1K7arYXTNwOYwn8GGBblaChOu49Nr1QyQFlRZ4J08tlCkKRZ7U5OFZouXpcWRBD5gv+bbaUJ9X+3PAaO1RE9XYnrn6foZrCmLETpFwzfytLx6fMevc5AU9xbEV/uEzAVW0PLMB34/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815198; c=relaxed/simple;
	bh=/9OXIks+WP4Qc7si1AAqjvfvw+oOv7dC/ZCPndVP9jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5V/8S51wYTW0vOk90h8Igap0Mu5Ugt70cTF/5pI1IHRtSASdGaxXVeKe+lP6e7ZKt7CwBkzTZnl47JACmkEP/6SYdoNvZFEXDRg26Fo2ViwRPgvggZtdBdfQLeBJkf12ni7Qo8Io0rOB7NzMyYT4GEy4t6E/9VLkk09PrO09pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8jh1HSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8jh1HSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D1D1F000E9;
	Tue, 26 May 2026 17:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815196;
	bh=Whl82O5bRki/IYHh4IYfIYx03EKWrtCkR8DvK6czpQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N8jh1HSscNVVmYUIabAD/LO7mRRGfAtGRZgW6aQwVcwHGf+VtuJGpzUkFQSP1n/lQ
	 UaWoZxSjS+CarU3ZhIL/Ca+Cw0A6FPrApXn09mxy+djdl1UqoYXd1gggt7ri/sJZ81
	 P19xePIK5olmcbld+jrtWbJ2e3z6qkucg9X8fRvHVBpPxyUPNbIgWapGylO67fTj+G
	 G6D5aCgeKvk9Jjk6S1juqkmhpwKHTCdLG/Ncl4TrftwfBrQbsjAPuv+YwaKEEbXE2I
	 oEMXcZ8qMHV1U4DFD6IQXEEm5CyXbGWaoG/2xBz1dDQ1fhMTSpgox7v3TaGC8adBNq
	 hjB/4xMR0MVgw==
Date: Tue, 26 May 2026 18:06:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <20260526180629.75c10bde@jic23-huawei>
In-Reply-To: <DIRMWY4EUJYM.36YED21N67YBC@gmail.com>
References: <DIRMWY4EUJYM.36YED21N67YBC@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 11:02:47 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> Forwarded message from Javier Carrasco on Mon May 25, 2026 at 10:59 AM:
> On Mon May 25, 2026 at 2:13 AM CEST, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 8 potential issue(s) to consider:
> >
> > New issues:
> > - [High] Cache pollution of AF_TRIG causes unintended conversions and unnecessary I2C reads.
> > - [High] The trigger reference acquired via iio_trigger_get() is leaked on probe error paths and driver unbind.
> > - [High] PM runtime usage counter leaks if the driver unbinds while an event is enabled.
> > - [High] Sysfs read/write functions and trigger operations access hardware without acquiring a PM runtime reference.
> > - [High] Out-of-bounds array write in veml6031x00_trig_handler when the timestamp channel is enabled.
> > - [Medium] Dead event sysfs attributes are exposed when no IRQ is present.
> >
> > Pre-existing issues:
> > - [High] Unbalanced double-put of the runtime PM usage counter on driver unbind.
> > - [High] The shutdown action accesses I2C registers after PM runtime has been disabled.
> > --
> >
> > commit cbdd69d1454af4788d5d18a23d3fb6854c9981e9
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
> >> index 9968d4414dc96..c57aaa29abf30 100644
> >> --- a/drivers/iio/light/veml6031x00.c
> >> +++ b/drivers/iio/light/veml6031x00.c  
> >
> > [ ... ]
> >  
> >> @@ -136,6 +189,8 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
> >>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> >>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> >>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> >> +		.event_spec = veml6031x00_event_spec,
> >> +		.num_event_specs = ARRAY_SIZE(veml6031x00_event_spec),  
> >
> > [Severity: Medium]
> > Will this expose dead event sysfs attributes when no IRQ is present?
> >
> > When i2c->irq is 0, the driver registers veml6031x00_info_no_irq which lacks
> > event callbacks. However, this channel array unconditionally defines
> > event_spec and num_event_specs. The IIO core will parse these and expose
> > event sysfs files. Reading or writing these files will fail with -EINVAL
> > because the callbacks are NULL, which violates the sysfs API contract.
> >
> > [ ... ]
> >  
> 
> @Jonathan: is this how it really works? How can I then dynamically
> define even_spec to account for it?

Don't do it dynamically. Define two lots of static iio_chan_spec arrays
and pick between them similarly to how you've picked the iio_info structure.

Trying to do more clever dynamic creation or not of event controls in the IIO
core is something we could look at but it feels like just one of a lot of
cases and this particular one is best handled by the driver not providing
stuff that isn't used if there are no irqs.

> 

> 
> >> +static int veml6031x00_write_event_config(struct iio_dev *iio,
> >> +					  const struct iio_chan_spec *chan,
> >> +					  enum iio_event_type type,
> >> +					  enum iio_event_direction dir,
> >> +					  bool state)
> >> +{
> >> +	struct veml6031x00_data *data = iio_priv(iio);
> >> +	int ret;
> >> +
> >> +	guard(mutex)(&data->lock);
> >> +
> >> +	/* avoid multiple increments/decrements from one source */
> >> +	if (state == data->ev_en)
> >> +		return 0;
> >> +
> >> +	if (state) {
> >> +		ret = pm_runtime_resume_and_get(data->dev);  
> >
> > [Severity: High]
> > Could this leak the PM runtime usage counter if the driver unbinds?
> >
> > Enabling an event increments the PM runtime usage counter here. If the
> > driver is unbound via sysfs while an event is enabled, the IIO core does
> > not automatically disable the event. Since there is no unbind cleanup
> > mechanism to release the pending PM reference when data->ev_en is true,
> > does this keep the device powered on indefinitely?
> >
> > [ ... ]
> >  
> 
> @Jonathan: Does the IIO core let the event enabled? What is the
> approach to clear it then?

It would be tricky to do it in the core because it doesn't actually know
what events are enabled - they can have complex interactions which are
driver specific - i.e. enabling one event can turn another one off under
the hood.  So it's a driver problem to solve. It can't immediately think of
a good example for you to copy.  Basically will boil down to keeping track
of whether an event is enabled, and decrementing runtime pm counters
appropriately in the remove path.

> 
> >> +/* AF_TRIG is reset by hardware, but the rest of the fields are persistent */
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
> > Can this cause unintentional active force conversions due to cache pollution?
> >
> > This sets the self-clearing AF_TRIG bit using regmap_update_bits().
> > Because CONF0 is not marked as a volatile register, regmap_update_bits()
> > writes AF_TRIG=1 and caches it. Any subsequent read-modify-write on CONF0
> > (e.g., toggling the interrupt or changing integration time) will read the
> > cached AF_TRIG=1 and write it back to hardware, unintentionally triggering
> > an active force conversion and causing hardware state corruption.
> >
> > [ ... ]
> >  
> 
> I will define the CONF0 register as volatile to account for this.

Nasty side effect for a configuration register!

> 
> >>  static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> >>  {
> >>  	struct iio_poll_func *pf = p;
> >>  	struct iio_dev *iio = pf->indio_dev;
> >>  	struct veml6031x00_data *data = iio_priv(iio);
> >>  	int ch, ret, i = 0;
> >>  	struct {
> >>  		__le16 chans[2];
> >>  		aligned_s64 timestamp;
> >>  	} scan = { };
> >>
> >>  	if (*iio->active_scan_mask == (BIT(VEML6031X00_SCAN_ALS) |
> >>  				       BIT(VEML6031X00_SCAN_IR))) {
> >>  		ret = regmap_bulk_read(data->regmap,
> >>  				       VEML6031X00_REG_ALS_L,
> >>  				       &scan.chans, sizeof(scan.chans));
> >>  		if (ret)
> >>  			goto done;
> >>  	} else {
> >>  		iio_for_each_active_channel(iio, ch) {
> >>  			ret = regmap_bulk_read(data->regmap,
> >>  					       iio->channels[ch].address,
> >>  					       &scan.chans[i++],  
> >
> > [Severity: High]
> > Does this loop cause an out-of-bounds array write if the timestamp
> > channel is enabled?
> >
> > The iio_for_each_active_channel() loop does not exclude the soft timestamp
> > channel. If the user enables ALS, IR, and TIMESTAMP channels, the loop
> > iterates 3 times. However, the scan.chans array is declared as
> > __le16 chans[2]. Processing the timestamp channel increments the index i
> > to 2 and writes to scan.chans[2], causing an out-of-bounds memory write.
> >
> > Furthermore, because the timestamp channel's address is 0, this incorrectly
> > attempts a bogus I2C read from VEML6031X00_REG_CONF0.
> >
> > [ ... ]
> >  
> 
> Not sure if this is a real issue, and the address for channel 0 is not
> CONF0 because it is defined in iio_chan_spec
> veml6031x00_channels.address.

It's not a real issue.  The macro 'looks' like it iterates over the timestamp
channel - but in reality that bit is never set in the bitmask.  David threw
together a change to that macro to fix this up but I don't know if we've yet
audited for any 'odd' handling that relied on the property.

Anyhow, this is probably the most common false positive we get from Sashiko
and in reality it's because I took a short cut long ago in that macro design.

> 
> >> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
> >> +{
> >> +	struct veml6031x00_data *data = iio_priv(iio);
> >> +	struct device *dev = data->dev;
> >> +	int ret;
> >> +
> >> +	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d", iio->name,
> >> +					    iio_device_id(iio));
> >> +	if (!data->trig)
> >> +		return -ENOMEM;
> >> +
> >> +	data->trig->ops = &veml6031x00_trigger_ops;
> >> +	iio_trigger_set_drvdata(data->trig, iio);
> >> +
> >> +	ret = devm_iio_trigger_register(dev, data->trig);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	iio->trig = iio_trigger_get(data->trig);  
> >
> > [Severity: High]
> > Is the trigger reference acquired here leaked on driver unbind?
> >
> > Calling iio_trigger_get() increments the trigger device's refcount and the
> > driver module's refcount. If the driver fails probe afterwards or is unbound
> > later, iio_trigger_put() is never called because there is no devres action
> > registered for it and no custom remove callback. Does this permanently leak
> > the trigger device reference and prevent the module from being unloaded?
> >
> > [ ... ]
> >  
> 
> Same here. I believe that only industrialio-trigger.c makes use of
> iio_trigger_put().
That's a known bug that we need to fix across all drivers.  It's a little fiddly
to actually solve. I've been saying I'll get to it but been too busy for a while.
Until sashiko complained all we had was a thread from a long time back saying
'we should fix this' :)

> 
> >> @@ -618,6 +1039,10 @@ static int veml6031x00_probe(struct i2c_client *i2c)  
> >
> > [ ... ]
> >  
> >>  	ret = devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action, data);  
> >
> > [Severity: High]
> > This is a pre-existing issue, but does this shutdown action access I2C
> > registers after PM runtime has been disabled?
> >
> > This action is registered via devm_add_action_or_reset() before PM runtime
> > is enabled. On teardown, devm actions run in reverse, meaning PM runtime is
> > disabled before the shutdown action runs. The shutdown action then attempts
> > I2C writes while PM runtime is disabled. If the device was suspended, it
> > cannot be resumed, potentially causing I2C transfer failures.
> >
> > [ ... ]
> >  
> >>  	pm_runtime_put_autosuspend(dev);  
> >
> > [Severity: High]
> > This is a pre-existing issue, but is there an unbalanced double-put of the
> > runtime PM usage counter on driver unbind?
> >
> > The probe function registers a cleanup action to drop the PM reference via
> > devm_pm_runtime_get_noresume(dev). However, this explicit put at the end
> > of probe means the devm action will drop the reference a second time on
> > unbind, causing a PM usage counter underflow that breaks the PM runtime
> > state machine.  
> 
> As I said for [2/4], there won't be any counter underflow that way.
> 
> Best,
> Javier
> 
> 
> 

