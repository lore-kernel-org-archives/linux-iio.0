Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514F3EFFA1;
	Tue,  7 Jul 2026 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421130; cv=none; b=HW9xrn9D4+hheD/fTygvyZt85MwSpbzdXalpOLjKLlnTLi2kZ+9ohyKpymVSwhGZ4qDhsih83qi9pED3IS8agfw/hi9tsAcs/lowKC3jvOMKffYybn7iSJ0V3VIruL6KQfsRo4MX6eAkWMV2xHHY6vnv7AihYEn0cZ99x0DzV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421130; c=relaxed/simple;
	bh=79iZhGA/eKoF7itCEDAEkbK5WX+rCydbBtRw25TyKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpV92WycypYavuKed74ASXNNCP1tUB+NskspbKfXw5CpbHUKoO+iJmNFe5g5VSBP2quCFOf684oZ6zZikoEuQXRoCfHlyId1u3ejkeXSy/FrnTqdwa6DsBF/6PAIOeWMx4QLTJqn9hi7h9b24763Dn8DwCe4JUcKAMJqawEywJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hchZPLi2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hchZPLi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EFB1F000E9;
	Tue,  7 Jul 2026 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421125;
	bh=xvUTqsdEp5kjADSpZapUlN+uufG0dQMmtEnLN8nwO9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hchZPLi2fSGJBNfWIPhNt6YH5ks4BUSoKyeJwLRINLlnm0ZpRELaiEhI+1vMPG/81
	 FMCVSvCXL0N5cKLa3Nt45tSTAyHk5nBaFTh1t0DlYJykjgtaZimari5SHf8u7owl2S
	 oJdIbpTg1flZNjxbrRMAEPc1qqiB3mkJ/JgQ8ze2Wh93Wk0j0M3yK/HrmXuT+0jLcy
	 je4QWyIv4W5Mq2lE57vBgC/doZ5KAf/Knqqx4Shvk81i92e2xaO19ts0LMx4pn3V7B
	 QcOdiPgzwi/6kQMDu+OyQDLk5zDylimSdQ6FoVgm7oj1Ob6muMC7dHoM1AK+znHBqn
	 QBPeZDxlm4XCg==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	o.rempel@pengutronix.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v6 2/3] counter: add GPIO-based counter driver
Date: Tue,  7 Jul 2026 19:44:58 +0900
Message-ID: <20260707104501.977372-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628210241.119825-3-wafgo01@gmail.com>
References: <20260628210241.119825-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12889; i=wbg@kernel.org; h=from:subject; bh=79iZhGA/eKoF7itCEDAEkbK5WX+rCydbBtRw25TyKYw=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFk+N0Q6t5xfk333b/Kvz+qt/3mDuK9PfycQ/+VvosRTC 4GauvrIjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAixraMDCv8NxRISty7/T+y feW3OMOLxTcfvl+xxVl9nv3PCptvJ7UY/orENT64t/6KyOUpf16aiM8WdpTN2cwaGaJVUMZ9Pqi OlxMA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sun, Jun 28, 2026 at 11:02:40PM +0200, Wadim Mueller wrote:
> Add a platform driver that turns plain GPIOs into a counter device.
> Edge interrupts on signal-a, signal-b (and optional index) are
> decoded in software. Quadrature steps are validated with a 2-bit
> Gray-code parity check; direction comes from the same identity.
> 
> The driver exposes two Counts on the same wires:
> 
>   "Count 1" - Synapses on A, B and optional Index 1. Supports
>               QUADRATURE_X1_{A,B} / X2_{A,B} / X4, PULSE_DIRECTION,
>               INCREASE and DECREASE.
>   "Count 2" - Synapse on B and optional Index 2. Supports INCREASE
>               and DECREASE only.
> 
> Per-Count state (value, ceiling, preset, enable, function, direction)
> lives in struct gpio_counter_count_priv so new per-Count features
> (e.g. floor) can be added without touching parallel arrays.
> 
> Sleepable GPIO providers (I2C/SPI expanders) are rejected at probe
> since the ISRs run in hardirq context.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

Hi Wadim,

I thought some more about the "enabled" race condition we discussed
previously [^1]. I realized it's not a problem afterall because "enable"
refers to the Count and not inherently the interrupt. In other words, an
interrupt firing during a "disabled" state is okay as long as the Count
is not affected. Because gpio_counter_a_isr and gpio_counter_b_isr only
update the Counts when they are enabled, we should be fine.

It looks like we're almost there with this driver, so hopefully v7 will
be our final revision. Some comments follow below.

> +enum gpio_counter_signal_id {
> +	GPIO_COUNTER_SIGNAL_A = 0,
> +	GPIO_COUNTER_SIGNAL_B,
> +	GPIO_COUNTER_SIGNAL_INDEX1,
> +	GPIO_COUNTER_SIGNAL_INDEX2,
> +	GPIO_COUNTER_NUM_SIGNALS_MAX,
> +};
> +
> +enum gpio_counter_count_id {
> +	GPIO_COUNTER_COUNT_1 = 0,
> +	GPIO_COUNTER_COUNT_2,
> +	GPIO_COUNTER_NUM_COUNTS,
> +};

