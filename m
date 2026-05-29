Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60D3403E3
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049284; cv=pass; b=RkDMZhEiUIEHh9rkygwbneUC+PshtC60K2gCUSnpQBb6DY/jpXA/F7l8hAP57zDtRVzQDPPtCBDMfbwFSCDlrDPLV434p4v5EhJsOqtLfUvX2QoEJ4xYyG7qJefjhPD9IBUaPTtFYBeQbjXW2FwgpSvAzbCFmquYiWjyYQOOrqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049284; c=relaxed/simple;
	bh=n8g9nbx/cd37EQYdG35MTeP1UwCovHHBH5OKJHp+X0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peGndp9geQEQUs7jjjHz1L2PVWYW73X692kLEJMu9Y1CLMCjcoWRCOYT6WMLHfac3s6sp0UywO075kEM4+X/x0piqQJut6srq0JIGQrGhpjwwIzeBKJOWRSOigQM/bvT5mjnynL3nz/3m4o3yvBS89+DMs6C7NsaXi6hpwvOjqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH4EWJZk; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH4EWJZk"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso130207eec.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780049282; cv=none;
        d=google.com; s=arc-20240605;
        b=cbF4hPXDGwr5YTUYu401PG6VdDhvs0lJRGBnMJl4Xy00zaPtjXljFszL9NvwuZa/bi
         3J3Fg6ekt/fN1k/kxI8TbvSXO2zrC2M6n8RL31v+E/+DD8hditp89kUsDKOHLMcZyrjj
         0hehy8wVUzisRjGTfqP/AZdCgdDuNMGMZmH3eOj0o19YgxssJMPD/929cWsa+zBDUkzz
         QT1MzY7BgU2N4If/EgLdYzPgDbg3DOJIeKInwaO4+bfm7Ql+48LlP/lgPGAOtg/fRx2p
         8+YhP1ZcSGr2j1jWGCUXLiPiMNxt0N6i9hH4JRS3SvcDwX2Sp+GGKRXfMupK/wYpNVJz
         V0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
        fh=7HeaosQ3zj2RMGOGBGHzt1dIjyNw9ntlNC1KxNVS5iQ=;
        b=MWQxegIJarN87CJpAaOpedcOADxjvzbUU7Xk9i41KrBZLDNPIz/gYt4E9Km53O2KdF
         FEvFgjtUxW/QGq0C/FGaJKUXdbrL4zzlFaoON8HHDg3IIKyIF4p5T/+DJMolh8AWc8g6
         HiGG1/FPqZz7l8dR8zck0qbo2K6/mMNitJvvGqsGb/Dlzz72c12g3PCxhOV0hm27s9Mn
         1OU9724SJdPW/8CLlcIPavcdeq6YbtElddUzt4lntpD62BtClDLOAbPOHRX7Tn72ivhf
         38EExBxc3phBhnxR8m0QFsla+FMsqW1MLQMf1QLWTSeJNe6/3K2jrWa3QD2BWGjpiHpA
         fcSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049282; x=1780654082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
        b=QH4EWJZkM2Bz2/Mg0D+E46mMWqXeiRUbecZwePs2Hf0Ke45z0GnQXgMLZrfAbndRM6
         /SLcdaAIjjw+clpICOIglgob62aMWcsLxyAakx+yykiy/WBwkKl+is6jGpCCxiubC6sf
         6rkBt+TeMUfXH6yKv5Szv9/D7Qt8G3qdkJDdI4SxxLSqcmGwHNRvrmS7ehAFuwPSLJAL
         5xz6RDmFcmTzK1U2kiMcPVwKzwN1zQWcxxqQdxUpBXyHuh6Vu60KN8Qe+jXabz2hPjkk
         +WPJ0oyCmIhv75bzm1Sl/LbRS8Z93q8f5yk1Sw8eIYDoavWhu1EiK0nOpKFBUx7RNk4q
         ihcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049282; x=1780654082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
        b=pwmbqckqqRI5ppGl6UloCuEV4Woh8m7EZsOVun9xE2Tnh0Fi3B+8cXpj9KbV7aSvu6
         dQTdaOx5bL45MFzd8kxb3zWwsxpMTU4/kYgzLdTx5BZSRiMEfQrnti3RQwQ6StZHpSNZ
         oysymFo9UDD6RJ/jrEMDNouvkml0vePJU5fbGnx/UT+sfLOII82N8gErqQBZILeNJnyb
         dy7gJXElnfAau+J8xDIk3sbpa9yL2vJaG/MhD/OhvkRwldjhdP2XaAijeoJ1dWdhbYEF
         i8zhzVzBTTWhR2+/9jm2/gRNP/wDZHVk+fFfuaM6eqqJQ6erL62zvw8GIIX7AcqtVtse
         U4mA==
