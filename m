Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8022E8B67;
	Thu, 23 Jul 2026 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789519; cv=none; b=G192liU6wjMvX8wXMqO7I6a9l+wRLsn5mg8RuH6ZNV+kaa9Gi4HnbahnaMybtmCewPMBDhW2S6dAwX/6vBKiQIdiv9qvo+SUeCfeQpzKyvA4oJ1l7vHq4kgROArYNprQmXtAeZHiLeCiihRIxCqzj1waSICe7DgMDLUEWwFAV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789519; c=relaxed/simple;
	bh=DQVG00EgF2O/I17ObhnJeyMOH1S/vh4pVPnhNXIELYI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=gBYmBSTgdvv4A2yMRL5mdn439uw7mVfIEfnS5mh0JPjhh2/aX5zXtIy92YRN0bodYJrpH18OS4beA3LsClS0QSTo2g7askFNZ3j/G4DeDtgw/W6+WA3sJSMHdVxJR7KrW8SOgziwVxCbiWJ2ee4WDCVKgxOEkgIbZN2n7sdXv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG6nPpiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG6nPpiL"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 34DB51F000E9;
	Thu, 23 Jul 2026 06:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784789517;
	bh=CYoQpAqMXC45ZUj0eFccRj+tXXcqIDKOcY5u7SGq3WY=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=QG6nPpiLhMWhzq3rj3VeZwvuQ8KpsUYWvlvqwypVdmVDZ5ufRA+mNItY8lYaYTebE
	 T4Pnp5iXgE1Hn+CN2GNeAIR8OA7ol4qt30Ib1K8qGWE6dwyjoj2rX9N00cIQPq9lW6
	 SaQ7i2V/+QzFxzLiRxTdaGT7dcAQgw/ZxLWHsKymilu2YGf1LMb4dYz96Dy3AuMZIz
	 MLj8w+vuKly8eNoaS2wQblPvp//BgbXZT55SB3VWTvaAw1cObOUAfAW8nRuNIyhGBm
	 xZ82i+o7VbkowcC31Uc4Rf444meV7D6IPvTwuWfSpMim5r7cYxIUOshhRkxUxWC7w/
	 T7dvxXvI23oyQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0f763f9ede22b7e25f10bdb6133ab419b1fbae607d63309a94d201f57326;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 23 Jul 2026 08:51:53 +0200
Message-Id: <DK5R2VCAK468.2GAEC7VG8OJBZ@kernel.org>
Subject: Re: [PATCH v7 5/9] gpio: regmap: Add gpio_regmap_operation to
 extend reg_mask_xlate callback
Cc: <dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <brgl@kernel.org>, <tychang@realtek.com>,
 <wbg@kernel.org>, <mathieu.dubois-briand@bootlin.com>,
 <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
 <andy@kernel.org>, <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>,
 <bhelgaas@google.com>, <o-takashi@sakamocchi.jp>
X-Mailer: aerc 0.20.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
 <20260723034237.2501507-6-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-6-eleanor.lin@realtek.com>

--0f763f9ede22b7e25f10bdb6133ab419b1fbae607d63309a94d201f57326
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jul 23, 2026 at 5:42 AM CEST, Yu-Chun Lin wrote:
> Extend the reg_mask_xlate callback with an operation type parameter
> (enum gpio_regmap_operation) to allow drivers to return different
> register/mask combinations depending on the specific GPIO operation.
>
> Consequently, update all existing drivers utilizing the gpio-regmap
> framework (across drivers/gpio, drivers/iio, and drivers/pinctrl)
> to accommodate the new reg_mask_xlate function signature.
>
> Suggested-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---

...

> @@ -71,7 +73,7 @@ static int gpio_regmap_simple_xlate(struct gpio_regmap =
*gpio,
>  static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> -	unsigned int base, val, reg, mask;
> +	unsigned int base, val, reg, mask, dir_mask;
>  	int ret;
> =20
>  	/* we might not have an output register if we are input only */
> @@ -80,7 +82,18 @@ static int gpio_regmap_get(struct gpio_chip *chip, uns=
igned int offset)
>  	else
>  		base =3D gpio_regmap_addr(gpio->reg_set_base);
> =20
> -	ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +	ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_GET_OP, base, offset, &r=
eg, &dir_mask);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(gpio->regmap, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & dir_mask)
> +		ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_OUT, base, offset, &reg=
, &mask);
> +	else
> +		ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_IN, base, offset, &reg,=
 &mask);