I'd rename this to GPIO_COUNTER_NUM_COUNTS_MAX for consistency with
GPIO_COUNTER_NUM_SIGNALS_MAX. Albeit, this is nitpick so I don't mind
keeping the name if you prefer it that way.

> +
> +#define GPIO_COUNTER_COUNT1_NUM_SYNAPSES	3	/* A, B, Index 1 */
> +#define GPIO_COUNTER_COUNT2_NUM_SYNAPSES	2	/* B, Index 2 */
> +#define GPIO_COUNTER_MAX_INDEX			2

The theoretical index maximum would be the number of Counts, so you can
set it to GPIO_COUNTER_NUM_COUNTS so it always matches in case we add
new Counts in the future.

> +struct gpio_counter_priv {
> +	struct gpio_desc *gpio_a;
> +	struct gpio_desc *gpio_b;
> +	struct gpio_desc *gpio_idx[GPIO_COUNTER_MAX_INDEX];
> +
> +	int irq_a;
> +	int irq_b;
> +	int irq_idx[GPIO_COUNTER_MAX_INDEX];
> +
> +	int n_idx;
> +
> +	/* protects count state, prev_a, prev_b */
> +	spinlock_t lock;
> +
> +	/* serialises enable_write() callers and b_irq_users */
> +	struct mutex enable_lock;
> +
> +	/* irq_b is shared by Count 1 and Count 2 (under enable_lock) */
> +	int b_irq_users;
> +
> +	int prev_a;
> +	int prev_b;
> +
> +	struct gpio_counter_count_priv count_priv[GPIO_COUNTER_NUM_COUNTS];
> +
> +	struct counter_signal  signals[GPIO_COUNTER_NUM_SIGNALS_MAX];
> +	struct counter_synapse synapses_count1[GPIO_COUNTER_COUNT1_NUM_SYNAPSES];
> +	struct counter_synapse synapses_count2[GPIO_COUNTER_COUNT2_NUM_SYNAPSES];

A future goal is to support pulse-direction mode for Count 2 which will
require two GPIO lines similar to Count 1. So instead of synapses_count1
and synapses_count2, I suggest a GPIO_COUNTER_COUNT_NUM_SYNAPSES set to 3
and defining a single multi-dimensional array called
synapses[GPIO_COUNTER_NUM_COUNTS][GPIO_COUNTER_COUNT_NUM_SYNAPSES].

> +static irqreturn_t gpio_counter_a_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp =
> +		&priv->count_priv[GPIO_COUNTER_COUNT_1];
> +	unsigned long flags;
> +	bool enabled;
> +	int a, b;
> +
> +	/* !! drops negative gpiod_get_value() errors. */
> +	a = !!gpiod_get_value(priv->gpio_a);
> +	b = !!gpiod_get_value(priv->gpio_b);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	enabled = cp->enabled;
> +	if (!enabled)
> +		goto out;

Shouldn't the enable state check occur before we get the current values
of A and B? If we are in a disabled state, we exit early and thus have
no need for the A and B values.

> +static irqreturn_t gpio_counter_b_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *c1 =
> +		&priv->count_priv[GPIO_COUNTER_COUNT_1];
> +	struct gpio_counter_count_priv *c2 =
> +		&priv->count_priv[GPIO_COUNTER_COUNT_2];
> +	bool c1_enabled, c2_enabled;
> +	unsigned long flags;
> +	int a, b;
> +
> +	a = !!gpiod_get_value(priv->gpio_a);
> +	b = !!gpiod_get_value(priv->gpio_b);

Same comment as in gpio_counter_a_isr().

> +static void gpio_counter_index_pulse(struct counter_device *counter,
> +				     enum gpio_counter_count_id count_id)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count_id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	if (cp->preset_enabled) {
> +		cp->value = cp->preset;
> +		if (cp->value > cp->ceiling)
> +			cp->value = cp->ceiling;

This is just an assignment so a ternary may communicate the intent more
succinctly:

	if (cp->preset_enabled)
		cp->value = (cp->preset > cp->ceiling) ? cp->ceiling : cp->preset;

> +static int gpio_counter_count_read(struct counter_device *counter,
> +				   struct counter_count *count, u64 *val)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count->id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*val = cp->value;
> +	spin_unlock_irqrestore(&priv->lock, flags);

This is a single read operation so the lock is unnecessary here.

> +static int gpio_counter_function_read(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      enum counter_function *function)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count->id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*function = cp->function;
> +	spin_unlock_irqrestore(&priv->lock, flags);

Same comment as in the count_read() callback.

> +static int gpio_counter_ceiling_read(struct counter_device *counter,
> +				     struct counter_count *count, u64 *val)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count->id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*val = cp->ceiling;
> +	spin_unlock_irqrestore(&priv->lock, flags);

Same comment as in the count_read() callback.

> +static int gpio_counter_enable_read(struct counter_device *counter,
> +				    struct counter_count *count, u8 *enable)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count->id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*enable = cp->enabled;
> +	spin_unlock_irqrestore(&priv->lock, flags);

Same comment as in the count_read() callback.

> +/* enable_lock held */
> +static void gpio_counter_enable_b(struct gpio_counter_priv *priv)
> +{
> +	if (priv->b_irq_users++ == 0)
> +		enable_irq(priv->irq_b);
> +}
> +
> +/* enable_lock held */
> +static void gpio_counter_disable_b(struct gpio_counter_priv *priv)
> +{
> +	if (--priv->b_irq_users == 0)
> +		disable_irq(priv->irq_b);
> +}

Conceptually, updating b_irq_users and checking for zero are two
separate tasks, so dedicate each task to its own line.

> +static int gpio_counter_enable_write(struct counter_device *counter,
> +				     struct counter_count *count, u8 enable)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count->id];
> +	unsigned long flags;
> +	bool current_state;
> +
> +	guard(mutex)(&priv->enable_lock);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	current_state = cp->enabled;
> +	spin_unlock_irqrestore(&priv->lock, flags);

Same comment as in the count_read() callback.

> +
> +	if (current_state == enable)

The current_state variable is only used here so it can go away entirely
if you replace it with cp->enabled directly.

> +		return 0;
> +
> +	/* disable_irq() may sleep, so it can not run under the spinlock. */
> +	if (enable) {
> +		spin_lock_irqsave(&priv->lock, flags);
> +		priv->prev_a = !!gpiod_get_value(priv->gpio_a);
> +		priv->prev_b = !!gpiod_get_value(priv->gpio_b);
> +		cp->enabled = true;
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		gpio_counter_enable_irqs(priv, count->id);

To ensures everything is ready to go before we start updating the
Counts, should the IRQs be enabled first before setting cp->enabled to
true?

> +	} else {
> +		spin_lock_irqsave(&priv->lock, flags);
> +		cp->enabled = false;
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		gpio_counter_disable_irqs(priv, count->id);
> +	}
> +
> +	return 0;
> +}
> +
> +static int gpio_counter_direction_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       u32 *direction)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count->id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*direction = cp->direction;
> +	spin_unlock_irqrestore(&priv->lock, flags);

