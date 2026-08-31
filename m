Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107541DF980;
	Mon, 31 Aug 2026 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135551; cv=none; b=SvEtKZNIRzct1rhQ3WMcfN1hcezFjcUbiN0oMl+vB8/7yPFGJz8T3ImDvLtljBhRurZ9MPhAL2PEtI7n+6fYDxonY72JAf6hRnxav6SWfdxELB85m2RcVYDMQV0ILZMvOEXuZCOw0WpMVdY0AmnlMXbnMHKARSt355jjETdBokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135551; c=relaxed/simple;
	bh=56x/ACdD2fsc80e1fKNvChwKBC90Q/R87VEXXUJQIpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dku29A65XIG+iICbnioAdyriRZo9UX6GHGuT0+ol751q+ltbdJI2BZyNYXPibyVcxF7akjwU5+86sulAkCODT2C5BS+5foHH9AZGQWj5P+rQhTsb6o0pBNWfJv/DBPUlPkMxxM370Ksp05X+Fhyt9zrqTmYpaB0ZJ5tD6NMjL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Wutm4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Wutm4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7C91F000E9;
	Mon, 31 Aug 2026 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788135549;
	bh=56x/ACdD2fsc80e1fKNvChwKBC90Q/R87VEXXUJQIpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o3Wutm4fke97VtdyJS1eK71djyBaaOlKWSsbw3fDawHvAbDfdxexrfB01UVxJU80K
	 46FrA2ShQrYKqHOBzzmjYiHKY8mnGjjWcJF/QjboPqNkM/HHSnSovnW8jDLteaB+vg
	 bAD8UfL6LTwi6HIyAwIBsmzLk0wN+90XGfNMnOYeT6p8gIwzzyN5J8nCuOJR0PHPwg
	 /Zug+74MQbtVeEg8QX4Rb2CssYGerN6WmMaVCEcrn+JIMijMlaSWLk/l7/JzZ0oF9W
	 w39PYkfrEht5URHIv30jIdkrWEQGpTMj2B5XWO77VEaiHpKZ/swXOero1OCuY4JK61
	 MtuX6Hm0kG6kw==
Date: Mon, 31 Aug 2026 01:19:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yang Zi <2959243019@qq.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org,
 o-takashi@sakamocchi.jp, email@sirat.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9310: fix NULL pointer dereference in
 sx9310_check_whoami
Message-ID: <20260831011905.30346599@jic23-huawei>
In-Reply-To: <tencent_1936AF0C31F45000EFB7B38019EFD4A06C07@qq.com>
References: <tencent_1936AF0C31F45000EFB7B38019EFD4A06C07@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 17:18:01 +0800
Yang Zi <2959243019@qq.com> wrote:

> device_get_match_data() can return NULL, e.g. when the device is matched
> through the I2C device ID table rather than the OF/ACPI match tables. In
> that case sx9310_check_whoami() dereferences a NULL pointer when reading
> ddata->whoami.
>=20
> Return -ENODEV if no match data is found to avoid the NULL pointer
> dereference.
>=20
> Signed-off-by: Yang Zi <2959243019@qq.com>
This one seems to have spaces where it should have tabs as well.

Thanks,

Jonathan

> ---
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 79ba46d8a0aa..305b41f2847d 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -892,6 +892,8 @@ static int sx9310_check_whoami(struct device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0ddata =3D device_get_match_data(dev);
> +=C2=A0 =C2=A0 if (!ddata)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> =C2=A0 =C2=A0 =C2=A0if (ddata->whoami !=3D whoami)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> =C2=A0
>=20
>=20
>=20

