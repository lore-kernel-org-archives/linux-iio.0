Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0130DEB8
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724259; cv=pass; b=EaKCZ8v3Rm61PdX/sLKvz6NcSqDruZFoePOyVspbmTQd30Y1wAnCuGblNCipmqWHp8wHXExWYqA9AORS3jt0N2QqPl9A0qCrW2Zuh8r8hrWy/KYQvIt9nwWBhew2PyxnmmC+RtYxyM/vJrB/hBPnBqqcN+FxXsg0A+86bJu1sjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724259; c=relaxed/simple;
	bh=jNyNjdk9PNgwREJvOimkD8X6lwxWtmK86IwlK0nh5Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl/LAFEDAA7PIYYmmnpNBEfGyxdLEcA9RZ6iKHHLO160DaklrTu+BLSHiAOJ2j8Au69A1FYIKy3ljJGNYUtLNzOfjzdxZBs4Q6RfkzlJcMVnx1Z+rAXSYx3LdV3+aL5y2Ung7H/ApPiQLgo81KG9exn35CAdyJkF0FbHeLFhRC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o50OZRYO; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o50OZRYO"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so2610902e87.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 19:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785724255; cv=none;
        d=google.com; s=arc-20260327;
        b=ApAJQOWC3er0syUfx7b9Ds6zZwhLF+jpVu+1QGprzVz9I1dvb1w9YhGeJ5yPiFO6BC
         /mWgfLmM/iBThSTW3lxu/MDjlLp30YanCXiQLRuZf6ehF56lMvUXeYQ/p+6NxLpejGPZ
         63lBobFQbTlgfDfDVAI0VF7jMuT7r6NKx79inoNYIKaNaABUnve+7sJuXJQo6gYGaSUr
         Q1wNHYrOS0a/Ik/ja653e3JcmRDKmqN41sH08Cz7RNzwcJj57EkXxcU040cbvXjCnp9h
         jcfPxwm980XpXgDm0AiD+AiylSaGch4yrFB+WzZFCBsiiWSEaJBWGx6HO/QUdp0GH3TA
         YIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnMU7IHc6px78a2zQeM08cBItnOh1w1M97WR78ocvnY=;
        fh=2/6AKgL0gsGW1VRsRMRCkBkx6g0afyTjk7qbMVHcF+E=;
        b=bK5QqqqWOEyKaMsj1ECNVVCqNK57ggxlVHJCkR0MKFGL1gCxyJJ9DTCcUXnLuTDKJp
         tAIFIV8KaaGx6WPFyTJUo11yXj9epC/3xQH8fuJrIqsAKfVXYqv3xUEpMOQIpQnrDvZT
         4Ri9kCkjxfuhBBY1m4eMsHFfsvgt8E56I/MLxm5tCh/Oh1gg6LA+k98kjVqVhHo4Glc8
         lI/v6oUjH0hxgpRlt/fH0BEXk+XOzyWECkp0F9Kb5swRunKOue0UUdU79CCP0ZIN4zPZ
         sDeRzqJxiFy0qWHEjcqPPpe0qdw0QAEjYXyIOvLnHHVk6iJ2b0mgkc8/sQSBEmtBfTHo
         EAng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785724255; x=1786329055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RnMU7IHc6px78a2zQeM08cBItnOh1w1M97WR78ocvnY=;
        b=o50OZRYOzqlLy/v3oYD+/Mho3TOKqWJDKF85QFyTeDL+K5SBGeZ6o2E0z0+bgE33J9
         Wb+s9N/kuzKDQu53nNDVDwKoEKxgIT1fI5/mnM/4uL1qpD+FhHpSnEqqtiQyflVCCZyR
         CoB8S09SuZL5/XfTdYT57rKKJE+vDPzzodwtKNI3aA2RUCDAB8fGmFySyD2gNl/pkYUo
         fR5PJ46QVRTnzaIGeSoyW3jqENlKCXv2gLekRpVx8yakDpOFvLdnT5zwDdMUhNTjmzrd
         eIjpvCxYyyfLyYm7BX/zsO+xCLMxL3zfO0nwAa82/d0yPm1WZ7WntaFS9u/Z4q/sCNaj
         ZAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785724255; x=1786329055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnMU7IHc6px78a2zQeM08cBItnOh1w1M97WR78ocvnY=;
        b=qqR68fxtXTg8z9+k8CXOR4jUDDmdmdQLlKuHqmRXLR1DFcJKQ2pCdmJE+07CibKpmT
         3MWjit5CpSCV8CdWzaxt6vxZIuv5xmrZaHyn9oRxZd5Orwcl4eQ0UcrA9YsahJQ5cYRZ
         EwNWqhUOw8vT+WeS4eW5xK3i19Jgsr4I9726AxcXxgkYgkOT6TYAm564oZBDACf2bkjF
         l3tgaiuN5psiRTOZycsGF7zrgh1VtnuGNXCURHZnwAPBaKDxU9oUO06/b1o7OZjnQaxb
         +NAYPa5KYJyrsXqhS0o0WvcB3x+iF1Pqzs7/PZFZT+rxh0nDixpL3bKJ9eA0kHvCx9Mc
         kC9w==
