Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FD3B841F;
	Wed, 17 Jun 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682578; cv=none; b=iHbBLW94INFdqgyAIqDOY3XU3odgY3etZyWVIfJhfmBsuR1rqLZ7QY4vTBaUsCrXR5PwtlcRorRE9hXFpfZn45ivyq4TYmULf2cjhbuC3VuhCLGCjJp3eXAOtz+gtYpf2L7Q0GDi5hniGrSWumKNG4Zk8i2/C99dXvrYIMecbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682578; c=relaxed/simple;
	bh=SRjiwovu/jJtzvRmNc50pu9BPx5VagzBXtGe5px+1MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlVEXnLzbdHcf+8OpRlwWsmVauGI9UoaNJsmb9AYw98oYaTZxrGQkfW2KMdBmN0FNJ2h86VQUCwqcJLLU29eA1DwW+5ZRaxRcr6j5OlpZItnidBVWEmeCgbV/nCRsHHP0PIBRabxQHLMcw3r1xrFqtTZQQrBRmL+yf8taYlE5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPwFFaMP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPwFFaMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136151F000E9;
	Wed, 17 Jun 2026 07:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781682576;
	bh=s21k/d38ZhjkT/2qgt8gntdOu3Zd4dwfawLP2iZta7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPwFFaMP1L61QSfRF9AOxpjrAQdkK6MpYeFuqx3s6TaOjvjvCmZmYmY5aqcpmmIhq
	 eMqy0dph/VMWqKhOKCWs5QeyJLZZ2c42Qwwzlq4iozhuwCcIS3UmoIoFXogrs+tO6g
	 XExUPtITFVAkvjJu9N7yXAOnKB8e5Gk2L+lKMCU7OT29ojUNB988w9DtWdrTVs8aAv
	 aB9Sf15B1wWYXUP+4Uw694NkcSfDrRaH9GPcwuAs4J74A/5u9bmWN0EG8SaoBH0rdp
	 KHAQufmXZbG0616GJvSJMy95X/9JN5nh4IFJIvguUzHhns1lCkHXkc0X404mhFXb5j
	 fTBQuIxOttWVw==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de
Subject: Re: [PATCH v5 2/3] counter: add GPIO-based counter driver
Date: Wed, 17 Jun 2026 16:49:25 +0900
Message-ID: <20260617074929.333876-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524193846.19216-3-wafgo01@gmail.com>
References: <20260524193846.19216-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16193; i=wbg@kernel.org; h=from:subject; bh=SRjiwovu/jJtzvRmNc50pu9BPx5VagzBXtGe5px+1MI=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlGAUd4A29rNayIWV91/S3X8uzjl4sVI4x5z1XIf3pyZ 6dCNtu1jlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiPncY/rtMywhlnC73/vP7 QMa+TyuVLd8y3rmx70ALN6djp+6eWhdGhrl5/5RZquIii4KncZ18UR3zmW97xix3fyf2Rr3tfyT quQA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sun, May 24, 2026 at 09:38:45PM +0200, Wadim Mueller wrote:
> Add a platform driver that turns plain GPIOs into a counter device.
> Edge interrupts on the signal-a, signal-b (and optional index) lines
> are decoded in software using a 2-bit Gray-code parity trick for the
> quadrature X4 mode and direct edge checks for the other modes.
> 
> Supports COUNTER_FUNCTION_QUADRATURE_X1_{A,B} / X2_{A,B} / X4,
> PULSE_DIRECTION, INCREASE and DECREASE.  Sleepable GPIO providers
> (I2C/SPI expanders) are rejected at probe time becouse the ISRs run
> in hardirq context.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

Hello Wadim,

Because this is a novel module, I want to make sure we get it right lest
we merge something incorrect and end up needing to support a broken
design for many years onward.

One change I consider is whether to make Signal B optional. If a device
only has a single GPIO line available, it could still be used with only
Signal A as a counter in increase/decrease counter function mode.
However, I wonder whether this is substantially different enough from
simply using the interrupt-cnt module on the respective IRQ? I'm CCing
Oleksij and the Pengutronix team in case they wish to comment.

Regardless, the Counter subsystem is capable of interfacing with the two
Signals (A and B) independently, so users should be given the capability
of counting pulses on those two signals independently if so desired. In
the Generic Counter paradigm, an arbitrary number of Counts can be
associated to the same Signals -- it's just a matter of defining each
Count's Synapses.

