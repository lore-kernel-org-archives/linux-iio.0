Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BA36D4E4;
	Fri, 15 May 2026 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824105; cv=none; b=i11N8MYajAs9tDsgoiIeCDSaJYoAgHaSyXof67XFZB7xzRa32iQKGDj/vQbtsSv+X6RmP7F51V5AqkgEMqi/eLuNMUlSZYiPCJbIY7MBEbW/MGZ69E/y1E8MLUtvO+ArrL8eRnYPy5ykoD96Hqjk8wvNrt/DEseK8Wydz1QKc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824105; c=relaxed/simple;
	bh=60kRau48iTEuUMjbvRdUT1ZnBbKWW2xQzfzA3WrKVO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH8aei2ee0W5yt0tDhqlk73mUfOj/wfAHbjZeY9Mb+RkVSA34m4EX5pJnrVLGgAz7Fq5vQt4EEBNRqlA0jFtv8ObRqyLeh9xMifDbyMcB7366zml4AUeWKMdl7orHEIEW29Nop3+CZLhj0dLVmvzv9H5BCCst7Va3lZxL+Evbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTrbLpLr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTrbLpLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0817FC2BCB8;
	Fri, 15 May 2026 05:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778824104;
	bh=60kRau48iTEuUMjbvRdUT1ZnBbKWW2xQzfzA3WrKVO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTrbLpLrln0yjx899IaioEWCVn0LzR3DzxNIFupI0/htZ2F/7F39GFfjC1VLqVwHO
	 pQd75OSrNoIFcJ3RbYrqGqoMnNHGVu7UqlV2Cx2WBujBSLvKL1+nUVnRk7gLBmTeM1
	 cfpqBZ3I7O2TVCIvqYlBRJEqvhoKnZOvGc5lIz9fadbBvYWvs7zidPkMPRPBDqPnBF
	 BUWGGlB6UJ1h6SZRcpCh2jPp77kgVFRqu0FYyeiu+jJP+NQur13g5l4UHGF8zKfCK1
	 3wGy/RSissY6CU7F1SCU/mB79wCWPn4BUq0cZ3wG5MtyZN8iE3E/YqQrBCTE+85/pm
	 npq1uyBkNyOoQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor.dooley@microchip.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linusw@kernel.org,
	brgl@kernel.org
Subject: Re: [PATCH v3 2/3] counter: add GPIO-based quadrature encoder driver
Date: Fri, 15 May 2026 14:48:17 +0900
Message-ID: <20260515054819.302445-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501200749.20029-3-wafgo01@gmail.com>
References: <20260501200749.20029-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21104; i=wbg@kernel.org; h=from:subject; bh=60kRau48iTEuUMjbvRdUT1ZnBbKWW2xQzfzA3WrKVO0=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlsm7Mb+HbOT2DYfyEv4U5I6LUr4gr3vij35a65r7enn /H0wS6rjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAi2lKMDNNFvy5tTYw7k+dv v600btPk18/CGGVk7s93fTrbtmy7eC8jw4EDL+6cPLQ4MuvhArGSJ1ILnxb9yU3xXT1/4b68nAp ffQ4A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Fri, May 01, 2026 at 10:07:48PM +0200, Wadim Mueller wrote:
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

Hi Wadim,

The Documentation/ABI/testing/sysfs-bus-counter file documents the Count
function modes. Because we're interpreting GPIO lines and can define our
own encoding states, it would be prudent to support all these Count
function modes (i.e. increase, decrease, x1 b, and x2 b modes).

> 
> An optional index signal resets the count to zero on its rising edge
> when enabled through sysfs.  A configurable ceiling clamps the count
> to [0, ceiling].
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

I recommend adding support at some point for a compare
(COUNTER_COMP_COMPARE) component and floor component
(COUNTER_COMP_FLOOR) which are common functionalities in quadrature
devices. It'd be nice as well to have events pushed for
COUNTER_EVENT_OVERFLOW, COUNTER_EVENT_UNDERFLOW,
COUNTER_EVENT_OVERFLOW_UNDERFLOW, COUNTER_EVENT_THRESHOLD, and
COUNTER_EVENT_DIRECTION_CHANGE.

> +enum gpio_qenc_function {
> +	GPIO_QENC_FUNC_QUAD_X1 = 0,
> +	GPIO_QENC_FUNC_QUAD_X2,
> +	GPIO_QENC_FUNC_QUAD_X4,
> +	GPIO_QENC_FUNC_PULSE_DIR,
> +};

