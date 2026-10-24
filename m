Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792808654;
	b=OIbkzeZKD1RmDvIuPcyNDpbTuR4rZtUEljP/VIj9+HLWlaBv2QXvkkXsF6/30eWgp1fi
	 VDlfJLDAKB3OO1cMwwXcgS/xy38Pk1gA9MTVQM19SPE+9ZbTOJAOkwq5OMOO9JzjJLvDt
	 CIGFipbaDntHxuXoCCX/xImrohx8ykfnTPK0xmzkXPm9rdTg1L8RMVd8YrdcSmR9/RKrk
	 c8TFAAx3MbrLqsKGNK6pqi6v0Jqad7XQ+2pESsLRMfvfmE2fKIPwjKLf75VuBMr1X83bO
	 SqUmLNQ2cQbv8mRDeDcLHdrLboqko2jYa0qfDiFEEQstuOPsVIRRpS7YMNU1w88rVOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792808654;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rELLt+aowdtmDN+hBIq0G+s40rzDksOPiSwq6dphHXI=;
	b=KYijmR+5TZtzwkitYpYECBblfOi2SV6QXEb0AIoxd/HOq2EfbqpsI/csKQ17vkunX8es
	 ppcnF6MN/2onIesJ2z/cgydeK0CttRqF9uX31Y2fxpNVzMEL5ZeJUi4PLdujFp69F5tGi
	 zxjqalQ+N7VzeBjwngPQEYkLxlRy0qLge6mL630yN0eAfXIoudWy3PyN1f0QENigEwk+1
	 SXpW65ukdvg6cfKRupGQhrQq2YkKXGpfekKcg34ChAcAKAKXf6pKw87u1f2FQWh4tVwUu
	 XWRyz6k9cwfaQCobYr8BiVBCR884Ysz2K3nUVOH0aQz2nFNkWkZOq9zi2AMsq7HPzBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcSnaOoS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D27606A31B;
	Sat, 24 Oct 2026 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcSnaOoS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C53D1F031E5;
	Sat, 24 Oct 2026 02:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792808653;
	bh=rELLt+aowdtmDN+hBIq0G+s40rzDksOPiSwq6dphHXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OcSnaOoSBeTkbPniTKDsZBs/IboFDXfSEjWfJSkI9T2SCFEin3zLte+wRfjx8H/ZL
	 YPEkdcjFVEgvEgQY6zTErszAihs6+8fU+LjclI5xEayH4k96R06+UCm+HZpLWBMwh9
	 bYqc12TfgrSX/jIE7MeLvz37V2WJfZ7BT8hemulsdV3CciXndKEvWEcKE3ssiwNUnC
	 Hd53hoDpXxz0/0C3Ww5y+ETvXUc5xN7eYEG/xYkxIPs+44IL4Tv8RXYnYEw25MBIhQ
	 kewQe+snEv9P1nAgZ9zeJPS2hsjV42niOx0l4gsyCRveNpRyl885HsQEJRwvTgTXqJ
	 u59L59kJZ7/FA==
Date: Sat, 24 Oct 2026 03:24:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <krzk+dt@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <conor+dt@kernel.org>, <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v5 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <20261024032406.2b06e47e@jic23-hlaptop>
In-Reply-To: <20261023080623.1830-3-johnerasmusmari.geronimo@analog.com>
References: <20261023080623.1830-1-johnerasmusmari.geronimo@analog.com>
	<20261023080623.1830-3-johnerasmusmari.geronimo@analog.com>
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

On Fri, 23 Oct 2026 16:06:23 +0800
John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com> wrote:

> Add support for the Analog Devices MAX30210 I2C temperature
> sensor.
> 
> The driver uses regmap for register access and integrates with
> the IIO framework. It supports:
> 
> - Direct mode temperature conversion
> - Configurable sampling frequency
> - Threshold events
> - FIFO operation with IIO kfifo buffer support
> - Optional interrupt-driven data ready signaling
> 
> The device provides 16-bit signed temperature data and a
> 64-sample FIFO.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
A few things from sashiko
https://sashiko.dev/#/patchset/20261023080623.1830-1-johnerasmusmari.geronimo%40analog.com

Feel free to just reply to the thread saying why they are wrong if they are.

In particularly it reminded me of the reply I made to patch 2
about what we might want to do to fix the event interface lifetime
issue.  I haven't had a chance to get back to that since.


> diff --git a/drivers/iio/temperature/max30210.c b/drivers/iio/temperature/max30210.c
> new file mode 100644
> index 0000000000000..01a1eff4da663
> --- /dev/null
> +++ b/drivers/iio/temperature/max30210.c

> +
> +static int max30210_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Enable FIFO-full interrupt */
> +	ret = regmap_set_bits(st->regmap, MAX30210_INT_EN_REG,
> +			      MAX30210_STATUS_A_FULL_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Flush FIFO before starting autonomous conversions */
> +	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF2_FLUSH_FIFO);
> +	if (ret)
> +		goto err_disable_irq;
> +
> +	scoped_guard(mutex, &st->lock)

See the stuff in cleanup.h  Don't combine guards and gotos in
same function. They may be fine in some cases but it is considered
bad practice.  Here I'd just not use the guard.

Make sure to check for other instances of this.

> +		ret = max30210_autoconv_get(st);
> +	if (ret)
> +		goto err_disable_irq;
> +
> +	return 0;
> +
> +err_disable_irq:
> +	/* The core won't call postdisable() when preenable() fails. */
> +	regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
> +			  MAX30210_STATUS_A_FULL_MASK);
> +
> +	return ret;
> +}


> +static int max30210_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max30210_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vdd regulator.\n");
> +
> +	st->regmap = devm_regmap_init_i2c(client, &max30210_regmap);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate regmap.\n");
> +
> +	st->watermark = MAX30210_WATERMARK_DEFAULT;
> +
> +	ret = max30210_setup(st, dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &max30210_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->name = "max30210";
> +	indio_dev->info = &max30210_info;
> +
> +	/* Currently, without an interrupt there is no way to drain the FIFO into the buffer */
> +	if (client->irq) {
> +		ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buffer_ops,
> +						      max30210_fifo_attributes);
> +		if (ret)
> +			return ret;
> +
> +		/* Runs after unregister, so nothing can re-arm the device; before powerdown. */
> +		ret = devm_add_action_or_reset(dev, max30210_quiesce, st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (!client->irq)
> +		return 0;
> +
> +	/*
> +	 * Request the IRQ after registering the IIO device so devm tears it
> +	 * down first on removal, before the event interface is freed.
> +	 */
> +	return devm_request_threaded_irq(dev, client->irq, NULL,
> +					 max30210_irq_handler, IRQF_ONESHOT,
> +					 indio_dev->name, indio_dev);

Please take a look at what I said on v4 about this. I agree
there is an issue in the core code but don't want to fix it by
introducing a race here.  It would be helpful to know if the
code I put in that thread works or not. If you are seeing reasons
not to make a change along those lines reply to that thread
to continue the discussion.

Jonathan


> +}


