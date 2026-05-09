Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4C39099B
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316320; cv=none; b=LBRAUzgPwRIGiOZ5yMNUTzXchBG1iEl7ZhbHChVxsHoDtmJD0dYDfx+cf/9oVgq+kLNRGCxjE7SojHl/QVSzQo2vWwXjBWKI0V+hHa4yl4Yx/q2JF/2/CA2UYcm4bkRvQx3oUWxdbdjMSFauz2iTLIfeoL2ADf0qHIIxKFRGp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316320; c=relaxed/simple;
	bh=TFa+xEui4mi+TZmuskFzKaQ5HYjVAER89kwrNi7tb1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NjSQiqkNrsR6uVzqNh4sOK1nBI8pb+bU8xMQqgQ8zPjKnWR/rVu/y/qeY70+LkxVO7ch3IpeM5vsnWBTlUVu3u9vafnQyT8IIoJ7oH2RPeHj+f+nD4XLRbqxu0yifict+pqMZJQN1rQHBYDMnLKo3RRgO32Y5QSwl8FuvHqTGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX1YhGFs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX1YhGFs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso25755245e9.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778316317; x=1778921117; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9M25LVxkvy4DTqh7u0Q+7wnu8lKX2GhtudATPtKQPlk=;
        b=DX1YhGFsP4zuLXMtQ13bu4Fz9R6tHhOCXpH23rbPB/bdmzmKOkfDEK/VqkfWIY2foq
         XyUGDuvoB07TlCaKaC+D3aq0Ir2BVOGeCdqGoRwmcMQklZragCTZnnJIW7bslG+UByLo
         73+nzOVhvNY97OVz6QwLlYIO3MBdKLy5vCT1j+buc6ONCCSp818fLL1xR7lrIvv61C9M
         i7ipmfVTPaXWuIm+MomINVal0XoLeVMGMfw9K+HjLZIbmy8SLppU7xaf8+UI9ZQzl3FK
         D0irR3TL45SFKAm73B3SZcf3yp11PsxEJMQs0pkIpXpx7AzGkHdjOL0fMuCsciiBETLs
         /r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778316317; x=1778921117;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9M25LVxkvy4DTqh7u0Q+7wnu8lKX2GhtudATPtKQPlk=;
        b=EyvkWzqtLFEmvF4N6d/imohe87pJOpctDL0Sn0p1Yf+Zlhobme4Sj9u30aFchWFy7g
         gbOWY/qXnzcRCBQs06KZbH1Ey/U4ANSb7MMrNgNnree3LXpd4QRhJI9TRhDY/yaYLJcm
         yrQsfVHEDOjxxvVXQabl161Rd0qQXzpKg7HmcjzC5BaEiX+wgUfGGHqAJGLocTXZ8Eh1
         nd7DwVsJZ6WlkKQMup6n0iEKgY12l+U1wKbeZ01ORc9H4NyqyaZLnTduioF5var7aOai
         Gg+aFbVdjWz7ONkgOatZSS9whHtOFLj7K6A0DPEZ9jWL8wLpyYeZ+lvb7WPxfu0hIdpF
         9b/Q==
X-Gm-Message-State: AOJu0Yx96PWfykxJEFUqsv7fFfSmpR3A9cfpv61ik7p1s/o4L6a+upW+
	J5eNyOiO9px/mWlNYzlCiHUXVtyLRsMysKrhsMQZwns8m6A9ZNqJbzen
X-Gm-Gg: Acq92OHSgzH0EmuDaCbtsAprTfUixhUFcL6uLZel/e+20pHa0fGjn2hiApqmReFGXeu
	n+c0ueBp8aZlTcpVR2bYpEXvV7RXSKDqfTNBrN2l1m+dmRZ7IooWFIRdYhPl4iiPzUyJpdCktge
	0yYguqNgqud2lZZOBQu8LVNLjWCkTVWEsvg5QXt9KeoYkCWQDWa1DMxfP/aVmSv6QONMbG/RnPb
	gHOW+rZL54D9se/ScVhebeLOxueo/dlGzLhBUXJVMbiiMgAcgoSw+Ni6LdN1d5dodyLeSrYNqmo
	+XJ6b/3a2H79F4+g5cbiO/zgjvPBVRFl5nLi+2bvQh0it+tpgAhqGRxu3J+D1RvxQKkRjsFBV0k
	fUsOhCENakYIxlYjL+02IPEqNVoeed9z2aSlf8xg9zYx+U9Eg4kOxBpKF0T5FtcroMai2jqnWoN
	HWrBE9ynv8gLKwBQxGJBqM5Vmv50d82XQ3FWG8wsnGETAvvgJPj773kmntg+Q2NXXuJuO8tB5uU
	g==
X-Received: by 2002:a05:600c:4ec7:b0:48e:51f8:eb37 with SMTP id 5b1f17b1804b1-48e706d8ad9mr26118485e9.25.1778316316665;
        Sat, 09 May 2026 01:45:16 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b00fsm11698603f8f.11.2026.05.09.01.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:45:16 -0700 (PDT)
Message-ID: <6afc2b680efa5a64c59e9f6a65b3b42919cd8688.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: viperboard: Fix error handling in
 vprbrd_iio_read_raw
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Joshua Crofts
	 <joshua.crofts1@gmail.com>, Maxwell Doose <m32285159@gmail.com>
Date: Sat, 09 May 2026 09:46:17 +0100
In-Reply-To: <20260507190751.28352-1-salah.triki@gmail.com>
References: <20260507190751.28352-1-salah.triki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 20:07 +0100, Salah Triki wrote:
> The driver proceeds to the reception phase even if the preceding
> transmission fails.
>=20
> This uses a goto error label for an early bail out and ensures the mutex =
is
> properly unlocked in case of failure.
>=20
> Fixes: ffd8a6e7a778 ("iio: adc: Add viperboard adc driver")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> ---

LGTM (though Andy's comment makes sense):

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v2:
> =C2=A0 - Add "adc" to the patch title.
> =C2=A0 - Move dev_err() out of the mutex critical section.
> =C2=A0 - Include Reviewed-by tags from Joshua and Maxwell.
>=20
> =C2=A0drivers/iio/adc/viperboard_adc.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboar=
d_adc.c
> index 9bb0b83c8f67..f7ce3effd730 100644
> --- a/drivers/iio/adc/viperboard_adc.c
> +++ b/drivers/iio/adc/viperboard_adc.c
> @@ -70,8 +70,10 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev=
,
> =C2=A0			VPRBRD_USB_TYPE_OUT, 0x0000, 0x0000, admsg,
> =C2=A0			sizeof(struct vprbrd_adc_msg), VPRBRD_USB_TIMEOUT_MS);
> =C2=A0		if (ret !=3D sizeof(struct vprbrd_adc_msg)) {
> -			dev_err(&iio_dev->dev, "usb send error on adc read\n");
> =C2=A0			error =3D -EREMOTEIO;
> +			mutex_unlock(&vb->lock);
> +			dev_err(&iio_dev->dev, "usb send error on adc read\n");
> +			goto error;
> =C2=A0		}
> =C2=A0
> =C2=A0		ret =3D usb_control_msg(vb->usb_dev,
