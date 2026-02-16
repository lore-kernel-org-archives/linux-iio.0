Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69531D5AD4
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252279; cv=none; b=FN3ECim+isBmuyxlULl13K/3HBy2JR/t5ycGN5VHc7ZL7b1LAsUEVlhvW3KSco+8nZrr0FXLxsvztuVv4tB3UncdAiVFXG95HEeDf3p0lRtneMEwSmCGRwL9XQtlTPpQmKifULBAt+gzLWQmnO2BSLtv0rUVuWwnZfLpx6HvkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252279; c=relaxed/simple;
	bh=oJ3Jb0H6XTUCs8eAjN0EUoQseEV7cBNbePIAUCcnQz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGCjeFpaZSMWOFqWhSGCHU0Zqvx6o/EZya6StHFXLzeY2jKVj6dUd4K08HLQLp6vYizWPu0wWnVzX6fwv8224JUU0kGQ+Jgb39+V/QGIwYSyL79a5l539A1oWZtH8r/6guJBmrdF0MzrbyX0/YQLDx4uRLivcnPBpyXbXQLblRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTb6FrWM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTb6FrWM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so2664335f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 06:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771252275; x=1771857075; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WVzoSyFcsGuxxxP9dZCCrbalL3jLqSKHOVQs8wddW3o=;
        b=fTb6FrWM2osfCysXvIBt1vBoPqSCLhn8c8MUZfl4lmSIl6CFqfAeRQeWf0lDW+HQby
         izMrT8Sy9ptCBwio1W0lOJd0ttQCSejZbEeYDLKnxcW/eookXlL1U5pah6b8lOaMd2mS
         Ylqclsxz5cQjhrbtKsFkjJYDYNzAC8J4og1+KsF987qW+WF68GPAulw5fgoQmdHNMInS
         HHTz51iI+rnM0kpS7ha/zMoxv7U2qdMIYjoQY59+4x8cbEVG7zBvAXc6iv32WkC71aWL
         /VO8XiWxWfb3w9EwZmblt5KLsy5p7eZ3poTAwYgQsnevsmUKtSaT2OnntcXLZlXLuqhc
         qtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771252275; x=1771857075;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVzoSyFcsGuxxxP9dZCCrbalL3jLqSKHOVQs8wddW3o=;
        b=g3LsaxBzivKm3Zz/6jacT7GADa8Qy92T09S3q8eC81QFqTvm+GCZf+rwElwN3qpLhY
         zA8JHIxdNsaqEjXU0MaWz9hnQwOx7LzN0m7OwTa3qphavr5xoa+W7l7FKSlxcRVgSo9U
         v+xavsvQscSPhsO0wvuYtQYXRcGeFbyME/gYtFWvbV6pPcQGfYfq2XwWvf4TNI+5Ltf7
         AhVy9459VDtATR1ImypPmLpkpVIM0I1ALyxEW5rKOY1FWRSbc8ZayrkwnGHQ68o6TqTt
         q3VYuA8jXo8J+H/CnWINv7oEuOrUCtu7/OcgfPgfacVGoQ3JQMYH5WGJrCR2bi1cgfKw
         JCYA==
X-Forwarded-Encrypted: i=1; AJvYcCXtdCazqlI/ywQOcETTyRtTb4k6w4gikSxIpAaXQDKxQLndJfjpwpQt89xI8Z33BW/Om11GdWE/nX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8g3T88RYuMgAxA+t51k6PT7VDvhLmduksQEJHYS4zsV8Urca
	QJ54sVpUbNVDMnObkIp8B7kjTkxVmWbzONSJyTAJW7sMrZw57Oob8Yes
