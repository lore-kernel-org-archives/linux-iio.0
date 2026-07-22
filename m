Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCBE298CC4;
	Wed, 22 Jul 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720983; cv=none; b=JoHMCXYkcsk6p4ClgHoBx2vhnf/0oxoLaDdX/Z8w0StjBpJoJ5veoIFcnHO3CSm/5Nud6cUeaAnMU5Mv1n2BWIAxc4hd+KrwI8j5JRCC88Xre5wV1cBR7w8pnnpMYsxAW+0zPF/0hfbtju9Uz88bYVjwWPnCsB4o86jiNuReVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720983; c=relaxed/simple;
	bh=G1t4QRBx/d1FMNdtxRdII12ILCN644A1tUO/xDqhNG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFbUGq5v7t0bgUA/9lrnybhpKR8llfP+91lJFLl0tOMB1XQJWGrAMSLtr/GLv/2sGTUb5SJg7oF5BETqlZ9xo3aMeeDEuQhNtr/oSunuoyePXHlosUhWXz2wSLYe0mIhVCLSU02Hc2119TBkyq+5lOXytiwaR0iLD8uicji51Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGCaZBda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGCaZBda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEA41F000E9;
	Wed, 22 Jul 2026 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720982;
	bh=9nyVvZjg5pmkHu8JnBWzmjYOzzzqWtk1cj4N9hykgSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hGCaZBdagpv5hkl5YixSE/w2WcIOxVeCJSSVhG8mdICchyecSu3F2bBNDPMXnJtNr
	 qZUkGhgnR62tzi/QEZ3CDrBYFFDnfMgzvkbdcZ0+jq/ItG/lN4mPFJVvn9XldC6kuP
	 /imye9jEMBXvQxpdGkEZln/zM6cpf8iyn+IuiSt2FZSp/v5a0OFino+iRZg6ZcS9/2
	 vuxR2YDMSmoeRGxsXrFlnUWBZnhpyAMmN7Bl8r3Iagc8GhjQlU9JETMZYuLrPxQlP9
	 Og7iu7vqROrGxkYd7FVV6Eq7BH5VLRiB5x8VFdu5HpaUes8r05GQModR90RwmNkF0Q
	 GXYZnYWX5czJQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] counter: add GPIO-based counter driver
Date: Wed, 22 Jul 2026 20:49:34 +0900
Message-ID: <20260722114936.849882-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714081709.17846-3-wafgo01@gmail.com>
References: <20260714081709.17846-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7515; i=wbg@kernel.org; h=from:subject; bh=G1t4QRBx/d1FMNdtxRdII12ILCN644A1tUO/xDqhNG8=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFkJ66zMS1f9mtz/ad6jb0J+PpsL4j4XHX6ddeN6kSCLc 5R3baxyRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRiB6G//nP50gLzThw8M+s CZ2zlttqH17xnn3uilC+xOzFpquT844zMjz2rLp++VIB1y/jHwUpSVtc0+7nO9x6rCPqHlhwQc1 eiQ0A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Tue, Jul 14, 2026 at 10:17:08AM +0200, Wadim Mueller wrote:
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

The sashiko-bot picked up an issue I hadn't considered in the previous
review: 64-bit reads may be implemented as two 32-bit read operations on
32-bit systems resulting in a race condition. So it seems that we do
need to acquire priv->lock to protect access to u64 count_priv members
even when we simply read. As such, please add back the spinlock calls
from the previous version for the relevant u64 members (value, ceiling,
and preset).

A few more comments below.

