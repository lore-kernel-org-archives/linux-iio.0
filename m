Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6913A48FB;
	Tue, 12 May 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594499; cv=none; b=FZ2Dk0UyQ9DWDzh8a0RL/JZnvZBK8ASrnjEIj2Ru4qC62q772E0GxTY4bM8oVfO2RMNDphnyJl591yCFrFWPVNSWdDFzb0ukbUbhMdf4tUdqlu6c2SoeNm3EECrdwKF7sup4bRygwiDiv1Z1emRF+9q9sI0iNW8CZ7bG2OlohFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594499; c=relaxed/simple;
	bh=Az5pGG+aqgff27737qy+8QZOMmvLeyzUAsfzqSt652c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADdOb2Ac+PvcxEp9U1h8JqrJcOUbcy40uM2IFVKhJRVEgNwGQgLHTBBjkXgLaGlRSGl0rV5esV06ZemqBKAwcrG/t9rhhdEDCezR2fDj2sjGtvsK7YaZc3BoX0/bZ4R4CJFdznCNt9jjcFYfF/9WB1B3cLNeO8LiO8zt45cGziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jenP0cin; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jenP0cin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B48C2BCB0;
	Tue, 12 May 2026 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594499;
	bh=Az5pGG+aqgff27737qy+8QZOMmvLeyzUAsfzqSt652c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jenP0cin0S4i61xZzTdcwMhCA2O+ljLOhPY/de6ZkNcZAdCY2+Mj3P6V412auoE7X
	 F2nq9hyQBREKkLKh/IeErKh29SIg/p0eR92laYhrq3foDWcdTv5jbVehBPmbzFq/6S
	 xET2WZv4S404V136pfgnyhxf5fHwCRDFTu0Mq1piuGjCNh9TrnI1Bwx5UzMOAn22zs
	 3LuFpPNgkK1Gcz//oeo/KsgWaRqdcMQY24iLZlVldqb73ZntZSXE7lZ39Yko35YpbX
	 mC8lfuEWprs4Oj39xdUCu9yNHlRO0j0bIlm9jcPoKeaRhFBIP7RVqynpE7KNjX/x7g
	 ffTOG7yqzCiKA==
Date: Tue, 12 May 2026 15:01:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Matteo Martelli <matteomartelli3@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, Linus Walleij <linusw@kernel.org>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: Drop unused driver_data in four i2c drivers
Message-ID: <20260512150128.79c4408b@jic23-huawei>
In-Reply-To: <8e07be10e69b5699bba7ef70533a0d49f8cc1eb1.1778582187.git.u.kleine-koenig@baylibre.com>
References: <cover.1778582187.git.u.kleine-koenig@baylibre.com>
	<8e07be10e69b5699bba7ef70533a0d49f8cc1eb1.1778582187.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 14:50:34 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> For the four drivers the .driver_data member of i2c_device_id is
> write-only. Drop the explicit assignment.
>=20
> While touching these arrays use a named initializer to assign the .name
> member, which is easier to parse for a human.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Given these are obviously a good idea and the other cases I called out
are more complex so probably want their own patches...

Applied to the testing branch of iio.git

Thanks

Jonathan

> ---
>  drivers/iio/adc/pac1921.c    | 2 +-
>  drivers/iio/light/apds9160.c | 2 +-
>  drivers/iio/light/tsl2563.c  | 8 ++++----
>  drivers/iio/light/tsl2583.c  | 6 +++---
>  4 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index bce7185953ec..68bdd2f30bad 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1310,7 +1310,7 @@ static int pac1921_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id pac1921_id[] =3D {
> -	{ .name =3D "pac1921", 0 },
> +	{ .name =3D "pac1921" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, pac1921_id);
> diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
> index 3da0bdac04cf..8dacb1730429 100644
> --- a/drivers/iio/light/apds9160.c
> +++ b/drivers/iio/light/apds9160.c
> @@ -1572,7 +1572,7 @@ static const struct of_device_id apds9160_of_match[=
] =3D {
>  MODULE_DEVICE_TABLE(of, apds9160_of_match);
> =20
>  static const struct i2c_device_id apds9160_id[] =3D {
> -	{ "apds9160", 0 },
> +	{ .name =3D "apds9160" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, apds9160_id);
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index f2af1cd7c2d1..7e277bc6a8b1 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -839,10 +839,10 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl=
2563_suspend,
>  				tsl2563_resume);
> =20
>  static const struct i2c_device_id tsl2563_id[] =3D {
> -	{ "tsl2560", 0 },
> -	{ "tsl2561", 1 },
> -	{ "tsl2562", 2 },
> -	{ "tsl2563", 3 },
> +	{ .name =3D "tsl2560" },
> +	{ .name =3D "tsl2561" },
> +	{ .name =3D "tsl2562" },
> +	{ .name =3D "tsl2563" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tsl2563_id);
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 8801a491de77..a0dd122af2cf 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -913,9 +913,9 @@ static DEFINE_RUNTIME_DEV_PM_OPS(tsl2583_pm_ops, tsl2=
583_suspend,
>  				 tsl2583_resume, NULL);
> =20
>  static const struct i2c_device_id tsl2583_idtable[] =3D {
> -	{ "tsl2580", 0 },
> -	{ "tsl2581", 1 },
> -	{ "tsl2583", 2 },
> +	{ .name =3D "tsl2580" },
> +	{ .name =3D "tsl2581" },
> +	{ .name =3D "tsl2583" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tsl2583_idtable);

