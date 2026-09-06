Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950183C1D73;
	Sun,  6 Sep 2026 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666635; cv=none; b=h3aBgw3vhUW2P3zMRgqxvS+GREtd53gzVtVDpEaUpgEse4/u90xpDSwz6bDPDbTvWeii4k/iuTpdMLjVIRpcJzt5mThqibA+Qv4epJeSZ0IrHtqm54oiwPAKOI7YECKoEIeHuTExLWYpvOmIIM5KA8i4A6+3W5yERb7PsRQmb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666635; c=relaxed/simple;
	bh=ebDom084COVQMpMZJxpqPSrBDeTGz5YHbvDD+BGBc5s=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=gYrrhWXLsgJLKFwkHCR/DBKpYDTeVziFS0WFOfniUuwXSj2Pt8GjP8m0kU+Ak36U7QTTDrT+lcQyEWzaDJXHEaZhs8jBY5Rykezp5wGLQbtA7rKEO00TOqOuENbVzBQ20qrCaikGLmwGy1qYOGvOl7X9JQouyow9XqMvQtZCEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW2oqw7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW2oqw7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397951F00ADF;
	Sun,  6 Sep 2026 03:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788666631;
	bh=BTq5+jku7wz6AHD3U8Hwc9D5mIrP8zS3ob8KTHV+1d0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZW2oqw7FBIaufa8GiXKsCMTayM+XDllr6qdL/uucR+88fF8bQAVF0f/c+vAe81qxS
	 +Xub3Abp4g/3zypOfMWAxfnY3JJhscCeC9tltCgDklximlYKBBxG4dOXdGKEmP3dFP
	 1XUfX3dYu8u0R2l7ziF0sF4KMORlvn1dEdGY2oHKZEgel4Bbx5O3PZCuOaNvynW2V7
	 92GSxVa6SpeXWEwDt6SiDF2bIlbhybGyYeUqfyqz2l1kTQNbptZP94TCwvOlI5jJAY
	 PzvkRUv6i6MgTfHJGKXbEwMaGvgYq7vXyiUo5Uf2B2Lj0wpmvuIKgK+XJGmlixIPIR
	 fJmUgqST2ChzA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 14/17] iio: adc: ad7768: Add per-channel conversion
 delay
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260904-ad7768-driver-v6-14-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-14-e4378f946bfb@analog.com>
Date: Sun, 06 Sep 2026 04:50:02 +0100
Message-Id: <178866660280.3402141.14562225854530074451.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3576;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=ebDom084COVQMpMZJxpqPSrBDeTGz5YHbvDD+BGBc5s=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnOL+gwGsUNRR0LvErFuFaeSjprrXoIw/7mQbY
 5ucs6xpmA+JAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzi/hEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiBByD/9JxoTScidSXZjp96684vhayXrRea2rQTAxbbRGjozDYSN
 6t+e/NigcjAXCDi9PyIjU6dXVqiepk1r6Dgj2pWDzJOuYbfrvdFTakKckLOqUVGxlVgkWYqRTdR
 +34vkdrgamwlY+k7HsAb5CYEJWyrYa9TDW8p+tx94mX0HlKoNYrUx6+bn+g7htpvXsLmb4UsngB
 z5bx7GygqmG5X6PKGHGkvo1CssMvHrNpDktoXON7cuzLgYhRIYvy/HULrmWLoDmB0sUIXVYLiEn
 aa+LMdNozsfqtPdb9WSWMGR+UJB/RzcE2+H4Junq5qfzVXiryWLAyZdlY0s8IwozHsrPk9LepvJ
 OXY9V4GBEzP2l1VMvJo3H8+f2KQN5ddiZvpBgxmYwSKQVXJouDHgx4EeFweHlH7EvYC3bNvRoad
 uXMn2P6OHwC+246rEBDiZE4f7Mw6ISGYjxYLVTi2Ja1EcuXu9sTU4A5F+BQE4D6P1gHOCQAL0YL
 iVzkBmfdhublGZMDeajc+ZF3fVDGquQHNEn01nolmx11Zpxa9yDN2eQcVPGDN2poyIqsUqVm6ur
 TYSpXbxovksSvi4O1XXusyuoNXNjegb9erkBd8zuX/fYxpIBMM1VNlQIt6yWcSQerr9q+3F1mr7
 9g6gYLk9e0d19Z/59fMYri+5vNe3NmbtWn0EnSQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Expose the per-channel synchronization phase offset through the IIO
