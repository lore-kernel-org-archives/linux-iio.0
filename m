Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630B2ED866
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130997; cv=pass; b=iCIpbwhC67VUnIoqZO6XLxSqVeEHF3vDOcoM29S/xNtNOmH3LF0MmdyB56O0aidIKtmjsbedhsmwTyu4pRBIt48q3QmB4dTP6GicpN9RjWm3Jvq/lrI2gSpbf/nlMe6Lgs6PVBDSk+x511JyGqbZzC5OA6US0wxwi8MUzpbpQH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130997; c=relaxed/simple;
	bh=s6TMw/t8TwmZ9hTFL0cXJhHoIVq+ti2CBVZ7v8bG9vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2gr3aLhj0hZe3mlvWl81Bnp7b6TK77nYppeQ66b8VxJTkzq75gcHm21x2j2UHbdicXjRyps2cUjHwB0/X7d4nnHlPe+4aRt42YvYV0sY+kSCjIGFDZ9+bnXSpZMgbNIWXbCO2cSfyaxP4jm7FGjb88gt+XVmwGk/gBabEQMA3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L26QmPr3; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L26QmPr3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee07570deso48350965e9.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 07:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770130994; cv=none;
        d=google.com; s=arc-20240605;
        b=Tqlnb0rh5Z57mv/O+TP/gTeqcGTX23BUqPon60TfYf1GoymHVWYuvmfBjXFhAkeYEu
         BLY4yMr6uSJfhAjyADf3EHGP4K1AW886UTLX1WiI8OXsMMKXGwqLN7LKZztkjb7LSpvh
         5AiOeF6tgO0+ZctDyuyx370rfkjet24RF/YlTZp+NuOq6bRfP3P82zPsnpcE8so9p7i6
         MVInbVlaxBfZ5/eKCWZ36NZ+9Yq0R5BukWlsWkncd1rVX23hKpeHmNXk9mDj7r0zrw5d
         kbOhEoflW/EV8NZ7yAB5FdnHBF1Psggn6QZbc8u+xqr/McY33TiLEpRDxNe/28irYM3g
         Rupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VGIYTuEUulJeU0/OSREhm3zUfZwfDji51fjUfoXxiEM=;
        fh=8kf2TvkVTQziXQBTRyzV/3JVlp+Jg0NW72KK2Q02t+Q=;
        b=A3eogij2q4U4n6NbK08u88hF/zffD9wFsgJ4jU4k1lbnjJ8ZVVN1y5moZWsn5B4DXu
         4OzMQ39kxH/itIHj4lQMfSnGXHhlrmBO7uufaWYF5eKEQsK/zuZSHLIXPHXjkIs8FBjB
         SDDl+gX8zzD+BX4wO6N0oh670whUahA4ITKHkNs0ogRlylKV2wYD2mehCDnvAiZh8eJN
         pXAwpitc343ayN6FcqqG6M/UZTJ6IqdXCgL7HWqClQxy780HZcujEEsT1k//fyUZlXcO
         Zj8IKX9Ex2tQWKmTD7fxDXzgEB3u1slI1JjZXOdbzTYVSu9uVk+PcbZ31zEH10PyW2rp
         LHVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770130994; x=1770735794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGIYTuEUulJeU0/OSREhm3zUfZwfDji51fjUfoXxiEM=;
        b=L26QmPr3F2q4pZ10zq18C2Zy/c+5gclgQWPEw3YiAjWIFfHdVu3mMc5tlVwMrA+DCr
         V3duTPPiPCJv5jbIddMXKjwyc+0ThfFfnNetQMq3i0vvskDtUB61AEt2ejE6wlxhyrHT
         I+WCwkHgRlH8hgxJdfA58sc36mH5NS816iQv8CwxHJK4xuxv580QrVoj53btHyu9kIlJ
         u5aC2S/18T3MVNWgwobOJvegNRouijG1I9cJ6d++XXjSw2Ubqt/Vmr3s1a8KyYRcZqpV
         /hyYFwwAqSwFFSLq5slW8ZmJ5U0vKqACnguiOTZe2w//Hws/1DXUaJGStvWdDuFx4KTw
         ieJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130994; x=1770735794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGIYTuEUulJeU0/OSREhm3zUfZwfDji51fjUfoXxiEM=;
        b=gA2z4FX5N4+9ubtpxaE2MVgBPLJ/pd1c9BSEuwKQuSTnNp8gakn8kChd9JXNxJ738F
         lD3XXuClpQYwsMxr/kYWjURCWeYtcFEyh3wcwaOWyTnz7LZUk31GUshMtghqV/HTWMrq
         Q0RVenw821pcHNVWD9o8/TjhdJkw9QHl00v9e6MbMgWNhA7GOWB+rDC21BKWwbhvUd1y
         4/KfAcfzyq2VymaZta6egbOJZhB0leRVNt3PA1nvGxBZI4D750qZ5//J2ltEaJYWJrJz
         Oh0Yrb5dLZCJfqj8SQHqD0zfem3BrRJni5eeTQbB0j+mx2BrKjIWphIP0UfCcqwI01YP
         Q5eA==
