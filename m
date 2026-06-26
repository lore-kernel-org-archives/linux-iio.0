Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B83F58C7
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481162; cv=none; b=p54X3qwOm0WV+0GZnXPrLats3MZtzv20wuGd4OtUyq1y1a5UtNvtIEc9On//QO/KlRP+1oMZ3K+1u59WgvuCYINcO6bf1ArF8gQeMGRqggjKVdGk3ZCFTZZRW2NqvbSbxaIWxhg4Riz9a6O3JmK/skrCrX8mJSxd5uDy7fNgQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481162; c=relaxed/simple;
	bh=8IWGMBNMMaYvrEtzeOyPCy0ciX1dHwS/xUpWBpFHs7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=CTWx6ZK/vr14t8rhuxmQC2m+qrkPki/NMfpNGfkRuWJOjT18iiVBOlqSEdbQvAh7yMPGl/Q7aHrmTFrWBqlMgYxdVzJolJNrv2CyHgPtpTSa8Lwwf5Yr615iAyeBklz9as9nl22wqlpz+igi2/oCRwlj/0c8vyg5ATnybBjTYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyvQoPxa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyvQoPxa"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so9510665e9.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481159; x=1783085959; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=178Ey6oKnQQUab4uHEMxdjvdHtzJxPn/oHknzkZEjfI=;
        b=RyvQoPxaLH4iun2lvEkUBiXqGTKCVdpCMb/IQjZXLaVUSqS2lYbz57n1xT4e3mvjg9
         utTOuz3YjE1JZfoxSfEV4eMGX4mWivd3TaTnptTjcPu16n2XAAMlta9hiFiBDwedU5FA
         2uwAb/rCh8bDx+LNJ+tIA9HX8vnMH2D0h1tkagN+9lBzzfzhUj0ao+qyUqXZ8yFmAQe7
         PYyiBlVXezL7rUC86OBeeR20ihzEGh8GJlMS/AmliE76rITlHATrFbQNQG9pVEXsM1C4
         6gIGh+nxmBL3CTzMElbPIEfmQfmyBaKFY5EQ3TNtm2Dpl0Wk2RFtRUBnVJ4EY0/ThdtW
         aRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481159; x=1783085959;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=178Ey6oKnQQUab4uHEMxdjvdHtzJxPn/oHknzkZEjfI=;
        b=ceel/geJ70/ORAaZTvLONrqRYSXXLUtKUQWZaylOexF949s5WERBaF5H185riSghd2
         yr6Y75cyRm5ksbOm2CIEywJ6E9+yVOYFuDK6dfc9kDx7YOAXMD2VRHtp+m41ecVAh0Ke
         jk98eHkQ5Ncedxw4nWytDg3DAo+i3PaCfvg5xksr6Dj1rZ+DNcVrDUKOV7sw5SWLwvBO
         AG0hEKoNWb4a/dakdUKLS+i4Lc6IPmPga2CUScbqntkkG+u5KJKzhqvzJEL5Z60x8XCq
         tahiuMdM6KCmE4ftEpVncavnr+7zjh5uKLOi8hB76rdS+gPrGy8mDFEqb6G4wjus1uSB
         QM1A==
X-Forwarded-Encrypted: i=1; AFNElJ9auMzxE42i3+8TxCNJgwqrjfa7Qlh8Jnim0BW5ri/hfzvhgtU0OzUXUHb5EYlU+YlDKXlCScgl5RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRliCX2abI/oqXctd4BwT3CmvuuOFk0W4dibZiwg9p7N69SBp7
	L/uZkdlIPw2JNUGZwqXw1TYP/GAuyTggKaGJM4JlLAzNzCyw3gKLocqj8FHdxrze
X-Gm-Gg: AfdE7cl3RwwfLhOrEpROpjuFGprCBL4GhozAjbckoFlGc4pw6APqIeqABBA6OKRAsok
	AOBm+v23Z5vDKX4hx6shL0HA1PixooOgxP7WI0VhcwxgOgL83LZPfjCJaSGN5aKm4T6iJbbVvTc
	quHRKqzYkFetLffY+gsDWXKGyS/XulVabdSAfLBt829pkdbZkMBP3SnmV/geh/nNkw+BP2026Yp
	5pjrFz+RPHCycKSaTLQ/HTJcwF6OvETC3MtcCl9fMz/AiAmlGHesLZdqdww/Ad5JVpdOUxUyIJv
	NVGw22HQ3NNsUU2JHbug5tJJMmJ7kX9kp9jwxX2BEDITQH0VBpM+YVdZ+aojSuXji3UwtfjEVBw
	tKzXZpG9HJGNeKVdXBDwd5E5FLDnx6F3AgkT920ztQX/OBs5F8Ru9971VRjiJ4JJo7Q+3CCfoNs
	2KE51C7k2UkDjAySe1EWR0Mvk=
X-Received: by 2002:a05:600c:3549:b0:492:4363:e7eb with SMTP id 5b1f17b1804b1-492668acc8cmr101181495e9.32.1782481159145;
        Fri, 26 Jun 2026 06:39:19 -0700 (PDT)
Received: from localhost ([2001:4bb8:16f:1117:388:ce2:35e4:fb50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c278ab2sm33706745e9.1.2026.06.26.06.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 06:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 15:39:16 +0200
Message-Id: <DJJ0U2MQA2I9.2UNT5E1OYW733@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH] iio: light: veml6075: fix UV index reported at half
 value
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Shardul Deshpande" <iamsharduld@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260626110400.68885-1-iamsharduld@gmail.com>
In-Reply-To: <20260626110400.68885-1-iamsharduld@gmail.com>

On Fri Jun 26, 2026 at 1:04 PM CEST, Shardul Deshpande wrote:
> veml6075_get_uvi_micro() normalises the UV index for the configured
> integration time by dividing the summed, responsivity-weighted UVA/UVB
> components by the integration-time scale factor relative to the 50 ms
> base case (which is returned undivided).
>
> The supported integration times are 50, 100, 200, 400 and 800 ms, i.e.
> the register field index int_index in 0..4 selects (50 << int_index) ms,
> so the correct scale factor is 2^int_index =3D=3D (1 << int_index).
>
> The code instead divides by (2 << int_index) =3D=3D 2^(int_index + 1), wh=
ich
> is twice the correct value. The reported UV index is therefore half of
> the true value for every integration time except 50 ms (handled as a
> separate case). As the driver powers up with VEML6075_IT_100_MS, the UV
> index is reported at half value out of the box.
>
> Divide by (1 << int_index) instead; this also matches the undivided
> 50 ms case (1 << 0 =3D=3D 1).
>
> Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor d=
river")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
> ---
>  drivers/iio/light/veml6075.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> index 59187244a..af71df69f 100644
> --- a/drivers/iio/light/veml6075.c
> +++ b/drivers/iio/light/veml6075.c
> @@ -244,7 +244,7 @@ static int veml6075_get_uvi_micro(struct veml6075_dat=
a *data, int uva_comp,
>  	case VEML6075_IT_200_MS:
>  	case VEML6075_IT_400_MS:
>  	case VEML6075_IT_800_MS:
> -		return (uvia_micro + uvib_micro) / (2 << int_index);
> +		return (uvia_micro + uvib_micro) / (1 << int_index);
>  	default:
>  		return -EINVAL;
>  	}

Hi Shardul, thank you for your patch.

I agree with your reasoning, but why don't you get rid of the switch
once the operation is the same for all cases?

Best regards,
Javier
