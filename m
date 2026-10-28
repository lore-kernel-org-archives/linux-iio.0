Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153353;
	b=QiWC/cpeO9NhRED2PQTpt/B6KzKjzqJ9y+uT1F/IginfQhcQftxDoUKcJThGiMrixmcP
	 j+gyZw8af2A+GHTRySA8pGFddaqzaj88Q41J+H8noYguhcaaFfZ3HLYlCGQuU9gEk3Vlm
	 MP7/1qp+WJhZMOaAJCcJxF8JzWN94HhsAj8tLM640mK4cRLJ6aqnBuX9HcoMaQYnDax3x
	 /ADCFhHqeENr4EtnR/dGdXT7JsHNMAq2C9EyuCXWTIyRaGFrzhcmeslH1agkYBLriYpeR
	 inex5hwLNUwwpyKd+bVBcHWPylE7dN4sDeV6YI50mCHhO6wPLa2X2plBCA4lCz0iT/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153353;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b5HjZdh2yKxFGrfPenLoIjzp9fFH2lJQ+StmQcjE9YM=;
	b=0wUL0kdaPSU0EOcMZ+GoY61eYcI1RRARDDtDhUHGZY9Ir0q3SMKhbDh0bu7bzdvFH4rk
	 IbqIgaL68eaP+FbPEjErRtLL//v4Iph76/f5U2YK+5Jo1moSXaKnAaWocsZlBR5WfsGso
	 5QI75AYTSpL1lDNQKebQihYOvdMtsuRLa30cTWTvnUh6hzpOKerrExTgSWbEgHtnqVKle
	 xD0Fo++/cFN/QuYWlIuy46x7Mzv+DYoo6T0Pi6I/UlUZVLTRdWHyGa+ZjJy43++pwfsLi
	 W0FhsuR7FGtfyin60Tqq1t5uMIiiuWKvc7anI9jvXIc6T6lkaXBjCTOdUFVPtz0RLQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hK2vt+lF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB4606A31A;
	Wed, 28 Oct 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hK2vt+lF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE631F01825;
	Wed, 28 Oct 2026 02:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793153353;
	bh=b5HjZdh2yKxFGrfPenLoIjzp9fFH2lJQ+StmQcjE9YM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hK2vt+lFd95/4EAeL1ZmUeeJCvQOeptmCDyVGIGDl6v/t/HF3XytZRdsVcFHDs+0k
	 BJhMcDBLPMCm92RAmrzBjpijhLQMA81pfN2MpqtSAo7MceDZKBDV7v96+GEsJ9DcsL
	 kVVPM5dgGaXGjC4ZMlAwGiY6rzSMwJqt7x8f+TNbk9enaBWQRUT6QWajJmQEum3xNj
	 O8kehJKJRqiHygl83jLsTUbKZhpjpAt128D7zgrHqxis0G4fgGMVzWE+GO6r3p+LfB
	 FpCkw4fMVe4xskdEAGjoTEdbG0IuZATdcTYVSBQqmRtjn0X2PBTRj6l1YcD4gOkG7U
	 k/65001Hv1W/w==
Date: Wed, 28 Oct 2026 02:09:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Vlad Dogaru <ddvlad@gmail.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 13/15] iio: proximity: sx9500: hand on probe deferral of
 GPIOs
Message-ID: <20261028020905.7e0e86f0@jic23-hlaptop>
In-Reply-To: <20261027-llm-char-misc-iio-v1-13-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-13-0d818334f6c7@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 17:19:17 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> sx9500_gpio_probe() treats every failure of devm_gpiod_get() as "the
> line does not exist".
>
>  If the GPIO controller has not been probed yet,
> the lookup fails with -EPROBE_DEFER, and the driver binds for good
> without the line:
>=20
>  - without the "interrupt" GPIO client->irq stays 0, so no interrupt is
>    requested and no trigger is registered: the device has no events and
>    no data-ready trigger until it is unbound and bound again;
>  - without the "reset" GPIO the chip is not reset in
>    sx9500_init_device().
>=20
> Which of the two happens depends only on the order in which the drivers
> are probed.  Return -EPROBE_DEFER so that the probe is repeated once the
> controller is there.  All other errors are handled as before.  The i2c
> core sets client->irq again at the start of every probe, so a deferral
> on the second line leaves nothing behind.
>=20
> A system that describes one of the lines but never gets a driver for its
> GPIO controller now keeps the sensor in the deferred list instead of
> binding it without the line.
That's all a bit long winded though accurate.

