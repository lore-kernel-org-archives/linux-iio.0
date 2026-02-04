Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CC41C2F6
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221457; cv=none; b=fXC1QK30Zgc7HvdIm3Jy5QpKnKFM+Qy4uPNb4h4uLMpoCZSg6tVQGRme0UfUewLat3O8noelLhP/gOU5cAe50N1gTTctxFWMj+vFJcuMHbnbfgtU3iyLQHIgtCMKV7BPY2gygHuTu3Vg1jlBtdjbRb4+cihk5ToIXYnlZxkpgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221457; c=relaxed/simple;
	bh=4E1jH7wOwRsAxSfEB1aLRRNC3xEDX0UlJw3aUJFDyj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkD6egfZA8tRWOWxSXGn/z1N37SOgUBSuynkS6g4KrbQavwEWXgNSY1TbpbSqxEP55f9QLIS6LFf7JYrlIyS9Bla2tJa8rPbAcFvzKhPbIrXmP70xoT5ix81u702VzbNnwlNQjNuZwhSzz1SicwnINS9Kxl593H5NIkT1lTKy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSFz9wGu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSFz9wGu"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4805ef35864so62205185e9.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770221455; x=1770826255; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0zp6ukmR5KrJWp6xEwH+jtTQlqHxCZ+qzDHuKO7DipM=;
        b=jSFz9wGuk90pcsb/O3xYUeHhjgpDirrIQd8XShawYoSAmrJO10KuO+vHGLF0+EKdLi
         DRBwVqorZSqEcK/FS0TAn6aTcJ3/d0dVkpZXlyLmku1EFCvEeGNOzGRS2ZhxKzbJiuVF
         e+m3dNY8MTGe7y+DYDNEqwiQrVvo7UBmCaBBCVMEfMgTiq8CSnSEiT32XXMSLgpyLuc8
         DU/cyRbDvCVi+uvBNHbgfjzmPNQNq4fyXjRQey49kkn7NX/hAuILUt+yhUsDZktdnW7b
         7XuV+YaODfpZp10PioxobEC5Bq3FB5oq0pg29+FJ1/7Wo+wF89zqNu22oVvGlvkTHIHh
         o9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770221455; x=1770826255;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zp6ukmR5KrJWp6xEwH+jtTQlqHxCZ+qzDHuKO7DipM=;
        b=jd6Q2Uq/BZrawBGQSqozfwt7+9YOH4ZnhccFhXz4EJBAsi1pEKIh44nP10Xuz/u4ig
         Tc8WSpLbd6GCyio+UW6Bt5TLwk42JJ190iISfTk8X1rVARJU4lDKaESWREsOrnon9Y3w
         nyuPMudcVDni+1S5CIkWEV3Z9fqDM7+TC2ugx8HxvOv20609gBK+8j4pDPaDYOFnn+im
         0V4P+vTC7Lyhqx0eOcx7dlN7XEeoXBZOQ7E/JQ3CFlbg3gY6hD6jUZrmGqDur2TEG1cj
         QuHuMqxj2w0dncivnoc5NvQlZ0nP61eV/CxYJTZcawilkA9oIb4Wy7ZqrXvuw8ilhRkD
         AvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/HWU74VGm4KYjG0W6wW6elPxE32I0+S6ybBmv4I3cCZnNroe+havtQwpC2WqqGNT2Ra8RddSXMXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wuwUJtsahCjiytx4XKo/s/eIzwbd0A92jnQuUlJ5K4gFN8ED
	Vmj7ZFoDro97YDOb3K8WeSBFK2i3IUb4az9/JHoJsS7sUzPRX6S/q2Cq
