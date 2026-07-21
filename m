Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67C433BC8;
	Tue, 21 Jul 2026 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618136; cv=none; b=LUXMyKw2VxO2url0TDsGGhFzyHHqEuh0HQGjTVUpTQHhORw2FyeFSOD1pFZM+QLXplG7tqj8xWocHPVVFjk3UaF9Msg1hUIOatnwnZ113KwaPjs0Ai6tGUmm2n77AFSGj28Khj+kQ9J/SLgvsqIvcHIxFoTfgGeB6j2CtxHKzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618136; c=relaxed/simple;
	bh=sqG+mf61sVHzHX9Ml6vYnB6RrFqbOc04p0pmrv+d2Kk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=FEgAnl0RMDbJuZZGmw75ykxGzYzdpO8ULOhyiQ0gt0HVso2fLzRIjxhf1HG9uX9B1WD0/tYUC7sHI/uzCG0veMCTAoh57+OqacDX6qtIb0iWkra92M3Q0DuMFqkN43OGtlTcZMGefD9n9RalkGFXwMaMUCR3QGkEakSQYEEuQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LojgiPpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LojgiPpR"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8F6731F00A3D;
	Tue, 21 Jul 2026 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618135;
	bh=GaJRVJQ5XZGCkHN9g80pTuSxJZLQqtAHbZXWNwuSlG4=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=LojgiPpR5FB1bzHwFAj12QmHVpQQgS8tiPR1x7lntU7B1cOxf+QlOFrRr1ujCF2Sx
	 F+KY1JLIKxw+CBbwh6Q8vq9D11Kz9fZubREv0DnaPFGfjCrkwzIEp2+lTi+I6Vki2S
	 58k442RvidWfdntoEroVpVzpk503akgiL9KfyXMv+tP6htF/Iv5SFJ9EKhebtu6Gk7
	 XqhSBJYmPNAtJ2LwXzj0+yxTovCOSHZYHnfZFZxwQ3A0HClmvyKlwkdR0OTXywXD+A
	 xOkOOMPyPnSHfhe1loRP+iZainweAI9bE41YmMUwEXgKmHwuUNuTAcSPR7rzG5X7g6
	 wQ0Bea31cf3pg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8200c31585c40afbd24e7b89cdcbb5fcce070fa3abde24da82471f9861a6;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 09:15:31 +0200
Message-Id: <DK42BVHLGJV1.1TC0EG2OJA7ON@kernel.org>
Subject: Re: [PATCH v6 5/8] gpio: regmap: Add gpio_regmap_operation and
 value_xlate support
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
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-6-eleanor.lin@realtek.com>
In-Reply-To: <20260721065802.689530-6-eleanor.lin@realtek.com>

--8200c31585c40afbd24e7b89cdcbb5fcce070fa3abde24da82471f9861a6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi

Thanks! Looks very good, a few comments below.

On Tue Jul 21, 2026 at 8:57 AM CEST, Yu-Chun Lin wrote:
> Extend the reg_mask_xlate callback with an operation type parameter
> (enum gpio_regmap_operation) to allow drivers to return different
> register/mask combinations depending on the specific GPIO operation.
>
> In addition, introduce a new optional 'value_xlate' callback. This routin=
e
> allows drivers to translate or modify the register value and mask
> immediately before a write operation. It is particularly useful for
> hardware that requires additional control bits, such as a write-enable bi=
t,
> to be appended to the data dynamically.

Please split that into two patches.

