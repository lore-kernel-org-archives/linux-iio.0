Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCF395AE9;
	Tue, 21 Jul 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618620; cv=none; b=qWtW7THfBaFfYClkXpvDXYGnFjDVpqGk6Z9RSA1mM58oV0YoCuNKYBnoSBKhi1eZ6BG9IsasSADXmr7cdb9ZZTZKDtZL/0hCdJ9zk9jLeX1YCukeOsXNe5w9d8aLskh8d+gHUbS5iUOugQS5gBwGrDuXAnXYAWfq91JeootAkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618620; c=relaxed/simple;
	bh=UEY6xkEuQZOkXlbXKy4KpinACi8SuFNR1qJxBTkYng0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=R5OO9wbjYNs2tEnoQN+tVrptJK/3E+oRQyRYiEr23mjLPivy8qH0TYKA/KKwO+3RjR3nlRPgRfVIvY3o/v916s7xKh9IQl3FqOHeSIX9I3HsxYMKNEIve+eoCxFwyBQhhqFeNSECnlnP7Rb42Fk/Y50wkvmnZ/lPUGR97Uog5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxqCjIBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxqCjIBT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A2A511F000E9;
	Tue, 21 Jul 2026 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618615;
	bh=ZzNKwYbh3+ddUedwP4rL/5PhQuvCGYCjp2kSGL9jO+s=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=oxqCjIBTsxbKTm05pGYrpFEnBg0BuWNIKiUSUY6rjDGcf6oO/pEfcRv2Gb9yLlciH
	 F37o2+9qN8v8UwhW/nhTZDeYzv9wyea5cOaMkityrP5hyUF2jMQNJUEO+hHu/0SlRV
	 1eXdo4byDr8VwBpeaLjnbjVDLYdocSKzrRVtQ9YGv7ZF/D2Po2CdvwRcwk4rfKfaGz
	 8tnayXIpK3sgHLCakRBC/jqPUsrbC2qQX5YVlkDoh0W4XQY4Zavfl9Q0VbTM8OKuBI
	 6ogaEjWWPHDdUEhJ371d1Tc3fwks0GrZFkrEGAf1b+WsVMOqJFIRsBUxF4uISZeZt4
	 keq2AfnUEI3OA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ce1331a05ce8abff49a814a2037f3b2db678bbcb07d7dd867c7d762b35af;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 21 Jul 2026 09:23:31 +0200
Message-Id: <DK42I02A80FJ.1TX1U341LOAXG@kernel.org>
Subject: Re: [PATCH v6 6/8] gpio: regmap: Add set_config callback
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
 <20260721065802.689530-7-eleanor.lin@realtek.com>
In-Reply-To: <20260721065802.689530-7-eleanor.lin@realtek.com>

--ce1331a05ce8abff49a814a2037f3b2db678bbcb07d7dd867c7d762b35af
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 21, 2026 at 8:58 AM CEST, Yu-Chun Lin wrote:
> Add a new set_config callback to struct gpio_regmap_config to allow drive=
rs
> to implement hardware-specific configuration such as debounce settings,
> or other platform-specific GPIO properties.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---
> Changes in v6:
> - None.
> ---
>  drivers/gpio/gpio-regmap.c  | 1 +
>  include/linux/gpio/regmap.h | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index aecc35f610dd..b856326ff01c 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -454,6 +454,7 @@ struct gpio_regmap *gpio_regmap_register(const struct=
 gpio_regmap_config *config
>  		gpio->reg_mask_xlate =3D gpio_regmap_simple_xlate;
> =20
>  	gpio->value_xlate =3D config->value_xlate;
> +	chip->set_config =3D config->set_config;
> =20
>  	ret =3D gpiochip_add_data(chip, gpio);
>  	if (ret < 0)
> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index 45a30f50043f..23460995c1d1 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -89,6 +89,9 @@ enum gpio_regmap_operation {
>   *			mask before writing. This allows driver-specific logic
>   *			to append additional bits (like write-enable masks)
>   *			dynamically based on the current operation.
> + * @set_config:		(Optional) Callback for setting GPIO configuration such
> + *			as debounce, drive strength, or other hardware specific
> + *			settings.
>   * @drvdata:		(Optional) Pointer to driver specific data which is
>   *			not used by gpio-remap but is provided "as is" to the
>   *			driver callback(s).
> @@ -150,6 +153,8 @@ struct gpio_regmap_config {
>  			   unsigned int base, unsigned int offset, unsigned int reg,
>  			   unsigned int *mask, unsigned int *val);
> =20
> +	int (*set_config)(struct gpio_chip *gc, unsigned int offset, unsigned l=
ong config);
> +

Do we need an additional struct gpio_regmap pointer as a first
argument? How does the driver fetch the attached opaque data
pointer? I see that your driver is doing

 struct rtd1625_gpio *data =3D gpiochip_get_data(chip)

But it is the gpio-regmap core which will attach it's own data
pointer to gpio_chip, no?

-michael

>  	void *drvdata;
>  };
> =20


--ce1331a05ce8abff49a814a2037f3b2db678bbcb07d7dd867c7d762b35af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCal8ecxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jBkQGA1A7EWWOjRqDhXMsnbAyMtS3LfS8umhGf
A/SWgoujF/5HeE4DRJ7pyhOYImQbLiyqAX41p2UlZ69j3XV5pT+xltCuumg7EQ8M
HS9haG/0bMEBdmU9b6at2T7rzlGLY6EC0TM=
=cf4G
-----END PGP SIGNATURE-----

--ce1331a05ce8abff49a814a2037f3b2db678bbcb07d7dd867c7d762b35af--