We use device specific enums to map device hardware register values to
the Counter subsystem function enum constants. However, because this
driver is not tied to any specific device hardware, you don't need to
define a new enum. In other words, just use the COUNTER_FUNCTION_*
constants directly in your code.

> +struct gpio_qenc_priv {
> +	struct gpio_desc *gpio_a;
> +	struct gpio_desc *gpio_b;
> +	struct gpio_desc *gpio_index;
> +
> +	int irq_a;
> +	int irq_b;
> +	int irq_index;
> +
> +	spinlock_t lock;
> +
> +	s64 count;

The count_read()/count_write() callbacks pass a u64 count value, so I
suspect this private count value store can be u64 as well.

> +	u64 ceiling;
> +	bool enabled;
> +	enum counter_count_direction direction;
> +	enum gpio_qenc_function function;
> +
> +	int prev_a;
> +	int prev_b;
> +
> +	bool index_enabled;
> +
> +	struct counter_signal signals[3];
> +	struct counter_synapse synapses[3];
> +	struct counter_count cnts;

I know you only have a single count, but for consistency with the rest
of the code and Counter subsystem, I recommend declaring this as a
single element array:

	struct counter_count cnts[1];

> +};
> +
> +/*
> + * Quadrature state table for X4 decoding.
> + * Rows = previous state (A<<1 | B), Columns = new state (A<<1 | B).
> + * Values: 0 = no change, +1 = forward, -1 = backward, 2 = error (skip).
> + */
> +static const int quad_table[4][4] = {
> +	/*          00  01  10  11  <- new */
> +	/* 00 */ {  0, -1,  1,  2 },
> +	/* 01 */ {  1,  0,  2, -1 },
> +	/* 10 */ { -1,  2,  0,  1 },
> +	/* 11 */ {  2,  1, -1,  0 },
> +};
> +
> +static void gpio_qenc_update_count(struct gpio_qenc_priv *priv, int delta)
> +{
> +	s64 new_count;
> +
> +	if (!delta)
> +		return;
> +
> +	new_count = priv->count + delta;
> +
> +	if (priv->ceiling) {
> +		if (new_count < 0)
> +			new_count = 0;
> +		else if (new_count > (s64)priv->ceiling)
> +			new_count = priv->ceiling;
> +	}
> +
> +	priv->count = new_count;
> +	priv->direction = (delta > 0) ? COUNTER_COUNT_DIRECTION_FORWARD
> +				      : COUNTER_COUNT_DIRECTION_BACKWARD;

Quadrature encoding represents changes of a single unit value at a time.
Because we never increase nor decrease more than a value of 1 at a time,
I think the code would read clearer if we determine the direction first,
then make the adjustments to the count value thereafter. Maybe something
like this (assuming priv->count is u64):

	if (!delta)
		return;
	
	priv->direction = (delta > 0) ? COUNTER_COUNT_DIRECTION_FORWARD
				      : COUNTER_COUNT_DIRECTION_BACKWARD;
	
	if (priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
		priv->count = (priv->count == priv->ceiling) ? priv->ceiling
							     : priv->count + 1;
	else
		priv->count = (priv->count == 0) ? priv->ceiling
						 : priv->count - 1;

> +}
> +
> +static irqreturn_t gpio_qenc_a_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +	int a, b, prev_state, new_state, delta;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	if (!priv->enabled)
> +		goto out;

Do we need to check the enabled state? If the IRQ is disabled, we don't
reach this path, or do we?

> +
> +	a = gpiod_get_value(priv->gpio_a);
> +	b = gpiod_get_value(priv->gpio_b);
> +
> +	prev_state = (priv->prev_a << 1) | priv->prev_b;
> +	new_state = (a << 1) | b;

I might make sense to wrap the state operation into a macro to make the
intention of these bitwise operations more intuitive. For example:

	prev_state = CREATE_QE_STATE(priv->prev_a, priv->prev_b);
	new_state = CREATE_QE_STATE(a, b);

Or something like that makes it more obvious that these two lines are
just building the indices for the state array rather than any inherent
meaning in the binary representation of the variables.

> +
> +	switch (priv->function) {
> +	case GPIO_QENC_FUNC_QUAD_X4:
> +		delta = quad_table[prev_state][new_state];
> +		if (delta == 2)
> +			delta = 0;
> +		gpio_qenc_update_count(priv, delta);
> +		break;
> +
> +	case GPIO_QENC_FUNC_QUAD_X2:
> +		delta = quad_table[prev_state][new_state];
> +		if (delta == 2)
> +			delta = 0;
> +		gpio_qenc_update_count(priv, delta);
> +		break;

After determining the delta value we call the gpio_qenc_update_count()
function immedidately. We can save on a function call and remove the
!delta check in gpio_qenc_update_count() if you make the call only when
delta is known to update the count; for example:

	if (!delta && delta != 2)
		gpio_qenc_update_count(priv, delta);

In fact, you may consider just removing the "2" states from the
quad_table and leaving it as just "0" because the effect is the same,
right?

> +static irqreturn_t gpio_qenc_b_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +	int a, b, prev_state, new_state, delta;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	if (!priv->enabled)
> +		goto out;
> +
> +	a = gpiod_get_value(priv->gpio_a);
> +	b = gpiod_get_value(priv->gpio_b);
> +
> +	prev_state = (priv->prev_a << 1) | priv->prev_b;
> +	new_state = (a << 1) | b;
> +
> +	switch (priv->function) {
> +	case GPIO_QENC_FUNC_QUAD_X4:
> +		delta = quad_table[prev_state][new_state];
> +		if (delta == 2)
> +			delta = 0;
> +		gpio_qenc_update_count(priv, delta);
> +		break;
> +
> +	case GPIO_QENC_FUNC_QUAD_X2:
> +		/* X2: only A-channel edges update count */
> +		break;
> +
> +	case GPIO_QENC_FUNC_QUAD_X1:
> +	case GPIO_QENC_FUNC_PULSE_DIR:
> +		break;

I guess you added these two cases to pacify the compiler warning for
missing switch cases. You can provide a default case instead so we don't
need to list out every case that is ignored.

> +static irqreturn_t gpio_qenc_index_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	if (priv->enabled && priv->index_enabled)
> +		priv->count = 0;
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	counter_push_event(counter, COUNTER_EVENT_INDEX, 0);
> +
> +	return IRQ_HANDLED;
> +}

In many quadrature encoder devices I've seen, Index functions can be
chosen which determine what happens to the count when an Index signal
occurs. Typically, one of those functions is to reset the count, but
that is not necessary the only function nor is it unconditionally
enabled.

Existing drivers such as 104-quad-8 use COUNTER_COMP_PRESET to define a
preset component that holds a value to preset the counter on an Index
signal; COUNTER_COMP_PRESET_ENABLE is used to enable/disable such
functionality. You may want to implement something similar for
gpio-quadrature-encoder, and consider other such Index functionality
that may be desirable to provide to users.

> +static int gpio_qenc_count_write(struct counter_device *counter,
> +				 struct counter_count *count, const u64 val)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	if (priv->ceiling && val > priv->ceiling) {
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		return -EINVAL;
> +	}

So the ceiling component represents the highest value the count can
reach. I would argue a ceiling value of 0 does not indicate a disabled
ceiling but rather a Count which is limited to the value of 0; n.b. this
technically is not a disabled Count because COUNTER_EVENT_OVERFLOW could
still be pushed in this scenario, albeit a rather dubious configuration
for the Count in real life applications.

To "disable" a ceiling, the user would set the ceiling value to the
maximum value supported by the device hardware (or U64_MAX in our case
if priv->count is u64). In fact, you should initialize priv->ceiling to
this maximum value in your gpio_qenc_probe() callback so that we don't
limit.

> +static int gpio_qenc_function_read(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   enum counter_function *function)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	switch (priv->function) {
> +	case GPIO_QENC_FUNC_QUAD_X1:
> +		*function = COUNTER_FUNCTION_QUADRATURE_X1_A;
> +		break;
> +	case GPIO_QENC_FUNC_QUAD_X2:
> +		*function = COUNTER_FUNCTION_QUADRATURE_X2_A;
> +		break;
> +	case GPIO_QENC_FUNC_QUAD_X4:
> +		*function = COUNTER_FUNCTION_QUADRATURE_X4;
> +		break;
> +	case GPIO_QENC_FUNC_PULSE_DIR:
> +		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
> +		break;
> +	}

If you use declare priv->function as enum counter_function, you can
replace the entire switch as a simple set operation:

	*function = priv->function;

> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +	return 0;
> +}
> +
> +static int gpio_qenc_function_write(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    enum counter_function function)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> +		priv->function = GPIO_QENC_FUNC_QUAD_X1;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> +		priv->function = GPIO_QENC_FUNC_QUAD_X2;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		priv->function = GPIO_QENC_FUNC_QUAD_X4;
> +		break;
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		priv->function = GPIO_QENC_FUNC_PULSE_DIR;
> +		break;
> +	default:
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		return -EINVAL;
> +	}

