Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB739E162
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778424031; cv=none; b=Y+K8bVfUVLnV/3AC8Jq/koGtvVx2iy86w/ouiuhoVlYsn9wypiAdtfakFnjqFkCfSOtOpvlx3OCU/LwlKTfGcMIRJQjTeo4nKVWXQZH8dAbqMab3/F1Ah56qbD3D8NaPdbyDMSWW9bNad/15vXDShQ9AvcOI3C3ZGxFPK8I+SCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778424031; c=relaxed/simple;
	bh=5hMtyrpO4o/xrWDyBZAdZa2vglyjgQ5ZkQbZ7oKGLqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9piGm3z8StSu68OnDv5EiSaRGU8RAcxotCQRiRFm39aKfmCseT2skq2rVqmziIBza0bcIQKjpNqNJV30zQmqv8yN+yEYUyKP12Qm3Mb6LHUcHB2+TAXhoWLOUiOMHw/xc7a50SXWUShnOUrhjgrGITR0mypUnO50cBO2CtuUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqpVP75G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqpVP75G"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso41508985e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778424028; x=1779028828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiN95M/W3RKJE3egtZ7DgExVN40C9ma45InA4oM+ByQ=;
        b=kqpVP75GftTV6QggqGSG+9c4FfdACTr8KuWJBr2LQ59IkmzFtJ/UhMYYD3Fa7sOZUC
         WZdrovplik/r8CbHESTNgAci/20KQwkZwq5EwCrUCV8KVsN1Wb3w6eUVqdXcMmWREkwO
         zAeBsFbOScmI9ydfvasdSGXkA4lftCOnc85Oi8/j8KZsHkS4VJD1ENNTYHGSl49xyGA8
         k+PVeljTdKfHgpEQQxA0Q0GRL1PBcPBuk0+esP2W+8yCQuIx7Un2N9ksY6RPTC27UwKo
         5IUaM+xvK8JVZkVtFnDsB/cU2hiWR3v5Z/qCnGJNqi7sCKEFWPbW8xP2zyKtuI/QT42q
         s7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778424028; x=1779028828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiN95M/W3RKJE3egtZ7DgExVN40C9ma45InA4oM+ByQ=;
        b=Cv5jORndT3OiKcjnQ0bLNnL+DsH9BION0LxPjWCGz6lGkcJIDpuT7If2VQJeol3hCL
         rTmImC3wsf6yTxwE1v3VyIgI+/1HolztN9G2XaDyoMntwHdTJkds15xUMGPDafvTSR26
         e0b1l7Gz1PP2IwRmfPKAgugko8L128V64MRkVGxWYCuFVH/TXeEt1RDaIo6Oeei4hJEI
         0ZYH+KWXuSlwGrRsVDDzSMAVbWkgkQyFVKFNIqXKm4NCaW9PQVXuVTf0/21XHPzp55P8
         /w7vghVvwBp+lO5MAiMbDBo5orG/DHECbb/J19KjjrITovXU+zx73J1F2CI25me+IQvL
         tbow==
X-Gm-Message-State: AOJu0YxB8ZrfPfa2RfagKdfQ0xGyhYfOxtyf40mSAK55xP9UNfwv+OE4
	CAMh0s1lEzp+WtPvmkDb9P9vAOtIeYH+uMJq0idF/l3fU4PaLn9B7AGM
X-Gm-Gg: Acq92OHUNHp26txGX11/VCaL0Az5J6drBByVKyUiVIRcebXE0kLTdCYFQnkP1xkuiBk
	u+GwDnFslefWwBTpaHQQQmLCks1JEcGeDWtvzhMj9bcc2CgY00vPFl/8rGZSG/3oxhgJC4phwpr
	h+pdJ4wBlgL+dKCbrzh9uDY8yRWhVcXxaHWGq6Z4FXEpUe3MgntRx0O0rbGRMG2AACRrGzPUBR5
	xseqVP5hsNkWi4K/Sm6GBI62vR33654X7u4aUwFJaeJybvgiBgaATmZB1BhAP9ggrdaebTlJRRN
	oftuIMhQ9fr+NLIc1NwjIwOJIyH9elwEurUby59R+19ufJe9YUDZ/H41Dt7AAxLc7phAzbToPyp
	sGNgRHiYvZ5J00sn4L+gznVX42gvakqdt3w8LccSKCWgZe0BqoSzUxxGixk9+29d4b+t/cJl63F
	SC2SToy8n9bPSCUeSAxGRqTYrRRWmVdiflZ9PXi4pdltiVcUK3znWZ3Yz/cCVKWEuQitZ1hb+pI
	ja5wMXQ
X-Received: by 2002:a05:600c:4512:b0:489:284:44ab with SMTP id 5b1f17b1804b1-48e51e1deedmr319196545e9.12.1778424028175;
        Sun, 10 May 2026 07:40:28 -0700 (PDT)
Received: from jernej-laptop.localnet (46-150-62-216.dynamic.telemach.net. [46.150.62.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db09943sm44844115e9.19.2026.05.10.07.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 07:40:27 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Michal Piekos <michal.piekos@mmpsystems.pl>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add GPADC for Allwinner A523
Date: Sun, 10 May 2026 16:40:26 +0200
Message-ID: <5JZHjuPfR4qv95vQhkLpDg@gmail.com>
In-Reply-To: <20260510-sunxi-a523-gpadc-v1-1-4f6b0f4000fb@mmpsystems.pl>
References:
 <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
 <20260510-sunxi-a523-gpadc-v1-1-4f6b0f4000fb@mmpsystems.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 10. maj 2026 ob 14:57:22 Srednjeevropski poletni =C4=8Das je M=
ichal Piekos napisal(a):
> Add support for the GPADC for the Allwinner A523. It differs from the
> D1/T113s/R329/T507 by having two clocks.
>=20
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> ---
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         | 37 ++++++++++++++++=
+++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d=
1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d=
1-gpadc.yaml
> index da605a051b94..89da96cd705f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc=
=2Eyaml
> @@ -17,6 +17,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun50i-h616-gpadc
> +              - allwinner,sun55i-a523-gpadc

It shouldn't be combined if it has different number of clocks.

Best regards,
Jernej

>            - const: allwinner,sun20i-d1-gpadc
> =20
>    "#io-channel-cells":
> @@ -29,7 +30,12 @@ properties:
>      const: 0
> =20
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> =20
>    interrupts:
>      maxItems: 1
> @@ -40,6 +46,35 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            - const: allwinner,sun55i-a523-gpadc
> +            - const: allwinner,sun20i-d1-gpadc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - description: Bus clock
> +            - description: Module clock
> +        clock-names:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - const: bus
> +            - const: mod
> +      required:
> +        - clock-names
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names: false
> +
>  patternProperties:
>    "^channel@[0-9a-f]+$":
>      $ref: adc.yaml
>=20
>=20




