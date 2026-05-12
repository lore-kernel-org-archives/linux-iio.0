Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D63A4277;
	Tue, 12 May 2026 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594426; cv=none; b=JFHNtDhNXyim19AYw2hPOGgKfcofPrUn9JFmCpwPKsKTSKnH7AbMrrPVJhr5sVeTNnRjFQHjGRADVR1kBm0ZxjJH9LU0vSl8fjbHqwetE8uqngmCg5oHoxNMYG3GObCDjV2q1mX9uD6a3Pn4Jgf8r7NSlL5D+ptXMSOyWzlVJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594426; c=relaxed/simple;
	bh=Zh/XlhEXx31smiI+HD4pzzhFayxcKiAsgAuUEKIy2Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/BYyoo+ggWnu2El4gNTnbAvVSpXyKkRY/zDctRUysZMyA7iTX3HjNpzdtY8eaenfx92idYyJICbaE/Z9pkpQbL5p5BVrgONNoeb9bhtOY6WB+e97O9ucQAIyIW97n/okTjo4qq+2K4sNjxmMCZJUiefNrAAEQbQP2tSvwbWbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWY3lVcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWY3lVcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D7EC2BCF6;
	Tue, 12 May 2026 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594426;
	bh=Zh/XlhEXx31smiI+HD4pzzhFayxcKiAsgAuUEKIy2Gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SWY3lVcFyNRs3Gwu21kZsujpV2n6ikqAcUl3lZA6uEHuSZ2LQlFdGSf5HZ/1CT1NT
	 fwBaNGkIvCSYlrYRPZj0Ok/jss2FON9ok0v1VeHFhF2LNWytBKFyg55tIu6Qs4lcSM
	 gtepQ0JNVQoUDiyFKOpCDOZkxdp94Dn8MoRUUHB2ZsXwb4CCX0v9Vkq3Nd1NIgqfUF
	 29cHSH74Hx8LEzT37OS8jTvPTMt8d8lYQmg1ii7dkEXm8cmPbqLjNxiMEN+vQ0ELet
	 r2cbdXKv0uB05gShaEqMwkdvgdJmduSQ3N3PsP/cLxqcb16CVjeHnjwDbz9MWAEWWw
	 as/ow0+Vng1QQ==
Date: Tue, 12 May 2026 15:00:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Ariana Lazar
 <ariana.lazar@microchip.com>, Alex Lanzano <lanzano.alex@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Remi Buisson
 <remi.buisson@tdk.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Christian
 Eggers <ceggers@arri.de>, Tomasz Duszynski <tduszyns@gmail.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Andreas Klinger
 <ak@it-klinger.de>, Waqar Hameed <waqar.hameed@axis.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Gustavo Vaz <gustavo.vaz@usp.br>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Dixit Parmar
 <dixitparmar19@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>, Guenter Roeck <linux@roeck-us.net>,
 Chuang Zhu <git@chuang.cz>, Kyle Hsieh <kylehsieh1995@gmail.com>, Linus
 Walleij <linusw@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Sander Vanheule <sander@svanheule.net>, Romain Gantois
 <romain.gantois@bootlin.com>, David Jander <david@protonic.nl>, Kurt Borja
 <kuurtb@gmail.com>, Tomas Borquez <tomasborquez13@gmail.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, chuguangqing
 <chuguangqing@inspur.com>, Shi Hao <i.shihao.999@gmail.com>, Erikas
 Bitovtas <xerikasxx@gmail.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: Initialize i2c_device_id arrays using
 member names
Message-ID: <20260512150006.7ab14fcf@jic23-huawei>
In-Reply-To: <35a46c1014a1452b0c191a588bee8a09ddea964e.1778582187.git.u.kleine-koenig@baylibre.com>
References: <cover.1778582187.git.u.kleine-koenig@baylibre.com>
	<35a46c1014a1452b0c191a588bee8a09ddea964e.1778582187.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 14:50:35 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Hi Uwe

A couple of these are cases where we can rip the driver_data out like you d=
id in patch 1.

Other minor things inline.

Thanks for doing this.

Jonathan

> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc=
150-accel-i2c.c
> index b4604f441553..aab3b110faa5 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -245,16 +245,16 @@ static const struct acpi_device_id bmc150_accel_acp=
i_match[] =3D {
>  MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> =20
>  static const struct i2c_device_id bmc150_accel_id[] =3D {
> -	{"bma222"},
> -	{"bma222e"},
> -	{"bma250e"},
> -	{"bma253"},
> -	{"bma254"},
> -	{"bma255"},
> -	{"bma280"},
> -	{"bmc150_accel"},
> -	{"bmc156_accel", BOSCH_BMC156},
> -	{"bmi055_accel"},
> +	{ .name =3D "bma222", .driver_data =3D 0 },
So we do have BOSCH_UKNOWN for the the 0 value.  It doesn't actually mean
it's unknown but rather that ID matching will work so we don't need
to know what it is.  Maybe we should use it anyway rather than 0?

Original approach of relying on the magic 0 is more horrible still so
this is definitely an improvement!

> +	{ .name =3D "bma222e", .driver_data =3D 0 },
> +	{ .name =3D "bma250e", .driver_data =3D 0 },
> +	{ .name =3D "bma253", .driver_data =3D 0 },
> +	{ .name =3D "bma254", .driver_data =3D 0 },
> +	{ .name =3D "bma255", .driver_data =3D 0 },
> +	{ .name =3D "bma280", .driver_data =3D 0 },
> +	{ .name =3D "bmc150_accel", .driver_data =3D 0 },
> +	{ .name =3D "bmc156_accel", .driver_data =3D BOSCH_BMC156 },
> +	{ .name =3D "bmi055_accel", .driver_data =3D 0 },
>  	{ }
>  };
> =20

> diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
> index bd4877268689..d4c4b19edc61 100644
> --- a/drivers/iio/adc/ad7091r5.c
> +++ b/drivers/iio/adc/ad7091r5.c
> @@ -117,7 +117,7 @@ static const struct of_device_id ad7091r5_dt_ids[] =
=3D {
>  MODULE_DEVICE_TABLE(of, ad7091r5_dt_ids);
> =20
>  static const struct i2c_device_id ad7091r5_i2c_ids[] =3D {
> -	{ "ad7091r5", (kernel_ulong_t)&ad7091r5_init_info },
> +	{ .name =3D "ad7091r5", .driver_data =3D (kernel_ulong_t)&ad7091r5_init=
_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad7091r5_i2c_ids);

Hmm.  I guess another user of the common library actually supports multiple=
 parts.
For this one we could just hard code it in ad7091r5_i2c_probe()


>
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index e7e29359f8fe..b3ae00431910 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -332,7 +332,7 @@ static int max5821_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id max5821_id[] =3D {
> -	{ "max5821", ID_MAX5821 },
> +	{ .name =3D "max5821", .driver_data =3D ID_MAX5821 },

Used?  I get suspicious of any single entry ones and I can't immediately
see where it is used.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max5821_id);

> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index fb02eac78ed4..602f7b95c83e 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
Comments below refer to the these 3.

> @@ -1007,8 +1007,8 @@ static const struct of_device_id sx9310_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, sx9310_of_match);
> =20
>  static const struct i2c_device_id sx9310_id[] =3D {
> -	{ "sx9310", (kernel_ulong_t)&sx9310_info },
> -	{ "sx9311", (kernel_ulong_t)&sx9311_info },
> +	{ .name =3D "sx9310", .driver_data =3D (kernel_ulong_t)&sx9310_info },
> +	{ .name =3D "sx9311", .driver_data =3D (kernel_ulong_t)&sx9311_info },

These are used so fine. But the other users of the sx_common library are
less obvious. I'm fairly sure the use here is confined to this sub driver.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9310_id);
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx932=
4.c
> index f61eff39751d..4831d33cb337 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -1135,7 +1135,7 @@ static const struct of_device_id sx9324_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, sx9324_of_match);
> =20
>  static const struct i2c_device_id sx9324_id[] =3D {
> -	{ "sx9324", SX9324_WHOAMI_VALUE },
> +	{ .name =3D "sx9324", .driver_data =3D SX9324_WHOAMI_VALUE },
Same as below. I think you can rip this out.  Do the same for the other
tables whilst doing so.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9324_id);
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx936=
0.c
> index 4448988d4e7e..f8fd399dc2be 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -845,7 +845,7 @@ static const struct of_device_id sx9360_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, sx9360_of_match);
> =20
>  static const struct i2c_device_id sx9360_id[] =3D {
> -	{"sx9360", SX9360_WHOAMI_VALUE },
> +	{ .name =3D "sx9360", .driver_data =3D SX9360_WHOAMI_VALUE },

These are only 'sort of used'  I wonder if we should just rip
them out.  They are used locally in e.g. sx9310_check_whoami()
but there is only one value so we could hard coded it there instead.

This smells like cut and paste rather than something that is actually usefu=
l.
The name should be hardcoded as well.  Is is for this particular
driver and the sx9324.



>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9360_id);