X-Gm-Gg: AZuq6aJ8MNfvZCBjkDuSnVmTz3Qp8FPwQFlCDkhQb+ZC/Sf/GN6ZYK++ruL/q0WysU1
	BHWoTd8mJzn80P/M0GQrFZW/ANi0etVwHfKM6IAqSHgqT59VtxCYH7MJaFNudq8iLej/8nl3s/K
	gGFYaFu415KMqIzw7dghWOv5e0258ypJAVnXDLCjw6URl4t3ZTLskpvV2G3vXzubKuDFezAITQR
	B//FV1GMk0KZnDDIX48dWnOgl5yof2pFklCToAiPoPQ5ExbHdHA2FxEI0SUpkOPADOrT9udt2GS
	tGcDzJiBSY1Mud1kEzsOBCTRR+uDdJlFk5vASo+S2R45pl7QWfjOPxvz69p7xgusGv6ww5N88hU
	VPrDBmBYdCaP++i8xwoer/vc4sOtj1JV9z11GuOuqn0Xz31wMiQkPFmKtNk1nPELAGrTLvHym8Q
	m86OGxeAoPSu3ZVWUS0PD00RsIqstSeaI=
X-Received: by 2002:a05:6000:1aca:b0:437:75c1:5797 with SMTP id ffacd0b85a97d-437978cccfdmr19128938f8f.14.1771252274995;
        Mon, 16 Feb 2026 06:31:14 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad112bsm27780377f8f.36.2026.02.16.06.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:31:14 -0800 (PST)
Message-ID: <525a30ed9127b689549bfaedc086638e2e3b5670.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Date: Mon, 16 Feb 2026 14:31:57 +0000
In-Reply-To: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-16 at 09:14 +0100, Andy Shevchenko wrote:
> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

LGTM. Just one minor "complain". Anyways:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/buffer/kfifo_buf.c=C2=A0=C2=A0=C2=A0=C2=A0 | 29 +++++++=
++++++----------------
> =C2=A0drivers/iio/industrialio-trigger.c | 24 ++++++++++--------------
> =C2=A02 files changed, 23 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_bu=
f.c
> index 38034c8bcc04..a126cc05fb38 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -224,9 +224,9 @@ void iio_kfifo_free(struct iio_buffer *r)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(iio_kfifo_free);
> =C2=A0
> -static void devm_iio_kfifo_release(struct device *dev, void *res)
> +static void devm_iio_kfifo_release(void *r)
> =C2=A0{
> -	iio_kfifo_free(*(struct iio_buffer **)res);
> +	iio_kfifo_free(r);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -234,23 +234,20 @@ static void devm_iio_kfifo_release(struct device *d=
ev, void *res)
> =C2=A0 * @dev:		Device to allocate kfifo buffer for
> =C2=A0 *
> =C2=A0 * RETURNS:
> - * Pointer to allocated iio_buffer on success, NULL on failure.
> + * Pointer to allocated iio_buffer on success, error pointer on failure.
> =C2=A0 */
> =C2=A0static struct iio_buffer *devm_iio_kfifo_allocate(struct device *de=
v)
> =C2=A0{
> -	struct iio_buffer **ptr, *r;
> -
> -	ptr =3D devres_alloc(devm_iio_kfifo_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> +	struct iio_buffer *r;
> +	int ret;
> =C2=A0
> =C2=A0	r =3D iio_kfifo_allocate();
> -	if (r) {
> -		*ptr =3D r;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> -	}
> +	if (!r)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D devm_add_action_or_reset(dev, devm_iio_kfifo_release, r);
> +	if (ret)
> +		return ERR_PTR(ret);
> =C2=A0
> =C2=A0	return r;
> =C2=A0}
> @@ -275,8 +272,8 @@ int devm_iio_kfifo_buffer_setup_ext(struct device *de=
v,
> =C2=A0	struct iio_buffer *buffer;
> =C2=A0
> =C2=A0	buffer =3D devm_iio_kfifo_allocate(dev);
> -	if (!buffer)
> -		return -ENOMEM;
> +	if (IS_ERR(buffer))
> +		return PTR_ERR(buffer);

Subtle change that could have been mentioned in the commit message.=20


- Nuno S=C3=A1
