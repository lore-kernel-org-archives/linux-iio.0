Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECB2C08AC
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651225; cv=none; b=sQ6B1ZbB3bQJ4tMQIn9wg6FnRhrowXltKniSljQq1GZAD5WJOqLfVMpEAMFq76WpjRnkYcYFGVvMP/+fFZGR8MgFQZSP9TWe4FROn/Idsf4x3ng6SPNbvcW3Bc0zSoGYbpCWHsHi41XXdA34gM47SG+55pXWzTzY1hHwtI6oWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651225; c=relaxed/simple;
	bh=/DTBtqRqcC5OC0Dq6qFFmz4oUnj08UkYgankr+LjlKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP4O3KMuy9oIzF4jaE0j06X4IIjCYa6mcFwpTA3tQdVbuJj24LFWcHs0312k/Sa6bCrsJIPC3ktH+FXpP3CI39DejYFnaEuQ/6LmDl5GUnHa0OBkzpKdFMpsslFggHMrIbUfFZYo5aEU/KYRi3f6QxXDGMjz1fp4SLBAu6AeWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibGd73Ii; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibGd73Ii"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso113528345e9.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651221; x=1780256021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wm+7faE/KDZlzLz6DmGYDzcXfZCzeyf4YiUU7ixWxQg=;
        b=ibGd73IiupcxE1qNu/Y9tnfczfJo6nsJh/QtWJ9BX2FnGxrhon9h4O8bUbzRelOMMK
         4OtBehfa+vg1DIlf5QMpup534RE+lkBLtA/UXGBoMW1jD9a7Rb5XAtyLgyfMNYGQZ4SZ
         25cHIuw5qkzh/FUd01fmNDp0cq7q8lBFsYaeIy5AJxNSFUJRzbgCQZ2I+HQOMV/AUQQ4
         nxZiZ3OeyJ+SONS0iiXQLJhNrCMTvUGiDV7ZpD260DSFu4qYRk35KmokdEmrG1WiRKWX
         RpQXvY7tAunqrMsGuyYX24B+cJRE7pecybUDtcqbfS8T8OGR1V3ACCITIv+VQvRa+Sne
         wG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651221; x=1780256021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm+7faE/KDZlzLz6DmGYDzcXfZCzeyf4YiUU7ixWxQg=;
        b=GgZMJ8nlgrpCLg4sP+LIrHVCG1BquJeq896+PEAc+/JUHjxfbYLa3EHW7MZlrXEElm
         N86ixFivcQt7jskorP9NGlIEXD870hVlv6M6HmhgEK9AcFuKqyiN5l2r7dofBED6IlFy
         57fvopDBtyTzGYLxqDW0ve3PtqflPQM71J9vKlo20P0fKPphQutA81j1M8P/nO9vVAOh
         zOGmKC18i+UxBcR8cwA6mRZHaKoLsUrBXlGsyhZPsbQVAcYSXyEK8VJBkahHcElbHfnt
         sxN1khWX5ILrR1O6+9+twlBsIj4N8hZ1eMMXyyq3YkzXOvGHRukjg3XL1tJONLU4M7M+
         1L2w==
X-Forwarded-Encrypted: i=1; AFNElJ+7sjMdIJ0q8Lu6yueJ/cZZoYPbuXwAky45ApMcNDyab3QwdY8A7FYgn0q+48zbVtQ2315TGAaFaRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLBn334FDt7jFMicNX/T9puXJME9lU0RglX4HoUzbPYbCvet6
	S+HX6tCeMXlI7girre+NuL+JVNBjIdy6Hq8m45SxhOcp0qfOfX795x+b
