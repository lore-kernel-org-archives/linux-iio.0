Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC52773F7
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001226; cv=none; b=eGoWiKx8sEysOyq8QxxPqcCpUTno4xP/nNhhIMHVosplw/J/Lb72MV2LxRL3U0BjPUt0WTQlDNXbniTUhgsTL9hW8dfXljUa13ZrChT7OzFKqgJq5Kw49vP7nmEJoBsZOF2SN8b737M9pAhJnu78vBNalEGX9A+bJpTOz2nCHVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001226; c=relaxed/simple;
	bh=TEDdPlaEpnW7WaNXhFAsw4ldmvR29Oedig7dlA21uFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YDGIswb5eyOzBED+AkdyodWaEWGUvkTD+J4N4AJ584GDeibufSubHKpFKO2uDfhl/TeOcjLxgBCpJ5P5Y5xs6qimeTiPC57JIQJCPjNnjNZ7AS8fC2Ya0SnEy0ODXt6D8oqIoPygPnx1xIZnp2q71rJLOS4OpU23Zoeka8m53YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5gX8JfU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5gX8JfU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48379a42f76so40275e9.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771001214; x=1771606014; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TuMWoNcNJvwge2oM1K5CKUPuWI2oL9A2iyuZQ+8bSTk=;
        b=V5gX8JfUqgRJdyMSycwBm4aAcYbm5s0oPdlrIdS5PNuj7zhK1EBMZYGwkph4LsFmrU
         RqlbI7kXjpu5WLSrFCLAy3n4lo2CH36/AHPdowI9Ti9d1N2y/T1jOxoM/R6ssvLEMycv
         dGGZLS3h5mLFZwvk3JsqVHaGAAkcNaPOjVHIlEqnonR7emyqrEfwgPtLnd/Wv1mNg4yE
         CLUx+X7UeUEK1rU/YX4RCA4kbv1RblShxLlEo/hMtgXpOpdQskbEz0OuqHeSHXogJLDE
         N/D7DJGxpWcZcb7apkcKay19jHHaQmsG099xpYqBzVatTX1W6FhBj2b1s2FZUe94VKF1
         ySSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771001214; x=1771606014;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuMWoNcNJvwge2oM1K5CKUPuWI2oL9A2iyuZQ+8bSTk=;
        b=nVFKajV5bxD5aZIK6B8WzbgAVcxFDpRHqdyQk6m2u486Pn0XrT6QMj2VXKJcfsgJA1
         YBydvoRaFuLPugMgVMR8bEECvINB3BvcPI62e8uIIpzYe474e86EgopY/bn5edxPMcIA
         DJjPvHWQht4HVlL/XT1vVCQFp+SiraiKGrU7G6BjtBELnNFxZ+nqigHcGRxejvbExn2e
         5vl4Dy2XC0fYUg/Zv2BWGnmVA+v5CJ8ZGdZtJ2kC+BGCkaIYRp9qrql8gtUq4HZVQRoV
         HUy3LgbNQHcU78QZodORvtrImJacbaa7GDxT3OVWJkP6Tzpbh+aQW4SqRiPa1XcqDdiI
         arDw==
X-Forwarded-Encrypted: i=1; AJvYcCWnpSy4tU0WHHrqzkeQ7l67YxnUBPXUVvA9ZtddJykVMvVGyWBGdWoSaV9yb0ZR6x/vIh29bdeDQi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIwBDWkOITG+lU1K1w0Ad0Qk7Zz0ci81eHSqTHLc5yTOiB2qG
	bgxfR+QWZBMj87YjgEq2MdOxOETaRzeiO3tV5xJ7QurjJ5CDKcaTjJFr/WsMUhtE
X-Gm-Gg: AZuq6aLHWxX22gKn0923jCzGiAVDjKJO5t0mhTB/KrjfnxCGExCIgVl0zaTaV5pJiXl
	PTTpoeJyWkp8NoUUVAIYsdFLHhlYMN61VWUrxhiv9UX7DcQN89nq676YkYU+XYGM9Z2kf3J2uo3
	qy3VrHNrWHracKfQyY3dXlkxpe0NOhu0fOgYPVKIksMlJN9HgbD6orK/NyV+6UuL1ovHJLFRqjM
	yEkyjTcR+rM9+YyYjFXpsfXsSF05qh0udY/l3vVB25iZMvi/glkdkXZzXl8+klTHosdEYsn+HbS
	CC0CPOEFiXMT54X5rs3giiNHqKp6NylXouzqRnNL/Z5qGF1ZRfP2F/lb9Jto2vyySfDyybl3GMc
	qqhMpomNdnCwrhYE5qTCF6UyWCj0HAG2V3E+4A2jU7bxZ2awKqA814gZ/uLF80gLcChoQzTXw1l
	K6W5aQhQ4iHtdoSRg7lp4oMd6wKmpvuuU=
X-Received: by 2002:a05:600c:4753:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-48373a15e72mr43771295e9.5.1771001214115;
        Fri, 13 Feb 2026 08:46:54 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a34d66sm24238785e9.20.2026.02.13.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:46:53 -0800 (PST)
Message-ID: <61edeb390553a8e7419a8cce6d92af53123b9960.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7768-1: Fix ERR_PTR dereference in
 ad7768_fill_scale_tbl
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>, Jonathan Santos <Jonathan.Santos@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 13 Feb 2026 16:47:36 +0000
In-Reply-To: <20260213031207.21291-1-ethantidmore06@gmail.com>
References: <20260213031207.21291-1-ethantidmore06@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-12 at 21:12 -0600, Ethan Tidmore wrote:
> The function iio_get_current_scan_type() can return ERR_PTR, the return
> value scan_type is not checked for this and immediately dereferenced
> which can cause a kernel panic.
>=20
> Add check for IS_ERR() and return early to avoid crash.
>=20
> Fixes: ff085189cb17 ("iio: adc: ad7768-1: add support for ADAQ776x-1 ADC =
Family")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
> =C2=A0drivers/iio/adc/ad7768-1.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index fcd8aea7152e..f45a09e39367 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -541,6 +541,11 @@ static void ad7768_fill_scale_tbl(struct iio_dev *de=
v)
> =C2=A0	u64 tmp2;
> =C2=A0
> =C2=A0	scan_type =3D iio_get_current_scan_type(dev, &dev->channels[0]);
> +	if (IS_ERR(scan_type)) {
> +		dev_err(&st->spi->dev, "Failed to get scan type.\n");
> +		return;
> +	}
> +

With the above, it could make sense to change the function to propagate the=
 error back...

- Nuno S=C3=A1

> =C2=A0	if (scan_type->sign =3D=3D 's')
> =C2=A0		val2 =3D scan_type->realbits - 1;
> =C2=A0	else
