Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499961;
	b=T29vDlRPbaEkqOjSNTvuqAnR6GZ2ZUxXbD3ZGNBIMYVa4/ic6K/uVyQNqhwqrzbRHDut
	 UiV65l6bHPPRd3TENGqkXEWYjkXYM/6wXD16q1o5N8RJvzNWi1iorTSUr0/qT43LKZAZi
	 gcgP+wsS+iKubMn4GvkWrxy4yyhsyU/RzFezVw3xUpkz3tEniLRW29OHf9PvSYJRjoOtN
	 yyTWYTwzpGGw6ULyJI2+/g/SdSt7l73NEO4LUWblhCPG1luskC4nE/uvh/V5Hh16y2JgE
	 oxau8B62ekePaaLckWgx76s3VxsCE1Zvb7rN9y+r+BkGMlGibiRWE0+LUz5l6smejFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499961;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fPyspVFbPKIDQ4LqkzeoiuA1iNZYYjJnNTZsI6hWXKY=;
	b=Xpl6TIDNMy4XZlyBfD4KTFs7EbT4uFi+RMenV8GPdUH/mFnkAJfyr4Y5qJz21aON9hWx
	 DZxADrqMDM/hzYcgWM2dMdvEebiJb5tyoOQyVBx8gn+aVXQCPGUHg8O1RF1YFAqul8C4U
	 2guGU2KsvXvchqd+XX53WHU67oqsBp25WuEkxGA3xDJa21G4zXpVTAaWBs5XCEsr+pHwb
	 Zt1j6EMnfidsEJ0mOa2Yep0cBkpc6ZBTFyLHA2bwNG7B0tEv/0+V9hyupO4QvkkXFcTMu
	 IJ9Wf1Q8QoEtq/Yi+zR3fyPBZiFtcpu3eCs61XHzH1OxEyTO3Kbi6599xthTvs0l8EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amzA5L5b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 748F4606A319;
	Tue, 20 Oct 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amzA5L5b
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 842ED1F000C7;
	Tue, 20 Oct 2026 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499961;
	bh=fPyspVFbPKIDQ4LqkzeoiuA1iNZYYjJnNTZsI6hWXKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=amzA5L5bHG9DIriq3h2b/Os91GZsZpLn91eYSpfkQFR/nuyPRfhB5bvbe7uirA8wO
	 6nELKuRj3I5YIGVsNJmNeCRy6nzvOnZzaPPhlU6O0ySEfqQqBnJki0cY6UL84G9+Bm
	 yUOIutEKrklpRWrwmx4KO8LWEEUeN5JPuas8BQaRC10oBysGHcpDc4zn1QrqSHVqsr
	 4y1pBb75Hwpegkl5gGBipGGBtTwWl3r920zMGwUlxNWTsvO8grapN7oTzeN9jQWdr6
	 F54ozaeXyHlEyKA1vOR5jborJ2CXdjHKTIYqZsVSOqhrl7eAUD+Mxn1Yjy7uBeCRKu
	 2RD27EsLe4rfw==
Date: Tue, 20 Oct 2026 14:39:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 06/10] iio: frequency: ad9910: add axi backend driver
Message-ID: <atddZ9KZkXwgv2IA@monoceros>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-6-3c21648c8e26@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hepozkqd53cm62gy"
Content-Disposition: inline
In-Reply-To: <20261015-ad9910-backend-support-v1-6-3c21648c8e26@analog.com>


--hepozkqd53cm62gy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 06/10] iio: frequency: ad9910: add axi backend driver
MIME-Version: 1.0

Hello,

On Thu, Oct 15, 2026 at 01:49:46PM -0300, Rodrigo Alencar via B4 Relay wrote:
> +static int ad9910_axi_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +				const struct pwm_state *state)
> +{
> +	struct ad9910_axi_state *st = pwmchip_get_drvdata(chip);
> +	u64 period, duty;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	period = mul_u64_u64_div_u64(state->period, st->pd_clk_freq_uhz,
> +				     1ULL * NANO * MICROHZ_PER_HZ);

Does st->lock protect st->pd_clk_freq_uhz? If not, the lock can be taken
later.

> +	period = min(period, U32_MAX);
> +	duty = mul_u64_u64_div_u64(state->duty_cycle, st->pd_clk_freq_uhz,
> +				   1ULL * NANO * MICROHZ_PER_HZ);
> +	duty = min(duty, period);
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED)
> +		duty = period - duty;
> +
> +	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_PERIOD, period);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_WIDTH, duty);
> +	if (ret)
> +		return ret;
> +
> +	st->pwm_polarity = state->polarity;

