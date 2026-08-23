Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3A3515EF;
	Sun, 23 Aug 2026 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513995; cv=none; b=squY2UzcXkOdnQWao+FDqvFc34bFHpYraXstUcxvayJIk0IiCklyXnlc3UQcIUHwo2TeFVBaMtJlhda5a0pVJL0DNiDxuPIY1CPP0qal5m3yDu/MNsbBUSCNLgTyeCZ0DRgwvSIrpvjHexUkZM1JU7esXc02/tZNdLBfSKfqbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513995; c=relaxed/simple;
	bh=itzQ5jV4BN8Ss0Lby1cpZAmO5kE4SoO0NCU8doihEM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0WZTVgxBeXgQ7JQEzSWeu+6eRW/YjjTqVPBIbwjg7olGLUojbVOCTDwBU3aTZjItCbEzjmwD//+4vmXUALX+i+FbgzMyUDfzHYbGqfl3XHhipuylGubezdCHRs9MenfknCFBhkfmI5d1Keie80EUX5KXsB/Ryj9ZFJGG43E3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqvdhyI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqvdhyI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EAC1F000E9;
	Sun, 23 Aug 2026 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787513994;
	bh=zLEE0is5dWhs16wMe34Vd1UXOLmD5Wu3lEF7TZ/ozEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QqvdhyI55iVZzRF/c9RS8/5Xfb6HEMEYsDvqw5w0N9ZQbQlzyNhN6sRRWQv55njuU
	 S5v4k24oadl7iOdoQmQeCjwtoCgeyYo0ZA+EPy1r9z2eyw3MV78SdH4TgV+i0c7qFg
	 WsUtXvXSmOp60fecJfJus22teLnW1p/y8CAd8jjFe3Fwp4GmAd++rpOii2eXjcgbFu
	 41dn8xvejS3PRVIA3Wo6isZJOEXnAzR4ktiAXC0A0D8r6zgte1gBzHRCimFEiygx5p
	 3KCESm982FAmu+OqpZqE21uuXa/9E9mbcwj+tun4nHZ8k254fMrCgj/JyqiNla9v8b
	 rB9mm0gUoGFLA==
Date: Sun, 23 Aug 2026 20:39:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 13/14] gpio: ad7768: Add AD7768 GPIO auxiliary driver
Message-ID: <20260823203947.3ecdc448@jic23-huawei>
In-Reply-To: <20260821-ad7768-driver-v4-13-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
	<20260821-ad7768-driver-v4-13-bb8fbd06d4eb@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 16:07:06 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> The AD7768 provides five GPIOs controlled through registers shared
> with the parent IIO device. Register an auxiliary gpio-regmap driver
> and use the parent device for runtime PM.
> 
> The device has separate input-state and output-latch registers. Add a
> reg_mask_xlate() callback that checks the line direction and reads the
> programmed output latch for output lines while retaining input-state
> reads for input lines.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Linus W, for I think that (when you are happy) you can pick up this
and the previous two enabling patches via the gpio tree and I'll take
the rest via IIO.  One small wrinkle around the maintainers entry that
we can fudge in various ways.

> ---
>  MAINTAINERS                |   1 +
>  drivers/gpio/Kconfig       |  12 +++++
>  drivers/gpio/Makefile      |   1 +
>  drivers/gpio/gpio-ad7768.c | 118 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 132 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc94e7803a7c..3de7ebcc4ee7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1639,6 +1639,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> +F:	drivers/gpio/gpio-ad7768.c

This may be the only reason we can't merge the gpio driver via
the gpio tree, independent of the rest.

Maybe drop this for now, or break it out as a separately patch that I can
pick up via IIO.

>  F:	drivers/iio/adc/ad7768.c
>  
>  ANALOG DEVICES INC AD7780 DRIVER

> diff --git a/drivers/gpio/gpio-ad7768.c b/drivers/gpio/gpio-ad7768.c
> new file mode 100644
> index 000000000000..710739e33dff
> --- /dev/null
> +++ b/drivers/gpio/gpio-ad7768.c

> +static int ad7768_gpio_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	struct device *parent = adev->dev.parent;
> +	struct gpio_regmap_config config = {
> +		.parent = &adev->dev,
> +		.label = dev_name(parent),
> +		.ngpio = AD7768_NUM_GPIOS,
> +		.reg_dat_base = AD7768_REG_GPIO_READ,
> +		.reg_set_base = AD7768_REG_GPIO_WRITE,
> +		.reg_dir_out_base = AD7768_REG_GPIO_CONTROL,
> +		.pm_dev = parent,
> +		.reg_mask_xlate = ad7768_gpio_reg_mask_xlate,
> +		.init_valid_mask = ad7768_gpio_init_valid_mask,
> +	};
> +	struct gpio_regmap *gpio;
> +	struct regmap *map;
> +	int ret;
> +
> +	map = dev_get_regmap(parent, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(parent, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_UGPIO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	config.regmap = map;
> +	config.drvdata = map;

Why not do all this in one place rather than init then later
modify?

	config = (struct gpio_regmap_config) {
		.parent = &adev->dev,
		.regmap = map,
		.label = dev_name(parent),
		.ngpio = AD7768_NUM_GPIOS,
		.reg_dat_base = AD7768_REG_GPIO_READ,
		.reg_set_base = AD7768_REG_GPIO_WRITE,
		.reg_dir_out_base = AD7768_REG_GPIO_CONTROL,
		.pm_dev = parent,
		.reg_mask_xlate = ad7768_gpio_reg_mask_xlate,
		.init_valid_mask = ad7768_gpio_init_valid_mask,
		.drvdata = map,
	};

> +	gpio = devm_gpio_regmap_register(&adev->dev, &config);
> +	return PTR_ERR_OR_ZERO(gpio);
Could do
	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&adev->dev, &config));

Though maybe it looses some readability?

> +}
