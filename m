Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59F370D6E
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037628; cv=pass; b=Jwrgs5F/n00J8c2DZtxuxBJRQLYB1m8Bml+zxqKFohz3KRv5ga5ZinBPkelBBGe5xw6nqM5LApuq+UIkofKbOPFpVO7uBFBy5PkihL7cC6nbCNqwSJriseXVsEK/ELaHMYW2f2zRpvY9nSlI37b0SPhlMH8ZExTfmPkAyg3czeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037628; c=relaxed/simple;
	bh=T9DIDFm3lzuegkQEDN325v2/6T2Fm7otzgZ6GevR3nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtRn7vadtjs9ql4oG5c8VbsL6uM4nlzyaJhnm4x3pcfMeIBoGX1MsfJLjUHmSt/xuGrE8JdYv33PiPvV8e1Oiiuj/RYI5BG90ew92JyXAylhPDGTjc/b56btkvpZvP0kNPPkgH2m25QVsKW6kV9ocqzGacS7rq/yNGurwXY3QYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibm/XjI/; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibm/XjI/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so71646725ad.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 07:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784037627; cv=none;
        d=google.com; s=arc-20260327;
        b=EXlAT0WgEd7IkRM5jEN/KkIDlOv80X28GeFjFvcHpwdcPw12OOMjtCU/ql0ueYWY26
         lXk+HUhAgLGQw3HNcbhcGJSrM1tLBqkQ8GOhqPDCZ6rOplyH4qAz6M/7mBl5GybWT4WE
         +mFtOwdN5FsuYTuYIg/4sbUqpiWuyukS0uofvbA//YYFUV+CtNyf4i8p/iPW7N6Sk53K
         8f/d0L0rtCzDz7lXHYntbzQstlm90bo83GwoK4wv/gY0b+AuoSxuSw93MdSZSnjKzCxz
         L+1MbrmRe46ds+c0KYdPq7jOKJcZvJ1rlYhjGHhJXy5rfWTUvTXZKJhPb1m8odCKla8I
         Bljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2/KhXQ427CL5ieErbt2/8G6KNeA30GSlOdbiwIQ4Jc=;
        fh=+ywIOMvlNg8wU+8QsoB/1rP8Nh+zMfFDhSbspBYxFbY=;
        b=nnE/5P9REzT79XoMRTP3oGYr0yhAnLaf4nQolV1P2/QwnTBGg3+nbZoMYn2jm9UupP
         VVv9WYgCeUr+cD+MmU5eEjlc+DCF9xGrs6+rThgQ9N5guUQHKcvI+cn3kA/FS65cgnxB
         ZQtbRBS/N3vsA5SHQX2sI0crozdb9BU4bZJawm2F5rOi+15vobF1TN/t1g3CThPSw30P
         Jv5ZssjuTznKjnZQuOKlS4VuGKPd4pU75j6TVYi05vb352iHjiOvOCe1QdP1fGs5PdLT
         QSx6ZVQ8agD2CAom0LABCUUFUdmF38qmbyT4qyU5grLc6L6e1z71jy3l5QqXkQT86mGw
         z+cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784037627; x=1784642427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2/KhXQ427CL5ieErbt2/8G6KNeA30GSlOdbiwIQ4Jc=;
        b=Ibm/XjI/UF9zGxfKyTvCLeNx0Z8KAuQRc5hxmnVoiqbgj12rW/N74Zc8//Z70MGCYc
         s32dsQpdaYE6UgSdO1VLG4Ly05kYJPcrDNYGj7H0P6SXqbUkg6sasau7TJeuMu0CYJA/
         4GWc8UxZ+z5hm4E2ur0j7iJJvdxU+jbFXCsSVWOZViELOWaKQJE4JNeBKY8+nsEZjy2N
         oodjSRD4rTxP73j2T3GmMEkb/VBD3+N2SS/28TfjxTnXDXjnskUXTiuYm6T0bw0Hk8Uv
         J0S1TuF/6wjGTXuN7UNconlyJMW6bodw0ltWL5uo8UmTxedVStJ5ErsdcCcRO21KOsY4
         klEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784037627; x=1784642427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2/KhXQ427CL5ieErbt2/8G6KNeA30GSlOdbiwIQ4Jc=;
        b=K5vs41wwBkBelqnpXOKJuS+FhKawL5sstTWG3Ot8RGSjOPh9vlhthhGYAcaXs9PpNq
         fKKcL34Jv4wuQLjokkX+ZRldjTaSQ0z+MpFHeFUqqCDIFKT45ydTY/2IleOPnJg8UZdA
         je3LjgauEc/nUSENK/lgJvVLPMw/pfe4AYqyyBtOp7DeL12NJ/tUEgiQzfWVo4Hoo9Zy
         yK9w9BI5G0nnzX4ZZxP6TApLF3gD/4TAO8Zif+ncRPAsqXA3B2cR/eVHOFwPvd9WKFPy
         v+DUB+rXBfMWOxV0SUYs04/10CyDJ0MHPVR7vy/Sr7ySOZoj4+P1QyuiRiUtXRj2JvXk
         1+eA==
