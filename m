Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64723182D
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915288; cv=pass; b=Ffag7DLCZSaP79R4a9Xr1XTNOAtB6QPafTZdmtraMlyA3m1bFkhtrfBw2FCcU494GvJKHcAz8I52cKu45ts4v8fnSBaE+2KEQaUO+i5FXCKSDDKe40DAyn8hC/uGXcQp1sRXgTSM+6/ButjaHFyVpmIFf3CIa8xWzNbKWpCSDBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915288; c=relaxed/simple;
	bh=R1YF+J8AAnhG8MJmuIKJ7+VkdhBmKeB7irsDbb8coF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baCn7FHV/BWa9H+/zRzbEt/49AAzLXRjI6xrlHwC+ZuLkb2FTDz+zX0QJRqeO3jJ31ET6wXEG8lurgRZ5Yj+iDS7e3wDr6Lx+yB/1+HE2xYRlmWFY0TcdwFT85VsbejYAQWI/eoE+9bfMqygWLwdE1yayS80zHzlptZJEDa5wc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc1KPwXD; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc1KPwXD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso36197695e9.2
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 10:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777915286; cv=none;
        d=google.com; s=arc-20240605;
        b=aL7jkhY4oOR/7wKH0EwdGHCkMBmPegm94WmuDiKX2FrPl7qCxLB91BAvFidj1nKuzF
         P9b+dwLFOT32y+7sDll2mKhnW/vfDXy2p0Rk85QxNAGJSB3YuiA2gY3WFtoPEAdA/k7S
         opzDjJII59G7B+E0PNbZZwXW0sMYws3+xJ1k+br/WpiqKWtcjCsxeFGraSrSZt9if646
         fOx0sAlOWKPrA0Tg39z81wkI9F18RXH8Gyr6MdNVHBg9Z3DJQWb58Dm3lY+6Nf9nnUV4
         4vmdI4YkDOPbxEaIl95phPZxxo+e0ZOzWmNYLHTOZoO+iHt7XvcNEv+/9f4ykci1BPBn
         kiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7DgWWBkDrHYOZdQTqLg9fJ9ZJacXeXoIWQf4YRL801o=;
        fh=Ky7V9PVh2ylWDqHV2YTsOxA69jwLQeSH9mGdAeaPNMU=;
        b=fyxBOqxQv4U0H+9MAtjt+s6qb2mzQF3eT/7kPWOCpXLH9aJTlmAUkBfhDpYgQ/zmm6
         YyhHjhRu2QcfQ1tV8NVZNpLnZNXS0uigJN/Gks4rtCPrTGqhg/NNeFkkSddZgriKY+hx
         8581zJqIBxH8TA23rbfpzYa+gMhw8j9dCG0PUTMECzhSbJME+wGLMwMYuTKVy5eJI8n3
         Ufkk7RJ5r2EcEDfwGc6voVlyzdxFbLACZrNoWQVFvtK/tFU16t+WpIt12DVKx3mtGj5e
         Tw+HQnszvI2HHnvbgauXCccjmB8QtOAB5PZVZemKQV1e4kfChtsfVKF+88ZPyiaFWKNU
         dJvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777915286; x=1778520086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DgWWBkDrHYOZdQTqLg9fJ9ZJacXeXoIWQf4YRL801o=;
        b=Kc1KPwXD9H5rpbNZssRzB9a9fGZlHRZ87bEnAOJm5wI/cBCOELrIUAj+Udtwd+FeYa
         +rvRNe0K/gfHNtPP8gkUaShBSRznhEnT3/1cuR56CxnTLitNDH208bNyt92CyV5KTU5g
         Z/ClHVxiygqy0SuffOaMdMMG4lK+UTW0vtpzhyipCp5YrnDVOSeVvzayBs4s/0Vu/Ieq
         8LBoQM2PaNtCdPJ0GQnl3XHLk3DCQMlmOuJqhN5LwSAwQLLN8DEpWMyS0ikJhzPfUmp5
         7slCrMskmuT/2vDsw3tDnmaTUmhLEWoEe4Thajo0qt3SqcRFuEuGxUydnbPIOdHflgk6
         OYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915286; x=1778520086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DgWWBkDrHYOZdQTqLg9fJ9ZJacXeXoIWQf4YRL801o=;
        b=Sx268l+66qTPopOCGZluxHZnkpbly0cRNl2nownA9TVM8aGUf1LiqJ/hxbHixvX753
         VDd+4v/Qu3xB6DUEhoy5yIVsArEbTEYrjAsQ9vY4xQNbxuOYPrhoxKea6xkosIEpEJQw
         sizwOJVyPLpGOuCC6kd4FzLd9GsaD4ou/X113HPQtXPfk/Jmc/QaerCxWKSSiJF2SlrT
         LLGf5F44vQkRnReDC4fWS7udhLgcCA4D2F6ELAxyoryDqSvMbbW9/ktOz/5096nqC8I6
         2jtMl26Go7vBnJvloQmYprdiz+Fv1eGsNLnVAC5fDFWfnwsfMV/uzl5qorfbE3Olun1H
         gX3w==
