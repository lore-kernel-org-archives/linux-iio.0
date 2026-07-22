Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792134749CD;
	Wed, 22 Jul 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736048; cv=none; b=IppkkvLlkraY2PT2vqO7jkuX5Y2JO4CMweOzdVzZE6gbjn9jXlN03tV20F1oBCKgvWBgiwZAoVwcOJq9XNMmieDSl/tMp3ZxTnM87R+RhlWU5JIamOI8mSFqWQ6M5n9y+ZwhH3Jgdb7uUFbkUVwxM5IDicvqBeRfgg/RFBv9TgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736048; c=relaxed/simple;
	bh=gQohexZnJwy91ur+KHozlCWYr/oet6LQXTkUlbVsHz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tz7+yS/2yzRsQGFg8qli2U/0T7PT+9dkjY8Fl4I2q45oPty8VQcUEL56MBLE4pHRo0ZipcuVEK9qzAKchfNJCnk/ZS7ym8dq4N2YTBBLHwH2CASM54IidySxtM1Sujiyh7FwOQECg0uEBiJaRBY91yM+P8IQLVwCqiTK5yfjT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXeC64G0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXeC64G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898401F000E9;
	Wed, 22 Jul 2026 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736047;
	bh=Rycz4JXQS8vhhT2SHJaUbVNk+50BfSxzgXN8KX85+kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QXeC64G0oNJibQHkHlbTU8EEactKSuDZLqs+bmrQoFemwO/R3A5f7cFbsGEwjzdoi
	 a4xBpt7CAXfDf3RHG/BjrO3irpmNPGsuSb6/FwqM0TZ23LsWN/zoIojB50Rdy1Gibv
	 NdaHV33wkI4n6hjlq7PdIbKpVo8vXM7F2hwJKrLF2Z3rlMaEqvvk+PIENTxJSKCTOl
	 zQxbS9qnOMvYPJtwZwh2Cm9+9tYiwqKbKi2H3yNJodPgFbIXNImR1Hx61mBmf089GY
	 byaqpT/0BttQvulOUeC/rJOGuXdA9KuFr5NXPExkASXD9n0uaLXgumx2wrfj7Pz+Ow
	 6FyKoQrsi2Sbg==
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
Date: Thu, 23 Jul 2026 01:00:40 +0900
Message-ID: <20260722160042.855724-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722114936.849882-1-wbg@kernel.org>
References: <20260722114936.849882-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3692; i=wbg@kernel.org; h=from:subject; bh=gQohexZnJwy91ur+KHozlCWYr/oet6LQXTkUlbVsHz4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFkJL+WWr7Q7zfnSTu5UlPtj5YD76Qkr5uQyLomY0Hvky B0OnYDMjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAih/IYGa5su/jk92rRi5sP CAecmxEY7fbdLOIg07uNFkf//g98x1DHyLA4+FHRgwtsjAJOE8oue1zt3LLb9tjl6+pyF9as2SV h+JsNAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Wed, Jul 22, 2026 at 08:49:34PM +0900, William Breathitt Gray wrote:
> On Tue, Jul 14, 2026 at 10:17:08AM +0200, Wadim Mueller wrote:
> > +static int gpio_counter_setup_signals(struct gpio_counter_priv *priv)
> > +{
> > +	priv->signals[GPIO_COUNTER_SIGNAL_A].id   = GPIO_COUNTER_SIGNAL_A;
> > +	priv->signals[GPIO_COUNTER_SIGNAL_A].name = "Signal A";
> > +	priv->signals[GPIO_COUNTER_SIGNAL_B].id   = GPIO_COUNTER_SIGNAL_B;
> > +	priv->signals[GPIO_COUNTER_SIGNAL_B].name = "Signal B";
> > +
> > +	if (priv->count_priv[GPIO_COUNTER_COUNT_1].has_index) {
> > +		priv->signals[GPIO_COUNTER_SIGNAL_INDEX1].id =
> > +			GPIO_COUNTER_SIGNAL_INDEX1;
> > +		priv->signals[GPIO_COUNTER_SIGNAL_INDEX1].name = "Index 1";
> > +	}
> > +	if (priv->count_priv[GPIO_COUNTER_COUNT_2].has_index) {
> > +		priv->signals[GPIO_COUNTER_SIGNAL_INDEX2].id =
> > +			GPIO_COUNTER_SIGNAL_INDEX2;
> > +		priv->signals[GPIO_COUNTER_SIGNAL_INDEX2].name = "Index 2";
> > +	}
> > +
> > +	return 2 + priv->count_priv[GPIO_COUNTER_COUNT_1].has_index +
> > +	       priv->count_priv[GPIO_COUNTER_COUNT_2].has_index;
> 
> As sashiko-bot pointed out, the Counter subsystem doesn't handle gaps in
> the signals array. What you can try instead is use a local variable
> num_signals to hold the current signals array offset:
> 
> 	num_signals = 2;
> 	if (priv->count_priv[GPIO_COUNTER_COUNT_1].has_index) {
> 		priv->signals[i].id = GPIO_COUNTER_SIGNAL_INDEX1;
> 		priv->signals[i].name = "Index 1";
> 		i++;
> 	}
> 	if (priv->count_priv[GPIO_COUNTER_COUNT_2].has_index) {
> 		priv->signals[i].id = GPIO_COUNTER_SIGNAL_INDEX2;
> 		priv->signals[i].name = "Index 2";
> 		i++;
> 	}
> 
> 	return i;

Oops, I intended for those 'i' to be 'num_signals'. However, if you like
you may name it 'i' or whatever makes sense.

> 
> Now, to refer back to the correct signals element later you have three
> options: loop through the signals array and check each id, or save the
> signals offset to a member of count_priv so you can refer to it later.
> 
> I think the first option is the simplest because there are only two
> Index Signals and a single if statement suffices: if priv->signals[2].id
> is not GPIO_COUNTER_SIGNAL_INDEX1, then it is GPIO_COUNTER_SIGNAL_INDEX2
> (and vice versa).
> 
> > +}
> > +
> > +static int gpio_counter_setup_synapses(struct gpio_counter_priv *priv)
> > +{
> > +	int n_c1 = 2, n_c2 = 1;
> > +
> > +	priv->synapses_count1[0].actions_list = gpio_counter_synapse_actions;
> > +	priv->synapses_count1[0].num_actions =
> > +		ARRAY_SIZE(gpio_counter_synapse_actions);
> > +	priv->synapses_count1[0].signal = &priv->signals[GPIO_COUNTER_SIGNAL_A];
> > +
> > +	priv->synapses_count1[1].actions_list = gpio_counter_synapse_actions;
> > +	priv->synapses_count1[1].num_actions =
> > +		ARRAY_SIZE(gpio_counter_synapse_actions);
> > +	priv->synapses_count1[1].signal = &priv->signals[GPIO_COUNTER_SIGNAL_B];
> > +
> > +	if (priv->count_priv[GPIO_COUNTER_COUNT_1].has_index) {
> > +		priv->synapses_count1[2].actions_list =
> > +			gpio_counter_index_synapse_actions;
> > +		priv->synapses_count1[2].num_actions =
> > +			ARRAY_SIZE(gpio_counter_index_synapse_actions);
> > +		priv->synapses_count1[2].signal =
> > +			&priv->signals[GPIO_COUNTER_SIGNAL_INDEX1];
> 
> You can use a ternary directly like this:
> 
> 	priv->synapses_count1[2].signal = (priv->signals[2].id == GPIO_COUNTER_SIGNAL_INDEX1)
> 		? &priv->signals[2] : &priv->signals[3];

I suppose index1 would always be at offset 2 if it does exist, so this
ternary isn't needed here but rather better for the index2 case in the
count2 block.

William Breathitt Gray