X-Forwarded-Encrypted: i=1; AHgh+RpSlQO2KSsv/x+yZVJYC4+W9SxnQc081u3ZcweW4nDZCp2OafO7ffqhlYb0ieYdQmnS6hHgWR71qbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bTrcdj3zpCTnBaEw0mGe6tqNXExAkR3t1SDiTOpj7WhHixqI
	L98b7UyOmjjdX9I0jlaTbtiQFQID4eBztunoFICnVT5SkhBVKmemohJOtDNAjD+RW9nwhk66YNr
	IMTZYuNrOmIhUMzW4Pu4QT6saCu60zVE=
X-Gm-Gg: AfdE7clR9UvwY69tBtg4dTT/1LMSGyl94HCNpT/gYCSyC6ssuLgUDwVkRt9t0Igkp7h
	wknx2w3K6CrTYTXTH7bS1WTIkK82FNnnTwEAIaQu4C8uuB/rz6Vswq/SCuni4dm8BWUYESKeGpd
	9frK/ZJqTDPc+maJFJT52JrDuebblqbGAp7spShFNaHFs77WXpHaslwRVBhcN33ozTcx0Ttzx6r
	dfcfxhjzwwsVGt6YQyCadQbqSp9v1qZikMvifdq/pdtqTbovmFfVndLZnjovX4sFKbHU2twe4pc
	TBX7YzJqiKB2WLW8JRKhcVu/DoPBg2p8rYKAwKWY
X-Received: by 2002:a05:6a20:72a8:b0:3c0:9c18:d5ad with SMTP id
 adf61e73a8af0-3c3572b5794mr2798444637.74.1784037626720; Tue, 14 Jul 2026
 07:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-10-clamor95@gmail.com>
 <akeYWRF-wIlrHTF5@hovoldconsulting.com>
In-Reply-To: <akeYWRF-wIlrHTF5@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 17:00:15 +0300
X-Gm-Features: AUfX_mwnssZkuxVf2843X6HTYGv-SRm_VXHXZEuLPu7vTjXTmj8SvtNozHDr9W4
Message-ID: <CAPVz0n2EGy3uWwUfumvRxr2M_Z9ZMZ5f9=RO=S5vUsGk=ejcJQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] mfd: lm3533: Add support for VIN power supply
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 14:09 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:26AM +0300, Svyatoslav Ryhel wrote:
> > Add support for 2.7V-5.5V VIN power supply.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> > -static void lm3533_enable(struct lm3533 *lm3533)
> > +static int lm3533_enable(struct lm3533 *lm3533)
> >  {
> > +     int ret;
> > +
> > +     ret =3D regulator_enable(lm3533->vin_supply);
> > +     if (ret) {
> > +             dev_err(lm3533->dev, "failed to enable vin power supply\n=
");
> > +             return ret;
> > +     }
> > +
>
> No delay needed?
>

I have not found any in the datasheet, if you are aware of the delay
duration needed please elaborate.

> >       gpiod_set_value(lm3533->hwen, 1);
> > +
> > +     return 0;
> >  }
>
> Johan
