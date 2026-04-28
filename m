Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013332720D
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394519; cv=none; b=KWE8swyqLJxrgbKOZWwkebFiv6GoViQEmGYu96LAb/SFT3wZIU806rkf94dxJGUptS2a5qFymNJHpON+3TW9xY8E3IBJMGBgMXtnENdlbE7eDT7HEfRZjOIa4YvNs628KgBIGy1esW5D6HfU2CwuNR9DvAcPYJHuBt4+2+YIiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394519; c=relaxed/simple;
	bh=SWgFC01oRFGvTAc9C7pOp4OWHBMEJJD9LFKUxH4dqmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQf3PJeDcqytpcoac5lmUPJTLaQg+FxcFGLh31WtD1Lus59ZR9oOO/7QLNdiEeQBVn99gRwyKN547vT1SB5r5rkY+O5OLT4U7j2k0a2QOdtzlt9bIeLCi58u/J8z/fZWR9DozQqrT3tSdCZ8ZlyI4C18qdWAidoByASXo/xqFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=LMwgE484; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LMwgE484"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ba840146so104977515e9.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777394516; x=1777999316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUNqqMlw/UVl/Mg79ZSfZ1fNRUz7cYSVuWIlASgTfA8=;
        b=LMwgE484Ik+UCLkZgfSkMXYK+1mdBZF+7/Exb54H3V4OYCgSbiEGhAAdjSpFlJijVN
         TVrTGijUrqWEsCq2UzDq5YkBVyOYHENXtx1C/posb5mmbnr7vfQmLTd2aqChSUr6OWZi
         sanygEo1csNrP4AhNIn6i+Q6Ia8Xr/ujqvNH73zeu1cwjq4ChwNfnBUym1vVGlTgnNRF
         6tIL6pkQnwo0QgfDr4bSGKtCKhL0Lo3rSrg0usF1kC+NZxBWImKQXR7c5gQDSZyBpcPh
         MCEYOGtxpzbQ2jwom5C9ctukfARgmk0ul+dJ459nPPtvnpzCKpze8GrFvA4iP8gJDbRd
         g5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394516; x=1777999316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUNqqMlw/UVl/Mg79ZSfZ1fNRUz7cYSVuWIlASgTfA8=;
        b=FJOYHFeKADkxNOL6dFPlfMAie4BaPoyuB3kNjk+UtYc8W04gKx0DurSECfX87NSsSA
         Ln4xKb4r3J11cNkRdHOVNhyuepqPs5fvOGEH2Nlt/r9eVx5/F6gpqgMlpTXCYWiOETbn
         FHXunfQc83+bXT9XUUWxeswen0RCbSKB3PMwAXBX8o/qTRYPTi/zvTzyTg6DSY7S2STw
         CCMyJYx370IPisOtcWFWEKAFq3sNpqj8H4k7XveTYnCly9soU4U5xDuLuIjUHtURf38y
         muQ5z6Gk0muGuOA2RcVH/BGr7R+j0sKzoHSwLmUIPiL3EsYYTTYGUBb3mmc4czmIvRdv
         Q6xA==
X-Forwarded-Encrypted: i=1; AFNElJ/2FIosHimKfrsZuViUCJ/BS1WJ/w3TW3y14lOg50kKQ7YqB41rq6F/v4cxMiYYUUCrRjjOWOjvdAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFocyEhSLqBXI4K/Rgu862WTW/JZfz5sEQCvND5UZZ3oo8lMQr
	h7oC75Q5rXnPWoQT0Fxq+TVFcncM1bRzswOO/d/n1BH5jvJEVi2hxYyPgh6UYy/nQVEyoZ6knfT
	DO8iP
X-Gm-Gg: AeBDiet8a8FoO0kEUiM0f3xLA5Ua8WmL2lnHhbqm/BbFVx6kYP5bGg9/vWdKdmd/G1Q
	2rdKIez8SSt9U/SN+kH4AZ7t1R0WPCDecd1XkaQShZ8Vn/suIMJJeX/TsgbfNHPXITGajhPUwyj
	LCXFNkVCO955tXVuKnV53ylAuInnzXtJO2K0wcMFCcBbzjQb1W58/ejPh9fozdGgPtINo3pQRwK
	d8kypbj6FnYyuns1TKMNVVkR9SVJqS1eUfdQAfJryehqkl8wJQL56EfcTnPYgMKvB9lmLN7Mcml
	LqdZPXxxp5GwdkUIR37jrR1rRhfRkmNSUd3L0LuddQmw0KwFzOzZy1tWQ6Ui6EZWon/McCuMl5U
	+EvIbyosQZybimr3hKWTpFcvGBdJxPvETXk3Gehom2huOyy/HGz4FCHgK88a5pXvIcbVOLu4oep
	7NiB+DffL8gm5thw/nPoIkRyZWwsCUIICtROrXwdXhbVrh8hXlLn4cKCOfBfOGA2fuvIGBtlMOf
	z9+cyURFRuHqTvFWdLe5AkDBg==
X-Received: by 2002:a05:600c:524e:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48a77b2409fmr64257315e9.21.1777394516124;
        Tue, 28 Apr 2026 09:41:56 -0700 (PDT)
Received: from localhost (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a7b900af7sm267245e9.1.2026.04.28.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:41:55 -0700 (PDT)
Date: Tue, 28 Apr 2026 18:41:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Message-ID: <afDjKB5CAZHmoJVp@monoceros>
References: <20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zkxugxsjuoggtztf"
Content-Disposition: inline
In-Reply-To: <20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com>


--zkxugxsjuoggtztf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
MIME-Version: 1.0

Hello,

On Tue, Apr 28, 2026 at 04:45:46PM +0300, Radu Sabau via B4 Relay wrote:
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index a955556f9ec8..43aa296922c6 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -442,10 +442,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev=
 *indio_dev,
>  	ad_sd_disable_irq(sigma_delta);
> =20
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> -	ad_sigma_delta_disable_one(sigma_delta, chan->address);
> =20
>  out_unlock:
>  	sigma_delta->keep_cs_asserted =3D false;
> +	ad_sigma_delta_disable_one(sigma_delta, chan->address);
>  	sigma_delta->bus_locked =3D false;
>  	spi_bus_unlock(sigma_delta->spi->controller);
>  out_release:

LGTM,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks for fixing my patch
Uwe

--zkxugxsjuoggtztf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnw41AACgkQj4D7WH0S
/k7cjQgAkFyXE09pc0rJlnIEdo9YBieeAwnp/9A1lZydf247jTB4uxGAuP3TnYZr
k+/G/mCdEafusCG8otpZln5NDYA1cBQ4R+K2G09l4kKUWEI3YH/d9SeK79+luYQI
NBIi6LWVIhaNJ7ZE5pI56+LYVm8t2/nqheNnYgQ7dKk2MWD9FoVJEVPFAn6RKNum
I6FbBjA86F/taGQ6E/YwpfXFBPxJVOszhytIP3eIRKkEGrJHryQh8SnxRPal5aid
IKTQBw5oiCi/sMZU0GeznuV9OFATrZqaau9u9AQZEovy2zgQTSQhcCteiinUsmFW
BqOs+Hb6RsLdeOnljgstOPbykNycoQ==
=fe6b
-----END PGP SIGNATURE-----

--zkxugxsjuoggtztf--