> conversion-delay attribute.
> 
> Derive the delay resolution from MCLK, power mode and decimation rate.
> Validate the requested delay and program the corresponding phase
> register when applying the active channel configuration.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>
A few things in here from sashiko as well. + one from me.

> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> index 802666f7abd4..9c6bebb1857f 100644
> --- a/drivers/iio/adc/ad7768.c
> +++ b/drivers/iio/adc/ad7768.c

>  
> +static int ad7768_get_convdelay_params(struct ad7768_state *st, unsigned int ch,
> +				       struct ad7768_convdelay_params *params)
> +{
> +	const struct ad7768_freq_config *freq_cfg;
> +	unsigned int dec_rate;
> +	unsigned int mclk_div;
> +	u64 mclk;
> +	u64 mult;
> +
> +	freq_cfg = ad7768_find_freq_config(st, st->power_mode_idx,
> +					   st->ch_freq[ch]);
> +	if (!freq_cfg)
> +		return -EINVAL;
> +
> +	dec_rate = ad7768_dec_rate[freq_cfg->dec_rate];
> +	switch (dec_rate) {
> +	case 32:
> +		params->shift = 3;
> +		params->max_raw = 31;
> +		mult = 1;
> +		break;
> +	case 64:
> +		params->shift = 2;
> +		params->max_raw = 63;
> +		mult = 1;
> +		break;
> +	case 128:
> +		params->shift = 1;
> +		params->max_raw = 127;
> +		mult = 1;
> +		break;
> +	case 256:
> +		params->shift = 0;
> +		params->max_raw = 255;
> +		mult = 1;
> +		break;
> +	case 512:
> +		params->shift = 0;
> +		params->max_raw = 255;
> +		mult = 2;
> +		break;
> +	case 1024:
> +		params->shift = 0;
> +		params->max_raw = 255;
> +		mult = 4;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mclk = clk_get_rate(st->mclk);
> +	if (!mclk)
> +		return -EINVAL;
> +
> +	mclk_div = ad7768_power_modes[st->power_mode_idx].mclk_div;
> +	params->step_ps =
> +		DIV_ROUND_CLOSEST_ULL(mult * PSEC_PER_SEC * mclk_div, mclk);

Sashiko:
[Severity: Low]
Is it safe to pass the 64-bit variable mclk as the divisor here?

The DIV_ROUND_CLOSEST_ULL() macro explicitly requires a 32-bit divisor.
Internally, it invokes do_div(), which casts the divisor to a 32-bit
integer.

While this might not cause a functional issue here because mclk is bounded
and fits safely within 32 bits, it violates the API contract and can
trigger static analysis warnings due to the implicit downcasting of the
u64 type.

-
Not a major thing but given the docs for DIV_ROUND_CLOSEST_ULL call
out that it 'must' be a 32 bit number, I'd add some checks to confirm
it is.

> +
> +	return 0;
> +}
> +
> +static int ad7768_set_channel_convdelay(struct ad7768_state *st,
> +					unsigned int ch)
> +{
> +	u64 delay_ps = st->ch_convdelay_ps[ch];
> +	struct ad7768_convdelay_params params;
> +	u64 max_delay_ps;
> +	u64 raw;
> +	int ret;
> +
> +	ret = ad7768_get_convdelay_params(st, ch, &params);
> +	if (ret)
> +		return ret;
> +
> +	max_delay_ps = (u64)params.max_raw * params.step_ps;
> +	if (delay_ps > max_delay_ps)
> +		return -EINVAL;

Add a comment here in why you need to do the check fist in
the step_ps multiplied space then again after division.

> +
> +	raw = DIV_ROUND_CLOSEST_ULL(delay_ps, params.step_ps);

Sashiko:

[Severity: Low]
Does this have the same type safety issue as above?

The params.step_ps struct member is declared as a u64, but is passed
to DIV_ROUND_CLOSEST_ULL() which requires a 32-bit divisor.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