Same suggestion as for gpio_qenc_function_read():

	priv->function = function;

> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +	return 0;
> +}
> +
> +static const enum counter_synapse_action gpio_qenc_synapse_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +};

If I'm not mistaken, you can fire interrupts on the falling edge of a
GPIO signal. It'd be good to support such a configuration as it's
necessary for Quadrature X1 A mode.

> +static int gpio_qenc_action_read(struct counter_device *counter,
> +				 struct counter_count *count,
> +				 struct counter_synapse *synapse,
> +				 enum counter_synapse_action *action)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	enum gpio_qenc_signal_id signal_id = synapse->signal->id;

You can eliminate a lot of the else statements the switch block by
handling a couple default cases. For example, you can define a default
action mode of "none" and have the rest of the code only set an action
if meets the right criteria.

Furthermore, the Index synapse should be treated as independent of
the quadrature mode; the Signal is not evaluated in determining the
encoding state, and is commonly used on physical quadrature encoder
devices as a count reset trigger in non-quadrature modes. So I recommend
handling it early here as well:

	/* Default action mode */
	*action = COUNTER_SYNAPSE_ACTION_NONE;

	/* Handle Index Signal */
	if (priv->index_enabled && signal_id == GPIO_QENC_SIGNAL_INDEX) {
		*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
		return 0;
	}

