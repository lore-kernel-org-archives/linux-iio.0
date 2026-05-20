Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375D35975;
	Wed, 20 May 2026 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779252338; cv=none; b=DGmF+DTVdwAy3n674IPzYzj0T/4IP2g21uLBZf4SbLv8ybW3JAkdh/F3jEPBuBBt7BPSAscZgez2FpHmINUgOJyMtrtxsqxsYopgMqyZ4/6GIasLotBm5u5C9ASgj99Xl7j0PKTnswiSkuUhW2XS1S+DW4d3pVgQCUEj9WYrzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779252338; c=relaxed/simple;
	bh=N8qLJxZvss3nS/1dHodTs3c3ZDVkmaTy30XpXdgUGU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVb+yAr+48bFlhUhZcVogw7Wlv512l7p+ZoClKjdc3y32xRE+Lvx/CkclUEhDSQQ4ze2OMtSo1wx/Homu8qYgLjCk2HXA8H3HfXfzwIoEWk7cp7yljfLD1G86j0XT4wEw0hW6MsVhrz4E8CWnfkGd3q5y6kmtXmTxJEojnY0Nvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChYawrfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChYawrfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E181F000E9;
	Wed, 20 May 2026 04:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779252336;
	bh=GxjV6OkSdoXWE+ksQKD+ktVQGxx/5D0BMXZvmxXOP9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ChYawrfMvL9cfUC2VkWjtz2K81Q3nPeG/2+OpdXJk41ZxdbPPbqB7xhyiov0EUIMb
	 5hVUhcDICFyeEhQ4Zdb3IlCBt9zvCrIQfVmebVZKn5/oNpayTr5mtiWb4kNjvR1Lim
	 ooEUlPqWvKuj61D0iW4RwkXRG0U//87UnXUsmJ0JgFfocWw4e9SOA/6r5yVwB4kY2T
	 pcSsqCqWBRsGp75dJWYXzDB83gGNxlzt8elqZWuQOqVppoQHVA9b8yrOx6SZzYmIYv
	 Dkfa1Nq2jswK2NDMfC6hWeh7wWtyH6bBsfelaxwB1zB8igX1PeA0CBrvnYIyEagfiQ
	 ZUoT4FCiI+kDA==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] counter: add GPIO-based quadrature encoder driver
Date: Wed, 20 May 2026 13:45:20 +0900
Message-ID: <20260520044525.128529-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515153616.157605-3-wafgo01@gmail.com>
References: <20260515153616.157605-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12038; i=wbg@kernel.org; h=from:subject; bh=N8qLJxZvss3nS/1dHodTs3c3ZDVkmaTy30XpXdgUGU4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFm8NnrFJ4T1p96wqNM1OVVhd65DI23etDtr3fbeT9z2q lympiqno5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZjIuRpGhn3yMxt5Fd2rT2Vv 77BuPbEsVPHh6nhOxjXT/+lr/fO21GJkeLtqboDvtrlt2Uneb/Q3pBke3zClPXRzjv6Lz8cr5Y4 VMQEA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Fri, May 15, 2026 at 05:36:15PM +0200, Wadim Mueller wrote:
> Add a platform driver that turns ordinary GPIOs into a quadrature
> encoder counter device.  The driver requests edge-triggered interrupts
> on the A and B (and optional Index) GPIOs and decodes the quadrature
> signal in software using a classic state-table approach.
> 
> Supported counting modes:
>   - Quadrature X1 (count on A rising edge only)
>   - Quadrature X2 (count on both A edges)
>   - Quadrature X4 (count on every A and B edge)
>   - Pulse-direction (A = pulse, B = direction)
> 
> An optional index signal resets the count to zero on its rising edge
> when enabled through sysfs.  A configurable ceiling clamps the count
> to [0, ceiling].
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

Hi Wadim,

This driver supports non-quadrature modes such as pulse-direction and
increase/decrease modes. Perhaps it's best to rename this driver to
gpio-counter so that the name indicates the more general capabilities we
have now. What do you think?

