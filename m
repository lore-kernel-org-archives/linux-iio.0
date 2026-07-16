Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4341E6BB
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206320; cv=none; b=JDfvuNapsjDnImfHHRfZAKAlr4KjwJHK395S65SOPdrS9qx9an37kVjhQ+eizBo06MwMNJ3V7/YqGS/VcvlabNnzssb88xs/Urw92m6eDNuUHp7JJhtc6U/adlw3CQ4aM/OVWl/0w7JqHchz8Y72GVNk6g7i9KDzhuFXH0n/NjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206320; c=relaxed/simple;
	bh=VR3SMlT8uVOc7go8QC/yrYB5j6aytm6Y0wmDp+cxf5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxxIwb5nWEOywAFIessWJqy2xX2hLKenOktzfkG54/qhtolM6cIM6j4mGRZ67LtNj5HbfJE0lBEIvsjlbmJfCs9PqMTI8PkXkz+YCvz6FyCs0/X6vIr/wznbNabh7VkaLBsXGc4vnnrBduXdugziqDmsdlyGxLiB/M8ixrWLU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYyF6sJw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYyF6sJw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493ec555a26so42980305e9.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784206315; x=1784811115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ul11tJT1l5adysBjwRjDH76SMORtb0GLL1jr99LfX9A=;
        b=eYyF6sJwR2T1ZOWXmAMKBYNKocSe8xYx/SNPd2AjSCoPksd+xQntoAFQP/0qle+8Uv
         duAphG7qnVdIaAFLaVJ2jec7KLuTAVAYU5MKhNDdGDeX4TArvIGIQlvTYA8miD7hWHhY
         gSv8w+5s2yx5RIZOyPPPTBLIxYaYxpdUe1sT3kKG2dTirpepxuAnpd8WSsdEvEUqW03h
         6sAEAIlVr936KLqmcVVaRoVIGkUaIz6CO1+PZeM4xf7WlmlAF4ep1bXVkbnwbsF/4i2l
         7vYGDfOhKAq6MwIKozlvkL3aR/lknnjjjS9vPIDGwfsgOuDBNBXT9LTPqtmCbkGnPIC+
         o1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206315; x=1784811115;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ul11tJT1l5adysBjwRjDH76SMORtb0GLL1jr99LfX9A=;
        b=gynyHTPzvYujbW43FiLKcNR78CxTthXRlLBVf0ZwIzMgU6abNhrsGnD2chTXtXfLVQ
         EkaCyBqUoCO/4f5zgf8EtwDXAvzy9alAemGFbhVRxpvjq/fbKmfl2P1GHIGmrvrU02lR
         VHDVzKRTrVdjABis/yL3qME9TVMVAhwC1wkJlvmEejTHsd6RWDKbrtMmQaTonds9JE5F
         Sy3Hva9qT8H8/Sej7kB3nGZBQqcOERNfzwq+ws7QxJ79YtI2q2ybAeGBVdS0Fmd3ZdpW
         ApdfBtzAvkf2l6xkwrlhi0NVz7aPmcPzvmcuYVjSgmQoYtXQMQcEXx68sWhtluhpBUGY
         Jv2A==
X-Forwarded-Encrypted: i=1; AHgh+RqqfEcZpooqSP7u5keqjzn4AOwYuzO3nvpkZc0phkYcjlRMXvM0JBogZDNkdUrHRWctt2BqcNafJi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeP8rt5wp3wWQ8FcNnI1bPOSDsUGbumRN0vjifz0471+dlF6QD
	AnYVjsSBNnMR1dtdsrGo44usUD1A9J1dNiit6r8Ah1eDOTNPKKOequwy
X-Gm-Gg: AfdE7cl9aR61xC2UM8wPEUQIfZo8h9raPifNQs7SLMV28yp+HzxGr/98jCJtLmU/bjp
	suaCI1zLQpj2oVf91MhJ6QomPUNvgNDb3R6ppLLcs8oiP0yRUk3x3+i0kNSJNXYafO3xaYwnvqh
	uJo4rkzWMDFBZas8ZEVnJ3jzfkManrp8RFq/70ff+YFrHtaETE06ZWhShO7v2/E+b+xs5LE21Zc
	FCUYrQhoDtSnFtHeeMgmCEEYBkA6NhALfNItgcOgTBcZ5snmsG/UV9+4p0SlqAvRG0ahnyjqrP6
	U9Z7mESxfkgAls1jK70vNs2H1OOAwyrXZn9J+AmEYgDzIUenA7dNjzhhKrhfvehDSuyJlgXQoJr
	f391RNpL/7ogaNB4CzWfEjx/1L5fblKWzgXr7YCwQ/atwoUGLBdgO/jy/oQCsBY04kNFvhYJqTf
	V9Zydx2XHG0bG9qn3i0gkTWNTSE105vU9Oh9irqIlyzqQdZXf3xWxaKQaMX/YEn4UU/Wkyv4Tq2
	ZQbnhTVhIv/flSWgzgRJhMSBNZT8YkmxVYjHiSBL8xPWrBrh0mqUtwMxRHxUDrR9nOQBNrbmMnw
	HRyqxNzYEbZNjzC4vSk9p/KnPfdfXqktfYQA+CmnPD0zgBC4lvf4NLOjwK4IA3ggqEGlkk0Fmmu
	xikmIX1QOfDod8C3xudd1Ziw=
X-Received: by 2002:a05:600c:3e0d:b0:493:b499:3ef2 with SMTP id 5b1f17b1804b1-4953c299474mr77446935e9.37.1784206315300;
        Thu, 16 Jul 2026 05:51:55 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e7f7f7sm56488105e9.2.2026.07.16.05.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:51:54 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:51:53 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: =?UTF-8?Q?Vojt=C4=9Bch_Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
 dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: resolver: ad2s1200: use dev_err_probe()
Message-ID: <20260716145153.000003fe@gmail.com>
In-Reply-To: <20260716123100.100394-1-vo.kratky@seznam.cz>
References: <20260716123100.100394-1-vo.kratky@seznam.cz>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2026 14:31:00 +0200
Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz> wrote:

> Use dev_err_probe() instead of dev_err() to simplify the error path
> and cleanly handle deferred probing.
>=20
> Signed-off-by: Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz>
> ---
>  drivers/iio/resolver/ad2s1200.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1=
200.c
> index 55bcbbd4021a..7c7ce0e2f9cc 100644
> --- a/drivers/iio/resolver/ad2s1200.c
> +++ b/drivers/iio/resolver/ad2s1200.c
> @@ -144,16 +144,14 @@ static int ad2s1200_probe(struct spi_device *spi)
> =20
>  	st->sample =3D devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
>  	if (IS_ERR(st->sample)) {
> -		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=3D%ld\n",
> -			PTR_ERR(st->sample));
> -		return PTR_ERR(st->sample);
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->sample),
> +				"Failed to claim SAMPLE gpio\n");

Please align the error message with the parenthesis, i.e.

> +		return dev_err_probe(&spi->dev, PTR_ERR(st->sample),
> +				     "Failed to claim SAMPLE gpio\n");

Same goes for the other change in this patch.

--=20
Kind regards

CJD
