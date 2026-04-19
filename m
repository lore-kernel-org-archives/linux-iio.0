Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD12FB965
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776585649; cv=pass; b=sT+KcxxxOt1MdbELmescuSwIYQsEAEXrbCbHUhRi1g04HTuHjVxlnsio9FutU/AtFZVBj2YALzyTU+H7WkEytrmRuiNzKwq6p+PITZsaloYOOImSDxpPZk9REEwybFHuanach6KzgGE8SuI8NavnUIGi+28BmBOrq1vR+WeC1Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776585649; c=relaxed/simple;
	bh=2abiZr7o5o9n3MgDZZRlE7z5cwnYcdepAd/MNqbQdzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEWLFH5zka8q6JQ3Y1rSPl6VD6T50gri20fb2Xd12UMlWkiOXNBWsZMePfVTwL2lhzgoM0IVF4ZtOtl/ed3qBGCM5+3TDIC7k07uJUkjc+BBQCBUT+CJR9ZzkOz8kl2B81aA2HHIVdl5ooEPvxU9bXLqQMZoXywqxEkIiySSjvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbOltDvJ; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbOltDvJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so15440605e9.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 01:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776585646; cv=none;
        d=google.com; s=arc-20240605;
        b=fn2AAVD8jCyWpDKXHnPzEDSiL37AxAnAxBcIUQDmqJYuwuGuNCPe7N6XfpPpnAZ2Bm
         4wF0cA+OYIXqfNGMPPT/LAVzKupgkcroF8676fOTJnjfZUT2xi2ttSJQFtRoQ5lplVRu
         P8zD51eZvGNsYIUviOO2uajLuilei11kndgu9wovsZuvWeWkLdbSpvkLzVQmX35YsMYF
         t2kM0Er750+dY+ONqY0GpWV260yapuAJgfKWQxGSE9ltkSCzLzfBdNqA1Y/MB+jp5In0
         93ky6+w7pGepwN+e7rzULN6S5zq59CT0tKBWXZ/cBbvtzxUA1IXiXIEwqJEBe5PXI5tE
         T3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5bJj2YUX3nt/Dk+iVGu4h6btDy49Kr3dD0yeQxG9Eyc=;
        fh=c2svtbfiVC0hBHPnTEf75a7OUnSrX5a1xgQtTXOGrSY=;
        b=LVEdL80vtthpQYLEiwW6oGig/XY+KUoyTWVOcElguHOrX8YzNZfe8q0hrfE9R/h8Vi
         ylCVWdhC3Xu71P14ZZLPRutl7eH3i3xau8eEgOCCjYLSZ8z2K8txrvfrwP25TrjpUgap
         VE+GfCQpZ+IUemqAq9o6+PCfK6muOan92ujOAtsq+pBLKjoQIDV4UeqHDRBaLl6qrc4k
         O9TRstvvdkURvrukl5xnxNQsaFQgHvH4AIsuLMW3ST9K7NFBuO2y570YOj3IKYsS0CWj
         6LvuyCf/Y0bkcxzeH5nF71T6klvsAkvLw3f+TSj7N8Mm5RYEw5Slyr09NdXK3B6p/tWL
         2QgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776585646; x=1777190446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bJj2YUX3nt/Dk+iVGu4h6btDy49Kr3dD0yeQxG9Eyc=;
        b=MbOltDvJtASpsG26qpvrdPFnGtCDFtUaZJr1oVJI3C2yUIiefEzbAXEJdeepDGQsMA
         Qz0TFYWyyhZd6rH2PzqAdtr0HUYRD0bs2CVVicoCA2hhr/oOztIKqQKJ+zEpwo9eS8oZ
         JucRWen+PJq67eKLXqePOIhdUFwoaf1BZZwXOiLReOKCiLDDeZcool6Qbh9Rkd890Rlb
         3S+9aJODCqN8YXImzTMpbxaBoZtfaj16fiPa+oUexjjMZODMZnBFte+RIv8vtv5NR8Ba
         u4m/EWKt6qzFnit5QnE/B0v2OyHeG/EdtMDqnd3gOYH9l4lo6IoEggcWK9e6ry96/isd
         OZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776585646; x=1777190446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bJj2YUX3nt/Dk+iVGu4h6btDy49Kr3dD0yeQxG9Eyc=;
        b=M51Kf372qrcg8EQI07foI146c99yKr3l7URRBtkWWkC8T74F1oXyFjUkGSE4/x2omh
         Qko91asO6VkyRYn9SI27+BuoXeGdQ3PAjwn/8+bqSbxGxR95/AstZNgPuLk/pjt9Vt6q
         +lmX2JQwImsVt+KBlZe8vsPjc8uNgerzx2v7Qxku4GxvwagVmiBtPCx06jEawMfg5J8B
         SjVlyCn4SynPNoyUKF+RTk+FLMLY96ivEuhP9llYtuNEtgqHMmzo6zSAzchUGFomK3Ih
         Wvuisc2aqqrq7H6MZKKUVuaxbUAUwFcNLHYg2IHJ1ZXkpM7ap5Q7mrvO3+Ynhnp+ZjKi
         YwIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S20LyJWNPdyEDmU0AKlALxLd5g7Fp0oA9/2XvaYUAx02/sEHSc9/4MMzwNDuSG3XK7jQidkhfSqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9LPeO4NJKq4QXOk6vNrYcIMH1njUzM5hIQWEOtg0tnBvNMpe
	Mnq3EkAtt44C6Dg8pY5wwPCOB9DlTffkW0Ll5No42HjzHTArCR7OrvMeZyGxEnmtH031esXDKwF
	eZ40ogpq0dibwgcQpFfVE6qptTl0JrBU=
