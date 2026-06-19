Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775431E842
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877306; cv=none; b=oqzmInP8Q2bmmV4MFPMn8wYift5ZO4Un7mLoRoxZdHKv4qsl4rZVpDbT5AlEfPAUnz6wdwNDHESJC6B2l9xAmxEWs5CjiAqqAmhhfudl8II6DM/LC0NYz5p+CSMY/wbUlDAzzu+X5Fp5woB3TvJ5+XKPy6AenhFQfYvow4/D75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877306; c=relaxed/simple;
	bh=YHho1W7z8mDTSrmx2x2mx+vt0TMFKl8MlygYeiLgLLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6bdO7M5414L2Y6rj8VYiSPuGMk27FB3tdJDk780Pt5aaziQnS/F+Ejq5xpKgSMD1Dc5/O/AEnxBBsYTodgvI/qW8wBf0UUSIn2f+5YPNfaIizGtmVANWgpq01BO9TaUDy32iiS2I4PZMoYO2ZCIn1MZpTksg6Xopk+5hOhU9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jzNybQeo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jzNybQeo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1087451f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781877296; x=1782482096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Xcl53W/d1zCewy2NCxbH3yCSfF9le45zZCAWmtsM2w=;
        b=jzNybQeoap1knJjgxp2o3ucYKDggB4m/UoQm8qZVL+Gc+H+yVlOjVIN/W4lMn0Qlhr
         A0q63yIanBXiGnptkYtFj4AoJQhWQxoEdah+2fN3MHefFJXK2LmoqesFRhVMPgJIrnv8
         oyau+BWLiT4aqcG+8gthnScV52NVuQ2RduF9zDXPe2/44gBF3cZClDmIOryvKhahp4kn
         EAdCpa4iF6cRSXY5VLEeyPSvoEl7UkEJkRslIXhLdwGtTkdNxBk7UQhaymPUu8G21Pzt
         SPA8XMQgUbkUMzvJSW1VSGjTZTLHVt7xVw0k4CmZnLcgIlYFB4amyJnmInapLXCYE/YS
         MWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877296; x=1782482096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Xcl53W/d1zCewy2NCxbH3yCSfF9le45zZCAWmtsM2w=;
        b=URSIbS4RhGe4WqHPEjt10XOxynZq9o8jCwPzHTFcqG/RHu8Sm4XERJ2vYMRwFhcjQb
         /+1zbP3wM1EnS7hFAOX6VkHahkb8Si24LDNrc2nhLsQnCdkA+NxdOqvw62O3/AJrMoQB
         3mPVTCGPiDrvtHQD+qbVJDQXfdLoeEONWrfHKLdMNSifgzUfRLaLkfBFYEGEAoRAud4c
         h1yukggm7ZSbVFWZ2tpyzK9zXC1Oy+uTGRCc2XiHgTMKw1iYs8bfegjctwiJhXLsmaJL
         y6aillXCFcIaVmHvcRugDFDNCVV/8q7A+kWeSKKXP8wv5al4Y7uiOB1tYzSnnYhTuITa
         N2Tg==
X-Gm-Message-State: AOJu0Ywk6yXPYGBqZYfxpDz/ejCAKZWUHC/eE3ohUvJKdaQ3J1btI6We
	2ftDDfWhH3P3TYub2jGz1ONBxk7c/9cQGnAreUvOubFioIVd8h78GcIGZ2i9vI98VPs=
X-Gm-Gg: AfdE7clqsbmiCNzjRsuiZjDr3YjW+m2MaA2ZDV6LiUjdnDnH3o5uYyMYoXoZBbyT0Wl
	+tD0iJWNacpi/WHRqrIxycDnvYrWx5I0gQnpWCKfhesifIQuHmAEE/Zq2aH0ttGv/pfP1z8y0F0
	8FuvjpBw9SH1bh4shjCzRR7ZpE8anKZB9qL2qeXdemwidEICzBeUsHuXqSx1QvHV9Ujacu2kwKN
	LA37FNXKvewlX19tN31+G5PdHVLGYwdlgzCCyfGZez5aBHcMWyt2DLfAGbrrejYuSOOkXuH5UhE
	/3O3nANams3mIyZ9yk49sHksK7jyQUokdu/AuDUWwZ9pNHbx68269GTdg2SeXUUftEK9zA6jNMa
	hjpJBIUbWz3LWLOIsTTzeVIxqZIq5PBORV3wmDhJ8+4Ey0wFoRcp5XeZZr648SGx5RvB+/khMCq
	4Rd+yt0MpX9Kxi8nQ4jaQxuDl2VDyZTE+xZiUW5rsPv/PFJPSwxp6gC/pDzMFcZDbCf6pb+gR/K
	fw=
X-Received: by 2002:adf:efc7:0:b0:460:e2e:6e2b with SMTP id ffacd0b85a97d-46501d44f6bmr5284891f8f.20.1781877296318;
        Fri, 19 Jun 2026 06:54:56 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4650bc423bbsm8215153f8f.28.2026.06.19.06.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:54:55 -0700 (PDT)
Date: Fri, 19 Jun 2026 15:54:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V11 4/9] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
Message-ID: <ajVKBsanqx_2Js4b@monoceros>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
 <20260610175455.19006-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqdmbuvony2rmfoy"
Content-Disposition: inline
In-Reply-To: <20260610175455.19006-5-macroalpha82@gmail.com>


--fqdmbuvony2rmfoy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH V11 4/9] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
MIME-Version: 1.0

Hello,

On Wed, Jun 10, 2026 at 12:54:48PM -0500, Chris Morgan wrote:
> +static const struct spi_device_id inv_icm42607_spi_id_table[] = {
> +	{
> +		.name = "icm42607",
> +		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data
> +	}, {
> +		.name = "icm42607p",
> +		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, inv_icm42607_spi_id_table);

Missing comma after the .driver_data lines.

Best regards
Uwe

--fqdmbuvony2rmfoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo1SisACgkQj4D7WH0S
/k4xngf5AfHOcRigvBqAnsXwv0DuvWRHWEyTHKoVr+MdoJvfw32l9h+n9PyP5GJ0
bQaTazLaUF7bwmmz7OyOXjjAnfgoDG87Aljxk6+ahdxg/pk69KY3jntHRlQsDiJ1
eibfV/XzjGdZ2VfKRPYVRja3Fw8h+3N1nrDDGM5sahOnBHca8nIoxvYbyid4ELmT
Hxr032EqX+p9Ul+wfojNFYGI563rjHf3l3KxPmb7REndTAhYCBIlyD6nbmLp/iHT
iyjkBkMbyQlgiVyRFGtruSO6J02aX+9w+0/YIbG1m5+WYXK87W93DroIeipJI7+O
LmshblDilFCetr1eijawAtkueNnNhg==
=Yazu
-----END PGP SIGNATURE-----

--fqdmbuvony2rmfoy--
