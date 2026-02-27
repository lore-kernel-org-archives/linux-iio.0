Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97903E9F93
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208809; cv=none; b=pdrPCm2xboAqZUJobpGyAT0ZjzC+Q8Sq5BUYR4MslWI6FUFfP6h0eg02XIaKNgU/ajTOgeNWNZCearppvwuC/thKvp73NylMNSN0l5sUFY8Ar5tOPAUYXETVmxz/lM2cfyjZsWupyGHyzEIGEkX0C0oz6u9kLJQvlU6mrpHDnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208809; c=relaxed/simple;
	bh=bKatHkwULPGDsVsrKowe/tlLr8JOra2a/NwDBt4lxhM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L6fFrMiwXLrS+L8w5h+Ykw5KT77f6IXwvz40XfIKxSmcZyjeBnDE5ie6jy2rSnhPZ09ZWAPqbJy6XkeFICZvRVHwgSLBiozo0L8DE1MG0SjJrBfWIbSPt9fs0iYdGXc2ZEm7WUaToOVsqGNg7nu+KK9FpuvnX43mWAxt+EVGUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIiW6yxs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIiW6yxs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so14881125e9.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772208806; x=1772813606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oia6BuKQyrXeIBJn5Pnqfg7ijhLfp+J8Ra1hfCfQB4Y=;
        b=XIiW6yxsU2wqQLC2TAhZophx1ruoJPrz8QEKzK5lxsJpqFn/Nduaf2FhkSid+RilY/
         pLdCjrZCHQ9Mun606yeL4mOIypUnukGRTki4YRtRbXClT0Pr8uDrQ6enAl85cQctPUf+
         Q7M7KTHgppXhkRmXcMQq5u9k78cvSyxKxm3yLVjqod+KY24MIBaIST+2xMD/kaBw3MJ6
         qOxE8sJ2VWFLI04NRcmLHCivhlnjwCmcUjZUPveyo/fwfViMKkoL0ZbHXfTqanKS1+Fj
         6R5Y4VlC8rfPDFHEX6NGctQJ8PsYdjIWkHlmtZzM/af+CPGFl7rzUB7+TIVVRNvYTpQj
         gcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208806; x=1772813606;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oia6BuKQyrXeIBJn5Pnqfg7ijhLfp+J8Ra1hfCfQB4Y=;
        b=BsMIxS1/scQacEr+227O2s1CIrrPUGmzlMsZhg/uRqG415N3KICsgN5rz2Y1lRqQg0
         7aQfVPhmUsMSuDCKJQTt3R000iWloCVOR7Q7OOlQQ2fjtwKJsH8m04Y3T+UiUs6WF9DY
         Hp1348fEgiEzc9DX8qBOM9cjpFCu3kBGrnaxLHVKgeDumAsBtboPt4WmnEmmzoy6+0wM
         aADEJ75j0/cHHNzepm01StYVzxp4iYRODTfQ0pgLPGjywqmBnKN60rZrgAL8Ozl8gETu
         l/ttnZWJNJ2gLnFZX2CFVzRw8TLdmfrcddNNHFVsr3+QEbgPUk2OdnFX4AlF6v4VqYXX
         Y/mw==
X-Forwarded-Encrypted: i=1; AJvYcCUXKkRR7NmMxzU+YbXzAoYoyOsaZHxSgcQMwSi/QVBkGCQ8T5AYVrGTiVMiH8ja/E/SAM87U9yoDfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxEoB67jVDVAvDd94c4wGea7yhEBUiD9YhaTwwx59Qx7fDkfK
	trUjZG7GfISoKC3zKhiIKNa2BOS4jx5n2G+XJph8C4rF5OzN39pBXKX2
X-Gm-Gg: ATEYQzyakD7WqSmH+qkVnTvYxP/wzLgHWL8Fnobn5WAk6MFpkFEclI5sZrRwlFQglz/
	732brU0p21yZa5rqQFw6unHF6928psMzK7CgHaSl9AJLuMA7w2Fsb2ywP8QTMG1HJYAB7PN2h52
	8yiafmZA1kFelEXchSUfJbIr2jR5/XLCCxmZEkpJeTiSn9i5RfC4lk6QWJb05vhZJBPp5X876A4
	xYLQsfgIwBWhMeKfi+3HS2IKnhA3gtebKUgRpERL/VHENGASOCG2DE+xaPg1/LjMgFug8N0UOdd
	dP25XNBffa8mhVnYTxbX90vuuP1gfaccyKjlU8oTyN81IPKnwGLEMj+4XW7StjFHegUBPET5HM6
	dXydOV1j+FaYtp14CPidlxr7fXRAlN+g1582gUgHaRxzmUUcxMu5QnxKTKsi8IO8Jt6oVnJO4Pm
	5p+pj/RUY4q1MIVj5q5Bv0fwLsqaABmq+UbWF+LnysoA==
