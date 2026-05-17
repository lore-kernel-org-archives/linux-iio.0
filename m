Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549B3B6368
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028045; cv=pass; b=F22DcwzcqcNn/M+gTo2sTzNRlRJ5+j1zJWG+EYaE2xQ4sfMIbE/tkc6XQeSh24J6OI0NYnMU/XoCeRWYcHv/oTAJyJJpAhtt0I+SR1G0voNgDBD3Ev8rWgu3PZF1qPvzbMk3MIr4q8yeFAhp3aPK+QRJC9HD/f4+wSADKKTTGN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028045; c=relaxed/simple;
	bh=IZHMWs+8Cp/KOe0MB2/iet7ivwJo1nP+BQO/cuxTsWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiXwVopFkPuJQ/gw6pyAXTArJxHS90aO97A/CBoAPF4+r6oml/jq64sUjCucwabzE9q0ICoKxfVe/+e5U9cwqrbOc7+qTzR7k9lMyJjI/wRHCmnYdtFK7U01EnZ4whvMptpTq2U87qwYQMLSqZWu8/rMJTdFzunQp6klLR90yjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFi8kcNN; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFi8kcNN"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-135200bc7d2so3425548c88.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 07:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779028029; cv=none;
        d=google.com; s=arc-20240605;
        b=a1pPj6jJPVdphNTw4zZPAkKM5mhLDN+sl3C9h43Yc0+LX50gX4ZMsFNPFCDEnKSmKU
         6NxBuFrsYcPSW3cb6Q4I0iBvEtxyY5JElXqNSWfswo//rQbCGcCFNkmznFmRsF7NU78p
         ghLbazywS6AXpo+TVxKiKDIfbx9bPdeEpty30wzGvG9nMsG1+JLeE0NKkkmLRRTIfg13
         D5mvSKZIQ5mBj4S4qLuHXENGJHWrviALzqhJOc+GAo1xXYyXFJ3BKcYN07Qz2IdQJwT0
         qOWYdq+LqsOFTGJxfZc2+dBsa7TBCEFCDgzfx/I1dAtQyidbwbwGzNF6MXdiXEuejRPN
         WYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
        fh=n1TVpnoRVVH8g3ib3L9VwKhG3pD1VDZ8fR0AG1sN9P4=;
        b=iwN7nQ/NkZ4sk9I6lzK85QUEROra0AkOeyZMdrxhpNmKje7KXDd7tijb6TtHCH5aPT
         3DDJpNzI02lM4RgnbZp+FHAVnqapusDEtjMWZsIVKXWanzpchZthGyzrujAG+g5zIB6G
         jBA3nq0VoYoLCnQRRqBDStG2qGsl02kdHepKXyajUbbInZj0CjG3BCzWLh8HpWqvu7ni
         3gl+g/kVgy+1AqezvoNDyC3CJlcUJ5sDzO6J5E9iS5ADJBnMggVWulKYYMOxH86xlkRR
         JLFqmWDFWJf8B/1upQVzIuHOFCDF8iuHc2N886tjZnebbbYFUFYzddiXjnlsFAK53jxh
         ZjMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779028029; x=1779632829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
        b=LFi8kcNN3DmGtdifJZsCdIXVMuz9BXu6AWo42tERT5aeZAQajuOZObh9y4TqR/I8EX
         AT/seDSYZr0I1pYQMHeN49IMfkGU6SzEdMNVep2hXD7/zUWvmdNAlUC/Sj+Fx24bkJzo
         MbVFCm8aiBsZ9y1otZ5s6ul5RtqaW5S8iFW4kLPFcdUJ0GaBqx1L7Siu79N1FB6SDlBi
         15YF7TI3oYyD9jBmbH+WxspMMvcU56xqagV17S0cK4XGnZIsPmPSzwmAnZhzGa1YMQBB
         HZh7yFZ3OMkOKwz5EUoG79Gz0FC1CcuvOuoLcmiQ5WrC0hWen/gJkWOjzgmjcP8hKdNs
         Xb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779028029; x=1779632829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
        b=ogrXW0iIahmuHFR7elp7gWuEWF08XCG0UUW/tuD+DzrUk7BCyL5a3RTVnCNgi0f1WH
         rQwz0yKF1+MK6NuL5mR4eafhjgDY4pK+pN0fIKQB7QNSjcot3lS+c9sWT8TQMaCfBBFc
         LLB0e5nNZo3vt36/zIQ1egFCsCqyxiQvIAl8Iwmp17vF7mQZV9gjzZqT45pbQpyhYXwz
         GZt65BPFKI1hSB5U0uUpbezkdX8xlxSppwkcVkSU+cj0ySCg5ju0MOYZTUSpf7w0+NmI
         rJeiYIaiA5Nrl5gaZdcBj1dpTd0AbsHs8fPdpQqZ+Tm1Qyc5ayH0we9hgcF9fJXkSWJl
         JV8w==
