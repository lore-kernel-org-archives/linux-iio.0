Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012171;
	b=qshqY6jxv1iebs6F77gCdM6MebjMBAYUbPiyBJuTV3NvNfCC4rnkda2K/cu7dzv9xalu
	 3VZq8SDLx3Uavbp/fX8syccXSmVHXLjn95UUuxzo2UnBpSlMHTZ3PahlF0vUq9mmJ8lu8
	 +VsUeG1PK6J24NM8lbPS7oAiW9t8XY9jruaTEIgkTeykVFbYAectIkyfCzyhI2qv+Ow9v
	 9HcnX1mqyECTocXcP4nN3ZM5PdKox8eMlicJHwJMD95SVBmmtzTKdQWHwza7pNDNhXOr7
	 E1al6EPTjyK0sWRHMOWxswdNVWbbaVCF3KG25HK98hwxIT31zcskof2NBKoavKvQ8vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012171;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=h3jtU7GdZhongGUdwg5/sigvzLdtk/MsVeihl8ihKII=;
	b=4Iw9dLpuD6hKtWQ4RAwtXV7RaWivf+O9Kt6tz30e2rL4ZB1XVXfHKWK9mYWZLTZQfSVE
	 pOwlZj7J/52nmkd3tN9j7QqVrAr0aBTT8xeYeoDxEfugsPhdI/lj1MFI79AfEuLUJcpkY
	 hiKVJhznuGrQIsbbTKiUIDt/rRsFev/OiTCFgEWIwuyh81icsU4cN4QaBTbGrpr4RHPdj
	 gFXNQiBYvgGAP8/5vw0cj8eS7WgTw+kACFrUa5Hgk7wSog8gGjt6wD/cbAocFmJH4ycWd
	 QyzZuFBPrbzpvROuPr/z69OP7MrNrdsCJy//BXTflWkwn8mO+VoEnY1/ePr0MLlEoEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djnUBmBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056E606A31B;
	Mon, 26 Oct 2026 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djnUBmBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E471F01825;
	Mon, 26 Oct 2026 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012170;
	bh=h3jtU7GdZhongGUdwg5/sigvzLdtk/MsVeihl8ihKII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=djnUBmBJjodsQZI9aMf9Q4GlGssaeOso+iijZD/+eEVGAs70ZwRDxM6zOme29aAYa
	 VB5/OK5ADUqeoeJ+50Bua6XVHOnf+0oBn9Kv4hSsvEcAIkU2o228YG+RhFfWTxqTRp
	 Zg5NbIP1ZsOPFemKZ962hncN7NOhT2vo3Bk3uGtG0nuofI7muCAMq1Eda5ktOQvZUB
	 WRCrxJ/FyS3kaOs0fQNg7cTC2dpQ4iO+SRwA6/0KySujHbfwV09Xw2nxG6NYZ2zMPU
	 neD8wHfkl4+Q7iLVwvdGU/i7pF/CBE1SIR4OVBE+tXvvoEoMmVhyZk08XR2MFkAglG
	 ohQMug12niF6w==
Date: Mon, 26 Oct 2026 11:56:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261026-fantastic-avocet-of-opportunity-ad80be@quoll>
References: <20261024041357.34346-1-olivier@mgcrea.io>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261024041357.34346-1-olivier@mgcrea.io>

On Sat, Oct 24, 2026 at 06:13:56AM +0200, Olivier Louvignes wrote:
> +description:
> +  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input channels
> +  measured against a 3.3 V reference. Its clients select a channel by index
> +  through "io-channels".

Drop last sentence. Here you describe hardware, not how DT works.

> +
> +properties:
> +  compatible:
> +    const: ingenic,x1600-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: adc

Drop clock-names, not useful when repeats block name.

Best regards,
Krzysztof

