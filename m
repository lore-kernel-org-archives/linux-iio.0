Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC419F13F
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770562162; cv=pass; b=lHd4TvL2o6biStFtlLZH6bqTCZRw/T4rbUJLU+L+shqIe+JIIM363iGn+0/hx6R7vr0zOJxoR7LOk5VRN2J5rlTDJKEWPQe/RwCwX2ZSqsF2kl1aLt9TYHe6ce1hGGp5c5vFxX7GSis5ydjx1Dvt58CPCzwwERqtSPzzuStJ1XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770562162; c=relaxed/simple;
	bh=FmHJHscw4UGRqf6tadsbey53/7alBZ0goPH23uKBsZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYNyKUWE1JXkZfdToyhkgGtrEREDTIWs9j2sJTyWUz9vt3ssP7G0vTi857+2i/6TKk9JHs8j1AVuyfzUUZ+KnUWARgApCYjbryzfaB4+tNXE3CbWHOlK91y+OFGfBH109S4s8QhdWseqELN6mIkm0gDSsEg6FmQJB6VDhd5I4sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+hiCOLF; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+hiCOLF"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b872f1c31f1so429271966b.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 06:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770562161; cv=none;
        d=google.com; s=arc-20240605;
        b=ieshkr4HW0Vq0uRMO83tlbFt9vS1RWAim8L4lb+ARLDmk2j6dCsyt/rOpx9yKIzwF9
         0dxJeXIxWrWzWi/aYF4Qh9OWlWWratJdGLosx9lEu+X76+EB4WMf9arAwSroA018SBi4
         1K+BXrhxfFwRBduxl1INr3nSD+f0CohaGgRrvgfHsYeDgxSLRupfQO9q8FKIcxoMSh0c
         /HwuP1Llhx6lJHMG2xTwZ4t7Bs4ADK0qClxvMVY1oxqbLjWDm7TFR2ki3jZbD7UV5HH1
         UwqNB9CtQSCXhlwAvKx4JRwQDvozlJxWW+B1a0zap3xw/02B8B48tp5JuGMhjBOqubGr
         1ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7QS0VkNqOpSXotrnDMRD5sTIzzQObxdRFOn5/qTfAgQ=;
        fh=oOFZ0ycK9mrGXGtsirg0Zmn0s7zawXi3po+EFbshXRE=;
        b=TJlhd8MwfialRLbQzTVgND3NfGplvHdOhCN3bwK434V3QPcgWyk3yZwIHCL2H56eKM
         XEMG7Tg6y9jU1ASxC8HFPuWjYOEzKzWE4lmvJEXxfbCbWXN8ehJ+kRIvb/RVMM5MJ7b9
         lE0qTSF/tUg+2exLKK61H2Stt8h0l8AZovW36pFhuGT/g0EoxTV4+kwL1b8c62Iu96Ht
         hXgpux9hWhjpCgpUnM+6NnLaSnk/+eixxbPijcya2D884EAKG/MhVnbexVNVrnPgY7au
         5YaKrHYq3F5qyvigmnVSZjxiZL/V8BSTqqpunZw+Sg+FIMO7PWQ8ov3z2N8aB1dUphnU
         g+vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770562161; x=1771166961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QS0VkNqOpSXotrnDMRD5sTIzzQObxdRFOn5/qTfAgQ=;
        b=T+hiCOLFdGVaRU4AS5E60jFWT27jFP/yUq2q3RU/DhEQvXsB1HWbwojWFVn0RONcCp
         NwbnVVVBX6OIIFMZqcOsEw3co9xxpT90WlSLJyxJ3NGMOVB62Enn5j6zCGRusNX412ak
         qABLXe/BFjyrEkc5xm+/zRs8iYkDtx0zzIn/uQwTafbKKEPjfBc4pBHir3EcnyOoQtfB
         mAGmM7X2Uu1yChZkbh8shRxdHkyTzaHe/Z0mWcByCsUY9zTu/SSlPy7RRvApo7i9wzmD
         YqCJaBuJU5kWkPUvv0kUbFIbwU9PenncD04ST7UxABy6dhVB4eaHP83SSZPR1Nic1S7m
         hdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770562161; x=1771166961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QS0VkNqOpSXotrnDMRD5sTIzzQObxdRFOn5/qTfAgQ=;
        b=IDVy2RQLFBd6iQR9JlGrJGm1WHbQMRQBwj6iFyThMGzVSbzZpGeoY8Ik06BI+KdLFS
         KNULFyJ9k8ssY+Ydn5KpwqDIEeKw59tMY0jZRGdOUPGzUT1AtilgCAOqhhk8SpxeVNb7
         c8ek5nr7aYSgGb5N00LZi4aaEuehT6pFwKxTLU8/GiMlNgk/sQKmmD8WOom1H5/L+uap
         ORVdhFQCKF5wtj4SwfE6YVtqtcMuG8n8bZ2LDIqLRNvS8RvE0uxuS3nMsqVPwc7r6teJ
         qtGaU493mHLOo/f0N55Ooc0uYyTAdsoEDEYW6HtxZ9IzDu+cSqszizvT2AKWv0Jh2KlJ
         EsGw==