> +/*
> + * Encode the four quadrature transitions in a single 4-bit state:
> + *   bit3 = prev_a, bit2 = prev_b, bit1 = curr_a, bit0 = curr_b.
> + *
> + * Indexing the table with this value yields the signed delta for an
> + * X4 decoder.  Illegal transitions (both inputs toggled at once)
> + * remain 0 so the count is unchanged.
> + */
> +#define CREATE_QE_STATE(prev_a, prev_b, curr_a, curr_b) \
> +	(((prev_a) << 3) | ((prev_b) << 2) | ((curr_a) << 1) | (curr_b))
> +
> +static const s8 gpio_qenc_quad_x4_table[16] = {
> +	[CREATE_QE_STATE(0, 0, 0, 0)] =  0,
> +	[CREATE_QE_STATE(0, 0, 0, 1)] = -1,
> +	[CREATE_QE_STATE(0, 0, 1, 0)] =  1,
> +	[CREATE_QE_STATE(0, 0, 1, 1)] =  0,
> +	[CREATE_QE_STATE(0, 1, 0, 0)] =  1,
> +	[CREATE_QE_STATE(0, 1, 0, 1)] =  0,
> +	[CREATE_QE_STATE(0, 1, 1, 0)] =  0,
> +	[CREATE_QE_STATE(0, 1, 1, 1)] = -1,
> +	[CREATE_QE_STATE(1, 0, 0, 0)] = -1,
> +	[CREATE_QE_STATE(1, 0, 0, 1)] =  0,
> +	[CREATE_QE_STATE(1, 0, 1, 0)] =  0,
> +	[CREATE_QE_STATE(1, 0, 1, 1)] =  1,
> +	[CREATE_QE_STATE(1, 1, 0, 0)] =  0,
> +	[CREATE_QE_STATE(1, 1, 0, 1)] =  1,
> +	[CREATE_QE_STATE(1, 1, 1, 0)] = -1,
> +	[CREATE_QE_STATE(1, 1, 1, 1)] =  0,
> +};

I believe we can avoid the lookup table entirely by utilizing some
simple bitwise operations.

Let's start with the "0" delta states:

    (PA, PB, CA, CB) = delta
    ------------------------
    (0, 0, 0, 0) =  0
    (0, 1, 0, 1) =  0
    (1, 0, 1, 0) =  0
    (1, 1, 1, 1) =  0
    (0, 0, 1, 1) =  0
    (0, 1, 1, 0) =  0
    (1, 0, 0, 1) =  0
    (1, 1, 0, 0) =  0

A "0" delta is possible in two scenarios: either both signal levels
remain the same, or both signal levels change. We can test for a nonzero
delta using the following bitwise expression:

    HAS_NONZERO_DELTA = (PA ^ CA) ^ (PB ^ CB) = PA ^ PB ^ CA ^ CB

After that test, the remaining states are changes in a single Signal at
a time:

    (PA, PB, CA, CB) = delta
    ------------------------
    (0, 0, 1, 0) =  1
    (1, 0, 1, 1) =  1
    (1, 1, 0, 1) =  1
    (0, 1, 0, 0) =  1
    (0, 0, 0, 1) = -1
    (0, 1, 1, 1) = -1
    (1, 1, 1, 0) = -1
    (1, 0, 0, 0) = -1

    00 -> 10 -> 11 -> 01 -> 00 = FORWARD
    00 -> 01 -> 11 -> 10 -> 00 = BACKWARD

The state change between previous and current is essentially a 2-bit
Gray code. Gray code is designed such that successive values differ in
only one bit. That means we can determine direction with just the
previous state of Signal B (PB) and the current state of Signal A (CA):
FORWARD when those two states differ, and BACKWARD when those two states
are the same. A simple XOR operation computes such:

    GET_DIRECTION = PB ^ CA

So we can now reimplement the table as two macros:

	#define GPIO_COUNTER_STATE_CHANGED(pa, pb, ca, cb) (pa ^ pb ^ ca ^ cb)
	#define GPIO_COUNTER_GET_DIRECTION(pb, ca) \
		((pb ^ ca) ? COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD)

With that, gpio_qenc_quad_x4_table[state] can be replaced with something
like the following:

	if (!GPIO_COUNTER_STATE_CHANGED(prev_a, prev_b, a, b))
		return;

	direction = GPIO_COUNTER_GET_DIRECTION(prev_b, a);

	if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
		if (count < ceiling)
			count++;
	else
		if (count > 0)
			count--;

I believe the intent of the code becomes clearer to read this way, but
I'd like to hear what others think of this approach.

