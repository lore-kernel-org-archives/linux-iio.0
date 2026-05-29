Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101C3C7690
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052193; cv=pass; b=jKXRsHBnUAsS7L3ym7zsGCRd5UOo0PNE7iTGaNixOD/EvKrBefhM4hOqa+OiKTZoA4r4W/9f3Y0bkUQXkP+TYlXi1Wfuu9wEBda5BXBBCuocrcpFd7jtuBwfdiJVHnuBDB98sLXJLYmuUAw7EtBwzFZ41JFb/5nsElgeNp5t8WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052193; c=relaxed/simple;
	bh=Y7dc5LHP74ZYKK/a6Hv5SvYo8Aw44DNxbmzdGSGer2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDdDEWTo1pRqbw+i8/kD2nRwbyCqjG5UcnpbB/f/YzyGVEL3IsvFzWLMuY5nH8Q2/BTh1fT2ROVjSq1kTUIEdHn/HKHY9DkGEAwY8l6HKn9sx6o1ohGQaEi5lH+DC21JhuvKvmw7OR5mGAd4CGJ5SzjdrraITkX0zZQnMseOaAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lbu8DpMo; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbu8DpMo"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1353c2f35cfso6829851c88.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052189; cv=none;
        d=google.com; s=arc-20240605;
        b=YcqedoBhSZlPZpEW91sRTOqnNtk/GAUO6DNQlG79rheZVAK+NjewBneLUsv+H9xyjH
         mziwzNYgi77QzKL7HeKg8QYkXpi772HTNzhVHDdGwlPHwJNRyOI4YjT16IySpaWt9DrQ
         J5b1sJX+50OgvkH/AGJ0qiJXdyOXTgaIFDwCivC0qW+EufLSXSlx6QCHKB5Lyt2iwmn2
         Yy4u+l/wlza94avyr2vs76TKcTxrn4lJ8PaxVZp0nRVhqGAQuTYaaLffULVJXl68EVb3
         PFWWFCnL2nXgUt+MDnNpSrPGV8GSVCe+fxTZtb1iNUYhi5TV/Ek5TufK/9sCJPSd49IQ
         5f+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QT9o7z8njCzuauXIRpTZNkDYlGBM5NI3aWAig5/bi7I=;
        fh=KdKufgNj0vRvnUO0lOvT9L8afgraKiWDop/WaLiWPgw=;
        b=ljmISx8EGcXppBpFR2um2g7Ed7kICJmI1tgRsFdEezkiPjBkFrTpf/u3VPOsER5MPt
         FsoXrpHwX1acdIRtczkv6F5/ckgq99Q8xFffT1NEz+EsxCvHc6Kej7395cdThfWzkQmP
         7ZMwH++EC1e6mZPqrOS5Ay3f8ItPhkeTXjr902+QejKNnNOtT+0qVvFh8j9gazagyaYE
         MEngRGZxKRcoPdbO94ou6WaG44ahh+Y3Q/OLYDMHEO3amUnWrQpvVlLGDXiCPp34hmUY
         RpT71oGMnmLb56+tIJjLPKP7i67BvvH13lsUYBFN0JOrg+6myVFq2PqqzF9N7QBjwxY7
         ZJdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780052189; x=1780656989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT9o7z8njCzuauXIRpTZNkDYlGBM5NI3aWAig5/bi7I=;
        b=Lbu8DpMo4pxqcsBXVtbqLe0NhbTjFp50POcVMm48mQVhtTSnx0CscTWnpEanSdshzS
         RkLGTJ2ta28nxAuIvrp/aTEswQScWUYjm2RxHPRwWmXJAvbtQeAnstVlu3d0C4lLms3s
         8F8Jn7/FHkuu7Jkm6ytH94infdSRNx1jXu6eKBu2CpGJIpQdNBZLvNzWQIUlaqfZMUV2
         tNZpqfBXzY7Or/6IYF342HTinVEb1ATIF9GPqXibUvuNqanXTqcVEwda5B89Dv4jxmMG
         9hNy6Hsht1Qc4oCp0EV9sIb0FtTtNCgIKdPRUZQBZ6COtvZjFvzJ96rgyTuVsB0s19r6
         OthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052189; x=1780656989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QT9o7z8njCzuauXIRpTZNkDYlGBM5NI3aWAig5/bi7I=;
        b=ZC0nKJ2P+XC06jIUB+uwSuclCyS2HJ5DkpkmJHiaHJ9YlBE4lznrZSaMmdoawxDc/A
         xeKrtv/HS/xALK6/ndQpbOgBfEV2bxgL41Em8NsjxA8j/D59qbv46W8vJ+UL4cPRmU03
         9dQWGOW5/jzAH6Mg3Wgw4FA6LfEMyySloyb6cpq//ukP1L40ZfOSkzdrDybXHlHgZz4p
         k1mJUIasVhc4M3uJ2Ji1lyXVYWFi+f3IianVvIpMJgJSs0RGDr0Iv7rWF+J+dWOtYJyM
         6uaOvE9GU0SWJ0o5bda2FpyGQMhL6cZO2orX0aLYaEO85l3+oPyevoIlDEQWBTwJN6S2
         mozw==