X-Gm-Gg: Acq92OGK1weGfEpb9IVx3uaf+NpMr62a/GlYfIn7ZX4ZiYxmCShbEnbceBiBuonB3LL
	ZPxm724xkCNfTRd/kpfxUAnshSWidkZMzwN5z4Zeixa1qMfLzYuZ9GuPRNrD59Rp+DOSHqazjHU
	xWb8uXJXjNKa+Ep1sGVj1QNRopIXLGnzQe5OOIomnwpgwqb2WELPbcrHtC/aSfg4mXY19+schp8
	wfnQv7W+QvrzbJbHhTdNahB8J1d3bUNsWVmwweEGD9Wl/tUIhF55p8LoZ1Nh/mMR7pucIARGTuE
	OajPCd5nWtpr01fKXPNBErCEhTxyGyO939q3ZDlELS9PcAjyxc4fMhagkPzYdJ4sZh875WhMCFZ
	2XfNBvJfESf1Qz2XhWD5txecoOAaw8xrMtepaolVkluK2/MDab5JuGxwv2TiKewDMVOSVwzzMS2
	Ulz8c4
X-Received: by 2002:a05:600c:34d5:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-49052c07701mr121800875e9.20.1779651220946;
        Sun, 24 May 2026 12:33:40 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f58dsm20606500f8f.5.2026.05.24.12.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:33:40 -0700 (PDT)
Date: Sun, 24 May 2026 21:33:38 +0200
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] counter: add GPIO-based quadrature encoder driver
Message-ID: <gd24pjtj7gr72cliw35upqq4axmcjmsnnnlj4y2suhhrro3y7g@qqlxziw3nbu4>
References: <20260515153616.157605-3-wafgo01@gmail.com>
 <20260520044525.128529-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520044525.128529-1-wbg@kernel.org>

On 2026-05-20 13:45, William Breathitt Gray wrote:
> On Fri, May 15, 2026 at 05:36:15PM +0200, Wadim Mueller wrote:
> > Add a platform driver that turns ordinary GPIOs into a quadrature
> > encoder counter device.  The driver requests edge-triggered interrupts
> > on the A and B (and optional Index) GPIOs and decodes the quadrature
> > signal in software using a classic state-table approach.
> > 
> > Supported counting modes:
> >   - Quadrature X1 (count on A rising edge only)
> >   - Quadrature X2 (count on both A edges)
> >   - Quadrature X4 (count on every A and B edge)
> >   - Pulse-direction (A = pulse, B = direction)
> > 
> > An optional index signal resets the count to zero on its rising edge
> > when enabled through sysfs.  A configurable ceiling clamps the count
> > to [0, ceiling].
> > 
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> 
> Hi Wadim,
> 
> This driver supports non-quadrature modes such as pulse-direction and
> increase/decrease modes. Perhaps it's best to rename this driver to
> gpio-counter so that the name indicates the more general capabilities we
> have now. What do you think?

Agreed -- renamed accordingly in v5 (source file, Kconfig symbol,
compatible string, binding file, DT properties and MAINTAINERS).
Conor's v4 Acked-by on the binding is dropped because of this.