X-Received: by 2002:a05:600c:1d12:b0:480:32da:f338 with SMTP id 5b1f17b1804b1-483c9bc0429mr51659645e9.14.1772208806151;
        Fri, 27 Feb 2026 08:13:26 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb2c5a8sm95379255e9.0.2026.02.27.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:13:25 -0800 (PST)
Message-ID: <778d2f20a786985ee3bc465e33d7706c1e051748.camel@gmail.com>
Subject: Re: [PATCH] iio: frequency: admv1013: fix NULL pointer dereference
 on str
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Feb 2026 16:14:10 +0000
In-Reply-To: <20260227131631.62303-1-antoniu.miclaus@analog.com>
References: <20260227131631.62303-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-27 at 15:16 +0200, Antoniu Miclaus wrote:
> When device_property_read_string() fails, str is left uninitialized
> but the code falls through to strcmp(str, ...), dereferencing a garbage
> pointer. Replace manual read/strcmp with device_property_match_string()
> which handles the missing property case internally.
>=20
> Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013"=
)
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Semantically it is a bit odd to use device_property_match_string() given it=
's for arrays.
But it allows for some code simplification so why not?! And we can always s=
ee it as
an array of 1 element :)

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog>

> =C2=A0drivers/iio/frequency/admv1013.c | 23 +++++------------------
> =C2=A01 file changed, 5 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/adm=
v1013.c
> index 9202443ef445..a1f88138939d 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -515,34 +515,21 @@ static void admv1013_powerdown(void *data)
> =C2=A0static int admv1013_properties_parse(struct admv1013_state *st)
> =C2=A0{
> =C2=A0	int ret;
> -	const char *str;
> =C2=A0	struct device *dev =3D &st->spi->dev;
> =C2=A0
> =C2=A0	st->det_en =3D device_property_read_bool(dev, "adi,detector-enable=
");
> =C2=A0
> -	ret =3D device_property_read_string(dev, "adi,input-mode", &str);
> -	if (ret)
> -		st->input_mode =3D ADMV1013_IQ_MODE;
> -
> -	if (!strcmp(str, "iq"))
> -		st->input_mode =3D ADMV1013_IQ_MODE;
> -	else if (!strcmp(str, "if"))
> +	if (device_property_match_string(dev, "adi,input-mode", "if") >=3D 0)
> =C2=A0		st->input_mode =3D ADMV1013_IF_MODE;
> =C2=A0	else
> -		return -EINVAL;
> -
> -	ret =3D device_property_read_string(dev, "adi,quad-se-mode", &str);
> -	if (ret)
> -		st->quad_se_mode =3D ADMV1013_SE_MODE_DIFF;
> +		st->input_mode =3D ADMV1013_IQ_MODE;
> =C2=A0
> -	if (!strcmp(str, "diff"))
> -		st->quad_se_mode =3D ADMV1013_SE_MODE_DIFF;
> -	else if (!strcmp(str, "se-pos"))
> +	if (device_property_match_string(dev, "adi,quad-se-mode", "se-pos") >=
=3D 0)
> =C2=A0		st->quad_se_mode =3D ADMV1013_SE_MODE_POS;
> -	else if (!strcmp(str, "se-neg"))
> +	else if (device_property_match_string(dev, "adi,quad-se-mode", "se-neg"=
) >=3D 0)
> =C2=A0		st->quad_se_mode =3D ADMV1013_SE_MODE_NEG;
> =C2=A0	else
> -		return -EINVAL;
> +		st->quad_se_mode =3D ADMV1013_SE_MODE_DIFF;
> =C2=A0
> =C2=A0	ret =3D devm_regulator_bulk_get_enable(dev,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(admv1013_vcc_regs),
