Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D36390204
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972068; cv=none; b=UdSj/WZBQSmNGGp6g4EikqOjpdGxQN1lhHkyLumZ7Itzmv2uDd/GLCzvzp94KMh5NYpHxPdqOMOL1S0cVBd7QhmYimJg1xzRpZCKiV55FyxQP3hWyg9mJ6S81m1tALVsDOE4sTXqb6lobWrMhk8GeLE8H9MEBKaFHpcMlGULqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972068; c=relaxed/simple;
	bh=VDtfdO15TmSPd1YLF4tUzPuukTeoidBLVzbiod0dE00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8wmFaM+ByEnFYJzMhIO+8+BYLa6RPoNenDRCAg6Z+Dc5an2L+9nxcpO4Tc+0ArQCcJ3B5f5IJQpGQvX3oOqcL5GSDWsfQwu6yEDjGxiA9EwEAWlsLcii62SMEthCQBGxW0rTfQHCcE3c0923GM8848BcTHeSzKt2XaOka8KUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SDZ03XKK; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SDZ03XKK"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e615efd7d7so2684025a34.2
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781972066; x=1782576866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=stc9e+NuTJE390Jhi5x3KXowpSGWUhAucrUQzkG/9Rw=;
        b=SDZ03XKKcfO/O04ALEvwuwqdEXBk+jOYzB89SvCsht9gA8SKqn76eNznYPuWM4UQbJ
         sPA1oVDRrMymwuWIsCR4E+AIVr+EGwifiaZCwZFx8YpmMNKYO0IG+aCy/qHEB833nZzo
         eJfr+/V1Zj/mant2RCEaorgygEt5xZAJSj0DA9Ile3Jmur91kTpwB795LdEgF+wUG0/R
         LmXPG0i+GucraZPzGmP1CNvP74FsDFiYk1j8HWlt4t6Ks4f1uwt1Zehbb9BCAN7ZK6op
         RTaoxpwfwIU/SWgDm3WRyOJI87Ep24Xc9kkI1OBr6l2hoUs7SzmAggbeHUL4ASsuNkap
         RZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781972066; x=1782576866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stc9e+NuTJE390Jhi5x3KXowpSGWUhAucrUQzkG/9Rw=;
        b=bKxQRzf+//kyV9m0zUEm+K7yS2+fwmx6/cuAFzfhIM1HlcWPDJflvdjoOfTlSr9D0t
         48f7Od2GRakbIeENN1NMTLlYj6fV1TcS5PORYy2ywBymgabypF0vgDJteeByYbS4BrtM
         eNL148qtssu2iXrcCNs1McfH3abo6GtlIULcOoH8p/A0viQuyKUriLLQ90fHfWguNQI9
         9/DjT+CUYIhT1Ny3wK8VvAVkZONfL8nSOpvJLh+vQi9T1AJYvq1rl1gIxO668ykA87nT
         VGB8tRZKt4VF/4SiATF8OYRpsuqgx2p9PXgqbxthK6lhDqP0U3IAIzwT+E2LAHGmLkr1
         IlQA==
X-Forwarded-Encrypted: i=1; AFNElJ9I04g3RTRE40hsB5XNDWKbTPsbB631h6IFK06ZcbHleJyfV72oOJujKl/d9Nw4K7IFaRSN6lGE0Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jLRNuyLc4qsX6mM7OvBfOFBNDIHmeSVdMZtimo+s8YvttzXK
	EUHZQ5tyIuNhICZL8vTGddtpXoohNV6NRhyBSuJAxPcxkj3izZqro46zsIy9wh3e8vA=
X-Gm-Gg: AfdE7cmad+1Nfytkz5QJzcU4A8xTld7m8jUip/e6wBoPCn8uqECJs+FUuKAjM/k+Wl4
	cuBfh9gRDjRiKwd0QmMkoLGrngC92GGXxkRabpOLKZMPeKc6jAO1dCli/WdsEksNxsjvzEcZCjs
	0TkNRxfDHoSxhpeCh9kEzqt8eygr0i+UMMmL8Ebd9qZWYi3jYrgl3UmF6HVRZ8pwUsApj2AtNW/
	SCgsrGaBYPkIIV5rFygKn34r5M3qAvLNHjcgQ/QczZABjbBYaKGTT4+L+Y0O51Aumc39FubnUVq
	nFB/sYWxxC58dE9h/bSU1RT5l2+25dP2PqNE1iQLUCWydIDIlUf69HgjMUbEiAR/+olffJNXb+g
	v+tUFEc3pBsJxMgai9PND3TuIWvTgzIkuNxgXbObzPAt4DhxBlu7u5iYvcRb94yJqyR+kOC3lB8
	M/xTM6aXrMcAd5e9bQ0gwWc2MVEHjGWaDpTEu4n3EpZN7xqNpWrjs3m6uc8HIAunk=
X-Received: by 2002:a05:6830:3749:b0:7de:84b5:88e3 with SMTP id 46e09a7af769-7e92d879fdfmr6842830a34.8.1781972065809;
        Sat, 20 Jun 2026 09:14:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3ad0:4082:8242:2d72? ([2600:8803:e7e4:500:3ad0:4082:8242:2d72])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94424c93fsm2202181a34.14.2026.06.20.09.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 09:14:25 -0700 (PDT)
Message-ID: <d2e4e716-da13-48aa-8a71-155ed90e593a@baylibre.com>
Date: Sat, 20 Jun 2026 11:14:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] iio: dac: ad5686: add ldac gpio
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-7-f829fb7e9262@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260616-ad5686-new-features-v3-7-f829fb7e9262@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 3:21 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> If wired LDAC, should be held low when unused (pin is active-low), which

Would better match the implementation if this said "asserted" instead of
"held low" (code says GPIOD_OUT_HIGH which should be read as "asserted").

> allows for synchronous DAC updates. This will be used to update all the
> channels at the same time when adding buffer support.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 6 ++++++
>  drivers/iio/dac/ad5686.h | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index a48acedff51c..73105c197964 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -12,6 +12,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> @@ -515,6 +516,11 @@ int ad5686_probe(struct device *dev,
>  		return dev_err_probe(dev, PTR_ERR(rstc),
>  				     "Failed to get reset control\n");
>  
> +	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->ldac_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> +				     "Failed to get LDAC GPIO\n");
> +
>  	reset_control_assert(rstc);
>  	fsleep(1); /* reset pulse: comfortably bigger than the spec */
>  	reset_control_deassert(rstc);
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index a06fe7d89305..f3110410d89b 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -60,6 +60,7 @@ enum ad5686_regmap_type {
>  	AD5686_REGMAP,
>  };
>  
> +struct gpio_desc;
>  struct ad5686_state;
>  
>  /**
> @@ -119,6 +120,7 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
>   * @dev:		device instance
>   * @chip_info:		chip model specific constants, available modes etc
>   * @ops:		bus specific operations
> + * @ldac_gpio:		LDAC pin GPIO descriptor
>   * @vref_mv:		actual reference voltage used
>   * @pwr_down_mask:	power down mask
>   * @pwr_down_mode:	current power down mode
> @@ -131,6 +133,7 @@ struct ad5686_state {
>  	struct device			*dev;
>  	const struct ad5686_chip_info	*chip_info;
>  	const struct ad5686_bus_ops	*ops;
> +	struct gpio_desc		*ldac_gpio;
>  	unsigned short			vref_mv;
>  	unsigned int			pwr_down_mask;
>  	unsigned int			pwr_down_mode;
> 

