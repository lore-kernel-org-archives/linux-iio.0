Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB90379C4E
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944964; cv=pass; b=lqQzt5RmMDyMgbAQnPw6CTrRFuO/UP52JUsjVK1qkAT3X+Z43N+raL0wyNqYL1nrrTbaaBAtDGlbJb/N7CqUbAjG4JM6HscNx6zU/dzDkq1Vw4dpST0Mg5MRfmNY90zcs3PE655oLmvFd/diJZvgZzsYBJyIh9/OKw2QV9VD/pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944964; c=relaxed/simple;
	bh=dBqku483Tr8lZOPnGGzRMy6kbH+Bn5fcTfRJaM2LVh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPLn1kUdCkwcAriAw9452cbVqxbUXAEk+FkcpGTFlybq4W2e3N9/bEcu+zzFG9oY+4QuvRRWrHNoH9S7nNX8sO8qo2pOr1usHCeB4lScnrjDQUKLuX0Tyd7pWZwdr7Qy/+8VlWQ6vFC/mF59olHYIQfr/3q5FgUi2vdve/hP3as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEqFImoQ; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEqFImoQ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so26581981fa.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 22:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786944961; cv=none;
        d=google.com; s=arc-20260327;
        b=ox9h+yevcqL5a0qhEU6ITprLe3wD9bLgiX913/y0UQmv5J7dgO7wR2pm/mUWM/rcw9
         GjalVUvAcJFdQGKAJItywJ4SZKifvwrG1diI8gvTrHQnS7iRlzfi+/VbV0UWtN5ZJwZ4
         WdlXRSNYrdEszHMGtl8ein1uL/HBWK4NPjxIspCOuRs/hGUD9jtn1ic9SrTBKWxpEXJ3
         BJ3jQ5aRvAddRq7j41/0mW1I1DjVYZHafHcYPtXf7li1l8Ur2dB4K25EtTFecqZKwJMk
         qGEvqDwNjdBIbioKgWsyANu3MM/JcJvQuBtsOyQMGCaSbn6T2SS+6h9lXWIHq5X96q4j
         rIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iuYx92zoubwFpQjcYMVGvP9XZdEVQ+XxrKAQgWuEjNQ=;
        fh=aIxG9eG/HJi9p0Qk1L/ltdEv4XUhcWu6vHARyJUtfdo=;
        b=lMm3Yg7mT3GkmnbwiKJxJdNsiMsyg90J5yPrxTXsPvAHtMmeXbCK7TPZ7JSgnTOtSS
         5LJ4G9rUfX35iXCnx1Vij1v77TbdbD7QMdHkbVoIoJWSy6niRgDukvDCJA8GWaseU3n/
         +CqTkPR0TyC2IcQvQ4uE3Nvv/Pi4Cu1WXYbtI0cQSTGKVw3H/y6RgvdNtV1E8d9nSqOV
         Gr8gr9Cc+RT58toB+aNfvZkjPXO6s6uxDlGUC0wspm7UP47zE/iW4B0gVN7vaBA5rN0e
         Grtfp2q1IxjmJwPt5obrtuo3wgmxNpWYiju7+i7fzFBeDggvUQaIt9G6ra71j0KdU3H6
         7prg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786944961; x=1787549761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iuYx92zoubwFpQjcYMVGvP9XZdEVQ+XxrKAQgWuEjNQ=;
        b=lEqFImoQhBxRCCPgg/NVBjxiFU6o2CpCuVH/ctq1YKWVxK/9AdJ0Wxk+HXzZjTCliJ
         6rwCJqBI8V/zwxb4WqVcxBTAOC/L8FsYz2dLb29bpDYYkm+zrirbQyACsLXjX+BZw/Y7
         dMGpLJUuDFB6v5aHp8m1+fpsaKdCZTjaJeesfDwJSQ7CJp9GHu2kRjcbX9YseC81H82p
         KKOobjRBmhjFDZ/En3xiQhJU9QyorQJbeBHBjU4GQEFSoyjTyj8+0sU8XYN+eXQpbsax
         WC/4Tzs5moNLEquRXoNLyWEd2s/MCB3dTt6tFvsyn34AQXSMiYxcia5fzf0hyCDjYnmq
         +Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786944961; x=1787549761;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuYx92zoubwFpQjcYMVGvP9XZdEVQ+XxrKAQgWuEjNQ=;
        b=YI5j6JrFOZWbU09e8fDRDyeeO9NPA5T8VUTTZYNIjyX5gR0ibrS08cwgQ6fCQafnKI
         WWJo5fLF7MrpUdW9XnOxc0EDyIE1mYwBHVIZ1l0gOtLGEaNOk/9cBp58HQUSXN01DNbH
         QWKu3tgCEH/3+LOpX/YnZRYSY+/MtatDCDmqEg9sFJqq37rCZmP60n9fQW3hyUXIpcTr
         9WeBG7fQZnWos1NhnLiOsoTTGgDeofRSaXJGk+Byt1i2SUHPuWBqCMsFV7KEm8eLuF+d
         FRNeZz88Ew6aDDByA5j39Ajcq+RVyJ53M8yanZhwHYp22qim+L76MXRcFJABMxehGiY2
         Oqkw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/dliOJ3yFaG/LtHQ/IYwgXisqE0GKUNkN7Us1qiWqfthwdqWNKs09zLQdhFe3CF1YpZEuGzm/oCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMAQLoR4QtiWHdYXNlGs5hD1/n1ppkFo7M56tbL/RUAMWQ8C2
	jHmnpC6l0iyLlwpNeV41rV9xdpf+LYbFML8xAPg/D3u7aloqXvzYfx61ak2NyV82exv2dsCZpk7
	pugjv7VpRg9SnLssxayIzfK1VI+h1GPg=
