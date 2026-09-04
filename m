Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B93C9898
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506472; cv=none; b=mTucarbbRjo6y1XRoyI7ajOu0GvWirZ3dnZ4yufunbGtc61encAH5GEAl/mgbLGXZI2H8FqhZskWcXWVfSRE8CXwNUea6fmhBoyD0mdL68rJk4LG9FYmSWZ3Jf/FIN6TsZGLWOkT0fJK0HPf/QpwC97ez4gdVi/CfjZZwMaizoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506472; c=relaxed/simple;
	bh=UwLSgQbz7RoEH80f5bvWG4dCeE7RGNOVRopS57wkUnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XjqL8WYTjBVYI44+YLy+tqvMm+DdhlClX6I5zGLJGI9TQR46DDtDzk6yyqbVnJhMG8hzKQnkAyI4rjnr6QtsZML4sb5Tbkb9YNOP675XwJo6nK7FgC7O1VmQvx/qq5lCS0Y9SFdjQI0NmpfsA+5lxTT0gGr3Xp+aPyy8iHDt8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rgfb9tJq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgfb9tJq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a5ded53570so815611a12.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788506468; x=1789111268; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opFmoZ7sP1gwLTl3u0ejO3xLoNddPlcYhTGSYay7Utw=;
        b=Rgfb9tJqwVl2BjZ1c1ZWTAoYrHN3IUo5McdznRNHzQxb71hxuwIp9Q4SR7y71CO0xd
         HPP3UMToXahNjIjblQhowM8bL8/axQVGJrEvcJWlsSW/j0Qg07EPCZ+c06nmuFDnM89K
         LhXJ9AsklM+l8bu00O6TDJaN54dYVT82XVBpY/s20rsRX1SJ8OaHrAldSOT0uQ1m9Z67
         fSBWEwCLg5PCmOmJVjuBIbnxTLRiib76w480laVXsLOS1ktNT+a4lzi+0mSaH9f+qrNZ
         yHvI3SaFMNrCu5KY4ymx9LRTSuazK2nLZO/IJ1mFPBBFoE7bKHyZa6ld9+VEmDi01k+H
         0dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788506468; x=1789111268;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opFmoZ7sP1gwLTl3u0ejO3xLoNddPlcYhTGSYay7Utw=;
        b=HVZXgucWOHTRQ7Emsn63QIpBrF97QfQQuo+dSf89m0Ala0lgIVC3Xj8Wvz2hFHk1z8
         ZJiYBoeo6tCxm0NSovx+Oq8ru79K5SIdp8dTvjgYnbMGvYu1cBdcfgwSCZgjAnJ9jF1B
         IBNNFzT8Zq6oa4ev/a+09tXHuijiYUtYoNZGmVQu+Cs0nw39l8o+HuRI3esIUMYxcWtf
         2vnFukc6PTYfYhj6To0AJ76wUqmbiBhgxRrLioUh7BUjRKpszSgQIjIKJvoJZUxzm/Z3
         ZTsxLNiZ7PNsYcbNad7MpJX662HoCKUkuhKBp5GLjcPYTcxZ6yfKE777FwJKHT404aq1
         gT/A==
X-Forwarded-Encrypted: i=1; AKwUvBwiV5wJOuEhvQjWO71NqSf1pvmMLWjUOnmyuhlt8KdBvLKtgci9Qk97P9VYXwOYHwiTJn99cXcFbAo=@vger.kernel.org
X-Gm-Message-State: AFuF++nDnUc9Xr2r7/80lKzQVI7wp6A0kyNbUT99baydXS5bnU2LFgRV
	UpfZVKjEfpKTXHMiTNi2/WIx1DY8wyqMkFDbKJkK/xhTXpV6eMXLG3RP
X-Gm-Gg: AYBFou0nn7gHoSafGq+K1+ZoGXzm3w5T0zrnX16UeMGKjy9pdxettyRdCmaDRX4rlN/
	xW0iQm6TUzz+UvYkRiNx161tigNkN4Rahj6Mo9OB2iLip12D3BzyNNjbGvdGD8g0tH8X/+9Gc4v
	/9ebV9FJuP7cx4zYo+YtHuOHuJWLpU7ks54UqaJzN20FpitTIgscAwfyIl2LI/sdkHzqQy/Q6L2
	XSMYFC1p9vmctfazW1LDmE+ILj+CaK0Yq33m8uB+6l/o08NclpT85ffda7qkr+tLNbjFThG0M1G
	co/6s7JKSC7499LFJ7/xie1ALVT9DWm2mzC5nQ/clDFfJdxGYnuqloozx7aAv0MAlAjHPOGKQrP
	cRejCBdP1aRRx7tHIK50bfTibrKGTPDDKbu3Ur3QRFsijttF57NMYtNnJFy7vVRfiHL64HAZOS5
	c/686bAVOcTgVotvUDzN3jW5bxzkZm+Lhy858z3Ec=
X-Received: by 2002:a05:6402:46c3:b0:6a7:ee54:f89f with SMTP id 4fb4d7f45d1cf-6a7ee5500d8mr400014a12.35.1788506468052;
        Fri, 04 Sep 2026 00:21:08 -0700 (PDT)
Received: from localhost ([2a02:8071:50c5:5c0::48d4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bf5072sm711137a12.28.2026.09.04.00.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:21:07 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Li Youhong <dayou5941@163.com>, jic23@kernel.org
Cc: maxwell@maxwelld.cc, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, Li Youhong
 <liyouhong@kylinos.cn>
Subject: Re: [PATCH] iio: flow: slf3s: disable regulator if measurement
 restart fails
In-Reply-To: <20260901025010.356735-1-dayou5941@163.com>
References: <20260901025010.356735-1-dayou5941@163.com>
Date: Fri, 04 Sep 2026 09:21:06 +0200
Message-ID: <87ld9hwkgt.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-01 10:50, Li Youhong wrote:

> From: Li Youhong <liyouhong@kylinos.cn>
>
> slf3s_resume() enables the vdd regulator and then starts continuous
> measurement. If slf3s_start_meas() fails, resume returns an error
> while leaving the regulator enabled. Disable vdd on that path so a
> failed resume does not leave the supply on.
>
> Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
>  drivers/iio/flow/slf3s.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
> index dfa7c1409045..9b63ceb3768a 100644
> --- a/drivers/iio/flow/slf3s.c
> +++ b/drivers/iio/flow/slf3s.c
> @@ -487,7 +487,11 @@ static int slf3s_resume(struct device *dev)
>  
>  	fsleep(SLF3S_POWER_UP_DELAY_US);
>  
> -	return slf3s_start_meas(sf, sf->medium);
> +	ret = slf3s_start_meas(sf, sf->medium);
> +	if (ret)
> +		regulator_disable(sf->vdd);
> +
> +	return ret;
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(slf3s_pm_ops, slf3s_suspend, slf3s_resume);
> -- 
> 2.25.1

Fixes the unbalanced regulator refcount across resume retries, as                             described.

Reviewed-by: Wadim Mueller <wafgo01@gmail.com>
