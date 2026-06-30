Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF91F4C8E
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795786; cv=pass; b=lNw5mVfqTTZJnV1hLjg7Il7GO4w8vtCwW6+KwpGA6oV53d0xbBPa6oJ9ZOkKFQ8DUJoyWu8jwg0K5OCLMgiMJ3CfTdCx74zxj6XGp0+DwBrr5TIoFbPeG61TgipDBdPURGXMccChRzMqK8fM34pikwMeSV/3Alg+bqLUXCawK7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795786; c=relaxed/simple;
	bh=26K430vXymRYfpzEosj02/cVImWPiZf8cypsFbNDMQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfIRRwW8rMkS/2IrC2EP0eGeyEpZ1tE3A4BZCvb0aH9O2Kw8I1/c9ZM91XqmfNADwH8NMxpAWnYld3n2YexT8ZvyFhiMlcmhHSLk6wLrti2XNBa1Ccn4XtyzttZtGgOMq4y6bElBHCzcFWHAOxCrnbjIISui/NzcNGgzRisnAbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAexHRIH; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAexHRIH"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30edbb0dc5fso1643964eec.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 22:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782795783; cv=none;
        d=google.com; s=arc-20260327;
        b=D4jA/dTSQUhEOc52Qh9+4TjFwCkM7q95n7+SOifk+YX0aJRXws9fJxF2Ez0x36fJ9I
         bWvHMYky8jrONzCTtl7cHsLMpPA/KcEutON71Aqh353BeL56t49+LdWG1fDbAsASpgpS
         LN6us0nbsJBXVGqRkJfjyN/11PnINAk/elnpTXzWHPCmHcl8Jq+cKo5WjwZbLyhUzHhc
         TXwD1YPm7K83LxAPhvN3DBw/P1vqj0ZXjlhsMCc/238NEbGlJ5AK/U3Rf/aQA/sxkr1q
         O3/eUHefG/nZ4X/Jhg4LT9pvC5jwGvTr1lfD52syKuHkbanhfGNNmIcGhHWKgPmtTBco
         SULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ra4+EZwCsIZYaZYh4YnWOQ2c+mtq4i3SaPInPLLqG0E=;
        fh=lJdQ0eoqUldsOzkRrm0/EQkl7EzBGxB894HuPzldxVI=;
        b=Ie3LC3B2oq8duuXRmWB0OMzURW7guZ/BnVHIe/fFIru6WzUpYpe4gdvsWa1pgJESiK
         vjNO3XTGe0SKpR53TzL8iJHCO6KNlZ4/rGkGLOGWPfMdn2jDabZbXWkiy93Q9tpT/MYx
         mG+R+73njN2p+2OTDuP6Xb0DQRg/7gamTwDcsRVtMS8lFNq8PFOmP6Ph50eH0H9se/pL
         pzVK435ziqWmm0zMZ6VSDtY5ZyFctaFIG2TAksvAfkVqMqWkWiCAsKoHPZpVtCmNttPp
         UbkgcWUMZTUDbNy4Q6tvwLv9frhNZps2Yi/CyKX8Rt4wUJlyeOzJ5QDSpHSc5n6UPz1b
         p5Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782795783; x=1783400583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra4+EZwCsIZYaZYh4YnWOQ2c+mtq4i3SaPInPLLqG0E=;
        b=qAexHRIHd5dXnB3U+++j+Lm9atKKfOdy40BJgELzY6V2eZpMvV7pa6bLZUcALe+18l
         cjOiqfXm0yWl2arz9YlA7cLHnVh5fYXPrFFUFE6/j3QKAQc566O52Xw+6xcoTGU3N80J
         siLhsuXLOhDTd+MTlpA1KEDtkPjJNrrBT2ItmSr1EBppU99x1EqphzhPMhZYPhxiFZ27
         TUULv++95yMjTFL3R7wh+Lwm1wIaRaddu2dHq5Jp87mwYmL3m14YO5mN9WCEUunOOhS+
         DtlEbC0f6AzSEAqSeDLJWnZ3gfnHUJORfX3ea0GsuIeHikv6bS35w7b6u2JrF8wuKXhc
         +aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795783; x=1783400583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ra4+EZwCsIZYaZYh4YnWOQ2c+mtq4i3SaPInPLLqG0E=;
        b=C63NfdpyY5gPW4ZU8w7SGbEyo/N747ipj3DSg7iodbSfpsglCMc+Soh2u0PH8A7O4e
         o8rLFdmG175Mg66E2dIpC2E2cCC+3TELYPf/5Cs9W/i4Ib0eGjWZEdQxZOJeoFtDJPsf
         ALW9mCuBTG3seEY9TQVFD4P/aOtwn3GhLlolWbBgMK8MeJIisbTkZLchXW+QXPF0oQXL
         +/q32fIXjrzg0Q5amuSQ5dfbmtK/m1kHnhB9xEybW9cjKkQm5NqngIJfQvUTbbmYttFs
         waPT75D0TBQ7TIsNSwU70xiCVRYLAi7BIwt/H2oGySJHesb9N9Mt24MrtNrQ2Tlm0X+A
         O+mw==
X-Forwarded-Encrypted: i=1; AHgh+RriWkfcoTbqb69cw+a1YViZSJhiz2ukIdhh3EOvTUGDlkbT97hUb6ZPNqW0d+sf8dYxux8tpHDx+Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQ1QLUp4aGkmYRQPA6V72WN8Jr62E5NGxY5djxHqdeAqD6RS/
	1gLwx5aB5eNJgaKIMxmdeCeCojp2od3xVUGZBxmY/jRfCVEm4arVy91GscspKai6RDdn8D6gCix
	XADQphFB5cC0v0s0RKi/5fnxASF6FJSE=