X-Gm-Gg: AR+sD103Z3/3PVhY750AyUt/YbdZPdDVTp5Z8VVmcl6mAWCi6zlg+AUQ4wGx1bvZMAy
	65De+pKjgTs1iOUjxORhlwTQOIRAvsJRgWDPJPQShO7FLllqsFlfmkTU8+lbDyQIJyOmFkCBkyb
	X6GaDM2YTQPvLg4XmZDc+MckWkF3obYznSzfzctohcbRqweOqIvuY8N8tY88kVG9Ic2N2FryfPb
	Ccq2H7eNvbG74F5DloIghaFnpFgb2RdxLyjGzZOCNnzq3LetbyEQTzj3BIjwRhURWqz6O150CCQ
	BJDEgAaENDsYrQFbx6kwA8TwVBj4r0gft2b017qchjjPnw==
X-Received: by 2002:a2e:a54f:0:b0:39b:15b4:79ef with SMTP id
 38308e7fff4ca-3a13249d4afmr20231811fa.17.1786944961068; Sun, 16 Aug 2026
 22:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813-ti-ads112c04-driver-v5-0-79dff9e249cd@gmail.com>
 <20260813-ti-ads112c04-driver-v5-1-79dff9e249cd@gmail.com> <20260813165748.GA2065977-robh@kernel.org>
In-Reply-To: <20260813165748.GA2065977-robh@kernel.org>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 17 Aug 2026 13:38:54 +0800
X-Gm-Features: AcwNN1Vbhevhud9cKWrmo32hz_ACvcEqPiKW3pQSSAukqHeCRuMkVWcQpNH8veQ
Message-ID: <CAF7HswMiAA454Y1eFA2O1DtGjg-SQXUwLimaM9tVkjkDJSJSuw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:57=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Thu, Aug 13, 2026 at 11:06:02AM +0800, Kyle Hsieh wrote:
> > Add device tree binding documentation for Texas Instruments ADS112C04
> > I2C Analog-to-Digital Converters.
> >
> > These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> > interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> > interrupt output.
> >
> > The binding uses child nodes to dynamically define the connected
> > single-ended or differential channels.
> >
> > Excitation current, burn-out current, and reference source properties
> > are also included to fully describe the chip's hardware capabilities,
> > aligned with the ti,ads112c14 binding conventions.
> >
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 148 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   6 +
> >  2 files changed, 154 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yam=
l b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> > new file mode 100644
> > index 000000000000..68a0df21cedd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> > @@ -0,0 +1,148 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c04.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments ADS112C04 ADC
> > +
> > +maintainers:
> > +  - Kyle Hsieh <kylehsieh1995@gmail.com>
> > +
> > +description:
> > +  The ADS112C04 (16-bit) are precision analog-to-digital converters (A=
DCs)
> > +  with an I2C interface. They feature a flexible input multiplexer, a
> > +  low-noise programmable gain amplifier (PGA), two programmable excita=
tion
> > +  current sources, a voltage reference, and a precision temperature se=
nsor.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ads112c04
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: I2C address of the device.
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Data ready (DRDY) interrupt output.
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: GPIO connected to the RESET pin. Active low.
> > +
> > +  avdd-supply: true
> > +  dvdd-supply: true
> > +
> > +  refp-supply: true
> > +  refn-supply: true
> > +
> > +  ti,refp-refn-resistor-ohms:
> > +    description: Resistance of the external resistor between REFP and =
REFN.
> > +
> > +patternProperties:
> > +  "^channel@[0-9a-b]$":
> > +    $ref: adc.yaml
> > +    unevaluatedProperties: false
> > +    properties:
> > +      reg:
> > +        items:
> > +          - maximum: 11
> > +
> > +      single-channel:
> > +        maximum: 3
> > +
> > +      diff-channels:
> > +        items:
> > +          maximum: 3
> > +
> > +      excitation-channels:
> > +        maxItems: 2
> > +        items:
> > +          maximum: 5
> > +        description:
> > +          Additionally to AIN0-AIN3, IDAC1/IDAC2 can also be routed to
> > +          REFP0 (4) and REFN0 (5).
> > +
> > +      excitation-current-nanoamp:
> > +        items:
> > +          - enum: [10000, 50000, 100000, 250000, 500000, 1000000, 1500=
000]
>
> Drop 'items'. Just enum is enough.
>
> > +
> > +      burn-out-current-nanoamp:
> > +        items:
> > +          - const: 10000
>
> Just 'const'
>
> > +
> > +      reference-sources:
> > +        items:
> > +          - enum: [internal, external, avdd]
> > +            default: internal
>
> default for an items entry doesn't make sense as the entry has to be
> present. Instead (at the same level as 'items'):
>
> default: [ internal ]
>

Will fix all three in v6, thanks.

> > +
> > +    dependencies:
> > +      excitation-channels: [ excitation-current-nanoamp ]
> > +      excitation-current-nanoamp: [ excitation-channels ]
> > +
> > +    oneOf:
> > +      - required: [ single-channel ]
> > +      - required: [ diff-channels ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - avdd-supply
> > +  - dvdd-supply
> > +
> > +dependencies:
> > +  refn-supply: [ refp-supply ]
> > +
> > +oneOf:
> > +  - required:
> > +      - refp-supply
>
> Just to make sure, refp-supply is allowed without refn-supply? If not,
> either this should be refn or the dependencies reversed.

Yes - refp-supply alone is valid when REFN is tied to AVSS/ground, which
is the common single-ended case (and what my board does). The
dependency is one-directional on purpose: refn-supply requires
refp-supply, but not the other way round.

Kyle Hsieh