> 
> > +/*
> > + * Encode the four quadrature transitions in a single 4-bit state:
> > + *   bit3 = prev_a, bit2 = prev_b, bit1 = curr_a, bit0 = curr_b.
> > + *
> > + * Indexing the table with this value yields the signed delta for an
> > + * X4 decoder.  Illegal transitions (both inputs toggled at once)
> > + * remain 0 so the count is unchanged.
> > + */
> > +#define CREATE_QE_STATE(prev_a, prev_b, curr_a, curr_b) \
> > +	(((prev_a) << 3) | ((prev_b) << 2) | ((curr_a) << 1) | (curr_b))
> > +
> > +static const s8 gpio_qenc_quad_x4_table[16] = {
> > +	[CREATE_QE_STATE(0, 0, 0, 0)] =  0,
> > +	[CREATE_QE_STATE(0, 0, 0, 1)] = -1,
> > +	[CREATE_QE_STATE(0, 0, 1, 0)] =  1,
> > +	[CREATE_QE_STATE(0, 0, 1, 1)] =  0,
> > +	[CREATE_QE_STATE(0, 1, 0, 0)] =  1,
> > +	[CREATE_QE_STATE(0, 1, 0, 1)] =  0,
> > +	[CREATE_QE_STATE(0, 1, 1, 0)] =  0,
> > +	[CREATE_QE_STATE(0, 1, 1, 1)] = -1,
> > +	[CREATE_QE_STATE(1, 0, 0, 0)] = -1,
> > +	[CREATE_QE_STATE(1, 0, 0, 1)] =  0,
> > +	[CREATE_QE_STATE(1, 0, 1, 0)] =  0,
> > +	[CREATE_QE_STATE(1, 0, 1, 1)] =  1,
> > +	[CREATE_QE_STATE(1, 1, 0, 0)] =  0,
> > +	[CREATE_QE_STATE(1, 1, 0, 1)] =  1,
> > +	[CREATE_QE_STATE(1, 1, 1, 0)] = -1,
> > +	[CREATE_QE_STATE(1, 1, 1, 1)] =  0,
> > +};
> 
> I believe we can avoid the lookup table entirely by utilizing some
> simple bitwise operations.
> 
> Let's start with the "0" delta states:
> 
>     (PA, PB, CA, CB) = delta
>     ------------------------
>     (0, 0, 0, 0) =  0
>     (0, 1, 0, 1) =  0
>     (1, 0, 1, 0) =  0
>     (1, 1, 1, 1) =  0
>     (0, 0, 1, 1) =  0
>     (0, 1, 1, 0) =  0
>     (1, 0, 0, 1) =  0
>     (1, 1, 0, 0) =  0
> 
> A "0" delta is possible in two scenarios: either both signal levels
> remain the same, or both signal levels change. We can test for a nonzero
> delta using the following bitwise expression:
> 
>     HAS_NONZERO_DELTA = (PA ^ CA) ^ (PB ^ CB) = PA ^ PB ^ CA ^ CB
> 
> After that test, the remaining states are changes in a single Signal at
> a time:
> 
>     (PA, PB, CA, CB) = delta
>     ------------------------
>     (0, 0, 1, 0) =  1
>     (1, 0, 1, 1) =  1
>     (1, 1, 0, 1) =  1
>     (0, 1, 0, 0) =  1
>     (0, 0, 0, 1) = -1
>     (0, 1, 1, 1) = -1
>     (1, 1, 1, 0) = -1
>     (1, 0, 0, 0) = -1
> 
>     00 -> 10 -> 11 -> 01 -> 00 = FORWARD
>     00 -> 01 -> 11 -> 10 -> 00 = BACKWARD
> 
> The state change between previous and current is essentially a 2-bit
> Gray code. Gray code is designed such that successive values differ in
> only one bit. That means we can determine direction with just the
> previous state of Signal B (PB) and the current state of Signal A (CA):
> FORWARD when those two states differ, and BACKWARD when those two states
> are the same. A simple XOR operation computes such:
> 
>     GET_DIRECTION = PB ^ CA
> 
> So we can now reimplement the table as two macros:
> 
> 	#define GPIO_COUNTER_STATE_CHANGED(pa, pb, ca, cb) (pa ^ pb ^ ca ^ cb)
> 	#define GPIO_COUNTER_GET_DIRECTION(pb, ca) \
> 		((pb ^ ca) ? COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD)
> 

Done in v5, exactly like proposed.  The two macros plus the >= / > 0
guards replace the 16-entry table; a short comment points at the
Gray-code reasoning.

