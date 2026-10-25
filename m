Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971951;
	b=rwca6l0rEB6WpW3aXeVa3VqJZT2ANfU5qN17jI4AgEK9Ig4Q1p5dHfDPa5ikSmOJVEAK
	 YLUU976KAwhZxt3MTdZnDwib9/mtkLyGp2wp9S4XVPQvUhuNFy4kmikRhtqVJ19MPGTsr
	 lWdljUD3Qf0igqzYL/qB74UWwnj/J23xeS5ZvZdr8CoyiJ23kbeJ2ketTxqTiFUvnXDx9
	 sgKukGTtMNFhSjNMVHFMEm2TOvuGzxXmrCSxjEbI7sOeOqfwaygVHr+dGhAh/Bn5aUk2m
	 cV7v0pLFN9S39IgipqNF1r9Oez692i+7mlBwjbRM/dODxur9W8q0he1gpf9PzRA/gDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971951;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hakPJTGZwby279hgNDWQpX5r27VL4n94rHKLpL8MZvI=;
	b=WPVnAHEvTUoZy1QoNg1b1qnYjSQvDxCf70C+dmlrtZBCfJ+/hTRYfdCbgmo/6wy8r3CH
	 PSPJd9SuxxEnjOLiFrQBoysbSdM4Vc79sSoWosgtChS9G79jhHd0FuBKBh573BcszPbUt
	 mYwTQ8qNpcsBXx0scWPxPMn9K3paBgZK03yv/EGCsYt2IZfQDBhogv/F6JOYXvTix6AZD
	 nGZ26uLItXGNx+7UC0MrgHVT8wCQw1f8zK6iyFUu1QrS1d6GhQatD0kZyqzxVqNX4nMl9
	 DGN2ys8YIjqcx4QrkAlPQIjz8BLsS1vZN2inKk9cD84+Lx3BMBhza9WoHX9t9/C8HAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrdwL6sB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5194606A324;
	Sun, 25 Oct 2026 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrdwL6sB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1921F031E3;
	Sun, 25 Oct 2026 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971951;
	bh=hakPJTGZwby279hgNDWQpX5r27VL4n94rHKLpL8MZvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IrdwL6sB6nvALGjivn8Wto5yP4vhYdRRmNwmCq+SsJlkGH75VlZMWdS5PjsEIWBSP
	 fnUdx8U8xUxc7pEXbvDzpLMfSSNlNmcxNacePgn+A2kb+lXhVvuH+jDCX9dH0ZifG+
	 ORseMRwCkpTZ9ZS+wrLJbIdU0DnJsYGyVJWOL7payFTBUxOxBecGcvjPBOefMWlrM5
	 YqzK6xfXJt6WZGIv1+EzmYIO8RhzWgDk3070mFw5HyPLyYT8GGC/3ZNOoc5cMRo6bk
	 hkyEb+t+sNMYO6jXg0aOT1kIF+OOnf2pzQWUTyKDOpKwWz9OuVfSWYWRqWlTSRJIwD
	 an5Qv9txD4//A==
Date: Sun, 25 Oct 2026 23:45:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <20261025234543.0d5fb3db@jic23-hlaptop>
In-Reply-To: <20261024041357.34346-2-olivier@mgcrea.io>
References: <20261024041357.34346-1-olivier@mgcrea.io>
	<20261024041357.34346-2-olivier@mgcrea.io>
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

On Sat, 24 Oct 2026 06:13:57 +0200
Olivier Louvignes <olivier@mgcrea.io> wrote:

> The X1600's SAR ADC has four auxiliary channels, each with its own start
> bit, interrupt flag and 12-bit result, and none of the touchscreen or
> battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a small
> driver that exposes the four channels as voltages against the 3.3 V
> reference.
> 
> There is no datasheet here: the register layout and the clock dividers
> come from the X1600 driver of the vendor's 4.4 kernel.
> 
> Tested on a HiBy R1, whose play/pause and volume keys sit on channel 0
> behind adc-keys: all three read and report correctly.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

Just one trivial things in addition to the other reviewer comments.

> diff --git a/drivers/iio/adc/ingenic-x1600-adc.c b/drivers/iio/adc/ingenic-x1600-adc.c
> new file mode 100644
> index 000000000000..60683f26c693
> --- /dev/null
> +++ b/drivers/iio/adc/ingenic-x1600-adc.c

> +static int x1600_adc_probe(struct platform_device *pdev)
> +{

> +	ret = devm_request_irq(dev, irq, x1600_adc_irq, 0, dev_name(dev), adc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request irq\n");
> +
> +	/*
> +	 * Powered up for good: the keys poll it every few tens of milliseconds,
> +	 * and powering up takes 2 ms.
The keys aren't tightly coupled to this driver so make that a little vaguer.

A typically usecase makes use of .... for which polling is every few...
Hence leave powered up.

> +	 */
> +	writel(0, adc->base + X1600_ADC_REG_ENABLE);
> +	fsleep(2000);
> +	writel(0, adc->base + X1600_ADC_REG_CTRL);
> +	ret = devm_add_action_or_reset(dev, x1600_adc_power_down, adc);
> +	if (ret)
> +		return ret;

