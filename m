Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D925B0BB;
	Sun, 21 Jun 2026 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782058980; cv=none; b=o3Hru3MT/uDVxoF9OhJ8p22HrKjNDftqo5mfHf0D0xS7kc6bAlYlzuxtqi2RL5vbp3VqIYommxX3W6Yt2ClV739esOJNyZs2XKYFcGRZH59BndwxKyRQJlRHbRe2Ug68Pft3oAuY/pQpygaSWsMpE82Fn8Rg9L4Vg++oSltoxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782058980; c=relaxed/simple;
	bh=z10/lklRqkutWLnsDH5su8kVHjiE1KsxTtf/UyUoHbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8RHB78RmyDQKn7s53+A0qIbbK2bP3gd+kAxGinHVB2dnKLPqftnt6v4LHM8tCA9yNSju7eLT2gZOQzgCOcjGTwI3n8crN9sCcWG8WEGGni0afILDfrthZBqyqegGjfYYZuOONjI8N4j93egAqg8AxXz/N8K2nXQeWXIVL/E2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBcfAbmW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBcfAbmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E621F000E9;
	Sun, 21 Jun 2026 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782058978;
	bh=8Ux2wI9p7JOMBakNR+HAVd3CWTdKF1va7tlMnXbgy50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jBcfAbmW0KaTHmWz4OVabisehGjgO9Qf/Wf4J8p7O8TdULNVajlWyF2FGy5lzL0IH
	 mWUY8Dd0opMHuwUdzfmVV3W0FLpNUMhLOBbBxKglCsL9pAwjIdDiIUqtZX0Ky0c3kI
	 O0jS2Z+OrIFl73UKTBJ3yF4qutBquj35S2RuVbAN/n83zmyUtYytvJslsUUdV4D/OG
	 JnRHA7PwOrcPnL2jOZMsJMt1rrMLWjbJMBy+M2i2G5m8yqt/HZeNKbTa6VK24Rhi8i
	 S4kT2Rk/phxdGLXToc2/z5f9whMALHhti/rcbL5g1VGtMuX9PH+zxSDPXyHDy+aOB1
	 5s6FERNwB41Jw==
Date: Sun, 21 Jun 2026 17:22:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <conall.ogriofa@amd.com>, <michal.simek@amd.com>, <linux@roeck-us.net>,
 <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v10 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <20260621172247.3499cab0@jic23-huawei>
In-Reply-To: <20260618101414.3462934-5-salih.erim@amd.com>
References: <20260618101414.3462934-1-salih.erim@amd.com>
	<20260618101414.3462934-5-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 11:14:13 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Add threshold event support for temperature and supply voltage
> channels.
> 
> Temperature events:
>   - Rising threshold with configurable value on the device
>     temperature channel (current max across all satellites)
>   - Per-channel hysteresis as a millicelsius value
>   - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
> 
> Supply voltage events:
>   - Rising/falling threshold per supply channel
>   - Per-channel alarm enable via alarm configuration registers
> 
> The hardware supports both window and hysteresis alarm modes for
> temperature. This driver uses hysteresis mode, where the upper
> threshold triggers the alarm and the lower threshold clears it
> (re-arm point). The hardware has a single ISR bit per temperature
> channel with no indication of which threshold was crossed, so
> hysteresis mode is the natural fit. The lower threshold register
> is computed internally as (upper - hysteresis).
> 
> Hysteresis is stored in the driver as a millicelsius value,
> initialized from the hardware registers at probe. Writing the
> rising threshold or hysteresis recomputes the lower register.
> ALARM_CONFIG is hard-coded to hysteresis mode during init.
> 
> The hardware also provides a separate over-temperature (OT)
> threshold, but it is not exposed through IIO as it serves as a
> hardware safety mechanism for platform shutdown. OT will be
> exposed through the thermal framework in a follow-up series.
> 
> The interrupt handler masks active threshold interrupts (which are
> level-sensitive) and schedules a delayed worker to poll for condition
> clear before unmasking. When no hardware IRQ is available, event
> specs are not attached and interrupt init is skipped, since the
> I2C regmap backend cannot be called from atomic context.
> 
> When disabling a supply channel alarm, the group interrupt remains
> active if any other channel in the same alarm group still has an
> alarm enabled.
> 
> A devm cleanup action masks all interrupts on driver unbind to
> prevent unhandled interrupt storms after the IRQ handler is freed.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

