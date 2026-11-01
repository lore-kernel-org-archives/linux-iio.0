Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499075;
	b=vVOjDd5ghnEfohwO7bq2ih6gTPbLZABmWWv6Rg7cvmwNX8/HsnPvAbRityjjSTD7HVsx
	 uMnuJ5KqEmzskZcr75NDSbtYyKv19iaWA3CFM37g/oEMVAsKDcapKD7Ux+jXdSNA46JB7
	 MZNsBPDPBIEFrDHxtgF2XYV+wgtK4NKUxPsOdYpK6Smq5q731bndG3gXhZ7h2qTr+SwDU
	 HSYreob9ywM7iNYoa+xeBgQ/DzYu+DJ6Fa344P/g7kEZ+/RxmTzC7LSeNEPVgQBu2tnxw
	 yYHS1+hDpHO5qoVkRwveZjLwNJo7q5vTEbNFwnsRaGNM12UZNC8fK4uxub/JjU18l3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499075;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Je1hEFupyVknre7flundp6Auvep7hdapJqk9LTTSHEo=;
	b=JI3mt5D8XMstZRl+/6Vcj/55D3ELPri96xzcZmEPxnElFBKexjaeoFf1f0Vq+9BWNuc2
	 FRqfBYyZZvc5LlAKMqKqGT5MmRnJ1uPGhnQ5wCZ4N/blUdPRTTomu/nVUMfKyl2UEhg7+
	 3vfMwUl7Tdp299A7yqPMv9+pM3mw0ig4rBMU9MUYhcDX14UGHvhR1DZHP+f7a/fckOV1N
	 CI/Q4fOQFm/wzaav/ByKEHujujk0YeMuZc9uKQ+7eRUy0xUJuY0pk6eeZD4ZNts5GkxKc
	 mZVvZSA6AQlMuz9Ukr6pxQm2ZWioRAes2wEVikmbwmfpv19WSxk0dL96+XoSuQIZaCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEr1kp+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439C606A324;
	Sun,  1 Nov 2026 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEr1kp+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCB71F000C1;
	Sun,  1 Nov 2026 02:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499074;
	bh=Je1hEFupyVknre7flundp6Auvep7hdapJqk9LTTSHEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OEr1kp+CkEPQpDdI2L0cP3/O58VH94S4bWjcsJ5wtMewA+Q3xsGqhkBr40JjZsmbc
	 9FORUd8n/LaVhIQtjXb05bOSSzOtiLvRZo5sFbYB16dIZAehQEdRdxWleSOGDPFZLL
	 wgDhvLtIdYNaUCdpiS0gQYsA1Fxdhk7u8c6tbwD3ucg1OIyj/XeawUXHcePzs6QCLT
	 9/opQ3MSywDou8vV+G10AsYIi/iyg2CjuItpl8pyVVZh3PpH0/AgI9cpxeVJhZo7xA
	 8MQ9m2oW47IyFf21z3XrQhAFvOnrBDesSSi996lSk0gFu6OHVU+XZdG+ca4X0IsE3L
	 S7uP6DgXrmhAw==
Date: Sun, 1 Nov 2026 02:11:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Matti Vaittinen <mazziesaccount@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 15/15] iio: sx9310: use the data of the I2C table
Message-ID: <20261101021109.59b2cffc@jic23-hlaptop>
In-Reply-To: <20261027-llm-char-misc-iio-v1-15-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-15-0d818334f6c7@linuxfoundation.org>
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

On Tue, 27 Oct 2026 17:19:19 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> sx9310_check_whoami() takes the chip information from
> device_get_match_data(), which only looks at the OF and ACPI tables, and
> dereferences it. For a client which was bound through the i2c_device_id
> table, for instance one created with
>=20
>   echo sx9310 0x28 > /sys/bus/i2c/devices/i2c-1/new_device
>=20
> it returns NULL, and the kernel oopses as soon as something at that addre=
ss
> answers the read of the WHOAMI register.
>=20
> The I2C table has the same pointers. Use i2c_get_match_data(), which falls
> back to it.
>=20
> Fixes: 21fd3b1373f6 ("iio: proximity: sx9310: Convert enum->pointer for m=
atch data table")
> Cc: stable <stable@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: Siratul Islam <email@sirat.me>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Stephen Boyd <swboyd@chromium.org>
Applied to the fixes-togreg branch (I'll rebase and send a pull
for that after rc1), though I pruned most of these out to reduce noise
in the git log

Thanks,

Jonathan

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 79ba46d8a0aa..2585b9c6fb69 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -891,7 +891,7 @@ static int sx9310_check_whoami(struct device *dev,
>  	if (ret)
>  		return ret;
> =20
> -	ddata =3D device_get_match_data(dev);
> +	ddata =3D i2c_get_match_data(data->client);
>  	if (ddata->whoami !=3D whoami)
>  		return -ENODEV;
> =20
>=20

