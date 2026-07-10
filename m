Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5826A1C4;
	Fri, 10 Jul 2026 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649679; cv=none; b=HoFis64pMq2iSpuAS6D4OztI3vCpIsHRxi1fCM2sTDesQDElWl+lnB3hVvzMC1/U0Sf9afSN96C2Xv98vM5bfSJD9zzNodtj1GXPUfnbpda/TG547MukRaYoYsrsndyMdOI0m+sHDQQCkatBPyzCkx7Z45I+vMpwzoXiajx8fOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649679; c=relaxed/simple;
	bh=XMHY2ySP2qlEPytujj4x1Mlm5f+zE66Bxk61+TSsQ20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzqRS/KVoryOvedPnj7quwYhgSpqw0BlhLFBSEc7ccHeSsvDjcjfJLDsnCj9ZxksnnxqNrTk7tmF39nJFJEE9LhYzU3ZEtQgL8T32EhHNZNdJBVjlUx5q8UdLKMnCQT7CD5m7QJpQA0ntENX4J0KWpL4FJGexxCK411qv4VPOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOiMDzhN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOiMDzhN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2BF1F000E9;
	Fri, 10 Jul 2026 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783649677;
	bh=LaDsQTY+5JHqwCGEqB+v44bn/RcCB6G0HOwZJpEE4E8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HOiMDzhN3pmtpEsXiNCgElljzaUa5jtmeEj2MCxmUHG1jH1ER50wLEyRkjebIGMRb
	 l4SUl3tmHY9WjSmicTrz/Q/CjZq8Mz06LM+ttrBj7FhBSc59Hk5ZnEJ97s29W2XR1u
	 YY0y3mgMqKUt2we9PBbpD+jRIoKq7tib/OGvUS8jLtFMax1Wqz4dTvjfp5CzMWA9Sz
	 pkXIscPdkpWP7kfQyzaRx1fgQtdJNNS2OZfqrA9rGSQYLSy3bhvdfK3kCL9LxWIeGZ
	 wTr/3yk40hUu6cnb7/DrNtMmiIh22IhPedGSlz5MlEAwRo/YLdb3V0ZX/8dN2+ZeRp
	 jbi4YuJ4U6NSQ==
Date: Fri, 10 Jul 2026 03:14:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jananisunil.dev@gmail.com>
Subject: Re: [PATCH 5/6] gpio: ad7768: Add AD7768 GPIO auxiliary driver
Message-ID: <20260710031431.2b7a5bc2@jic23-huawei>
In-Reply-To: <20260709-ad7768-driver-v1-5-44e1194fd96a@analog.com>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
	<20260709-ad7768-driver-v1-5-44e1194fd96a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 10:50:16 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> The AD7768/AD7768-4 ADC exposes 5 general-purpose I/O pins that can be
> independently configured as inputs or outputs. Add an auxiliary bus driver
> to expose these pins as a GPIO chip, registered by the parent IIO driver.
> 
> The driver uses the parent's regmap for register access and delegates
> runtime power management to the parent device.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
A few things inline.

> diff --git a/drivers/gpio/gpio-ad7768.c b/drivers/gpio/gpio-ad7768.c
> new file mode 100644
> index 000000000000..c2f01b1abd7c
> --- /dev/null
> +++ b/drivers/gpio/gpio-ad7768.c
...

> +static int ad7768_gpio_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &adev->dev;
> +	const char *label = dev_get_platdata(dev);
> +	struct ad7768_gpio_state *st;
> +	struct gpio_chip *gc;
> +	int ret;
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->parent = dev->parent;
> +	st->regmap = dev_get_regmap(dev->parent, NULL);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(st->parent);
I'd use the ACQUIRE stuff you used else where and not worry about
maybe keeping power on a tiny bit long.


> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
> +				 AD7768_GPIO_UGPIO_ENABLE,
> +				 AD7768_GPIO_UGPIO_ENABLE);

set_bits()

> +
> +	pm_runtime_mark_last_busy(st->parent);

As before this is wrong.

> +	pm_runtime_put_autosuspend(st->parent);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	gc = &st->gc;
> +	gc->label = label;
> +	gc->base = -1;
> +	gc->ngpio = AD7768_NUM_GPIOS;
> +	gc->parent = dev;
> +	gc->owner = THIS_MODULE;
> +	gc->can_sleep = true;
> +	gc->get_direction = ad7768_gpio_get_direction;
> +	gc->direction_input = ad7768_gpio_direction_input;
> +	gc->direction_output = ad7768_gpio_direction_output;
> +	gc->get = ad7768_gpio_get;
> +	gc->set = ad7768_gpio_set;
> +
> +	return devm_gpiochip_add_data(dev, &st->gc, st);
use gc given you have it.

> +}

> 