X-Forwarded-Encrypted: i=1; AFNElJ+C3Z9kQBLFlupfDmKGHqTHcUwqdkO7l66dH64T96v8XwL5AeJPBA4Jihi08zcvYLor2zhhPaMg8Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQh2EKOmtTBIcEX8h3YJ62bUV8G/VtdPLqwbC2Uvmbdn8k4pKh
	hWq/Awc8ZXBjmCs3wcrK4FLd3FfFUSAIyiio1OPRO8ypvThaOR744dht5e41D4+LIraGeAsak+a
	3pAgmc7glPx8LRVvxQiKiuvxPRFLaBaI=
X-Gm-Gg: Acq92OETUp2vpfJf4QxMZrTJ3rSH2omDqvJDng9IfsNaq4LD9rd/UhAZiQ7/4GtWjKJ
	AX0+0m7nONel5tdMmSyg+v4UJD709uczoq+oWZ8lUxPHRn15R1C3Ju18NLr3Coq6flbZqJFpD4F
	HgV/2lkfHKKsEa9kKgRx4dJUtqmir2RK2ZjWfnc0IIIBX3TdGRH5g6ljFD8mAiazLmqJHJlUEQb
	g9B9eusCxVEpFktYpxlUniWJvkDXioivNImXya2uPw7IDpOO+4IGxLMpSyz5gDsXmHPMPvmpqRZ
	azzj+NA24vfC6Nns3zba3OujWfhxGg==
X-Received: by 2002:a05:7301:688a:b0:2da:4216:7ea3 with SMTP id
 5a478bee46e88-304eb16c784mr1065135eec.14.1780052189412; Fri, 29 May 2026
 03:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-2-clamor95@gmail.com>
 <ahlhinOh3NxB7FY_@aspen.lan> <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
 <ahludIZPMUlPDTG_@aspen.lan>
In-Reply-To: <ahludIZPMUlPDTG_@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 13:56:16 +0300
X-Gm-Features: AVHnY4J2FFsbeePVzhdaZr1L7xTMY9M_-IQ9RntYfCEGWE3LHkP9pzzQ1jAxVDc
Message-ID: <CAPVz0n0XvQwLd6gv2kiVHfSTyM_jF142beSwWb3L9sBLEQDzZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED controller
To: Daniel Thompson <daniel@riscstar.com>
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
6 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, May 29, 2026 at 01:07:50PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
12:51 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> > > > Document the LM3533 - a complete power source for backlight, keypad=
 and
> > > > indicator LEDs in smartphone handsets. The high-voltage inductive b=
oost
> > > > converter provides the power for two series LED strings display bac=
klight
> > > > and keypad functions.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
> > > >  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
> > > >  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++=
++++
> > > >  3 files changed, 304 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/leds/backligh=
t/ti,lm3533-backlight.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm353=
3-leds.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm353=
3.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm=
3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,l=
m3533-backlight.yaml
> > > > new file mode 100644
> > > > index 000000000000..866b0fb8ed04
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-ba=
cklight.yaml
> > > > @@ -0,0 +1,68 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backli=
ght.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: TI LM3533 high voltage series LED strings
> > > > +
> > > > +description:
> > > > +  This is part of the TI LM3533 MFD device. It represents two high=
 voltage series
> > > > +  LED strings for display backlight controlled by the TI LM3533.
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/leds/backlight/common.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: ti,lm3533-backlight
> > > > +
> > > > +  reg:
> > > > +    description: Control bank selection (0 =3D bank A, 1 =3D bank =
B).
> > > > +    maximum: 1
> > > >    <snip>
> > > > +  ti,pwm-config-mask:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: |
> > > > +      Control Bank PWM Configuration Register mask that allows to =
configure
> > > > +      PWM input in Zones 0-4
> > > > +      BIT(0) - PWM Input is enabled
> > > > +      BIT(1) - PWM Input is enabled in Zone 0
> > > > +      BIT(2) - PWM Input is enabled in Zone 1
> > > > +      BIT(3) - PWM Input is enabled in Zone 2
> > > > +      BIT(4) - PWM Input is enabled in Zone 3
> > > > +      BIT(5) - PWM Input is enabled in Zone 4
> > >
> > > This is optional and the drive implements a default (zero) that is no=
t
> > > documented here.
> > >
> > > Is zero a sane default from a DT binding point of view?
> > >
> >
> > Yes, if property is missing then PWM input is disabled which is
> > equivalent to setting all bits to 0.
>
> So the default should be documented in the bindings?
>

Ye, sure, I can do that.

>
> Daniel.
