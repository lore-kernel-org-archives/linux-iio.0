Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906B3D6CB9
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395554; cv=pass; b=Xgyb2y+1n4a+3nSbt4OB+HSrfKzjxkBk9+ugZDyd2vrhrMv91KYO2fKiE+3bwmL3Tr+Tb6k7fSn/NI58RarYZIpbWGK1UniWc/6RxESSXed8kDv4foCSo9yOcyQ7la3319m2ipi07FDjwLyg/1NfTQErKmONv+r8y4h2oZ7dmL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395554; c=relaxed/simple;
	bh=3B3t6ptcOYLW8i15s/yZOStzPGXLE8YErZRu0mWiPrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIY6bPJlITMrxPoHBGStj3k0pInbEopzTF/G61dA0VRIQOcVJG7NG2UB5Hiwe2JOe5OxHCjN9W61t1vPrgrZakQ49C7ZnmSGvBhsn+pcxF6/a3PbUjLTm8qd+vWExRJKi7qr+/oEfPr4sR0sm3yUOtfVD3jQlyPslaseEXMlZ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyUwTwsC; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyUwTwsC"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137dd5161feso20261c88.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 03:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780395552; cv=none;
        d=google.com; s=arc-20240605;
        b=hVqMRa92x6Z/FcOMrCsuxirf5kgvn8Kf7br0qyDZksGGgErkWKoX6dt+0hR4JFQr+A
         qXIWgyzwjBt4T/m/jcEZbV8BKJPxlYKw1hjcLLuZvWUIkDgxReHSY0Tqfjf0asxMltP4
         BDB2i7tSHiM1Beyxpf4phpyqYG+El3VNZvbDw3Y1xhtwLECmQ13+k3d4CFM1GF3Upi9H
         8ZI5k8C/xa3F9bV4DAOOCJJlpd+dHdv22Tt2OYyeYa1noFlrHwkzm/NBQ6QphAVzj+o+
         sbouW74IeaUHzo1OOfC5+p+QMYcaHB81xCiPdNsEhvRq9/6vg3479O0rReelIkJ6Tq3r
         Fj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
        fh=W1101tHSwI1B0WIUC62b5eqTpevxFB98h8hMB8o+ZyQ=;
        b=bUvLaMSnBliob7HVLaj2cDsvzvkE3p+YL7B9HGoNBiPd9mkK7oIkDbjxZEC+JRh9Ru
         5gkDOg8cuU/7ZUOn88FlKBMOTyhsulc9cvOLPH85JHHLcEkRJz/b7QIFVEAVZeLFqgvo
         kJUZSsGnfCihqBnMvkBJ8dgLRUJlQYhvy3ri97ukEEYl2ypgrpIOgXHG8hoVFdlRml+Z
         QBL6gysP5tqH09UQSNv85rjwFT8kAkFiYyDwM1YjWPhEl7zQhsz8wntPi+PNa/+snd9R
         ZOOKwpA86GKTpEaJRZwqSlzA54xwrdhCkywFrTLwp5Nf2cxalZricfoPmi9f6svW9VW4
         M22w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780395552; x=1781000352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
        b=AyUwTwsCHthjP6xub1kYtxw/LI3RE35opRdOgCOuDfMit/QnFgIeUTShTZZIpe7lBF
         qRQWCXiVBDsalYrzAVptKLel2m0TfNtWh7rlB/0YfAa0JxZpFTBMXmCqjgmyp6XYUC2h
         QjJ6fthhtIhDtpCkrreEsYzND+1a/XPf++2mHd6EuNSDjeEjI7/TXRDIJKyO1emHRWQd
         zZIsyiRQ76oy+WEZjmkjDAgD1tRWUqjXZbd+Fs1Ujp7llqA6OFqX3OzWrDW1ZFoisIF0
         yd6l2WV2jaXKT5SEz13bXNf+ZxlWNte7M/NODRmIIqX/pt8TiBLOFbw5Wg3xJht71mBr
         S/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395552; x=1781000352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
        b=QDp2p+KUKes+iT/oc4DqArBo28Gzcv1Pd9cE5/Zc5Ca8B2adW7e2B1hYO2l4UzTc6N
         oDJh9w12gPgMPPa1X/PckQsxKREcFGvLUbsunw/03TqBX0IznWM450bzHfnx5iPS9jaI
         0AXpfcwZp8NPO/hm+KRSZg6cbNhaHFazdgOPbXPXzuEd2Am1Dw/iHB57da2Zezl4qGAO
         szyxwPyUUUYeA13qsKPDh/C/e8iV1WwFaQ4Nq74DqAZ5kLXTf0aKBz4yezj9bjF9itqK
         xOvqaj6j5u9vvdSrp4SP8clblVqMfpCIrk0z4LJxxxtzwhto34FvC4GjWBpn6AGJYrAt
         3m+A==