There is some stuff from Sashiko that looks plausible.
https://sashiko.dev/#/patchset/20260618101414.3462934-1-salih.erim%40amd.com

Whilst the out of range temp thresholds might not be a bug
that causes anything particular bad to happen it would be nice
to report an error to userspace if a write is for something we
can't support.

There are some things that I can't figure out without data sheet
diving so I'll leave those for you to sanity check + some I think
we addressed in earlier discussions.
For a few of the things it raises I talk about them inline.

Note I didn't spot anything else (and probably wouldn't have
spotted these :(

Jonathan


> ---
> Changes in v10:
>   - Add Reviewed-by tag from Andy Shevchenko
>   - Add limits.h include for U16_MAX, S16_MIN, S16_MAX (Andy)
> 
> Changes in v9:
>   - Add minmax.h include for clamp() (Andy)
>   - Join sysmon_supply_thresh_offset to one line, change address
>     parameter to unsigned long for consistency (Andy)
>   - Combine mask declaration with initialization in
>     sysmon_read_event_config (Andy)
>   - Rename ier to mask in sysmon_write_event_config for
>     consistency with sysmon_read_event_config (Andy)
>   - Remove blank line in sysmon_update_temp_lower between
>     semantically coupled lines (Andy)
>   - Rename unmask to ier (u32) in sysmon_unmask_temp (Andy)
>   - Variable name and type consistency audit across all
>     event functions (Andy)
> 
> Changes in v8:
>   - Use MILLIDEGREE_PER_DEGREE in q8p7 conversion functions (Andy)
>   - Use regmap_test_bits() in sysmon_read_alarm_config (Andy)
>   - Join sysmon_parse_fw signature onto one line (Andy)
>   - Fix devm teardown race: replace devm_delayed_work_autocancel
>     with INIT_DELAYED_WORK; fold cancel_delayed_work_sync into
>     sysmon_disable_interrupts to prevent the worker from
>     re-enabling interrupts after the IRQ handler is freed (Sashiko)
>   - Drop devm-helpers.h include (no longer needed)
> 
> Changes in v7:
>   - Move TEMP threshold event onto channel 0; drop OT as
>     separate IIO channel -- OT is a hardware safety mechanism
>     better suited for the thermal framework follow-up (Jonathan)
>   - Use single temp_channels array; attach event spec to
>     channel 0 at runtime when IRQ is available, matching the
>     pattern used for supply channels (Jonathan)
>   - Remove sysmon_temp_thresh_offset; use SYSMON_TEMP_TH_UP
>     and SYSMON_TEMP_TH_LOW defines directly at call sites
>   - Return administrative state from temp_mask in
>     read_event_config instead of transient hardware IMR
>     (Jonathan, Sashiko)
>   - Add devm_add_action_or_reset to mask all HW interrupts
>     on driver unbind (Sashiko)
>   - Remove SYSMON_CHAN_TEMP_EVENT macro, SYSMON_ADDR_TEMP_EVENT,
>     SYSMON_ADDR_OT_EVENT, SYSMON_BIT_OT, SYSMON_OT_HYST_MASK,
>     OT_TH_LOW/UP registers, ot_hysteresis from struct
>   - Simplify sysmon_get_event_mask, sysmon_update_temp_lower,
>     sysmon_init_hysteresis -- all now operate on single TEMP
>     channel only
> 
> 
> Changes in v6:
>   - Remove types.h from header (not needed at any stage) (Andy)
>   - Macro brace on separate line for SYSMON_CHAN_TEMP_EVENT (Andy)
>   - switch(chan->type) in all event functions instead of cascading
>     if statements (Andy)
>   - switch(info) in read/write_event_value for nested
>     dispatch (Andy)
>   - Reversed xmas tree in sysmon_update_temp_lower and
>     sysmon_init_hysteresis (Andy)
>   - scoped_guard(spinlock_irq) with error check in
>     sysmon_unmask_worker (Andy)
>   - Combined regmap_read error check with || in
>     sysmon_iio_irq (Andy)
>   - Join devm_request_irq on one line (Andy)
>   - Fix fwnode_irq_get() to propagate only -EPROBE_DEFER;
>     treating all negatives as fatal broke probe on I2C nodes
>     without interrupts property
> 
> Changes in v5:
>   - clamp() instead of clamp_t() (Andy)
>   - regmap_assign_bits() instead of separate set/clear (Andy)
>   - Remove unneeded parentheses (2 places) (Andy)
>   - for_each_set_bit on single line (Andy)
>   - regmap_clear_bits() instead of regmap_update_bits() (Andy)
>   - Simplify unmask XOR to ~status & masked_temp (Andy)
>   - Add comment explaining unmask &= ~temp_mask logic (Andy)
>   - Split container_of across two lines (Andy)
>   - Move ISR write after !isr check to avoid writing 0 (Andy)
>   - unsigned int for init_hysteresis address param (Andy)
>   - Add comment explaining error check policy in worker/IRQ (Andy)
>   - Nested size_add() for overflow-safe allocation (Andy)
>   - Propagate negative from fwnode_irq_get() for
>     EPROBE_DEFER (Andy)
>   - Pass irq instead of has_irq to sysmon_parse_fw (Andy)
> 
> Changes in v4:
>   - Merge event channels into static temp array; two arrays
>     (with/without events) selected by has_irq (Jonathan)
>   - Event-only channels have no info_mask; their addresses are
>     logical identifiers, not readable registers
>   - Drop RAW for voltage events, keep PROCESSED only (Jonathan)
>   - Drop scan_type from event channel macro (Jonathan)
>   - Blank lines between call+error-check blocks (Jonathan)
>   - Fit under 80 chars on one line where possible (Jonathan)
>   - default case returns -EINVAL instead of break (Jonathan)
>   - sysmon_handle_event: return early in each case (Jonathan)
>   - guard(spinlock) in sysmon_iio_irq, return IRQ_NONE/IRQ_HANDLED
>     directly (Jonathan)
>   - Take irq_lock in write_event_config for temp_mask updates to
>     synchronize with unmask worker (Sashiko)
> 
> Changes in v3:
>   - IWYU: add new includes, group iio headers with blank line (Andy)
>   - Reduce casts in millicelsius_to_q8p7, consistent style with
>     q8p7_to_millicelsius (Andy)
>   - Use clamp_t with typed constants, remove tmp & U16_MAX (Andy)
>   - Use !! to return 0/1 from read_alarm_config (Andy)
>   - Use regmap_set_bits/clear_bits in write_alarm_config (Andy)
>   - Add comment explaining spinlock is safe (I2C never reaches
>     event code path) (Andy)
>   - Add comment explaining IMR negation logic (Andy)
>   - Split read_event_value/write_event_value parameters logically
>     across lines (Andy)
>   - Move mask/shift after regmap_read error check (Andy)
>   - Remove redundant else in read_event_value and
>     write_event_value (Andy)
>   - Use named constant for hysteresis bit, if-else not ternary
>     (Andy)
>   - Loop variable declared in for() scope (Andy)
>   - Add error checks in sysmon_handle_event (Andy)
>   - Use IRQ_RETVAL() macro (Andy)
>   - Use devm_delayed_work_autocancel instead of manual INIT +
>     devm_add_action (Andy)
>   - Use FIELD_GET/FIELD_PREP for hysteresis register bits
>     (Jonathan)
>   - Split OT vs TEMP handling with FIELD_GET (Jonathan)
>   - Rework hysteresis: store as millicelsius value, hardcode
>     ALARM_CONFIG to hysteresis mode, compute lower threshold
>     from (upper - hysteresis), initialize from HW at probe
>     (Jonathan)
>   - Remove falling threshold for temperature; single event
>     spec per channel with IIO_EV_DIR_RISING (Jonathan)
>   - Push IIO_EV_DIR_RISING events for temperature,
>     IIO_EV_DIR_EITHER for voltage (Jonathan)
> 
> Changes in v2:
>   - Reverse Christmas Tree variable ordering in all functions
>   - Named constants for hysteresis bits: SYSMON_OT_HYST_BIT,
>     SYSMON_TEMP_HYST_BIT instead of magic 0x1/0x2
>   - SYSMON_ALARM_BITS_PER_REG replaces magic number 32
>   - SYSMON_ALARM_OFFSET() helper macro deduplicates alarm register
>     offset computation
>   - BIT() macro for shift expressions in conversion functions
>   - Hysteresis input validated to single-bit range (0 or 1)
>   - Event channels only created when irq > 0 (I2C safety)
>   - Group alarm interrupt stays active while any channel in the
>     group has an alarm enabled
>   - write_event_value returns -EINVAL for unhandled types
>   - IRQ_NONE returned for spurious interrupts
>   - Q8.7 write path uses multiplication instead of left-shift
>     to avoid undefined behavior with negative temperatures
>   - (u16) mask prevents garbage in reserved register bits
>   - regmap_write return values checked for IER/IDR writes
>   - devm cleanup ordering: cancel_work before request_irq
>  drivers/iio/adc/versal-sysmon-core.c | 600 ++++++++++++++++++++++++++-
>  drivers/iio/adc/versal-sysmon.h      |  36 ++
>  2 files changed, 632 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 03a745d3fb4..50b5228aa22 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c


>  /*
>   * Static temperature channels (always present).
>   *
> @@ -52,6 +102,16 @@ static const struct iio_chan_spec temp_channels[] = {
>  	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
>  };
>  
> +static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
> +{
> +	*val = (raw_data * MILLIDEGREE_PER_DEGREE) >> SYSMON_FRACTIONAL_SHIFT;
> +}
> +
> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
> +{
> +	*raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / MILLIDEGREE_PER_DEGREE;
> +}
> +
>  static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
>  {
>  	int mantissa, format, exponent;
> @@ -69,6 +129,33 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
>  	*val = (mantissa * (int)MILLI) >> exponent;
>  }
>  
> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
> +{
> +	int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
> +	int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
> +	int scale, tmp;
> +
> +	scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
> +	tmp = (val * scale) / (int)MILLI;

See below. Overflow issue is if val is large enough that this overflows
before tmp is clamped, possibly giving unexpected values.

> +
> +	if (format)
> +		tmp = clamp(tmp, S16_MIN, S16_MAX);
> +	else
> +		tmp = clamp(tmp, 0, U16_MAX);
> +
> +	*raw_data = (u16)tmp;
> +}

...

> +
> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &reg_val);
> +			if (ret)
> +				return ret;
> +
> +			sysmon_q8p7_to_millicelsius(reg_val, val);
> +
> +			return IIO_VAL_INT;
> +
> +		case IIO_EV_INFO_HYSTERESIS:
> +			*val = sysmon->temp_hysteresis;
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_VOLTAGE:
> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		sysmon_supply_rawtoprocessed(reg_val, val);
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	u32 raw_val;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			sysmon_millicelsius_to_q8p7(&raw_val, val);
In this path, sashiko is asking whether it is possible for val to be sufficiently large
or negative that the calculation is going to given rather unexpected results.

Given in the read direction you assume it is suitable for passing in a U16, should we
have a check here? + error out if it is out of range?

> +
> +			ret = regmap_write(sysmon->regmap, SYSMON_TEMP_TH_UP, raw_val);
> +			if (ret)
> +				return ret;
> +
> +			/* Recompute lower = upper - hysteresis */
> +			return sysmon_update_temp_lower(sysmon);
> +
> +		case IIO_EV_INFO_HYSTERESIS:
> +			if (val < 0)
> +				return -EINVAL;
> +
> +			sysmon->temp_hysteresis = val;
> +
> +			return sysmon_update_temp_lower(sysmon);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_VOLTAGE:
> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		sysmon_supply_processedtoraw(val, reg_val, &raw_val);

There is another sashiko report about potential out of range val
here. Probably also want to check for that just as a way to improve
useability.

> +
> +		return regmap_write(sysmon->regmap, offset, raw_val);
There is also a comment on whether this is wiping out the fields in the
upper bits of the register. If it isn't (maybe they are read only?)
then a comment here would be good.

> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