In such a configuration, we would have two Counts: Count 1 is the count
you currently have implemented (supports all the counter functions),
while Count 2 supports only increase/decrease modes with a Synapse for
Signal B.

In theory, we could have Count 2 support the same modes as Count 1, but
we'll start with just increase/decrease modes to keep thing simple for
this introductory patch; new features may be added in future patches.

We should also allow each Count to have its own Index signal so the
counts may be preset independent from each other.

> +struct gpio_counter_priv {
> +	struct gpio_desc *gpio_a;
> +	struct gpio_desc *gpio_b;
> +	struct gpio_desc *gpio_index;
> +
> +	int irq_a;
> +	int irq_b;
> +	int irq_index;
> +
> +	spinlock_t lock; /* protects count, ceiling, preset, function, direction, enabled */
> +
> +	u64 count;
> +	u64 ceiling;
> +	u64 preset;
> +	bool preset_enabled;
> +	bool enabled;
> +	enum counter_count_direction direction;
> +	enum counter_function function;
> +
> +	int prev_a;
> +	int prev_b;
> +
> +	struct counter_count cnts[1];
> +	struct counter_signal signals[3];
> +	struct counter_synapse synapses[3];
> +};

You'll need to add another set of some of these members to support a
second count (e.g. count, ceiling, enabled, etc.). I believe a member
structure is a good way to implement this as it'll make future updates
and changes simpler than modifying several independent arrays:

	struct gpio_counter_count_priv{
		u64 value;
		u64 ceiling;
		u64 preset;
		...
	};
	
	struct gpio_counter_priv{
		...
		struct gpio_counter_count_priv count_priv[2];
		...
	};

If someone wishes to add some new feature in a future patch (e.g. floor)
they just add it to struct gpio_counter_count_priv and it's ready to go.