X-Forwarded-Encrypted: i=1; AFNElJ+pxQLzvK9pmDqEliEpFuFRNwXAAh5d2fbImkrDLL4edY/P0YTIAiYEduz7/gA7uk63NVLtJD0az/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEP23K9jfYLxSUHWu+Fo7qDCfvd8e4NPCIx8Xj6cv6Nc1MeTHP
	4BtYrUIZLp/5AlqHjGrItd0+wY61xorHLUXrFf0oF0jD5iv++0qtwqBCgzCB7hM5hdcK4q45EMF
	p/W3nGsYdZvzwzpXYxgcsgUzLl+xrq5U=
X-Gm-Gg: Acq92OE7vao/9+vO/E1XVRxLul32bbvx6aJ3/CWcCgtpQepduNs8R6Qylq/DUNwgf7a
	0d+7EnVskizZ5zuL6zQfKy/sDXAx5tBYjeR4TR1NZWDmIAGSwdcdTWlbtHTiCSIKQteQy4BDiUo
	eLTp8kkslM8bf4RLPt21XUPQDIQmevbau5B7p+rZeclRyEriNWnfGI5J1AGEO0kCFdGomxIyQWk
	sSPlHukB/XMT2oBh8xMfRZ+5jSBL+9v8a4Y9zOwilkaH5ZnK4hfROcUM045hQF0MqQgOXhGUWC5
	KgU4LlNp
X-Received: by 2002:a05:7300:a907:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30398680c36mr5240683eec.22.1779028029014; Sun, 17 May 2026
 07:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <20260517074306.30937-2-clamor95@gmail.com>
 <20260517144453.61cc210c@jic23-huawei>
In-Reply-To: <20260517144453.61cc210c@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 17:26:57 +0300
X-Gm-Features: AVHnY4IEMjYjQh2-EeqHWPNZxgaMpOfNHnP0k3ytWy1tFi4KeKl3gs6PRb7odls
Message-ID: <CAPVz0n10naSo_1n99orPGM4U8iDkOn1DW9Xe_RGE56CMpLm8kQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] dt-bindings: leds: Document TI LM3533 LED controller
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:4=
5 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 17 May 2026 10:43:01 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Hi Svyatoslav,
>
> I focused on the ALS part.. A few comments.
>
> > +# see ti,lm3533.yaml for an example
> > diff --git a/Documentation/devicetree/bindings/leds/ti,lm3533.yaml b/Do=
cumentation/devicetree/bindings/leds/ti,lm3533.yaml
> > new file mode 100644
> > index 000000000000..2e200f172400
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> > @@ -0,0 +1,190 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/ti,lm3533.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 Complete Lighting Power Solution
> > +
> > +description: >
> > +  The LM3533 is a complete power source for backlight, keypad, and ind=
icator LEDs
> > +  in smartphone handsets. The high-voltage inductive boost converter p=
rovides the
> > +  power for two high voltage series LED strings for display backlight =
and four low
> > +  voltage control banks for individual LEDs. Additionally, LM3533 feat=
ures an ALS
> > +  sensor support.
> Mention it is an interface for an external ALS.
>

Noted, thank you!

> > +  light-sensor:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: ti,lm3533-als
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      ti,resistor-ohm:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Internal configuration resister value when ALS is in Analog =
Sensor
> > +          mode and PWM mode is disabled.
>
> Good to note why this is a firmware thing rather than a userspace control=
led
> thing. I looked it up, it's because expectation is the input is a current=
 from
> the external analog ALS and these are used to convert it to a voltage wit=
h target
> range.
>

I will include your explanation.

> > +        minimum: 1575
> > +        maximum: 200000
> > +
> > +      ti,pwm-mode:
> > +        type: boolean
> > +        description:
> > +          Switch for mode in which ALS is running. If this property is=
 set
> > +          then ALS is running in PWM mode, internal resistor value is =
set to
> > +          high-impedance (0) and ti,resistor-ohm property is ignored.
> I'd mention the ALS is an external device - so this is saying what interf=
ace thing
> thing connected is using.
>

Noted

> > +
> > +    required:
> > +      - compatible
> > +
> > +    anyOf:
> > +      - required:
> > +          - ti,resistor-ohm
> > +      - required:
> > +          - ti,pwm-mode
> > +
> > +patternProperties:
> > +  "^backlight@[01]$":
> > +    $ref: /schemas/leds/backlight/ti,lm3533-backlight.yaml#
> > +
> > +  "^led@[2-5]$":
> > +    $ref: /schemas/leds/ti,lm3533-leds.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - light-sensor
> > +  - backlight@0
> > +  - backlight@1
>
> Similar for the led nodes.
>
> > +  - led@2
> > +  - led@3
> > +  - led@4
> > +  - led@5
>
> Curious - why are all the led nodes required?  What if some aren't wired =
to anything?
>

This is limitations of mfd devices. If it has subnodes, all subnodes
must be present to reflect mfd composition. Unused nodes should be
disabled.

However, I have asked Lee if he is fine if I will program dynamic mfd
composition based on the device tree. If he is fine, "required"
props/nodes list will be reduced.

> > +
> > +additionalProperties: false
>
