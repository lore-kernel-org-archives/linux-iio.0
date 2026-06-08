Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE2322768
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949947; cv=none; b=Nv8KaY2XrCvw5QXe6oZ12qFWoAs9KNiuudMgn9VnP0GMndujaKnMSMZbFogElV0aUHp161wzTdyOQLf09f8jA7kg08sR9zYZHIYRgJ7JbiA51kJ+Dz+5z+4LnbUKf4TX1sLsozbfPDIOEC0OQD8FbuBRA05P7UqDv9dzVsOrJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949947; c=relaxed/simple;
	bh=c6LhB50xzTUNM67LpJOLAQIsNPeE/Mn8reenaq+1+g4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDfSc/xrOf8Xo8lo0asLNyXEDADSx+2W1oXSjefrywUPQeb2fGHWVjgeM/EATyg13lGbfOGwCOxv18Xyq7QCAvK4QF++YeEEvHmApBtNyUgKOls5sb3IKUc9yA874MGfC6YAVtMSVxZYFDaAASq8EQACSJX5VWDmmZt33Bsx7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3O6MtKe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3O6MtKe"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so40043435e9.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780949943; x=1781554743; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eKc1RLhWdFzWQ4b3KniR44zhLEyDJi6XrNMBugE7zEg=;
        b=O3O6MtKeLHexvHm3F2c9fDIXf04fOxLh8rM+xeOieMjRFlALWx89AL79IGb186MSFp
         odLbmrfV9bDrRRn1WnChnV+rjAnZN7GU6GvFwtxx6RTznEoaKppI6sHQJJoInssqEI5t
         ERUPIRIWw2zm7ftgu+Od4OxUU/qQE0nfSAIXgIlXfIA/xY/W2xgX8pQdrDarDVUP68Q0
         y6X/5dyy+xoxm6eAuuyTtvDCy1ePWylaKR+72/fU+KG7bfEH/ZwbQSbfj1+kVLBeM3o7
         yS+K5zcpEgU2bCVqVVplDDNGuHYZuWX9+fxfaTaLgc6WahIDL00qxBk8Zi78mK3c1gQn
         x46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949943; x=1781554743;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKc1RLhWdFzWQ4b3KniR44zhLEyDJi6XrNMBugE7zEg=;
        b=b2F3pNrCITerOQ1eu+hua0Nivv4XMHbadB++3MrAcoErP8w6/jFPbJAEpspUVZmV8d
         t9lEVhKWGK6VnP2otAR+a3P/OvapJZHV0ruS/OQGzsUWecpIwB+YWaRrmlbOXBnUj77k
         aa77B8/sf6Dld2TXFtWKIC3TqtKikecSTCFsImhNFu92+7cnrBBJsnDXXmb5XhV+kf0E
         mAn49PEYyl0Nhlb3LRXvePxtC1MSR1MqCGPL2kZ1DTPu77IO9t9DrD4LbymvKsTmPotu
         GyiAbBL4rYz5CHy4jAZnZQ8nJNd9e/6WXffQLUKHvXNztUTfoIKNqMn6v+feABh6LRlo
         VvMg==
X-Forwarded-Encrypted: i=1; AFNElJ8TUIeYEetxZlD7YwJ5UsQDUy0Q/xUCtwuQ2od7CU/a4VuiE5Aufpj/Evtyi0GpUFMdOLFRyo3/OeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+ylmgHDWfKnw258ak08ig+cI9lEDNoXHE5044K1pGDMrA91u
	VWjzcQ3I272twgRzqRYqgxA6J/DaUP+XgBoZ0SBLmgtJoVWUmzQaRd+Lk9mAjA==
X-Gm-Gg: Acq92OGWvnBEgNE07WrTGqcYhvkufhoHiohCkY/kRr9SuE8QQhUAYfCZvq3xqAU3BKm
	LkyF7npSL25iHJCtONh8zOkNoArALIum8HKYmsU1U/NDGusTjaRPDzDFtfuJuPzMlndlVQh/SdV
	q57HLxDcnXz9HxOZDzRRA423sRIw8xJ3ZViXQLjyfWvypS7Z1uvYKdCca6CzNNG3ucUJtrc4QAx
	qHGVz55PciS0EZRJWsAJdogZDxGgP+WV1qg88ay6Q/J0dt+rLW3x3T2ARf61Hes0WCNXKBA2zqr
	/oje3KexLbx2+4wimZeKPVhlFXs4NInZx+OQfaBKjIu5fNwsfpq4RRjGnmip4UlJ9zYgKzwlkdL
	ftSIbUxwOQ/HtAaZoo69H2dCaRusnaoSBwKbnvGVNPSXP5OCgQb87gABCWkel08/GOhYmFAoIZA
	CnmkGgDY+Au+mlEPpZDJyk1WqrfPguEJDBjDlIut4O9nG2KgBD8WkXSuU8OUTB5HzU20PrNbw0S
	fH17uwzr8dkAPEFy14BvMA=
X-Received: by 2002:a05:600c:5246:b0:490:b55c:cec3 with SMTP id 5b1f17b1804b1-490c25d4c13mr281403645e9.12.1780949942907;
        Mon, 08 Jun 2026 13:19:02 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm452015575e9.14.2026.06.08.13.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:19:02 -0700 (PDT)
Message-ID: <645b6be8c47fe772902aa7b004701f977a0b6aa6.camel@gmail.com>
Subject: Re: [PATCH v2] iio: imu: bmi323: remove unnecessary cast in
 watermark limit
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>, jagathjog1996@gmail.com, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 08 Jun 2026 21:20:09 +0100
In-Reply-To: <20260608121558.85429-1-dennylin0707@gmail.com>
References: <20260608121558.85429-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 12:15 +0000, Hungyu Lin wrote:
> Remove the explicit u32 cast in the watermark limit calculation.
>=20
> The BMI323_FIFO_FULL_IN_FRAMES macro can be used directly with
> min() without triggering type issues.
>=20
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v2:
> - Drop the unnecessary cast instead of using min_t().
> - Follow reviewer feedback from David Laight and Andy Shevchenko.
>=20
> =C2=A0drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c
> b/drivers/iio/imu/bmi323/bmi323_core.c
> index f3d499423399..72955a697a93 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -1128,7 +1128,7 @@ static int bmi323_set_watermark(struct iio_dev *ind=
io_dev,
> unsigned int val)
> =C2=A0{
> =C2=A0	struct bmi323_data *data =3D iio_priv(indio_dev);
> =C2=A0
> -	val =3D min(val, (u32)BMI323_FIFO_FULL_IN_FRAMES);
> +	val =3D min(val, BMI323_FIFO_FULL_IN_FRAMES);
> =C2=A0
> =C2=A0	guard(mutex)(&data->mutex);
> =C2=A0	data->watermark =3D val;