> +static int gpio_qenc_a_delta(struct gpio_qenc_priv *priv, int a, int b,
> +			     int prev_a, int prev_b)
> +{
> +	int state = CREATE_QE_STATE(prev_a, prev_b, a, b);
> +
> +	switch (priv->function) {
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		return gpio_qenc_quad_x4_table[state];
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> +		/* Both edges of A; sign comes from current A vs B. */
> +		return (a == b) ? -1 : 1;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> +		/* Rising edge of A only. */
> +		if (!prev_a && a)
> +			return b ? -1 : 1;
> +		return 0;

Quadrature X1 count modes trigger on the falling edge when the direction
is backward. This isn't simply a requirement by definition, but
necessary for the proper interpretation of the quadrature encoding.

Let's evaluate an incremental encoder used in a positioning application
as typical use case.[^1] These are commonly implemented using a rotating
shaft with a quadrature-offset pattern; aligned sensors detect the
physical A/B pattern as the shaft rotates.[^2] As the shaft rotates a
quadrature encoding emerges whose A-B phase difference allows us to
determine direction: forward when rising edge of signal A leads B, and
backward when it trails.[^3]

Now consider what happens to the signals when the rotation changes
direction: there is a phase change between Signals A and B.[^4] The A/B
pattern on the shaft is physically present so it has not changed; rather
the pattern is now fed backwards to the sensors due to the direction
reversal. The key point is the physical boundaries of the pattern are
located in the same shaft positions they have always been, yet the
signal edges representing those boundaries have flipped as a result of
the direction change: positions marked by rising edges now appear as
falling edges.

In Quadrature X4 and X2, the pattern reversal doesn't affect positioning
because we count on both edges, so swapping rising and falling edges
nets the same position count. Quadrature X1 presents a problem because
we count on a single edge type, so a phase-difference in the encoding
results in a physical shift in real-life position. The way to account
for that phase shift is to swap counting to the other edge type when the
direction changes. That's how dedicated quadrature encoder devices solve
this problem.

I'm not sure of the best way to solve the Quadrature X1 problem in this
driver. Right now we fire off interrupts on both edges, so perhaps
there's a way for us to determine whether we're firing on a rising edge
or falling edge and evaluate accordingly. Does the GPIO subsystem
provide an indication for which edge triggered the interrupt? Or would
it make sense to provide two interrupt service routines (one on rising
edge and one on falling edge) and handle it that way?

> +static int gpio_qenc_function_write(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    enum counter_function function)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpio_qenc_functions); i++)
> +		if (gpio_qenc_functions[i] == function)
> +			break;
> +	if (i == ARRAY_SIZE(gpio_qenc_functions))
> +		return -EINVAL;

The Counter subsystem ensures the function argument passed in to the
function_write() callback exists within the count's functions_list. You
can remove the gpio_qenc_functions array check entirely.

> +static int gpio_qenc_action_read(struct counter_device *counter,
> +				 struct counter_count *count,
> +				 struct counter_synapse *synapse,
> +				 enum counter_synapse_action *action)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	enum gpio_qenc_signal_id signal_id = synapse->signal->id;
> +
> +	/* Index synapse always observes rising edges, regardless of mode. */
> +	if (signal_id == GPIO_QENC_SIGNAL_INDEX) {
> +		*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;
> +	}
> +
> +	*action = COUNTER_SYNAPSE_ACTION_NONE;
> +
> +	switch (priv->function) {
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> +		if (signal_id == GPIO_QENC_SIGNAL_A)
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> +		if (signal_id == GPIO_QENC_SIGNAL_B)
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> +		if (signal_id == GPIO_QENC_SIGNAL_A) {
> +			if (priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
> +				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +			else
> +				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> +		}
> +		break;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X1_B:
> +		if (signal_id == GPIO_QENC_SIGNAL_B) {
> +			if (priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
> +				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +			else
> +				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> +		}
> +		break;
> +
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +	case COUNTER_FUNCTION_INCREASE:
> +	case COUNTER_FUNCTION_DECREASE:
> +		if (signal_id == GPIO_QENC_SIGNAL_A)
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}

Instead of break statements, exit early by returning 0;

> +static int gpio_qenc_ceiling_write(struct counter_device *counter,
> +				   struct counter_count *count, u64 val)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	priv->ceiling = val;
> +	if (priv->count > val)
> +		priv->count = val;

Although having a count value above the ceiling isn't a particularly
useful configuration, I wonder if it's unexpected for the the count
value to be modified by an update to the ceiling value. It could be
considered a loss of data in a sense because the user might reasonably
expect the count value to hold the current position of whatever
application is running.

How do other quadrature encoder devices handle this situation? Do they
also adjust the count value immediately to ceiling, leave the count
static entirely, or merely prevent the count from increasing further yet
allow it to decrease gradually below the ceiling?

> +static int gpio_qenc_preset_enable_write(struct counter_device *counter,
> +					 struct counter_count *count, u8 val)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	priv->preset_enabled = !!val;

All the COUNTER_COMP_*_ENABLE() components are ensured by the Counter
subsystem to have boolean values, so no need for the double negation.

The reason the u8 type appears in the callbacks is to have a
well-defined data width for the chrdev interface; the actual values
passed to the callback will always be boolean.

William Breathitt Gray

[^1] https://en.wikipedia.org/wiki/Incremental_encoder#Quadrature_outputs
[^2] https://upload.wikimedia.org/wikipedia/commons/1/1e/Incremental_directional_encoder.gif
[^3] https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Quadrature_Diagram.svg/3840px-Quadrature_Diagram.svg.png
[^4] https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/QuadratureOscillatingShaft.png/500px-QuadratureOscillatingShaft.png
