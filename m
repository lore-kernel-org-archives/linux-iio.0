Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750954;
	b=KXwV+2soBy04QebqJ2yMl88FT4Ee2O1+OBFqTAVjesJHBZuCXLSrlzn/G8ywtmXj1bPi
	 fHWDSifdWGGPS2eNdDPDpa3DHQvRaSpiTsdrDbhyWmvVzWes/OYaS/FfRUh5z78EM7FmH
	 YJzHOyCcUHbB5R57mCOO+pFFy8rQv5bUVvY09XdOjiFSYsNXRbFlajLxwRVjhbGtrKyZw
	 2JvHmQpjl5w26KaBRM2768cyuGxj0GaHZ4v7iFzNJeGW8msBciAa0S+a1gM3+PQd1cLfb
	 hQzSGM6z3lL8u0B55pFwW1kcPQUUO/ao7rjDu3EGvM8ge4E8w5o/Q2WI6rrhLLf8AmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750954;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IYRPKhyfO4UMML71OXSlERrgz8hxI41+MGLebZDvWZQ=;
	b=3akPTFqV5jKklzO31MMIQBAsvSU5CKHrNibiRA4DLcZPv0jR6l2Qpef76rgfNeKrCydF
	 +Q7Dh4+w9/nIKGGcYzVvH99gS793PkW91X2cCM7I0tP9Ll/FsRJ5ZFRCZ7ihphy4IkmyL
	 Q3hEgCgN5g469y1z7RfFkF1SXy0kV2zZ9KrI9SSwqBV4ZkwoAgopJ0x5KzNgUO5s4FtKC
	 MTVCDuYYrQEKI/GBrlgHz+PeLoqbRa5JIcVoqk4uhc/dnGMPHnxDMvJMKJFTXJzq9S0m+
	 jUj8Uvljn+VfqL3P0phiQle+ozj9e27KtsQKneM+TULwL6YxlYOAmWua24pKMRj7h0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igqm35wy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45740606A31B;
	Wed,  4 Nov 2026 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igqm35wy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDC1F000C1;
	Wed,  4 Nov 2026 00:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750953;
	bh=IYRPKhyfO4UMML71OXSlERrgz8hxI41+MGLebZDvWZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=igqm35wydeHHI+kdSVegLZu8Mr69s9J++syGXGApo9f9VYuvaa17zJFuPj/9sJgtb
	 Ah3W1nldvbthpEtFoQTm2C8pdx9DsXBT8XQm46AyTVXS8MjVQfmZd5+aJ4d7qxNMtv
	 /7u5q6OFx00Alx6ifRu0LlhczCzH3G1oqlLOqh6LGnPjp7pHhRq0VR8pSgFR6+mR19
	 hmw/TweYgxtDVXLM8CEGgw7x2HUOKPeRrsX4dfE0qgtKjghKL2TegYZzuJW/nGfZIH
	 ei+ZV725A6LeG5hsMAeUrtoHSxkrCA1e2h7lNwi5N0HSwjipzT90A2GuQqm+tisOUM
	 PrQ1gYn2yJBuA==
Date: Wed, 4 Nov 2026 00:09:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 06/10] iio: frequency: ad9910: add axi backend driver
Message-ID: <20261104000906.61b07c44@jic23-hlaptop>
In-Reply-To: <20261103-ad9910-backend-support-v3-6-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
	<20261103-ad9910-backend-support-v3-6-0e9224ddf7b7@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Nov 2026 11:53:02 -0300
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add the driver for the AD9910 AXI backend IP core, which interfaces with
> the data and control pins of the AD9910 DDS. It registers as an IIO
> backend that provides:
> 
> - a DMA output buffer that streams data into the parallel data port;
> - the parallel data destination (F[1:0] pins) and data rate, derived
>   from the PDCLK frequency;
> - the PROFILE[2:0] pins control, through profile channel enables.
> 
> It also registers a PWM chip with a single output driving the DRCTL
> pin, which the AD9910 driver uses to control the digital ramp generator
> direction. The PWM implements the waveform callbacks, with period, duty
> length and duty offset programmed in SYNC_CLK cycles. The duty offset
> is realized by a delay applied once, before DRCTL starts toggling. The
> waveform is reprogrammed when the SYNC_CLK rate changes, so that the PWM
> output keeps its timing.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Really trivial stuff that I might have ignored, but given it looks like
you'll be doing a v4 might as well tidy up.

Thanks,

Jonathan

> diff --git a/drivers/iio/frequency/ad9910-axi-backend.c b/drivers/iio/frequency/ad9910-axi-backend.c
> new file mode 100644
> index 000000000000..db99fa9f2dda
> --- /dev/null
> +++ b/drivers/iio/frequency/ad9910-axi-backend.c
> @@ -0,0 +1,551 @@

> +
> +static void ad9910_axi_drctl_fromhw(struct ad9910_axi_state *st,
> +				    const struct ad9910_axi_drctl_wfhw *wfhw,
> +				    struct pwm_waveform *wf)
> +{
> +	if (!wfhw->period) {

Maybe a comment on why this one matters, not the width or delay.
If it's a case of all or none, just add a comment on that.

> +		*wf = (struct pwm_waveform){ };
> +		return;
> +	}
> +
> +	wf->period_length_ns = ad9910_axi_cycles_to_ns(st, wfhw->period);
> +	wf->duty_length_ns = ad9910_axi_cycles_to_ns(st, wfhw->width);
> +	wf->duty_offset_ns = ad9910_axi_cycles_to_ns(st, wfhw->delay);
> +}



> +static int ad9910_axi_pwm_read_waveform(struct pwm_chip *chip,
> +					struct pwm_device *pwm, void *_wfhw)
> +{
> +	struct ad9910_axi_state *st = pwmchip_get_drvdata(chip);
> +	struct ad9910_axi_drctl_wfhw *wfhw = _wfhw;
> +	u32 drg;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRG, &drg);
> +	if (ret)
> +		return ret;
> +
> +	if (!FIELD_GET(AD9910_AXI_REG_DRG_TOGGLE_EN_MSK, drg)) {
> +		*wfhw = (struct ad9910_axi_drctl_wfhw){ };

Given I had to go look to check if you were initializing all fields
in the other paths, maybe just do this zeroing at top of this function?

Doesn't matter much.

> +		return 0;
> +	}
> +
> +	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRCTL_PERIOD, &wfhw->period);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD9910_AXI_REG_DRCTL_WIDTH, &wfhw->width);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read(st->regmap, AD9910_AXI_REG_DRCTL_DELAY, &wfhw->delay);
> +}

> +
> +static int ad9910_axi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ad9910_axi_state *st;
> +	struct pwm_chip *chip;
> +	void __iomem *base;
> +	struct clk *clk;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*st));

Use local variable dev given you have it.

> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	st = pwmchip_get_drvdata(chip);
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
> +	chip->ops = &ad9910_axi_pwm_ops;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	return devm_iio_backend_register(dev, &ad9910_axi_back_info, st);
> +}


