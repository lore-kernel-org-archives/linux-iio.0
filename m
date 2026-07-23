Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18B3DAAB3;
	Thu, 23 Jul 2026 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790084; cv=none; b=KgJQ++lecYPDCkAcvSVeFisBM26/l0vAe1Vintj0NaSUrudG58N7E3I2LDiVjWgbULHTcZYCwvDCVygSuX7c/WESKzINgl44Z2hFCSMoo9qRgVk6RWzxRpAeQu5MyRIqTGVCkgEVhYwBCm1NcAYzSrvawiyZGN9QgLkMaJEVqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790084; c=relaxed/simple;
	bh=aS/fBbjg83mav+KytDq83xMsXwhBGHkjtWGiCgDZCsQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=SEeIAho00xGItQ1bdYDip07Z9BU3edz6doVkBcwAigw7rBcTZD1k55D7RljTvn1xnWSHPxTvqGi4niCY1EPatJ3AvpSzX05gOAlrHNF431HeqVR3W1jE3q7oGhh04GtuZ9qibtwCCrbgPql9mNYUY/o48qlFrDdF31OaLe6eZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4UZcyv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4UZcyv1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E62201F000E9;
	Thu, 23 Jul 2026 07:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784790079;
	bh=ClegPzyNZwWSn6yCoo0Y2iOyijfqcjOrfdtObvriJPk=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=i4UZcyv1a/AfJLgU4hXTNvZSN4gZAi8SKMv3smVK8TBpU3vVmAofRV6WOgU8MpLQ9
	 xdoJ1Tw9aL8cJECqY7uuMQDOg2eu8ZbbOQwtClXFKFb4kLl8Z25JQt0GI96bPY2A4U
	 oABxtJgjRmy/DpvQ2SBy7FZPpRiY3+l6gxs7RUuJc6MUxeJDjoqykABZev79HaGEQR
	 bxgOYEgAFFfADAcxubM/O+yDqbQrvxMZKvzwNOUYMU7OqrDmc0Oa2CagAB5XTVO1Z5
	 yGmeISejPNnTjL61JUTI9e/u+I+2nATUd5r1jVRGEmwR1o/7Mp/vO20j0JoaisbFpn
	 vEUkss+T2LH5g==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bcdbb4f5b86540f5f638637f481de919ca5fbee71c85807e04e08ee05a86;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 23 Jul 2026 09:01:15 +0200
Message-Id: <DK5RA1LUEMJ1.2UP4SW9DDADHK@kernel.org>
Subject: Re: [PATCH v7 7/9] gpio: regmap: Add set_config callback
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
 <20260723034237.2501507-8-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-8-eleanor.lin@realtek.com>

--bcdbb4f5b86540f5f638637f481de919ca5fbee71c85807e04e08ee05a86
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jul 23, 2026 at 5:42 AM CEST, Yu-Chun Lin wrote:
> Add a new set_config callback to allow drivers to implement
> hardware-specific configuration such as debounce settings, or other
> platform-specific GPIO properties.
>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---
> Changes in v7:
> - Drop the reviewed by tag from Andy due to the signature changes.
> - Add 'struct gpio_regmap' as the first parameter to the set_config callb=
ack.
> - Add wrapper to bridge gpio_chip to gpio_regmap.
> ---
>  drivers/gpio/gpio-regmap.c  | 16 ++++++++++++++++
>  include/linux/gpio/regmap.h |  6 ++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 8f58b272b870..98cfdd890069 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -51,6 +51,9 @@ struct gpio_regmap {
>  			   unsigned int reg, unsigned int *mask,
>  			   unsigned int *val);
> =20
> +	int (*set_config)(struct gpio_regmap *gpio, struct gpio_chip *chip,
> +			  unsigned int offset, unsigned long config);
> +
>  	void *driver_data;
>  };
> =20
> @@ -317,6 +320,15 @@ static int gpio_regmap_direction_output(struct gpio_=
chip *chip,
>  	return gpio_regmap_set_direction(chip, offset, true);
>  }
> =20
> +static int gpio_regmap_set_config(struct gpio_chip *chip,
> +				  unsigned int offset,
> +				  unsigned long cfg)
> +{
> +	struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> +
> +	return gpio->set_config(gpio, chip, offset, cfg);
> +}
> +
>  int gpio_regmap_reqres_irq(struct gpio_regmap *gpio, unsigned int offset=
)
>  {
>  	return gpiochip_reqres_irq(&gpio->gpio_chip, offset);
> @@ -386,6 +398,7 @@ struct gpio_regmap *gpio_regmap_register(const struct=
 gpio_regmap_config *config
>  	gpio->reg_clr_base =3D config->reg_clr_base;
>  	gpio->reg_dir_in_base =3D config->reg_dir_in_base;
>  	gpio->reg_dir_out_base =3D config->reg_dir_out_base;
> +	gpio->set_config =3D config->set_config;
> =20
>  	chip =3D &gpio->gpio_chip;
>  	chip->parent =3D config->parent;
> @@ -455,6 +468,9 @@ struct gpio_regmap *gpio_regmap_register(const struct=
 gpio_regmap_config *config
> =20
>  	gpio->value_xlate =3D config->value_xlate;
> =20
> +	if (config->set_config)
> +		chip->set_config =3D gpio_regmap_set_config;
> +

Please keep both settings together. i.e.

if (config->set_config) {
	gpio->set_config =3D config->set_config;
	chip->set_config =3D gpio_regmap_set_config;
}

With that fixed:
Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

>  	ret =3D gpiochip_add_data(chip, gpio);
>  	if (ret < 0)
>  		goto err_free_bitmap_output;
> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index b77d6371cd9c..4bf4319ec12e 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -93,6 +93,9 @@ enum gpio_regmap_operation {
>   *			mask before writing. This allows driver-specific logic
>   *			to append additional bits (like write-enable masks)
>   *			dynamically based on the current operation.
> + * @set_config:		(Optional) Callback for setting GPIO configuration such
> + *			as debounce, drive strength, or other hardware specific
> + *			settings.
>   * @drvdata:		(Optional) Pointer to driver specific data which is
>   *			not used by gpio-remap but is provided "as is" to the
>   *			driver callback(s).
> @@ -154,6 +157,9 @@ struct gpio_regmap_config {
>  			   unsigned int base, unsigned int offset, unsigned int reg,
>  			   unsigned int *mask, unsigned int *val);
> =20
> +	int (*set_config)(struct gpio_regmap *gpio, struct gpio_chip *chip,
> +			  unsigned int offset, unsigned long config);
> +
>  	void *drvdata;
>  };
> =20


--bcdbb4f5b86540f5f638637f481de919ca5fbee71c85807e04e08ee05a86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCamG8OxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jdMAGA6vdWDAfPlpbMRlL8bcVeH0J9ggUGO3k3
KKaE4tKNSFlTM5PlV39WvlxwxbB8MXX0AYCoD8206H984cP/OldL5d+dk/ye/hYn
/QlgWY+LBTrRVzH9V3kko106NbPt0pdn8uw=
=sqQX
-----END PGP SIGNATURE-----

--bcdbb4f5b86540f5f638637f481de919ca5fbee71c85807e04e08ee05a86--
