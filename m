Received: from mail-ed2-f27.google.com (mail-ed2-f27.google.com [74.125.228.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA524D37BA
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644510; cv=pass; b=Sk1V6hmTRPfgY6U7zque3+WOxZiFrWKYJFlRv306OcPlnXnP/irm/U2wRglxeDakdAxq9Nb6ysgfyyiaOnb6dyicPtXg1R4leDjiY6alRf1kAS+FtD7RfpzOYzZCRciTQo8qwWkTfiyhhZTi9o/sXlMGYQ8/3RpvQca9tAdCVYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644510; c=relaxed/simple;
	bh=VC3uqTx64qtizJvIeWHTm2N1VvFon3rcWBswhTm6g3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meQ+XlHboFejEUAnY4jPDtQ7mzV3rNRVRNVSp/WEzaQqICuYfUa4Og0Mv2Eaa6E8mZobFS7GeYoujPZ8HZY7qNPo/WNjCnPblZTaLw0Xun7Ualhr8FiaG031aCGdOMuJKdGTQr8dmnIohFdfNqv+RUo6nU9v1sHySbsFeI9OaFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=ZIDyc13x; arc=pass smtp.client-ip=74.125.228.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="ZIDyc13x"
Received: by mail-ed2-f27.google.com with SMTP id 4fb4d7f45d1cf-6aa135d6e97so1135224a12.2
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 04:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789644505; cv=none;
        d=google.com; s=arc-20260327;
        b=jZJqLk4SWjcmsXl4ZOli6gBlXP2TqAFi0R/GlscGyqQStTHC588O4jTzF/59+SmYz0
         ewb6x+aMk2a/O7RPEjLARznjTqxcx7+bgibSUSWMqr3qdsA8GG49zszzoOp6C2h3BSPH
         yP+AzLdCp0aJ7Lq/t7ga9fZ/rPADnjmcPYyGQUYktW9aZca+VFhFgSadeP1wo1a/8pZ3
         Yn5Zgretxd7U7IigTaEuPAXF4+EbyMKgDfu/wrprrDrdhteGJFuHjjrm71yTJ1Eq3RBH
         LymdHGL9+rVUGFDYb3ZbiAIf1rY9pi/rcXA3FShKi1TUYceZF07KK0m/ND+onelIc/ou
         0NXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=elvP5BwKT6RoQAB5diX5NiXHvp+jdzVM7rvzbyMAHDE=;
        fh=FxQb9OQTwKRucvzypvAuh78KphPfSO3VZeYwPkXE/lQ=;
        b=Wg03C/QmEATBwSH+sgOfIFoBnldebF76cPj8xNMBDVUQ0cGxzt1PgjsuNbNPBz6XtZ
         Kw6U1pO8CK/Dm7TVmjt4TSm0PrXBPRHXlCf0ufVMB8/ASn0znv3+CXBKJ2p3gyAEUIcr
         yeEwvq9U9c9RwfbFT5SHgYpips5fuHUg0OuDAcj61Iu4avJPtXx0YhxUY6yjk7cjCaQF
         uTDCsQb6TOiDUl6oguacRATxiljAn8haWBy68bRM1vEUom/P7Ac6RRUSuX8gVUr9hfiC
         l92HsB91/CTtrjxmE/U8Fu+wjjgVXdtrXoawM75nYKHPxYxkSsV1N0RIKam5+bN6zcml
         LSvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1789644505; x=1790249305; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elvP5BwKT6RoQAB5diX5NiXHvp+jdzVM7rvzbyMAHDE=;
        b=ZIDyc13xhufzMYtbzy8CQz71ncNfsI2Ff3kMgccc2uUZpYyCZLm2vGb0tHaNnIW2WR
         yeRDq5gR5HFmFho0Bc95D1R6qfp5CRhoqWrlY3Qpa42vRzwxAoLlfHcq+cJblH3pBkjx
         M1O8myOLAjlwopcaYylY5jG78kngZD0QI5tJ3jbsMZTbj3uIAI2bdg2U9RyjR/FiqcLI
         GoOasFHEgtroR7HLwvtZt0O4Vn0i++HTkcX4xe1wt/EGF2gR2Cm4sOfUcwNAbebKA7BY
         BpFRBa8F/QJSiX4saVDJYaAME0LtURY1OPbcmYMhK0kRuK3B6cdnX4YP9CrheT/4HVBL
         BF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644505; x=1790249305;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=elvP5BwKT6RoQAB5diX5NiXHvp+jdzVM7rvzbyMAHDE=;
        b=IgM6qGTKaMgpNveKX0kgvFmizoKnSGfHy3V8AHLdGY8weO4DsbPWMljBK7TldwbNbd
         nBJ4y0PZEiVcLSWNWVq342idEySJHuJ5iGBVfMgNy3Vnk2koQet5RYn9QasizoMVJHS+
         Lstyb07vANnPC0K1TCuXGl6Xd4k19EpvZGSCwstpata+kE3Bkw1URmNBpkdwXFEaiYIv
         ITq72V7EciswRnz2YDjAvWvvkwhuipGilcfH+JXOEwCQcJOdL37Tuo59g42yvQVL4w1U
         bO0oMNZwffjqbJ2Efu7fdtOPcgV/8QCMrWi6bf8LLPjQ5ICaHSdVJ/9+Dz1nmlyq9E7i
         eO9g==
X-Forwarded-Encrypted: i=1; AKwUvBymuhsTU/L/VH8Q68i9TEkdE9FEw41HstsD0GQ/QZZDcCWNH76U8N6jZD3oG3toSVtJRI7VHtR+TgU=@vger.kernel.org
X-Gm-Message-State: AFuF++kGp9GnHb7D7N0YuQA7enfURzHEwHbIf8GKLJuF+etTp8Dp5o0V
	10lit2UVn/tTxHvCuhsaQ1wEZvq75Lc62fHZ5a/5P/MIVOvCoLkkfUknxEZ0O/hu4fgyoUTSOwU
	7ERlxlu0kSjIBFhjcmGK7ircmRfwp7dJqoUW6XS9iKFDzc0dsbr/6GA==
X-Gm-Gg: AYBFou2YkqkX7K//eU4lupQJFjY42gMwpXECplhgazmtJOrNXKC26X/OnuD8MckLmAB
	AcGsM2BqZWGl7YxI3tP4vlbqBo/w9cmD3DYwpyR3JhqAPp6jFOuQyOzBkZh7kTjD7ouTSynyONA
	9fXm82hmi6MK+8URqGv+YcM3/ilmQ5lzTatz0KTc+2XC1ecSYp5HhQwPU1s7rVDd1GJoyLlT9QL
	V7ZJDLLq9nk8VYatFUxu38TDb7MuJm08TU4SsFn0GTO//QSAeLnUMdEfYDvwMikSiXm+GVD4hWI
	sUNcqrOc2vQF7bytecWZGeqXjbLGg6r6sGBdKzkLhBrKr/NgY3Fx
X-Received: by 2002:a17:907:3e82:b0:c29:f5d8:9c6c with SMTP id
 a640c23a62f3a-c29f5d89e31mr218839466b.27.1789644505308; Thu, 17 Sep 2026
 04:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917110121.631587-1-salah.triki@gmail.com>
In-Reply-To: <20260917110121.631587-1-salah.triki@gmail.com>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 17 Sep 2026 13:27:48 +0200
X-Gm-Features: AcwNN1UNrU3oHsY-myWs_zEnpWdpopKMRos-hB6K_a7zw0ZjQEus5Qd7uu-JNfw
Message-ID: <CAKv63utdoBrCFiw8vkGsMhY9PrWX0DWdxqP5szvTGpdmfSQh5A@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90614: Fix dual channel probe
 condition check
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

So this fix is for the MLX90615, which is registered as single channel
operation? Did you test on 90614 as well?

Best regards,
Crt

Crt Mori

Melexis Technologies NV
Transportstraat 1
3980 Tessenderlo

Mobile: +32 492 46 22 15
E-mail: cmo@melexis.com
Website: www.melexis.com

----------------------------------------------------------
The contents of this e-mail are CONFIDENTIAL AND PROPRIETARY. Please
read our disclaimer at http://www.melexis.com/mailpolicy


On Thu, 17 Sept 2026 at 13:01, Salah Triki <salah.triki@gmail.com> wrote:
>
> In mlx90614_probe_num_ir_sensors(), the check on chip_info->dual_channel
> is inverted.
>
> Currently, if dual_channel is true (MLX90614), the function returns 0
> immediately without checking op_eeprom_config1. This forces all MLX90614
> devices to be registered as single sensor (num_channels = 2), making the
> second object temperature channel inaccessible.
>
> Conversely, if dual_channel is false (MLX90615), the function skips the
> early return and performs an unnecessary SMBus read on EEPROM CONFIG1 even
> though MLX90615 does not support dual channel operation.
>
> Fix this by negating the condition so that single-channel chips return
> early with 0, while dual-channel capable chips (MLX90614) proceed to read
> the EEPROM configuration register to detect whether 1 or 2 object channels
> are present.
>
> Fixes: 3d5ead238bc8 ("iio: mlx90614: Factor our register IO and constants into model specific descriptor")
> Assisted-by: LLM
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/temperature/mlx90614.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 27d6ab5f5d7a..4f79da1f905e 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -565,7 +565,7 @@ static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
>         const struct mlx_chip_info *chip_info = data->chip_info;
>         s32 ret;
>
> -       if (chip_info->dual_channel)
> +       if (!chip_info->dual_channel)
>                 return 0;
>
>         ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
> --
> 2.43.0
>