The original code is rather odd.  If the intent is to actually have
these as optional gpios, why not use devm_gpiod_get_optional()
which documents that intent?

Anyhow, I suggest a bit more radical surgery given the driver
is fine without the irq and the code being fixes smells like it is
papering over ancient firmware. It definitely shouldn't run on
a modern system.

>=20
> Fixes: 45fd5f8e10d3 ("iio: sx9500: add GPIO reset pin")
> Fixes: e53111ad5dea ("iio: proximity: sx9500: Assign interrupt from GpioI=
o()")
> Cc: stable <stable@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: Siratul Islam <email@sirat.me>
> Cc: Vlad Dogaru <ddvlad@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iio/proximity/sx9500.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx950=
0.c
> index dadce9b44227..94cc577f4404 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -853,15 +853,15 @@ static const struct acpi_gpio_mapping acpi_sx9500_g=
pios[] =3D {
>  	{ }
>  };
> =20
> -static void sx9500_gpio_probe(struct i2c_client *client,
> -			      struct sx9500_data *data)
> +static int sx9500_gpio_probe(struct i2c_client *client,
> +			     struct sx9500_data *data)
>  {
>  	struct gpio_desc *gpiod_int;
>  	struct device *dev;
>  	int ret;
> =20
>  	if (!client)
> -		return;
> +		return 0;
> =20
>  	dev =3D &client->dev;
> =20
> @@ -871,6 +871,8 @@ static void sx9500_gpio_probe(struct i2c_client *clie=
nt,
> =20
>  	if (client->irq <=3D 0) {
>  		gpiod_int =3D devm_gpiod_get(dev, "interrupt", GPIOD_IN);
> +		if (PTR_ERR(gpiod_int) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
>  		if (IS_ERR(gpiod_int))
>  			dev_err(dev, "gpio get irq failed\n");

This is 'novel'. I did some archaeology.  Goes back almost 11 years
and at the time the driver only had ACPI and i2c_device_id. So
assuming we weren't talking board files I suppose this is papering over
a broken ACPI firmware.

Given the driver works fine without the interrupt (despite that print
implying it is an error).
Shall we just rip this out?  The irq from any modern firmware will
be in client->irq anyway so this section doesn't run.

>  		else
> @@ -878,10 +880,14 @@ static void sx9500_gpio_probe(struct i2c_client *cl=
ient,
>  	}

The next bit is valid, though with the above gone, I'd be tempted
to flatten this helper and just get the gpio inline.

> =20
>  	data->gpiod_rst =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);

	data->gpiod_rst =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
	if (PTR_ERR(data->gpiod_rst))
		return dev_err_probe(dev, "gpio get reset failed\n");
	if (!data->gpiod_rst)
		dev_warn(dev, "gpio reset not available\n:);

	return 0;

> +	if (PTR_ERR(data->gpiod_rst) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
>  	if (IS_ERR(data->gpiod_rst)) {
>  		dev_warn(dev, "gpio get reset pin failed\n");
>  		data->gpiod_rst =3D NULL;
>  	}
> +
> +	return 0;
>  }
> =20
>  static int sx9500_probe(struct i2c_client *client)
> @@ -911,7 +917,9 @@ static int sx9500_probe(struct i2c_client *client)
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>  	i2c_set_clientdata(client, indio_dev);
> =20
> -	sx9500_gpio_probe(client, data);
> +	ret =3D sx9500_gpio_probe(client, data);
> +	if (ret)
> +		return ret;
> =20
>  	ret =3D sx9500_init_device(indio_dev);
>  	if (ret < 0)
>=20