X-Gm-Gg: AfdE7ckEIIzAV+qUDm6nAEntboJiyuOf6f+c7Gd9WatsbwCAfJAQh2xRx9GsW7986M3
	tuJWoVNM9zQToMucBrdktcwEXgepZfxQio5n11HRzGMGksrgBe2zZcaO6XPbqaci+55CJ57RmDg
	hVkrHGN7gMqs4Xc+oQyGXV1rYkvrCiXK0zZjWZNO6u4qge4rTTqNco8AYdqD9SlUoypaxca5WFd
	CqYVOLewC1ChceXViJCCjTOllbp1/SFmhIuxwPUu4/0xcY9ls+wrr52TaEtgEJw6VrDOVGVnQ8g
	pfZ22NLh8G67wa5zxWS77rqRODvHUrwn8rmcw+z0Ovmlkft0u5bK+QHna6Q70eGQ6+VMAF8=
X-Received: by 2002:a05:7300:508:b0:30c:5ebf:63c9 with SMTP id
 5a478bee46e88-30ee12c2c20mr1759132eec.5.1782795783293; Mon, 29 Jun 2026
 22:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628191337.937-1-kimjinseob88@gmail.com> <20260628191337.937-2-kimjinseob88@gmail.com>
 <20260629-gilled-henna-96bde265d7ed@spud>
In-Reply-To: <20260629-gilled-henna-96bde265d7ed@spud>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Tue, 30 Jun 2026 14:02:52 +0900
X-Gm-Features: AVVi8CfXUuhem7yefx-KLpyYAbEwG_H69geGautzK_Hqk2IAHIRaKOFDs0XRRSw
Message-ID: <CALMSewJ3+GFSww2qpa4Vq0yUhe=Z7mTiw+ZJYAiHeJ1vqXPr_w@mail.gmail.com>
Subject: Re: [PATCH RFC v6 1/5] dt-bindings: iio: add Open Sensor Fusion device
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will remove that sentence in the next revision.

I will also drop the RFC tag for the next version unless there are specific
open questions that need to be called out.

Thanks

Jinseob

2026=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:39, =
Conor Dooley <conor@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Jun 29, 2026 at 04:13:33AM +0900, Jinseob Kim wrote:
> > Add a binding for the generic Open Sensor Fusion host interface.
> >
> > Open Sensor Fusion devices report capabilities and samples over an OSF
> > protocol stream. Sensor channels are discovered at runtime from
> > capability reports instead of being described individually in Device
> > Tree.
> >
> > The protocol version is discovered at runtime from the OSF frame header=
.
> > OSF GREEN is a product identity, and OSF0 is a wire-format magic value,
> > so neither is used as the Linux compatible string.
> >
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> > ---
> >  .../bindings/iio/opensensorfusion,osf.yaml    | 54 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >  MAINTAINERS                                   |  6 +++
> >  3 files changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/opensensorfus=
ion,osf.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,osf=
.yaml b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> > new file mode 100644
> > index 000000000..8016d582f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/opensensorfusion,osf.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Open Sensor Fusion Sensor Aggregation Hub
> > +
> > +maintainers:
> > +  - Jinseob Kim <kimjinseob88@gmail.com>
> > +
> > +description: |
> > +  This binding documents the generic Open Sensor Fusion host interface=
. Open
> > +  Sensor Fusion is a sensor aggregation hub. The hub exposes an OSF pr=
otocol
> > +  data stream over its host interface and reports capabilities and sam=
ples for
> > +  multiple sensor classes. The actual sensor channels are discovered a=
t runtime
> > +  from OSF capability reports instead of describing them in Device Tre=
e. The
> > +  protocol version is discovered at runtime.
> > +
> > +  Public project documentation is available at:
> > +
> > +    https://github.com/opensensorfusion
> > +
> > +  The compatible describes the generic Open Sensor Fusion host interfa=
ce.
>
> > It
> > +  is not an OSF GREEN board identity, and it does not encode the OSF0 =
wire
> > +  magic.
>
> I think this is evident from the previous text, and the first part is a
> bit confusing while the latter half is a bit confusing.
> Just remove this sentence I think.
>
> Binding looks fine to me, I'll provide a r-b when you submit a non-RFC
> version.
>
> pw-bot: not-applicable
>
> Thanks,
> Conor.
>
> > OSF0, protocol_major, and protocol_minor are wire-protocol details
> > +  exchanged in OSF frames.
> > +
> > +allOf:
> > +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: opensensorfusion,osf
> > +
> > +  vcc-supply:
> > +    description:
> > +      Regulator supplying power to the Open Sensor Fusion device.
> > +
> > +required:
> > +  - compatible
> > +  - vcc-supply
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    serial {
> > +        sensor {
> > +            compatible =3D "opensensorfusion,osf";
> > +            vcc-supply =3D <&vcc_sensor>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index 28784d66a..88172d4a4 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1237,6 +1237,8 @@ patternProperties:
> >      description: OpenPandora GmbH
> >    "^openrisc,.*":
> >      description: OpenRISC.io
> > +  "^opensensorfusion,.*":
> > +    description: Open Sensor Fusion
> >    "^openwrt,.*":
> >      description: OpenWrt
> >    "^option,.*":
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c2c6d7927..e4df9d8dc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20011,6 +20011,12 @@ F:   Documentation/devicetree/
> >  F:   arch/*/boot/dts/
> >  F:   include/dt-bindings/
> >
> > +OPEN SENSOR FUSION
> > +M:   Jinseob Kim <kimjinseob88@gmail.com>
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> > +K:   opensensorfusion
> > +
> >  OPENCOMPUTE PTP CLOCK DRIVER
> >  M:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >  L:   netdev@vger.kernel.org
> > --
> > 2.43.0
> >