> Consequently, update all existing drivers utilizing the gpio-regmap
> framework (across drivers/gpio, drivers/iio, and drivers/pinctrl)
> to accommodate the new reg_mask_xlate function signature.
>
> Suggested-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---
> Changes in v6:
> - Remove removed the hardcoded write-enable workarounds.
> - Retain the necessary prototype updates in every driver using custom
> reg_mask_xlate
> - Add value_xlate to dynamically adjust the register mask and value right
> before the actual register write operation.
> ---
>  drivers/gpio/gpio-104-idi-48.c        |  7 +--
>  drivers/gpio/gpio-i8255.c             |  4 +-
>  drivers/gpio/gpio-idio-16.c           |  6 +--
>  drivers/gpio/gpio-max7360.c           |  1 +
>  drivers/gpio/gpio-pcie-idio-24.c      |  6 +--
>  drivers/gpio/gpio-regmap.c            | 62 ++++++++++++++++++++++-----
>  drivers/iio/adc/ad7173.c              |  8 ++--
>  drivers/iio/addac/stx104.c            |  6 +--
>  drivers/pinctrl/bcm/pinctrl-bcm63xx.c |  1 +
>  drivers/pinctrl/pinctrl-tps6594.c     |  1 +
>  include/linux/gpio/regmap.h           | 44 +++++++++++++++++--
>  11 files changed, 115 insertions(+), 31 deletions(-)
>

..

> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index a3ba8242c353..45a30f50043f 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -13,6 +13,36 @@ struct regmap;
>  #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
>  #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
> =20
> +/**
> + * enum gpio_regmap_operation - Operation type for reg_mask_xlate callba=
ck
> + *
> + * This enum is used to distinguish between different types of GPIO oper=
ations
> + * so that the reg_mask_xlate callback can return the appropriate mask f=
or each
> + * operation type.

"Traditionally it was inferred from the base regsister. But that
might not always work, for example if all the control bits of one
GPIO lives in the same register. The user is free to choose which
method they'll use."

> + *
> + * Value operations:
> + * @GPIO_REGMAP_GET_OP: Mask for reading direction to detect if GPIO is =
input or output.
> + *                      Used in gpio_regmap_get() to determine the GPIO =
direction.
> + * @GPIO_REGMAP_IN: Mask for reading input value. Used when GPIO is conf=
igured as input.
> + * @GPIO_REGMAP_OUT: Mask for reading output value. Used when GPIO is co=
nfigured as output.
> + *
> + * Output operations:
> + * @GPIO_REGMAP_SET_OP: Mask for setting GPIO output value.
> + *
> + * Direction operations:
> + * @GPIO_REGMAP_GET_DIR_OP: Mask for reading GPIO direction (input/outpu=
t).
> + * @GPIO_REGMAP_SET_DIR_OP: Mask for setting GPIO direction (input/outpu=
t).
> + *
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
> @@ -55,6 +85,10 @@ struct regmap;
>   *			is used.
>   * @init_valid_mask:	(Optional) Routine to initialize @valid_mask, to be=
 used
>   *			if not all GPIOs are valid.
> + * @value_xlate:	(Optional) Routine to translate the register value and
> + *			mask before writing. This allows driver-specific logic
> + *			to append additional bits (like write-enable masks)
> + *			dynamically based on the current operation.
>   * @drvdata:		(Optional) Pointer to driver specific data which is
>   *			not used by gpio-remap but is provided "as is" to the
>   *			driver callback(s).
> @@ -104,14 +138,18 @@ struct gpio_regmap_config {
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
>  			       unsigned int ngpios);
> =20
> +	int (*value_xlate)(struct gpio_regmap *gpio, enum gpio_regmap_operation=
,
> +			   unsigned int base, unsigned int offset, unsigned int reg,
> +			   unsigned int *mask, unsigned int *val);
> +
>  	void *drvdata;
>  };
> =20


--8200c31585c40afbd24e7b89cdcbb5fcce070fa3abde24da82471f9861a6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal8ckxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/g59AGAyYU0CP1nHA8ANa/SQherUWHFQTuRKzfd
ngML2mzsBeddps30VYD5RXINxHsoaOAOAX43vmKj7wZ5FNUby1hB7uRQ3fkYQ4n3
arz7CYFjJatVnHZ6LCnPFPD5+7xh8YbJ/YA=
=nSb/
-----END PGP SIGNATURE-----

--8200c31585c40afbd24e7b89cdcbb5fcce070fa3abde24da82471f9861a6--