X-Forwarded-Encrypted: i=1; AFNElJ9OBVk0k6iDRriyVN5nNnhZPMp+5k59yp1BzE5Nyor+lsuWzcG5qHAJYhb5wwrIxmGdR0dlvl+wJ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VOQHBpF2vsx1ED4DY7gw5bTOw7uqa7DAH3PMIh14SpBPbSrp
	PYEaQyVDcGlxqt6a8LEpvhzjhPvJ81CUpavdGzuFNITpqlTYQgNejz3PUCILgawwrfl3hkfXpm7
	r+hZNTVmc6UFlAeryZmXPawJUQHTbVAc=
X-Gm-Gg: Acq92OF/31UVQhqpY2JcdBsi5ihW6uoKW1FwInumEPh0Y03XDtQ/p36bOwluKfPW6GQ
	rq+Tg1TPmkQ4A2FjgI/31+33MjPqShCIVCQ6LP5iZ570J57eVda3y5pA9D2rXzUDs5WVrZ655v/
	ZdGthAu99j54p9BILI4lwmWw56hQn92WqD2ObXJsOWa9Yjbfg4Dzi8LOAP8y1djDymNo/r3hsOS
	UY2zHKaBdX16ooOKL/toHBj0elLBfJnMKfrp25wF7G7+lY2ONuyurghgVYYQg1twc4kGfsM/yAu
	RzdJ3GpItRIpAu2q5BA=
X-Received: by 2002:a05:7300:6427:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-304fa67ee46mr6895369eec.19.1780395552116; Tue, 02 Jun 2026
 03:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-9-clamor95@gmail.com>
 <ah6PxFtoJUWkd79P@ashevche-desk.local>
In-Reply-To: <ah6PxFtoJUWkd79P@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 13:19:00 +0300
X-Gm-Features: AVHnY4KArfWMr0jnHoh9vtR5UqW4K7jQ3330Z8FTAYXvtwkDG99A7ncLjymdKC8
Message-ID: <CAPVz0n0P7Jk17cM2M1zuHZfySo2=Uibr5izwKU2tqiBpBcg0FQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] video: backlight: lm3533_bl: Improve linear
 sysfs logic
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:09=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Jun 01, 2026 at 06:18:28PM +0300, Svyatoslav Ryhel wrote:
> > Simplify the sysfs logic of the linear property by switching to a macro
> > and a ternary operator.
>
> ...
>
> >       if (kstrtoul(buf, 0, &linear))
> >               return -EINVAL;
>
> Besides _assign_bits() in the below, side note here to unshadow error cod=
es:
>
>         ret =3D kstrtoul(buf, 0, &linear);
>         if (ret)
>                 return ret;
>
> (obviously in a separate change).

Won't happen in this patches.

>
> ...
>
> >       ret =3D regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBAN=
K_AB_BCONF,
> > -                              mask, val);
> > +                              CTRLBANK_AB_BCONF_MODE(id),
> > +                              linear ? CTRLBANK_AB_BCONF_MODE(id) : 0)=
;
> >       if (ret)
> >               return ret;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
