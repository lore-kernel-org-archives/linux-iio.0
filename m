Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510D330328
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479066; cv=none; b=u7jQyAnv990JAzFo2S+kKPYS2JVabjWjaphTFCwvwL0K/JM8mcgbeGwc4enGhm2tAkFUX/i/LNUqnqEqKXMB1v1FmP9x8BMbho1buTmDHdjV/pNbmBbvenmJ+bkrluB7jNIX8XXH4QyizsRSGauT6vwR631x5qqsjtyN67BceFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479066; c=relaxed/simple;
	bh=qO6C8J/cP3Edpt5eGYC5iQ7/Ig+WQOUCtEeRe9W+vPg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=lJil0el4JUVTq4IFymKNimTSxDlvimE1suk/sBv8f5UoaPFe1/fepC826YVzP784MlQKM88NnxBU9z5tz7ixN564Vpmp27KFUYEdruyxolJUoJ2an/YxqXvSJg7QDwvLaUTsYkqax19SAEaYgurTmjjImZaP+KvoYSa7javN/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMJXQ0vh; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMJXQ0vh"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-491f5e6d564so122157b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 19:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479064; x=1784083864; darn=vger.kernel.org;
        h=references:to:from:subject:in-reply-to:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydSmVmC82mYVeellbIXszlpaXPXi1+VQo6qFCl16G64=;
        b=dMJXQ0vh8F0ICmaCp85RCpWUX3GR9+ymMoY/KGz4I5Ytl2y1Xk4Msu+OtzbZ1rtBQK
         0ZeibbvAp1tl+T0/ZtwXrWZufQ5oacRdA95a/5E5zJAkWPm8CCFE4geGtRNk77ANjfB5
         s92Q5Jk6bUIdTPKUhUD1hbhro80GmRGs0XYvNi4DcyrxJhzbd3lgp+e4fa4ORWFtwUL/
         41vcHE2DAtWXaWgjGg5hMX5pJvZjWUWP8PsqRG5y5Ulvf2TC9ahDVoj/o8cDPuO/5EM1
         Ke8+7ZvuPI4oflhCbyJiSG+aGhMUgXHNEh5sXTHpZdoU4etyZem7vKpzn3kfUcz3jHNb
         9rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479064; x=1784083864;
        h=references:to:from:subject:in-reply-to:cc:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydSmVmC82mYVeellbIXszlpaXPXi1+VQo6qFCl16G64=;
        b=tM9JtuXUd3EQjd7N70bIlyt+pjC13tIQNBvacKsN1t8h9ae1Trjnq0HleaxrIqHNQs
         TLGAZ9yyxFac2yfSlXQCkVO1oM8WA2o+QANrMjpmiji+tI8ikYdYr6dfScik5MFE3Ifw
         xOBLucdUFt9swwT5fyZz6udoG9lMwAiuudtGnbsU+S/5vlqyThbXG0VAyjkeO5kJuF2R
         m3KIzGQKWGFqsliLaXZfPd5eRUuB/EuoKTcB60IkTmCnpaAHxJuOpbIj7aHBeo9DxTct
         d3QUmOwIXler+peVjrdqmzxC5rPzlsgOwfaNf9/S7+/4VA9twTYoqo5bphaeOpStBG39
         5IIw==
X-Forwarded-Encrypted: i=1; AFNElJ84bULAuhy6ivu3G3xPgglmpOrW84tUYAg/VJerjK+Ektdoahl0h/b3kcDXJqJJKfkSg4lPonAdwEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU65bzP5PqZWI24AwOvhceJH4daFMTWnuDLMIYu9EWDB5KlLqr
	TRsSH+q4tGpahAn4Pi8XwyKDF4WU15UWNmA0YZDpcI0QePICjmxdbXRm