> With that, gpio_qenc_quad_x4_table[state] can be replaced with something
> like the following:
> 
> 	if (!GPIO_COUNTER_STATE_CHANGED(prev_a, prev_b, a, b))
> 		return;
> 
> 	direction = GPIO_COUNTER_GET_DIRECTION(prev_b, a);
> 
> 	if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
> 		if (count < ceiling)
> 			count++;
> 	else
> 		if (count > 0)
> 			count--;
> 
> I believe the intent of the code becomes clearer to read this way, but
> I'd like to hear what others think of this approach.
> 
> > +static int gpio_qenc_a_delta(struct gpio_qenc_priv *priv, int a, int b,
> > +			     int prev_a, int prev_b)
> > +{
> > +	int state = CREATE_QE_STATE(prev_a, prev_b, a, b);
> > +
> > +	switch (priv->function) {
> > +	case COUNTER_FUNCTION_QUADRATURE_X4:
> > +		return gpio_qenc_quad_x4_table[state];
> > +
> > +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> > +		/* Both edges of A; sign comes from current A vs B. */
> > +		return (a == b) ? -1 : 1;
> > +
> > +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> > +		/* Rising edge of A only. */
> > +		if (!prev_a && a)
> > +			return b ? -1 : 1;
> > +		return 0;
> 
> Quadrature X1 count modes trigger on the falling edge when the direction
> is backward. This isn't simply a requirement by definition, but
> necessary for the proper interpretation of the quadrature encoding.
> 
> Let's evaluate an incremental encoder used in a positioning application
> as typical use case.[^1] These are commonly implemented using a rotating
> shaft with a quadrature-offset pattern; aligned sensors detect the
> physical A/B pattern as the shaft rotates.[^2] As the shaft rotates a
> quadrature encoding emerges whose A-B phase difference allows us to
> determine direction: forward when rising edge of signal A leads B, and
> backward when it trails.[^3]
> 
> Now consider what happens to the signals when the rotation changes
> direction: there is a phase change between Signals A and B.[^4] The A/B
> pattern on the shaft is physically present so it has not changed; rather
> the pattern is now fed backwards to the sensors due to the direction
> reversal. The key point is the physical boundaries of the pattern are
> located in the same shaft positions they have always been, yet the
> signal edges representing those boundaries have flipped as a result of
> the direction change: positions marked by rising edges now appear as
> falling edges.
> 
> In Quadrature X4 and X2, the pattern reversal doesn't affect positioning
> because we count on both edges, so swapping rising and falling edges
> nets the same position count. Quadrature X1 presents a problem because
> we count on a single edge type, so a phase-difference in the encoding
> results in a physical shift in real-life position. The way to account
> for that phase shift is to swap counting to the other edge type when the
> direction changes. That's how dedicated quadrature encoder devices solve
> this problem.
> 
> I'm not sure of the best way to solve the Quadrature X1 problem in this
> driver. Right now we fire off interrupts on both edges, so perhaps
> there's a way for us to determine whether we're firing on a rising edge
> or falling edge and evaluate accordingly. Does the GPIO subsystem
> provide an indication for which edge triggered the interrupt? Or would
> it make sense to provide two interrupt service routines (one on rising
> edge and one on falling edge) and handle it that way?
> 
> > +static int gpio_qenc_function_write(struct counter_device *counter,
> > +				    struct counter_count *count,
> > +				    enum counter_function function)
> > +{
> > +	struct gpio_qenc_priv *priv = counter_priv(counter);
> > +	unsigned long flags;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(gpio_qenc_functions); i++)
> > +		if (gpio_qenc_functions[i] == function)
> > +			break;
> > +	if (i == ARRAY_SIZE(gpio_qenc_functions))
> > +		return -EINVAL;
> 
> The Counter subsystem ensures the function argument passed in to the
> function_write() callback exists within the count's functions_list. You
> can remove the gpio_qenc_functions array check entirely.
> 
> > +static int gpio_qenc_action_read(struct counter_device *counter,
> > +				 struct counter_count *count,
> > +				 struct counter_synapse *synapse,
> > +				 enum counter_synapse_action *action)
> > +{
> > +	struct gpio_qenc_priv *priv = counter_priv(counter);
> > +	enum gpio_qenc_signal_id signal_id = synapse->signal->id;
> > +
> > +	/* Index synapse always observes rising edges, regardless of mode. */
> > +	if (signal_id == GPIO_QENC_SIGNAL_INDEX) {
> > +		*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> > +		return 0;
> > +	}
> > +
> > +	*action = COUNTER_SYNAPSE_ACTION_NONE;
> > +
> > +	switch (priv->function) {
> > +	case COUNTER_FUNCTION_QUADRATURE_X4:
> > +		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> > +		break;
> > +
> > +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> > +		if (signal_id == GPIO_QENC_SIGNAL_A)
> > +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> > +		break;
> > +
> > +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> > +		if (signal_id == GPIO_QENC_SIGNAL_B)
> > +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> > +		break;
> > +
> > +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> > +		if (signal_id == GPIO_QENC_SIGNAL_A) {
> > +			if (priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
> > +				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> > +			else
> > +				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> > +		}
> > +		break;
> > +
> > +	case COUNTER_FUNCTION_QUADRATURE_X1_B:
> > +		if (signal_id == GPIO_QENC_SIGNAL_B) {
> > +			if (priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
> > +				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> > +			else
> > +				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> > +		}
> > +		break;
> > +
> > +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> > +	case COUNTER_FUNCTION_INCREASE:
> > +	case COUNTER_FUNCTION_DECREASE:
> > +		if (signal_id == GPIO_QENC_SIGNAL_A)
> > +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> Instead of break statements, exit early by returning 0;

All removed/applied.  action_read() now also holds priv->lock while
reading function and direction (overlaps with one of the Sashiko
findings).

> 
> > +static int gpio_qenc_ceiling_write(struct counter_device *counter,
> > +				   struct counter_count *count, u64 val)
> > +{
> > +	struct gpio_qenc_priv *priv = counter_priv(counter);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +	priv->ceiling = val;
> > +	if (priv->count > val)
> > +		priv->count = val;
> 
> Although having a count value above the ceiling isn't a particularly
> useful configuration, I wonder if it's unexpected for the the count
> value to be modified by an update to the ceiling value. It could be
> considered a loss of data in a sense because the user might reasonably
> expect the count value to hold the current position of whatever
> application is running.
> 
> How do other quadrature encoder devices handle this situation? Do they
> also adjust the count value immediately to ceiling, leave the count
> static entirely, or merely prevent the count from increasing further yet
> allow it to decrease gradually below the ceiling?
>

intel-qep, ti-eqep and stm32-timer-cnt all leave the count alone;
ftm-quaddec has no ceiling_write at all.  v5 follows that: ceiling_write
no longer touches priv->count, the update path uses a >= guard so an
out-of-range count can't grow, and the index ISR clamps after loading
the preset.

In addition, Sashiko AI[1] flagged seven issues on v4.  I went through
each against the code -- all real, no hallucinations.  v5 addresses
them as follow:

  1. !! normalisation of GPIO reads so negative errors don't index
     the state tables.
  2. priv->enabled under priv->lock; enable_write idempotent.
  3. preset/ceiling TOCTOU closed (check inside lock + >= guard +
     post-preset clamp).
  4. probe rejects sleepable GPIOs via gpiod_cansleep().
  5. action_read reports RISING/FALLING by current direction to match
     the ISR (overlaps with your X1 fix).
  6. action_read takes priv->lock.
  7. IRQF_NO_AUTOEN passed to devm_request_irq() instead of the global
     irq_set_status_flags() call.

v5 follows in a separate sub-thread under the v4 cover.

Thanks again for the patient review -- the Gray-code rewrite and the
X1 edge fix genuinly improved the driver.

[1] https://sashiko.dev/#/patchset/20260515153616.157605-1-wafgo01@gmail.com?part=2

Wadim

> > +static int gpio_qenc_preset_enable_write(struct counter_device *counter,
> > +					 struct counter_count *count, u8 val)
> > +{
> > +	struct gpio_qenc_priv *priv = counter_priv(counter);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +	priv->preset_enabled = !!val;
> 
> All the COUNTER_COMP_*_ENABLE() components are ensured by the Counter
> subsystem to have boolean values, so no need for the double negation.
> 
> The reason the u8 type appears in the callbacks is to have a
> well-defined data width for the chrdev interface; the actual values
> passed to the callback will always be boolean.
> 
> William Breathitt Gray
> 
> [^1] https://en.wikipedia.org/wiki/Incremental_encoder#Quadrature_outputs
> [^2] https://upload.wikimedia.org/wikipedia/commons/1/1e/Incremental_directional_encoder.gif
> [^3] https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Quadrature_Diagram.svg/3840px-Quadrature_Diagram.svg.png
> [^4] https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/QuadratureOscillatingShaft.png/500px-QuadratureOscillatingShaft.png