> +
> +	switch (priv->function) {
> +	case GPIO_QENC_FUNC_QUAD_X4:
> +		if (signal_id == GPIO_QENC_SIGNAL_A ||
> +		    signal_id == GPIO_QENC_SIGNAL_B)
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		else
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;

With the default cases suggested earlier, the if statement and else go
away completely and you can directly set the action to "both edges":

	case COUNTER_FUNCTION_QUADRATURE_X4:
		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
		return 0;

> +
> +	case GPIO_QENC_FUNC_QUAD_X2:
> +		if (signal_id == GPIO_QENC_SIGNAL_A)
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		else if (signal_id == GPIO_QENC_SIGNAL_B)
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
> +		else
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;

Ditto:

	case COUNTER_FUNCTION_QUADRATURE_X2_A:
		if (signal_id == GPIO_QENC_SIGNAL_A)
			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
		return 0;

> +
> +	case GPIO_QENC_FUNC_QUAD_X1:
> +		if (signal_id == GPIO_QENC_SIGNAL_A)
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		else if (signal_id == GPIO_QENC_SIGNAL_B)
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
> +		else
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;

In the commit description you mention that this mode counts only rising
edges, but you matched this to COUNTER_FUNCTION_QUADRATURE_X1_A which
depends on the current direction to determine which edge is active. I'll
assume that was your intention (otherwise this becomes a duplicate of
pulse-direction mode with Index handled independent of quadrature mode):

	case COUNTER_FUNCTION_QUADRATURE_X1_A:
		if (signal_id == GPIO_QENC_SIGNAL_A) {
			if (priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
			else
				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
		}
		return 0;

> +
> +	case GPIO_QENC_FUNC_PULSE_DIR:
> +		if (signal_id == GPIO_QENC_SIGNAL_A)
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		else
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
> +		return 0;

This cas becomes simple too:

	case COUNTER_FUNCTION_PULSE_DIRECTION:
		if (signal_id == GPIO_QENC_SIGNAL_A)
			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
		return 0;

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int gpio_qenc_signal_read(struct counter_device *counter,
> +				 struct counter_signal *signal,
> +				 enum counter_signal_level *level)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	switch (signal->id) {
> +	case GPIO_QENC_SIGNAL_A:
> +		gpio = priv->gpio_a;
> +		break;
> +	case GPIO_QENC_SIGNAL_B:
> +		gpio = priv->gpio_b;
> +		break;
> +	case GPIO_QENC_SIGNAL_INDEX:
> +		gpio = priv->gpio_index;
> +		break;
> +	default:
> +		return -EINVAL;

The default case is unneeded because all possible enum constants are
handled by the switch block.

> +	}
> +
> +	if (!gpio)
> +		return -EINVAL;

Why is it possible to get back a zero value? Is this to handle the case
where a GPIO line does not exist? Would it be possible avoid adding
Counter Signals for missing GPIO during the gpio_qenc_probe() call so we
don't encounter such zombie Counter Signals?

> +
> +	ret = gpiod_get_value(gpio);
> +	if (ret < 0)
> +		return ret;
> +
> +	*level = ret ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
> +	return 0;
> +}
> +
> +static int gpio_qenc_events_configure(struct counter_device *counter)
> +{
> +	return 0;
> +}

The events_configure() callback is option, so you don't need to define
it if it doesn't do anything. Its intention is to enable/disable device
interrupts based on the Counter watches requested by users; that doesn't
apply for this driver because our encoding state is virtual and we push
Counter events as needed when we update the virtual state.

> +static int gpio_qenc_enable_write(struct counter_device *counter,
> +				  struct counter_count *count, u8 enable)
> +{
> +	struct gpio_qenc_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	if (priv->enabled == !!enable) {
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		return 0;
> +	}
> +
> +	if (enable) {
> +		priv->enabled = true;
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		enable_irq(priv->irq_a);
> +		enable_irq(priv->irq_b);
> +		if (priv->irq_index)
> +			enable_irq(priv->irq_index);
> +	} else {
> +		priv->enabled = false;
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		disable_irq(priv->irq_a);
> +		disable_irq(priv->irq_b);
> +		if (priv->irq_index)
> +			disable_irq(priv->irq_index);
> +	}
> +
> +	return 0;
> +}

The value of enable is ensured by the Counter subsystem to be a bool
when passed to the enable_write() callback, so there's no need for the
double negation; you can compare against enable directly. Also you can
simplify the if block by setting priv->enabled unconditionally and
adding a return 0 to the if path:

	spin_lock_irqsave(&priv->lock, flags);

	if (priv->enabled == enable) {
		spin_unlock_irqrestore(&priv->lock, flags);
		return 0;
	}
	priv->enabled = enable;

	spin_unlock_irqrestore(&priv->lock, flags);

	if (enable) {
		enable_irq(priv->irq_a);
		enable_irq(priv->irq_b);
		if (priv->irq_index)
			enable_irq(priv->irq_index);
		return 0;
	}

	disable_irq(priv->irq_a);
	disable_irq(priv->irq_b);
	if (priv->irq_index)
		disable_irq(priv->irq_index);

	return 0;

> +static struct counter_comp gpio_qenc_count_ext[] = {
> +	COUNTER_COMP_CEILING(gpio_qenc_ceiling_read, gpio_qenc_ceiling_write),
> +	COUNTER_COMP_ENABLE(gpio_qenc_enable_read, gpio_qenc_enable_write),
> +	COUNTER_COMP_DIRECTION(gpio_qenc_direction_read),
> +	COUNTER_COMP_COUNT_BOOL("index_enabled",
> +				gpio_qenc_index_enable_read,
> +				gpio_qenc_index_enable_write),

The Index function in this driver is used to preset (reset) the Count so
rather than define your own "index_enabled" component, the idiomatic way
to handle this behavior in the Counter subsystem is to set
priv->index_enabled via COUNTER_COMP_PRESET_ENABLE().

> +	priv->synapses[0].actions_list = gpio_qenc_synapse_actions;
> +	priv->synapses[0].num_actions = ARRAY_SIZE(gpio_qenc_synapse_actions);
> +	priv->synapses[0].signal = &priv->signals[GPIO_QENC_SIGNAL_A];
> +
> +	priv->synapses[1].actions_list = gpio_qenc_synapse_actions;
> +	priv->synapses[1].num_actions = ARRAY_SIZE(gpio_qenc_synapse_actions);
> +	priv->synapses[1].signal = &priv->signals[GPIO_QENC_SIGNAL_B];
> +
> +	if (has_index) {
> +		priv->synapses[2].actions_list = gpio_qenc_synapse_actions;

The Index Signal only has two possible Synapse actions "rising edge" and
"none". Because that differs from the Quadrature A and B Signals (which
can also have "both edges" for example), you need to define a separate
static const enum counter_synapse_action array for just the Index
Signal which has just those two actions.

> +	priv->cnts.id = 0;
> +	priv->cnts.name = "Position";

Name this something more generic such as "Count" because positioning is
only one of the possible applications for a quadrature encoder not its
sole use case.

> +	counter->name = dev_name(dev);
> +	counter->parent = dev;
> +	counter->ops = &gpio_qenc_ops;
> +	counter->signals = priv->signals;
> +	counter->num_signals = num_signals;
> +	counter->counts = &priv->cnts;
> +	counter->num_counts = 1;

Use ARRAY_SIZE() for num_counts for the sake of consistency (and in case
we ever support more than one Count in future updates).

William Breathitt Gray