X-Forwarded-Encrypted: i=1; AHgh+Rr61+0VZceDMO9czm29bQorPsTSlQGpSpu74NdSJp8pmpIVumNjr+zSHNdEQiFDr/Afm62U+ONJYk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9+MMXgdWlITuUgubwKZ7kOPv0LfRoX1uBWICFenzoLC3dMYT
	MKAT5Z2bITJzzl8CuU7PZNQBF6+6S7VoM8XP4uMahngQmkIxX0t5BhoDpHADSC4Z4E7ofXcm8UW
	oSgkxMJ4cNSSPBnNJHx92BT77SuvrfxM=
X-Gm-Gg: AR+sD12zFJk1NgPDroAmgqCRQYTdtR4pQipHrNUPgl3DO+8meBIiEYNLkdzaR7fjuLr
	czApvkA/sUHrEZK2o+PT3PxZGg4JVoy18nQuUZnLpNNGaSxpf93hL2jZM6IBhEWrGVI+rwSLgB+
	cKFHzAPxoztEJQchu/T75B51051UG1hm1O+IcvHn7vc4nJk/vR04fQJMhMKHhBfzmC0lcwP5OIQ
	2kDaAN3JMj5VP1NMvjNWGgvtOMN49WCr8oFgz4aj08gIYGRSboqejwTrIYOmBtuO3zOXa5fYQ9c
	LHqPoGTVqyYhrpncvrT6n0fUAmDLm7U8a6f4teY83BcjdFewf2E61sji
X-Received: by 2002:a05:6512:6614:b0:5b0:eda:de25 with SMTP id
 2adb3069b0e04-5b2e4f18512mr1212646e87.6.1785724254914; Sun, 02 Aug 2026
 19:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
 <20260731-ti-ads112c04-driver-v2-1-aab0168c3c01@gmail.com> <b2297241-e0ae-4058-a406-348440798e38@baylibre.com>
In-Reply-To: <b2297241-e0ae-4058-a406-348440798e38@baylibre.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 3 Aug 2026 10:32:45 +0800
X-Gm-Features: AUfX_mxvBmWr20zpVeWomwBTghWXfR5czaw5n8HLsdzKC9VbeOD2hGqhKXv2nj0
Message-ID: <CAF7HswOr1CbsR2+K06NwCNty=xJg5mgCa8mXxY_nSP8um-YBRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 9:52=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 7/30/26 9:58 PM, Kyle Hsieh wrote:
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
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 122 +++++++++++++=
++++++++
> >  1 file changed, 122 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yam=
l b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> > new file mode 100644
> > index 000000000000..6a5ffda84b80
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> > @@ -0,0 +1,122 @@
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
> > +description: |
>
> The | isn't needed in this case. (It is only needed if we needed
> to preserve formatting, or if there is a : in the text that would
> be interpreted as a dict key.)
Understood. I will remove the `|` from in v3.
>
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
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> As the bot said, don't need $ref here because it is a standard unit.
> (So don't forget to run `make dt_binding_check DT_SCHEMA_FILES=3Dads112c0=
4`
> before sending.)
Yes, the `dt_binding_check` robot caught this right away. I will
removed the redundant `$ref` and resolved the warning locally.
>
> > +    description: Resistance of the external resistor between REFP and =
REFN.
> > +
> > +patternProperties:
> > +  "^channel@[0-9a-f]$":
> > +    $ref: adc.yaml
> > +    unevaluatedProperties: false
> > +    properties:
> > +      reg:
> > +        items:
> > +          - maximum: 15
>
> This chip doesn't allow arbitrary combinations, so there
> are actually only 12 possible single-channel + diff-channels
> values. So maximum: 11 and channel@[0-9a-b] would make sense.
I will update the regex and set the reg maximum to 11 to strictly reflect
the 12 possible MUX configurations supported by the hardware.
>
> > +
> > +      single-channel:
> > +        maximum: 3
> > +
> > +      diff-channels:
> > +        items:
> > +          maximum: 3
>
> For this chip, we should also have excitation-channels, excitation-curren=
t-nanoamp,
> and reference-sources.
I will add these properties to the binding to fully describe
the hardware capabilities.
>
> > +
> > +    oneOf:
> > +      - required: [ single-channel ]
> > +      - required: [ diff-channels ]
> > +