X-Gm-Gg: AZuq6aIcPvu9+pe/8IS1OKoLGeZkDDJHgBS1YFywrm/WVY8K4Bbu1G5N6aQRj9yyCpK
	hPNr1eaiUkv0E9qHTYpISbg/ZhcNBmYeBhPkNMgryVm5h3V6TEIu83UjcoLwGllwsqts2Z7qIsj
	gwSD4DZKZcnYoTWz9cxaxXWvRq3jUPfEcpR859HsG+5Rz1LYiHt3IgtPY/+QYkAik1Tiwiz5AnI
	H9WYsk7XupDKhowKJacu9rdJaqlf2rH3LqHtzIVTqMgTAoP/z/SXmg7VVyEk/YiFZImlv9QJLxg
	RDBk/CbrtvZGh8B2LIk4v+v2/aowVTTxf23j2puKDHhxorZHkHQMOKXPlfPpDhGvO+dGTzWlkhE
	R4PhTpTarQBZzSaxj/9cyD/GbaeN4Kb0NLVQ56jH2x0r47emfLtaPDA3GeRl0aXSawS5rHwtp7H
	imrkaao6oiquWKNaR0Wq8=
X-Received: by 2002:a05:600c:8b8a:b0:480:68ed:1e70 with SMTP id 5b1f17b1804b1-4830e99d515mr43578965e9.35.1770221454940;
        Wed, 04 Feb 2026 08:10:54 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805faf7sm7225027f8f.30.2026.02.04.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:10:54 -0800 (PST)
Message-ID: <4eacb9b5e846b74df5ebb02f1c77135fb1b2fa0f.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7768-1: prevent one-shot mode with
 wideband filter
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 	linux-kernel@vger.kernel.org
Cc: Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Date: Wed, 04 Feb 2026 16:11:37 +0000
In-Reply-To: <fc00e0592c79bd301cc29dc36731241ecadb9f53.1769889074.git.Jonathan.Santos@analog.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
	 <fc00e0592c79bd301cc29dc36731241ecadb9f53.1769889074.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-01-31 at 22:35 -0300, Jonathan Santos wrote:
> The AD7768-1 datasheet specifies that the wideband low ripple FIR filter
> is only available in continuous conversion mode and should not be used
> with one-shot mode to avoid malfunction and incorrect data.
>=20
> Add filter type checks in ad7768_scan_direct() to skip one-shot mode
> switching when wideband filter is configured.
>=20
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7768-1.c | 25 +++++++++++++++----------
> =C2=A01 file changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 8d39b71703ae..374614ea97ac 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -463,14 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio=
_dev)
> =C2=A0	struct ad7768_state *st =3D iio_priv(indio_dev);
> =C2=A0	int readval, ret;
> =C2=A0
> -	ret =3D ad7768_set_mode(st, AD7768_ONE_SHOT);
> -	if (ret < 0)
> -		return ret;
> +	/* Wideband filter is not available in One-Shot conversion mode */
> +	if (st->filter_type !=3D AD7768_FILTER_WIDEBAND) {
> +		ret =3D ad7768_set_mode(st, AD7768_ONE_SHOT);
> +		if (ret < 0)
> +			return ret;
> =C2=A0
> -	/* One-shot mode requires a SYNC pulse to generate a new sample */
> -	ret =3D ad7768_send_sync_pulse(st);
> -	if (ret)
> -		return ret;
> +		/* One-shot mode requires a SYNC pulse to generate a new sample */
> +		ret =3D ad7768_send_sync_pulse(st);
> +		if (ret)
> +			return ret;
> +	}
> =C2=A0
> =C2=A0	reinit_completion(&st->completion);
> =C2=A0
> @@ -496,9 +499,11 @@ static int ad7768_scan_direct(struct iio_dev *indio_=
dev)
> =C2=A0	 * Any SPI configuration of the AD7768-1 can only be
> =C2=A0	 * performed in continuous conversion mode.
> =C2=A0	 */
> -	ret =3D ad7768_set_mode(st, AD7768_CONTINUOUS);
> -	if (ret < 0)
> -		return ret;
> +	if (st->filter_type !=3D AD7768_FILTER_WIDEBAND) {
> +		ret =3D ad7768_set_mode(st, AD7768_CONTINUOUS);
> +		if (ret < 0)
> +			return ret;
> +	}


So the idea is to still have continuous mode running and get the latest sam=
ple after
we do reinit_completion()? If that's the case, why do we have the one shot =
logic? Does
it bring that much added value? Asking because I'm just wondering we could =
just let
it in continuous mode all the time.

This also sounds like a fix so maybe a Fixes tag?

- Nuno S=C3=A1