X-Forwarded-Encrypted: i=1; AFNElJ+gNJxwwQhxySe16xQgci4DDLgmDrIYr3WpKUaRn6Q4EL2lELFfIsjEhbF9Mhrot+KtkH3J4UVJqo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRuJVlSIg21jDrqAYTsrIe914B5edKswla6RnXYjGwMqcAqsz3
	W8XdSbPlxNibN3khuYa1xUO+OwuxB5CHPJC7uyNn7BqsEENJq4zVrCE9nktBQqBJLbQZA6Dh1q9
	XiB30Q0ws3h3svVA43iafICStXXUqe3w=
X-Gm-Gg: Acq92OHWiagcymRDw9NFl5XFW+wpmLb9HA9eRrXYgsDWZLXH0S4QWnnT157ADgJdpco
	lmBKcC+/ovMgan2+MKKi04TALAXpZ19gqhzO3kbeE7nFrYF/J7bQX8oaDH/Ebfcoc0qbxAFqvCp
	fWxNlRPVVSJ4vpDd6BgMt/uVcavWZzudI35V+LiWmR4yluV0D4Dz+ZUxdXhSW6X/wHAoUXYEuvc
	ZkmPjULcB+82jdRvtv3M/m033z7/1lWvYckz4Y+hSc8++Qwi84AbkFPn0nADroiBXhRFMIIvI3r
	juBVC/lOKDNu0EUqUwI=
X-Received: by 2002:a05:7301:6093:b0:304:aca:35c5 with SMTP id
 5a478bee46e88-304eb228f12mr937539eec.23.1780049281982; Fri, 29 May 2026
 03:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-2-clamor95@gmail.com>
 <ahlhinOh3NxB7FY_@aspen.lan>
In-Reply-To: <ahlhinOh3NxB7FY_@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 13:07:50 +0300
X-Gm-Features: AVHnY4Ju4apl_6PVevGT822qLIzQw2MECBwLZ58e2K1CK8Q_oHMtYlAD2TA9TPk
Message-ID: <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:5=
1 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
> >  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
> >  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++++++
> >  3 files changed, 304 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti=
,lm3533-backlight.yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-le=
ds.yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.ya=
ml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533=
-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm353=
3-backlight.yaml
> > new file mode 100644
> > index 000000000000..866b0fb8ed04
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backli=
ght.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 high voltage series LED strings
> > +
> > +description:
> > +  This is part of the TI LM3533 MFD device. It represents two high vol=
tage series
> > +  LED strings for display backlight controlled by the TI LM3533.
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/leds/backlight/common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,lm3533-backlight
> > +
> > +  reg:
> > +    description: Control bank selection (0 =3D bank A, 1 =3D bank B).
> > +    maximum: 1
> >    <snip>
> > +  ti,pwm-config-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Control Bank PWM Configuration Register mask that allows to conf=
igure
> > +      PWM input in Zones 0-4
> > +      BIT(0) - PWM Input is enabled
> > +      BIT(1) - PWM Input is enabled in Zone 0
> > +      BIT(2) - PWM Input is enabled in Zone 1
> > +      BIT(3) - PWM Input is enabled in Zone 2
> > +      BIT(4) - PWM Input is enabled in Zone 3
> > +      BIT(5) - PWM Input is enabled in Zone 4
>
> This is optional and the drive implements a default (zero) that is not
> documented here.
>
> Is zero a sane default from a DT binding point of view?
>

Yes, if property is missing then PWM input is disabled which is
equivalent to setting all bits to 0.

>
> Daniel.