What's going on here? Looks like I've missed this in the previous
patches. All the other drivers we are now reading the value twice.
In the regmap_read() above and the one that follows just after this
hunk.

Has the gpio controller two different bits, one for output and one
for input? Are you sure, the input bit doesn't reflect the output
bit if it's configured as an output?

IMHO this shouldn't be part of the core. rtd1625_reg_mask_xlate()
should either return RTD1625_GPIO_IN or RTD1625_GPIO_OUT depending
on the mode, if that's needed at all. I'd guess RTD1625_GPIO_IN
will just work fine and will actually fetch the actual line state.

-michael

>  	if (ret)
>  		return ret;
> =20
...

> =20
> +/**
> + * enum gpio_regmap_operation - Operation type for reg_mask_xlate callba=
ck
> + *
> + * Traditionally, the operation type was inferred from the base register=
.
> + * However, that approach does not always work =E2=80=94 for example, wh=
en all control
> + * bits of a single GPIO reside in the same register. This enum allows t=
he
> + * reg_mask_xlate callback to explicitly distinguish between operation t=
ypes.
> + * The user is free to choose which method to use.
> + *
> + * Value operations:
> + * @GPIO_REGMAP_GET_OP: Mask for reading direction to detect if GPIO is =
input or
> + *			output. Used in gpio_regmap_get() to determine the GPIO
> + *			direction.

This is also not very intuitive. I'd expect there is only one
operation for the gpio_regmap_get and that is exactly this one.

> + * @GPIO_REGMAP_IN: Mask for reading input value. Used when GPIO is conf=
igured as
> + *			input.
> + * @GPIO_REGMAP_OUT: Mask for reading output value. Used when GPIO is co=
nfigured as
> + *			output.
> + *
> + * Output operations:
> + * @GPIO_REGMAP_SET_OP: Mask for setting GPIO output value.
> + *
> + * Direction operations:
> + * @GPIO_REGMAP_GET_DIR_OP: Mask for reading GPIO direction (input/outpu=
t).
> + * @GPIO_REGMAP_SET_DIR_OP: Mask for setting GPIO direction (input/outpu=
t).
> + */
> +enum gpio_regmap_operation {
> +	GPIO_REGMAP_GET_OP,
> +	GPIO_REGMAP_SET_OP,
> +	GPIO_REGMAP_GET_DIR_OP,
> +	GPIO_REGMAP_SET_DIR_OP,
> +	GPIO_REGMAP_IN,
> +	GPIO_REGMAP_OUT,
> +};
> +
>  /**
>   * struct gpio_regmap_config - Description of a generic regmap gpio_chip=
.
>   * @parent:		The parent device
> @@ -104,9 +138,9 @@ struct gpio_regmap_config {
>  	unsigned long regmap_irq_flags;
>  #endif
> =20
> -	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
> -			      unsigned int offset, unsigned int *reg,
> -			      unsigned int *mask);
> +	int (*reg_mask_xlate)(struct gpio_regmap *gpio, enum gpio_regmap_operat=
ion,
> +			      unsigned int base, unsigned int offset,
> +			      unsigned int *reg, unsigned int *mask);
> =20
>  	int (*init_valid_mask)(struct gpio_chip *gc,
>  			       unsigned long *valid_mask,


--0f763f9ede22b7e25f10bdb6133ab419b1fbae607d63309a94d201f57326
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCamG6CRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j/8QF+MscjlU8Sr3zp+NgiNBUJvCVyP8/tzErf
IxBB/IHT+q67OBwib8y6HrvboYKuJWJfAX9SUD8iebYkI5Lui5jTFMlIPIoiVDrO
7vbU8b2W9xiMiABeddeUJEApcU4UNJtxg+Y=
=C68y
-----END PGP SIGNATURE-----

--0f763f9ede22b7e25f10bdb6133ab419b1fbae607d63309a94d201f57326--