X-Forwarded-Encrypted: i=1; AJvYcCWULyeh54c2VZMVQzAD3CZ8SymPGvHqAyHbLaJ937fyoQEODkMEkNiaPwneucxGSyjGsSZXz1C25GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXQGnadsdRQYCJcM3QCYjvhrOeRG7MQzOa9oF5GRavTVMR/Xj
	k2vKvxwaWarCqLTrrCbz1AETpx4rTPRNXB44WJnvDFe20GH4tENy/Cxg+SesLGmipoK1877bBT3
	wRTY0ltX78cjtfc8y1CmOG5tZ4uOJOf0=
X-Gm-Gg: AZuq6aJDISLaN/Jkrw7Q5tXZfM1dV8TlxC0IFHe7KTweH0E0CCLSAOK4wyBFGkYmagx
	jonfB31gS8N87M3SgN++d+zNd9+rhGsQqKEEkStZDbDQ2Uhwuti+oxvyIlgpfzMDGw6bO6Szql6
	WbK5sFHA9wuDwy5AO1z/gANHZnk1puei7bjxaoCJyJ62iYN4KzmHn/mjgpW/PZu/8kKYD0+GSKG
	T/tR5wsYlOshNwHJYMs4OlLQBoDgHZrvYm+nLX1RKVwAPB1CdFb9/6Gqiwx3CRPh6T9uohlsKD8
	HxnAhm4XisTZeTFlRK2VQ0ZsNX1fkU9TuL4oJIPFAIb7fOLfl7CXG2hb9NpiGMwtH1cXOj0=
X-Received: by 2002:a17:907:9413:b0:b7a:2ba7:197e with SMTP id
 a640c23a62f3a-b8edf25c528mr436693266b.29.1770562160683; Sun, 08 Feb 2026
 06:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-12-clamor95@gmail.com>
 <aYiH8iwetvRfWxGI@smile.fi.intel.com> <39B7F089-5B4A-47F7-B2EA-A526B290FA77@gmail.com>
In-Reply-To: <39B7F089-5B4A-47F7-B2EA-A526B290FA77@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 8 Feb 2026 16:48:43 +0200
X-Gm-Features: AZwV_QinSJks_QhB591HGO3jm53Tp3IPIh1wwVGFN0DYduqCRz4P0_2il4ahi50
Message-ID: <CAHp75VdatO1c5DvFghpSOLvr9PomrT3=tEADHJ7U8Xf2tgN2ag@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mfd: motorola-cpcap: add support for Mot CPCAP composition
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 4:41=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.com=
> wrote:
> 8 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 14:56:18 GMT+=
02:00, Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> >On Fri, Feb 06, 2026 at 07:28:45PM +0200, Svyatoslav Ryhel wrote:

...

> >>      { .name =3D "cpcap", },
> >>      { .name =3D "6556002", },
> >>      { .name =3D "mapphone-cpcap", },
> >> +    { .name =3D "mot-cpcap", },
> >
> >Drop inner trailing comma.
> >
>
> That would be a stray change, wouldn't it?

Have you read below?

> >>      {},
> >
> >Drop a comma at the terminator.
> >
>
> That would be a stray change as well, wouldn't it?

Have you read below?

> >>  };
> >>  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
> >
> >This can be done in the patch that adds driver data.

^^^

> Then lets move there.

Exactly!

--=20
With Best Regards,
Andy Shevchenko