> +static int gpio_counter_a_delta(struct gpio_counter_priv *priv, int a, int b,
> +				int prev_a, int prev_b)
> +{
> +	enum counter_count_direction dir;
> +
> +	switch (priv->function) {
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		if (!GPIO_COUNTER_STATE_CHANGED(prev_a, prev_b, a, b))
> +			return 0;
> +		dir = GPIO_COUNTER_GET_DIRECTION(prev_b, a);
> +		return (dir == COUNTER_COUNT_DIRECTION_FORWARD) ? 1 : -1;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> +		return (a == b) ? -1 : 1;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> +		if (a && priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
> +			return 1;
> +		if (!a && priv->direction == COUNTER_COUNT_DIRECTION_BACKWARD)
> +			return -1;
> +		return 0;

Wouldn't all quadrature counter function modes require a
GPIO_COUNTER_STATE_CHANGED() check? If the quadrature encoding is not
valid then the count should not change.

I believe both Quadrature X4 and X2 can use the same logic, with
Quadrature X1 being similar:

	case COUNTER_FUNCTION_QUADRATURE_X4:
	case COUNTER_FUNCTION_QUADRATURE_X2_A:
		if (!GPIO_COUNTER_STATE_CHANGED(prev_a, prev_b, a, b))
			return 0;
		dir = GPIO_COUNTER_GET_DIRECTION(prev_b, a);
		return (dir == COUNTER_COUNT_DIRECTION_FORWARD) ? 1 : -1;
	
	case COUNTER_FUNCTION_QUADRATURE_X1_A:
		if (!GPIO_COUNTER_STATE_CHANGED(prev_a, prev_b, a, b))
			return 0;
		dir = GPIO_COUNTER_GET_DIRECTION(prev_b, a);
		if (a && dir == COUNTER_COUNT_DIRECTION_FORWARD)
			return 1;
		if (!a && dir == COUNTER_COUNT_DIRECTION_BACKWARD)
			return -1;
		return 0;

In fact, you could even spin this off to a dedicated function:

	static int gpio_counter_quadrature_a_delta(enum counter_function function, int a, int b, int prev_a, int prev_b)
	{
		enum counter_count_direction dir;

		if (!GPIO_COUNTER_STATE_CHANGED(prev_a, prev_b, a, b))
			return 0;

		dir = GPIO_COUNTER_GET_DIRECTION(prev_b, a);

		if (function == COUNTER_FUNCTION_QUADRATURE_X1_A) {
			if (a && dir == COUNTER_COUNT_DIRECTION_FORWARD)
				return 1;
			if (!a && dir == COUNTER_COUNT_DIRECTION_BACKWARD)
				return -1;
			return 0;
		}

		return (dir == COUNTER_COUNT_DIRECTION_FORWARD) ? 1 : -1;
	}
	...
	static int gpio_counter_a_delta(struct gpio_counter_priv *priv, int a, int b, int prev_a, int prev_b)
	{
		switch (priv->function) {
		case COUNTER_FUNCTION_QUADRATURE_X4:
		case COUNTER_FUNCTION_QUADRATURE_X2_A:
		case COUNTER_FUNCTION_QUADRATURE_X1_A:
			return gpio_counter_quadrature_a_delta(priv->function, a, b, prev_a, prev_b);
		...

However, there may be a simpler solution possible without the use of
delta values. I'll discuss the idea further down in the ISR callback
review.

> +
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		if (!prev_a && a)
> +			return b ? -1 : 1;
> +		return 0;

There's no need to check prev_a because the ISR only executes when
there's a change in state. That means, checking the current a level is
enough to determine if the edge was rising or falling.

> +
> +	case COUNTER_FUNCTION_INCREASE:
> +		if (!prev_a && a)
> +			return 1;
> +		return 0;
> +
> +	case COUNTER_FUNCTION_DECREASE:
> +		if (!prev_a && a)
> +			return -1;
> +		return 0;

Increase/decrease modes aren't restricted to rising edges and may be
handled on both edges. Therefore, you may eliminate the if statements
and simply return 1 or -1 directly.

Ideally, we should allow the user to choose the Synapse action mode
(rising, falling, or both edges) via the action_write() callback, but
we can postpone that to a future feature improvement patch for the sake
of keeping this introductory driver patch simpler.

> +static irqreturn_t gpio_counter_a_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +	int a, b, delta;
> +
> +	/* !! normalises away negative gpiod_get_value() errors. */
> +	a = !!gpiod_get_value(priv->gpio_a);
> +	b = !!gpiod_get_value(priv->gpio_b);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	delta = gpio_counter_a_delta(priv, a, b, priv->prev_a, priv->prev_b);
> +	gpio_counter_update(priv, delta);

We could get rid of delta entirely. Doing so allows us to eliminate all
the delta code and replace the gpio_counter_update() call with something
like the following:

	switch (priv->function) {
	case COUNTER_FUNCTION_QUADRATURE_X4:
	case COUNTER_FUNCTION_QUADRATURE_X2_A:
	case COUNTER_FUNCTION_QUADRATURE_X1_A:
		if (!GPIO_COUNTER_STATE_CHANGED(priv->prev_a, priv->prev_b, a, b))
			break;
		priv->direction = GPIO_COUNTER_GET_DIRECTION(priv->prev_b, a);
		if (priv->function == COUNTER_FUNCTION_QUADRATURE_X1_A)
			gpio_counter_quadrature_x1_update(priv, a);
		else
			gpio_counter_count_value_update(priv);
		break;

	case COUNTER_FUNCTION_PULSE_DIRECTION:
		if (a)
			gpio_counter_count_value_update(priv);
		break;
	
	case COUNTER_FUNCTION_INCREASE:
	case COUNTER_FUNCTION_DECREASE:
		gpio_counter_count_value_update(priv);
		break;

	default:
		break;
	}

And a couple simple helper functions to handle ceiling/floor and
Quadrature X1 mode:

	static void gpio_counter_count_value_update(struct gpio_counter_priv *priv)
	{
		if (priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
			if (priv->count < priv->ceiling)
				priv->count++;
		else if (priv->count > 0)
				priv->count--;
	}

	static void gpio_counter_quadrature_x1_update(struct gpio_counter_priv *priv, int level)
	{
		if (level && priv->direction == COUNTER_COUNT_DIRECTION_FORWARD)
			gpio_counter_count_value_update(priv);
		else if (!level && priv->direction == COUNTER_COUNT_DIRECTION_BACKWARD)
			gpio_counter_count_value_update(priv);
	}

In this design, priv->direction is set in function_write() when a
user selects an increase or decrease counter function. In
pulse-direction mode on the other hand, priv->direction is updated in
the ISR callback for Signal B.

> +
> +	priv->prev_a = a;
> +	priv->prev_b = b;
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t gpio_counter_b_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +	int a, b, delta;
> +
> +	a = !!gpiod_get_value(priv->gpio_a);
> +	b = !!gpiod_get_value(priv->gpio_b);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	delta = gpio_counter_b_delta(priv, a, b, priv->prev_a, priv->prev_b);
> +	gpio_counter_update(priv, delta);
> +
> +	priv->prev_a = a;
> +	priv->prev_b = b;
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
> +
> +	return IRQ_HANDLED;
> +}

The B ISR would be updated in similar manner as the changes made to the
A ISR.

For the pulse-direction mode case, you will also need to update
priv->direction; Signal B represents direction, so a change in state
means a change in direction.

Remember to update Count 2's count value here too: increment if Count
2's priv->function is increase mode, and decrement if not.

> +static const enum counter_function gpio_counter_functions[] = {
> +	COUNTER_FUNCTION_INCREASE,	  COUNTER_FUNCTION_DECREASE,
> +	COUNTER_FUNCTION_PULSE_DIRECTION, COUNTER_FUNCTION_QUADRATURE_X1_A,
> +	COUNTER_FUNCTION_QUADRATURE_X1_B, COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B, COUNTER_FUNCTION_QUADRATURE_X4,
> +};

Count 2 will need its own counter functions list without the
pulse-direction and quadrature modes; only increase/decrease modes will
be supported at first.

> +static int gpio_counter_function_write(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       enum counter_function function)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	priv->function = function;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}

Given the suggested changes to the ISR callbacks, priv->direction should
be set here when the user selects the increase/decrease modes. You can
also set an initial priv->direction for pulse-direction mode by reading
the state of Signal B.

> +static int gpio_counter_action_read(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    struct counter_synapse *synapse,
> +				    enum counter_synapse_action *action)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	enum gpio_counter_signal_id signal_id = synapse->signal->id;
> +	enum counter_function function;
> +	enum counter_count_direction direction;
> +	unsigned long flags;
> +
> +	if (signal_id == GPIO_COUNTER_SIGNAL_INDEX) {
> +		*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;
> +	}
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	function = priv->function;
> +	direction = priv->direction;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	*action = COUNTER_SYNAPSE_ACTION_NONE;
> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		return 0;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> +		if (signal_id == GPIO_COUNTER_SIGNAL_A)
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		return 0;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> +		if (signal_id == GPIO_COUNTER_SIGNAL_B)
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		return 0;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> +		if (signal_id == GPIO_COUNTER_SIGNAL_A) {
> +			if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
> +				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +			else
> +				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> +		}
> +		return 0;
> +
> +	case COUNTER_FUNCTION_QUADRATURE_X1_B:
> +		if (signal_id == GPIO_COUNTER_SIGNAL_B) {
> +			if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
> +				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +			else
> +				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> +		}
> +		return 0;
> +
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +	case COUNTER_FUNCTION_INCREASE:
> +	case COUNTER_FUNCTION_DECREASE:
> +		if (signal_id == GPIO_COUNTER_SIGNAL_A)
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;

Increase/decrease modes don't need to be restricted to rising edge so
make them both edges.

> +static int gpio_counter_ceiling_write(struct counter_device *counter,
> +				      struct counter_count *count, u64 val)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +
> +	/* Leave count untouched on shrink; matches intel-qep / ti-eqep / stm32-timer-cnt. */

You can remove this comment; the code makes it obvious enough that the
current count value is not modified.

> +static int gpio_counter_enable_write(struct counter_device *counter,
> +				     struct counter_count *count, u8 enable)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	unsigned long flags;
> +	bool want = enable;

The Counter subsystem will ensure the enable argument is a boolean value
so you can use it directly in your code (or rename the parameter to
"want" if you prefer).

> +	bool changed;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	changed = priv->enabled != want;
> +	if (changed)
> +		priv->enabled = want;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	if (!changed)
> +		return 0;

Breaking out the negative case obscures the intent of the code more than
just unlocking the spinlock immediately on exit. Despite the additional
spin_unlock_irqrestore(), I consider this version below a lot easier to
grok:

	spin_lock_irqsave(&priv->lock, flags);
	if (priv->enabled == want) {
		spin_unlock_irqrestore(&priv->lock, flags);
		return 0;
	}
	priv->enabled = want;
	spin_unlock_irqrestore(&priv->lock, flags);

> +
> +	if (want) {
> +		enable_irq(priv->irq_a);
> +		enable_irq(priv->irq_b);
> +		if (priv->irq_index)
> +			enable_irq(priv->irq_index);
> +	} else {
> +		disable_irq(priv->irq_a);
> +		disable_irq(priv->irq_b);
> +		if (priv->irq_index)
> +			disable_irq(priv->irq_index);
> +	}

Hmm, is it a problem that priv->enabled is changed to a false state
before the IRQs are actually disabled? Do any issues arise if an IRQ is
handled during that brief period of time?

William Breathitt Gray