X-Gm-Gg: AeBDietaga09RmJXPoWW8zynWeCXKrQ07Agq+VRmgA4/HBY/mz6HlSob3lGXqoW4ohG
	7EeR6edvMm7I5ZcKown7nC3cbNUur8CHGrISXg0bRkJiGLCmIzMzpbAPH9O7MssObrGD7LVUobs
	vPhaw3C7KSnbfdTFbqUm25Z5iu2mFba6tJru/Hcxwu2F8mGdLq8zWOuxfDr1QLIbd3et+tpSZfz
	xn7Nl5oghpIIHj3GjFfas44rb3dM4v0UuH16cIoY+cyWCqnr7B+WBYmBwFQOwPy9CFFmJJ6wxAN
	0xyg+XiGWP4mNK7g4OY=
X-Received: by 2002:a05:600c:c082:b0:488:b043:5efd with SMTP id
 5b1f17b1804b1-488fb75f7a6mr100818975e9.13.1776585646094; Sun, 19 Apr 2026
 01:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418144716.132936-1-clamor95@gmail.com> <36e3611d-642e-42de-9a56-cf81c3e06832@baylibre.com>
 <6e9e830b-edb6-46a6-919c-8772b904262e@app.fastmail.com>
In-Reply-To: <6e9e830b-edb6-46a6-919c-8772b904262e@app.fastmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 19 Apr 2026 11:00:34 +0300
X-Gm-Features: AQROBzC_6dKFSrI53kHXOiNihW66xoqTF2Ed7YHGg9qcbRld_e4zc7ORuN_gh-s
Message-ID: <CAPVz0n3_jbun+rem3Z95BmniDcLMw+H8aRXGKftv0ScToMWVRg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Update APDS990x ALS to support device trees
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 18 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 23:2=
1 Arnd Bergmann <arnd@arndb.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Apr 18, 2026, at 18:24, David Lechner wrote:
> > On 4/18/26 9:47 AM, Svyatoslav Ryhel wrote:
> >> Document Avago APDS9900/9901 ALS/Proximity sensor in schema and modern=
ize
> >> its driver to support OF bindings.
> >>
> >> Svyatoslav Ryhel (5):
> >>   dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity
> >>     sensor
> >>   misc: apds990x: Use more device managed approach in the probe
> >>   misc: apds990x: Drop Vled supply
> >>   misc: apds990x: Convert to use OF bindings
> >>   misc: apds990x: Drop IRQF_TRIGGER_LOW trigger
> >>
> >>  .../bindings/iio/light/avago,apds9900.yaml    |  83 ++++++++
> >>  drivers/misc/apds990x.c                       | 197 +++++++++--------=
-
> >
> > As mentioned in my reply to the dt-bindings patch, there is already an
> > IIO driver that looks like it could be compatible. I'm guessing that
> > this misc driver pre-dates the IIO subsystem. I would have a look at it
> > instead (drivers/iio/light/tsl2772.c).
>
> I see that we have a number of ALS drivers like this one in drivers/misc:
>
> drivers/misc/apds9802als.c
> drivers/misc/apds990x.c
> drivers/misc/bh1770glc.c
> drivers/misc/isl29020.c
> drivers/misc/isl29003.c
>
> As far as I can tell, all of these are entirely unused, with nothing
> in the kernel creating the platform devices. The drivers that used
> instead have all been converted to drivers/iio a long time ago.
>
> Is it time to remove all of the above?
>

I will remove APDS990x from misc in v2 since this one I can convert it
to use tsl2772 instead.

> The notable exception is drivers/misc/tsl2550.c, which is instantiated
> from both arch/arm/boot/dts/ti/omap/am335x-evm.dts and
> drivers/i2c/busses/i2c-taos-evm.c. There is a similarly named
> drivers/iio/light/tsl2563.c driver, but unfortunately that uses
> a completely different register level interface.
>
>       Arnd