X-Gm-Gg: AfdE7cnpmLsGYTGjdT2hsxLoD+IgEsg+LZqBhrfO7+YDz9xpVhlVXCva2Tfr5ooDeA8
	/m2lmDDIjtwu0Kpit+4UB3CqD7aM09zw5aeQ30/WO+nACwdEAFyPNHamwJiu14NfGs8AcuGqiYk
	5aPE5l4pCpkrEzhiLC8KEBgcSsqtS1M9n0JQ11uakk4FOrHHAoQ125cRLE2dGm5moEKpHWIla1f
	/Kqc5UU6gc6DRRoVnPIKXx4UeYQFafjXjpsHAf2T+EyZ0GXkbwpLdYhpfqK1FxZSG178X1R+DJM
	LIlRSvBKjtWFzhLfRveRMJ4nKRGUPp3oyHeALYJJs5RQszq+bvoGCiL9iqc5DlncqJE+mtx+1Hp
	Tk0HB7FHat0cvUdO1V1W5Hw4c149BlCLhXwbrT37f6ke6gUBsPAxC5Z1npA6l5sJOGeZgR5sS4C
	oNVEarFcIWX/DeK+ayVm6sUOfM2fYI/VMb6d0E2TKNeGCowePlzw==
X-Received: by 2002:a05:6820:f006:b0:696:8e8b:20be with SMTP id 006d021491bc7-6a36d867d85mr499136eaf.10.1783479063723;
        Tue, 07 Jul 2026 19:51:03 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a3b0d60sm1028494eaf.0.2026.07.07.19.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 19:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e79ff914378473eb197fd41eb4f25e9588fd977c3e909f4864c620dc1c71;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 07 Jul 2026 21:50:58 -0500
Message-Id: <DJSUK8KQCYNB.1G3P4VAWBFBD1@gmail.com>
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>
In-Reply-To: <20260708013002.1377142-1-caio.groff@usp.br>
Subject: Re: [PATCH] iio: accel: adxl372: replace manual bitfield ops with
 FIELD_GET()
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Caio Groff" <caio.groff@usp.br>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <antoniu.miclaus@analog.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
 <andy@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708013002.1377142-1-caio.groff@usp.br>

--e79ff914378473eb197fd41eb4f25e9588fd977c3e909f4864c620dc1c71
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 7, 2026 at 8:29 PM CDT
Caio Groff <caio.groff@usp.br> wrote:

> From: Caio Groff <caio.groff@usp.br>
>
> Replace manual bit shifting and masking with FIELD_GET()
> macros for clarity and consistency with kernel coding style.
>
> Signed-off-by: Caio Groff <caio.groff@usp.br>
> ---
>  drivers/iio/accel/adxl372.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index e375d068a3f5..fb985bfeb19f 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -150,6 +150,11 @@
>  #define ADXL372_Y_AXIS_EN(x)			((x) & BIT(1))
>  #define ADXL372_Z_AXIS_EN(x)			((x) & BIT(2))
> =20
> +/* ADXL372_TIME_INACT */
> +#define ADXL372_TIME_INACT_MASK_H  GENMASK(15, 8)
> +#define ADXL372_TIME_INACT_MASK_L  GENMASK(7, 0)
> +
> +
>  /*
>   * At +/- 200g with 12-bit resolution, scale is computed as:
>   * (200 + 200) * 9.81 / (2^12 - 1) =3D 0.958241
> @@ -577,9 +582,8 @@ static int adxl372_set_inactivity_time_ms(struct adxl=
372_state *st,
>  		scale_factor =3D st->chip_info->inact_time_scale_low_ms;
> =20
>  	res =3D DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
> -	reg_val_h =3D (res >> 8) & 0xFF;
> -	reg_val_l =3D res & 0xFF;
> -
> +	reg_val_h =3D FIELD_GET(ADXL372_TIME_INACT_MASK_H, res);
> +	reg_val_l =3D FIELD_GET(ADXL372_TIME_INACT_MASK_L, res);
+ missing a blank line.
>  	ret =3D regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
>  	if (ret < 0)
>  		return ret;

Regardless,

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

--=20
best regards,
max

--e79ff914378473eb197fd41eb4f25e9588fd977c3e909f4864c620dc1c71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCak27EwAKCRAQghIb0dl/
iTE5AX9EE1vMyrmQ3Qk0peVGiTt4aqOwIxEd+A4OGhUCj/t2GKN0342WCPQP5cZ1
qSZvOY8BfA3ju8gkyqFt1F4yeJ4rjdHQV9wj2kO8QLVs+zKQYBbplOUeMnimzpCP
FwZwLwQc8A==
=mAmG
-----END PGP SIGNATURE-----

--e79ff914378473eb197fd41eb4f25e9588fd977c3e909f4864c620dc1c71--