X-Forwarded-Encrypted: i=1; AFNElJ/OtGgBuAJ69X3hxHsIcPbpFkveqqH+Nqrjv+kCLGl8z9qvx6D0GqNg/remuVc11GufgfjsRCv5Si0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdo3FJbLPXBdw7QWlxj2RvmxdmqRPEzA6SCXx/ubH98lohmTU
	YpY3u5toS8Yi07L0fc0lredNVdkXPKIvtpaJ6hUOBij+4iPM3SKydH+5HydF35qkdWlpZlVvHpK
	GoChCog0iPWi3jyiwAy+AN88pRvukzWU=
X-Gm-Gg: AeBDievlsPrYpyxMbt7UXfArhnzoG3G7N3RnB6l/aGDgIYoIrYHM9w+CcwdgKleZK9I
	YGTDoh09pi26iw7tv2BnWkkR/AZFPekv3uNNKn4CgVRFGh6Ow4I/57q3/AivOF4VwEFK5EV71im
	efkUftLs11e8KuZwAMekb8hfz3J86dLViDDlUdaOHEn9/5yM/sxzLgPicCSbs+hPIeQKAZD5nhZ
	Mur8W4rNZ/7D4bgVDcYVVDUFHR0KoRWTIxCJ0B2LKeFNgTJzpcrYcHIzjbyZgAn2VCTrKR0LGFV
	oapd22ViMZcHbXf/Lk0J1XxXqWizSbChdSrnZRbomnuawxf3JMyFMoBf9NDAj97uOquvr0eCWO9
	cuqKiWdA0XlUYSfAY31qdgWw2oLMDUJ3uipnudmbgo6XxYTmoIFF/Y+K0SdPlYmX4QOte5gkj1k
	rEB12A2NjbI4gmvF7PnWxjtrWg+WWsDtTlnnuEkL4dkF4LeNEFYw==
X-Received: by 2002:a05:600c:3e07:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48a98640536mr171247125e9.12.1777915285392; Mon, 04 May 2026
 10:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EC262467CD5E46CA97CF2B2FDCBCA0565C08@qq.com> <20260504174326.353b6f02@jic23-huawei>
In-Reply-To: <20260504174326.353b6f02@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 19:21:14 +0200
X-Gm-Features: AVHnY4LbvtKQiYdxkg4LZrXttAQ8Qlb2DtC7x_nAp6OILPD3QcfXEbxhGQlE6_g
Message-ID: <CALoEA-zCU_Pan1oQNLfno4DbQYFNVkSr_cqf3jBC=MA2qU26ew@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adxl313: fix typos in documentation
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wang Zihan <jiyu03@qq.com>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 May 2026 at 18:43, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat,  2 May 2026 14:07:00 +0800
> Wang Zihan <jiyu03@qq.com> wrote:
>
> > Add missing space in "ADXL313is" and correct "a single types"
> > to "a single type".
> >
> > Signed-off-by: Wang Zihan <jiyu03@qq.com>
> > ---
> >  Documentation/iio/adxl313.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.=
rst
> > index 966e72c01..3662153a6 100644
> > --- a/Documentation/iio/adxl313.rst
> > +++ b/Documentation/iio/adxl313.rst
> > @@ -11,7 +11,7 @@ This driver supports Analog Device's ADXL313 on SPI/I=
2C bus.
> >
> >  * `ADXL313 <https://www.analog.com/ADXL313>`_
> >
> > -The ADXL313is a low noise density, low power, 3-axis accelerometer wit=
h
> > +The ADXL313 is a low noise density, low power, 3-axis accelerometer wi=
th
> >  selectable measurement ranges. The ADXL313 supports the =C2=B10.5 g, =
=C2=B11 g, =C2=B12 g and
> >  =C2=B14 g ranges.
> >
> > @@ -112,7 +112,7 @@ apply the following formula:
> >  Where _offset and _scale are device attributes. If no _offset attribut=
e is
> >  present, simply assume its value is 0.
> >
> > -The ADXL313 driver offers data for a single types of channels, the tab=
le below
> > +The ADXL313 driver offers data for a single type of channels, the tabl=
e below
>
> ooh. That's fun grammar.  Intent is that there are multiple channels of o=
ne type
> but the form used in your corrected version is at best unwieldy given plu=
ral
> singular mix.  "a single type of channel" is fine for instance but this i=
sn't really.

Ah, my bad, the space is fine but reading it a second time - it does seem o=
ff.

--=20
Kind regards

CJD