> +static void gpio_counter_index_pulse(struct counter_device *counter,
> +				     enum gpio_counter_count_id count_id)
> +{
> +	struct gpio_counter_priv *priv = counter_priv(counter);
> +	struct gpio_counter_count_priv *cp = &priv->count_priv[count_id];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	if (cp->preset_enabled)
> +		cp->value = (cp->preset > cp->ceiling) ? cp->ceiling : cp->preset;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	counter_push_event(counter, COUNTER_EVENT_INDEX, count_id);
> +}
> +
> +static irqreturn_t gpio_counter_index1_isr(int irq, void *dev_id)
> +{
> +	gpio_counter_index_pulse(dev_id, GPIO_COUNTER_COUNT_1);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t gpio_counter_index2_isr(int irq, void *dev_id)
> +{
> +	gpio_counter_index_pulse(dev_id, GPIO_COUNTER_COUNT_2);
> +	return IRQ_HANDLED;
> +}

The count_priv array holds the respective IRQ value in the idx_irq
member, so you can loop through the array to find the particular
count_priv element. We have only two Counts, so a simple if-else will
suffice. That allows you to avoid the two separate Index ISR and instead
repurpose the code in gpio_counter_index_pulse() as the sole Index ISR.
Maybe something like this:

	static irqreturn_t gpio_counter_index_isr(int irq, void *private)
	{
		struct counter_device *counter = private;
		struct gpio_counter_priv *priv = counter_priv(counter);
		struct gpio_counter_count_priv *cp = &priv->count_priv[0];
		unsigned long flags;
	
		if (cp->idx_irq != irq);
			cp = &priv->count_priv[1];
	
		spin_lock_irqsave(&priv->lock, flags);

		if (!cp->enabled) {
			spin_unlock_irqrestore(&priv->lock, flags);
			return IRQ_HANDLED;
		}

		if (cp->preset_enabled)
			cp->value = (cp->preset > cp->ceiling) ? cp->ceiling : cp->preset;

		spin_unlock_irqrestore(&priv->lock, flags);
	
		counter_push_event(counter, COUNTER_EVENT_INDEX, count_id);

		return IRQ_HANDLED;
	}

> +static int gpio_counter_setup_signals(struct gpio_counter_priv *priv)
> +{
> +	priv->signals[GPIO_COUNTER_SIGNAL_A].id   = GPIO_COUNTER_SIGNAL_A;
> +	priv->signals[GPIO_COUNTER_SIGNAL_A].name = "Signal A";
> +	priv->signals[GPIO_COUNTER_SIGNAL_B].id   = GPIO_COUNTER_SIGNAL_B;
> +	priv->signals[GPIO_COUNTER_SIGNAL_B].name = "Signal B";
> +
> +	if (priv->count_priv[GPIO_COUNTER_COUNT_1].has_index) {
> +		priv->signals[GPIO_COUNTER_SIGNAL_INDEX1].id =
> +			GPIO_COUNTER_SIGNAL_INDEX1;
> +		priv->signals[GPIO_COUNTER_SIGNAL_INDEX1].name = "Index 1";
> +	}
> +	if (priv->count_priv[GPIO_COUNTER_COUNT_2].has_index) {
> +		priv->signals[GPIO_COUNTER_SIGNAL_INDEX2].id =
> +			GPIO_COUNTER_SIGNAL_INDEX2;
> +		priv->signals[GPIO_COUNTER_SIGNAL_INDEX2].name = "Index 2";
> +	}
> +
> +	return 2 + priv->count_priv[GPIO_COUNTER_COUNT_1].has_index +
> +	       priv->count_priv[GPIO_COUNTER_COUNT_2].has_index;

As sashiko-bot pointed out, the Counter subsystem doesn't handle gaps in
the signals array. What you can try instead is use a local variable
num_signals to hold the current signals array offset:

	num_signals = 2;
	if (priv->count_priv[GPIO_COUNTER_COUNT_1].has_index) {
		priv->signals[i].id = GPIO_COUNTER_SIGNAL_INDEX1;
		priv->signals[i].name = "Index 1";
		i++;
	}
	if (priv->count_priv[GPIO_COUNTER_COUNT_2].has_index) {
		priv->signals[i].id = GPIO_COUNTER_SIGNAL_INDEX2;
		priv->signals[i].name = "Index 2";
		i++;
	}

	return i;

Now, to refer back to the correct signals element later you have three
options: loop through the signals array and check each id, or save the
signals offset to a member of count_priv so you can refer to it later.

I think the first option is the simplest because there are only two
Index Signals and a single if statement suffices: if priv->signals[2].id
is not GPIO_COUNTER_SIGNAL_INDEX1, then it is GPIO_COUNTER_SIGNAL_INDEX2
(and vice versa).

> +}
> +
> +static int gpio_counter_setup_synapses(struct gpio_counter_priv *priv)
> +{
> +	int n_c1 = 2, n_c2 = 1;
> +
> +	priv->synapses_count1[0].actions_list = gpio_counter_synapse_actions;
> +	priv->synapses_count1[0].num_actions =
> +		ARRAY_SIZE(gpio_counter_synapse_actions);
> +	priv->synapses_count1[0].signal = &priv->signals[GPIO_COUNTER_SIGNAL_A];
> +
> +	priv->synapses_count1[1].actions_list = gpio_counter_synapse_actions;
> +	priv->synapses_count1[1].num_actions =
> +		ARRAY_SIZE(gpio_counter_synapse_actions);
> +	priv->synapses_count1[1].signal = &priv->signals[GPIO_COUNTER_SIGNAL_B];
> +
> +	if (priv->count_priv[GPIO_COUNTER_COUNT_1].has_index) {
> +		priv->synapses_count1[2].actions_list =
> +			gpio_counter_index_synapse_actions;
> +		priv->synapses_count1[2].num_actions =
> +			ARRAY_SIZE(gpio_counter_index_synapse_actions);
> +		priv->synapses_count1[2].signal =
> +			&priv->signals[GPIO_COUNTER_SIGNAL_INDEX1];

You can use a ternary directly like this:

	priv->synapses_count1[2].signal = (priv->signals[2].id == GPIO_COUNTER_SIGNAL_INDEX1)
		? &priv->signals[2] : &priv->signals[3];

Or wrap it in a function to abstract it with a name like
gpio_counter_get_index_signal() or similar.

> +		n_c1 = 3;
> +	}
> +
> +	priv->synapses_count2[0].actions_list = gpio_counter_synapse_actions;
> +	priv->synapses_count2[0].num_actions =
> +		ARRAY_SIZE(gpio_counter_synapse_actions);
> +	priv->synapses_count2[0].signal = &priv->signals[GPIO_COUNTER_SIGNAL_B];
> +
> +	if (priv->count_priv[GPIO_COUNTER_COUNT_2].has_index) {
> +		priv->synapses_count2[1].actions_list =
> +			gpio_counter_index_synapse_actions;
> +		priv->synapses_count2[1].num_actions =
> +			ARRAY_SIZE(gpio_counter_index_synapse_actions);
> +		priv->synapses_count2[1].signal =
> +			&priv->signals[GPIO_COUNTER_SIGNAL_INDEX2];

Similar comment as above.

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20260714082741.ACC001F000E9@smtp.kernel.org/