X-Forwarded-Encrypted: i=1; AJvYcCXyFQ1XmLnD5H/PL5w/mpWRKi/2FTg6CIm9mhA7BjFjQFPFqcnBrmbG56sRXBX2eqdf6Xfs7hnld2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMxSe5pyIspCQQ9Oo+Bhh1kktQqQEIJCpswmmtEPhrism3tKk
	dUvWyj3+5VSEqNIGqoWxoxn0UlPUDKQU0XG2PfK8LOCrFVYRhekS7fAsE4z2lleECLeq7DAzUXO
	nGEx8Xa2pF59ZuHYGUdCglbUBpmP9dzU=
X-Gm-Gg: AZuq6aIRLV/A+JIfeTpTK5gVb3NTxt5F+RDVkdvVkoosNsHWQxXSNOdrBfxktX9MoAN
	3Kqkvil2MY/pTYkFNV2Vupqb00y7i0uItidewJbtBgLv/X/ihncOuWlCf6kCAfaSboGLa269toU
	H89ueDzX6+I7skwxuw4gg8Y0fo8z/FfGEQwWm3Duii6e+2HtsYqXSMul8gUHhEhrj20ozWv7xFV
	qxAc3p8v8T9Grgk7WeIQralYgbZDrjArd15LOJ/s16JKPVgLpByLgP7vXbcxJJLFz1XeliLa78z
	mp4+H4o=
X-Received: by 2002:a05:6000:2892:b0:432:8504:b8a9 with SMTP id
 ffacd0b85a97d-435f3ab4f69mr24923375f8f.62.1770130993838; Tue, 03 Feb 2026
 07:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-8-clamor95@gmail.com>
 <8bd89524-dfc3-43b0-b0f2-cdb1cd51e1ac@baylibre.com> <CAPVz0n25ukBJ6=hmmR9nd4MBoPkHaHQ+ZHMXYxghYZdkB28_sg@mail.gmail.com>
 <20260203150136.GA2294714-robh@kernel.org>
In-Reply-To: <20260203150136.GA2294714-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 17:03:02 +0200
X-Gm-Features: AZwV_QhOrUmL6-YXtCaWdQ-PpGGpcikpM7Wb1yHtElG5VPVf7VhpylKKUQiQ_9M
Message-ID: <CAPVz0n0rG5XDUi-sr75rw_++kBbfyAfpMH0DoONZPmUKHfLfCg@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert to schema
To: Rob Herring <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:01 Rob H=
erring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Feb 01, 2026 at 09:07:07AM +0200, Svyatoslav Ryhel wrote:
> > =D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 22:02 =
David Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> > > > Convert power button devicetree bindings for the Motorola CPCAP MFD=
 from
> > > > TXT to YAML format. This patch does not change any functionality; t=
he
> > > > bindings remain the same.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
> > > >  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++=
++++
> > > >  2 files changed, 32 insertions(+), 20 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-p=
wrbutton.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/input/motorol=
a,cpcap-pwrbutton.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutto=
n.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > > > deleted file mode 100644
> > > > index 0dd0076daf71..000000000000
> > > > --- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > > > +++ /dev/null
> > > > @@ -1,20 +0,0 @@
> > > > -Motorola CPCAP on key
> > > > -
> > > > -This module is part of the CPCAP. For more details about the whole
> > > > -chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
> > > > -
> > > > -This module provides a simple power button event via an Interrupt.
> > > > -
> > > > -Required properties:
> > > > -- compatible: should be one of the following
> > > > -   - "motorola,cpcap-pwrbutton"
> > > > -- interrupts: irq specifier for CPCAP's ON IRQ
> > > > -
> > > > -Example:
> > > > -
> > > > -&cpcap {
> > > > -     cpcap_pwrbutton: pwrbutton {
> > > > -             compatible =3D "motorola,cpcap-pwrbutton";
> > > > -             interrupts =3D <23 IRQ_TYPE_NONE>;
> > > > -     };
> > > > -};
> > > > diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap=
-pwrbutton.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pw=
rbutton.yaml
> > > > new file mode 100644
> > > > index 000000000000..643f6b2b1f13
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbut=
ton.yaml
> > > > @@ -0,0 +1,32 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.=
yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Motorola CPCAP PMIC power key
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +description:
> > > > +  This module is part of the Motorola CPCAP MFD device. For more d=
etails
> > > > +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. T=
he
> > > > +  power key is represented as a sub-node of the PMIC node on the d=
evice
> > > > +  tree.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: motorola,cpcap-pwrbutton
> > > > +
> > > > +  interrupts:
> > > > +    minItems: 1
> > >
> > > Should this be maxItems: 1?
> > >
> > > > +    description: CPCAP's ON interrupt
> > >
> > > Or I suppose:
> > >
> > >   items:
> > >     - description: ...
> > >
> >
> > Both options are perfectly fine for me, and I lean towards using
> > "items: desc" but I would like to hear what schema maintainers would
> > say, which layout is preferred in this case.
>
> Either is fine. 'description' is fine if you have something specific
> about the interrupt to say. Saying what the interrupt is for is
> specific. So 'description' is good in this case.
>

Noted, thank you.

> Rob