An inversed polarity waveform isn't the same as just inverting the
duty length. So this is cheating. The right thing to implement here
might be inconvenient, but you shouldn't implement .apply() anyhow and
the waveform stuff has saner semantics.

> +	if (state->enabled)
> +		return regmap_set_bits(st->regmap, AD9910_AXI_REG_DRG,
> +				       AD9910_AXI_REG_DRG_TOGGLE_EN_MSK);
> +
> +	return regmap_clear_bits(st->regmap, AD9910_AXI_REG_DRG,
> +				 AD9910_AXI_REG_DRG_TOGGLE_EN_MSK);
> +}
> +
> [...]
> +static const struct pwm_ops ad9910_axi_pwm_ops = {
> +	.apply = ad9910_axi_pwm_apply,
> +	.get_state = ad9910_axi_pwm_get_state,

Please use the waveform callbacks instead of .apply() and .get_state().

> +};
> +
> +static int ad9910_axi_setup(struct ad9910_axi_state *st)
> +{
> +	int ret;
> +
> +	st->pd_clk_freq_uhz = AD9910_AXI_PD_CLK_MAX_FREQ_HZ * MICROHZ_PER_HZ;
> +
> +	ret = regmap_set_bits(st->regmap, AD9910_AXI_REG_RESET,
> +			      AD9910_AXI_REG_RESET_CORE_MSK);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_clear_bits(st->regmap, AD9910_AXI_REG_RESET,
> +				 AD9910_AXI_REG_RESET_CORE_MSK);
> +}
> +
> +static int ad9910_axi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ad9910_axi_state *st;
> +	struct pwm_chip *pwm;

the name `pwm` is usually only used for variables of type struct
pwm_chip *. Please call this `chip` as it is done in the rest of the
driver.

> +	void __iomem *base;
> +	struct clk *clk;
> +	int ret;
> +
> +	pwm = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*st));
> +	if (IS_ERR(pwm))
> +		return PTR_ERR(pwm);
> +
> +	st = pwmchip_get_drvdata(pwm);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +
> +	st->dev = dev;
> +	st->regmap = devm_regmap_init_mmio(dev, base,
> +					   &ad9910_axi_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "failed to init register map\n");
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_axi_setup(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to setup device\n");
> +
> +	pwm->ops = &ad9910_axi_pwm_ops;
> +
> +	ret = devm_pwmchip_add(dev, pwm);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	return devm_iio_backend_register(dev, &ad9910_axi_back_info, st);

It's unclear to me what is the relation between that iio backend and the
PWM. If .set_sample_rate() is called for the iio device, does that
change the output of the PWM? If yes, that's bad and needs fixing.

> +}

Best regards
Uwe

--hepozkqd53cm62gy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrXYPIACgkQj4D7WH0S
/k6k2wgAuvlnAI/8NOCk6w1mONb4/gMLWFBN4F+WgeB5WFVR3x8A3lRZV6iReu8D
iCcoiU3RCCXjd4Onz+dKx2R7RmAaOCpf2dRz5iDpAvmJvMh0zC0s55VfUZrLcyUF
JM28ZnzWgt1gMMjoTdUZ0DcsCMTmhXqqXcUNpF4vmq2mzNB4yx70sCBSc/H1jQQe
ajzKNjCLVpS9FkF/KsEpp7Lx9m/fUrr4TF5oZCxoc/FH9FNRgNCSErDoNkN5oR08
mA71Eots59CAPLd8w5PXmYoahVmKKAkxUyowR9AbcS0fDJWiJOPXc/mI8zxE7OKL
3eE8Yj21x7Rx+jeZMlfdcPBSRDjHKQ==
=VZx8
-----END PGP SIGNATURE-----

--hepozkqd53cm62gy--