Same comment as in the count_read() callback.

> +static int gpio_counter_preset_read(struct counter_device *counter,
> +				    struct counter_count *count, u64 *val)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count->id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*val = cp->preset;
> +	spin_unlock_irqrestore(&priv->lock, flags);

Same comment as in the count_read() callback.

> +static int gpio_counter_preset_enable_read(struct counter_device *counter,
> +					   struct counter_count *count,
> +					   u8 *val)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count->id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*val = cp->preset_enabled;
> +	spin_unlock_irqrestore(&priv->lock, flags);

Same comment as in the count_read() callback.

> +static int gpio_counter_get_index_gpios(struct device *dev,
> +					struct gpio_counter_priv *priv)
> +{
> +	struct gpio_descs *descs;
> +	int i;
> +
> +	descs = devm_gpiod_get_array_optional(dev, "index", GPIOD_IN);
> +	if (IS_ERR(descs))
> +		return dev_err_probe(dev, PTR_ERR(descs),
> +				     "failed to get index GPIOs\n");
> +	if (!descs) {
> +		priv->n_idx = 0;
> +		return 0;
> +	}
> +
> +	if (descs->ndescs < 1 || descs->ndescs > GPIO_COUNTER_MAX_INDEX)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "index-gpios: expected 1..%d entries, got %u\n",
> +				     GPIO_COUNTER_MAX_INDEX, descs->ndescs);
> +
> +	for (i = 0; i < descs->ndescs; i++)
> +		priv->gpio_idx[i] = descs->desc[i];
> +	priv->n_idx = descs->ndescs;
> +
> +	return 0;
> +}

Initially, I thought it would be fine to let the index-gpios DT entries
map sequentially to the Counts, but now I noticed two problems with this
approach.

First, the code around n_idx is much harder to grok. For example, in
gpio_counter_enable_irqs() the n_idx value is used as an indirect way of
determining whether an index IRQ should be enabled for a Count. The more
natural approach would be a dedicated index variable on each Count, that
way each Count knows its own index IRQ if it has one.

The second problem is that we now require Count 1 to have an index line
even if we only care about Count 2. The would be a problem if the user
has only three GPIO lines available.

As such, we need a different approach in the DT entries that allows
users to directly specify which index lines are for which Counts. That
way, you can store this information in gpio_counter_count_priv and know
easily whether a particular Count has an index IRQ and what it is.

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20260623053800.120909-1-wbg@kernel.org/
