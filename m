Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267271;
	b=zAMfmdHyYDCaqGvwLPxieDG5tQmsz6xM9Mk6UsgqzX0gweuxA3U6tuUXF3QD9IeCXq7I
	 kjpv/Lp/Xr3mMk94HJAcgNOcR3ZP6iM8tGQaM2j4ZFxMKtrk1jxnPWkERopCUMHZBzIAb
	 G6tjfNzIvEOofSoZpVaZs3mm1uEf5O4kaScSsYuKKwvLoHbZMm46BiGsJ0oupwdEvIJM5
	 J+uT2b2dpfHvnlXb6LiRSSy3/O/9Ux3b3HRU+Y7smlB55pWdq+OE3EZPXMQRD7enXvVka
	 Qm/oUay1NB4mhQS6tG5oYA5b8IEDFcbX8P66Pnd30TVifLx0Qmzfkjr55+vTz11ejtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267271;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JLznhEesXud6u4BhPm2aVn2jx6Uyq7IzPp7BgTwUqZA=;
	b=l3/R25hAahaChuDYFLF9g8nbRW6U1D6SPCDx8h0tNXWo1uie+XFpjgcguqnUynOoWzmr
	 kSC6xTq6FXKHkhYCgYg1LPz/AyjplqJLZgZJXlpyYeSwxKQVjiw3t+QfdvAXVuhKohIq+
	 kFT0V1/hauAu1xoFYd6A0LCEoQjeKZq7R5JO7JLp4LOaLnJa6x8XIvxFXD6kUV3b1WiJN
	 nr/gBhdcBe6RUCpf9wCXDb16+IoNmlnOYzFhBdoCbIPvZRkQplnKpwQjMMqO+pANZwbZm
	 VPqwh+ObFVvfvBAKdz01xNdkwiOWmEYe1Lc2fRBoOrWKc3fJKSrTW0+1jjNRKBuEZ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RkNO3YA/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60273606A31C;
	Thu, 29 Oct 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RkNO3YA/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D321F01825;
	Thu, 29 Oct 2026 09:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267271;
	bh=JLznhEesXud6u4BhPm2aVn2jx6Uyq7IzPp7BgTwUqZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RkNO3YA/U3bdXgOGg3qaT6s0CRkCmGtMa3IPUXdj7t1NrzXf1n+M7826uasZ34CtD
	 u3n2IDEKU+VDxWzJTSD4Gesei7glRO5XZhVaxNZcIzYIGR+0DWWHBkrxWdM4jQaPLQ
	 hpBpcNZ45+GtMjBm6XWjvunXCMZEZLpo88tml1ZGSidQQfWIwSv0FQMMdLQ6Xz0pms
	 ZEnxxO8bG+Y1txS8gMu+zcnUsVhVW3OYtZKgCH4TIb/kMTkpucUlJdhKWU3ru7sgOn
	 9SmAB+10cMQVk35G3nN98jR+qkGY/Jl5lxBNWTeRgarb8xaZhLJlHaUbYkZ4UpUwXG
	 p3AdtdwGwIh1g==
Date: Thu, 29 Oct 2026 10:47:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Message-ID: <20261029-rustling-scrupulous-peacock-5e6b03@quoll>
References: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261027134409.76824-2-Nicolae-daniel.Deaconescu@analog.com>
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
In-Reply-To: <20261027134409.76824-2-Nicolae-daniel.Deaconescu@analog.com>

On Tue, Oct 27, 2026 at 03:44:08PM +0200, Nicolae-Daniel Deaconescu wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> Add bindings for the LTC2387-16 and LTC2387-18, 15 Msps SAR ADCs with
> an LVDS data interface, and for the ADAQ23875, ADAQ23876 and ADAQ23878
> uModule ADCs, which pair an LTC2387 die with a fully differential
> amplifier front end.
> 
> Conversion start (CNV) and the gated LVDS clock are driven by two PWM
> channels. Sample data is captured by an AXI ADC IP core, referenced
> through io-backends. adi,use-two-lanes selects two-lane output, and
> adi,gain-milli gives the front-end gain: fixed at 2 on the ADAQ23875,
> set by pin strapping on the ADAQ23876 and ADAQ23878.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> Assisted-by: Claude:claude-opus-5-5

Drop tag. Not correct value for some time and recently checkpatch
complains. Anyway, your tag is the last one.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> ---
>  .../bindings/iio/adc/lltc,ltc2387.yaml        | 138 ++++++++++++++++++
>  MAINTAINERS                                   |   8 +
>  2 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
> new file mode 100644
> index 000000000000..f912260c8f79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2387.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology / Analog Devices LTC2387 ADC
> +
> +maintainers:
> +  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +  - Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> +
> +description: |
> +  The LTC2387-18 is a low noise, high speed, 18-bit 15Msps
> +  successive approximation register (SAR) ADC ideally
> +  suited for a wide range of applications.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/238718fa.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/238716f.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adaq23875
> +      - adi,adaq23876
> +      - adi,adaq23878
> +      - lltc,ltc2387-16
> +      - lltc,ltc2387-16-x4
> +      - lltc,ltc2387-18
> +      - lltc,ltc2387-18-x4
> +
> +  clocks:
> +    description: Sampling clock
> +    maxItems: 1
> +
> +  pwms:
> +    maxItems: 2
> +    description:
> +      PWM signals used to synchronize the sampling procedure
> +
> +  pwm-names:
> +    items:
> +      - const: cnv
> +      - const: clk_gate
> +
> +  io-backends:
> +    description:
> +      The AXI ADC IP block (axi_ltc2387) that captures the LVDS data stream.
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      External voltage reference. When absent the device's internal 4.096 V
> +      reference is assumed.
> +
> +  adi,use-two-lanes:
> +    description: The device uses two lanes for data transfer
> +    type: boolean
> +
> +  adi,gain-milli:
> +    description:
> +      Gain of the fully-differential amplifier that the ADAQ2387x modules
> +      integrate ahead of the LTC2387 die, expressed as gain * 1000. It is
> +      fixed on the ADAQ23875 and set by pin strapping on the ADAQ23876 and
> +      ADAQ23878, so it must match the board. The bare ltc2387-* parts have
> +      no amplifier.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [370, 730, 870, 1380, 2000, 2250]
> +
> +required:
> +  - compatible
> +  - clocks
> +  - io-backends
> +  - pwms
> +  - pwm-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - lltc,ltc2387-16
> +              - lltc,ltc2387-16-x4
> +              - lltc,ltc2387-18
> +              - lltc,ltc2387-18-x4
> +    then:
> +      properties:
> +        adi,gain-milli: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,adaq23875
> +    then:
> +      properties:
> +        adi,gain-milli:
> +          const: 2000
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adaq23876
> +              - adi,adaq23878
> +    then:
> +      properties:
> +        adi,gain-milli:
> +          enum: [370, 730, 870, 1380, 2250]
> +      required:
> +        - adi,gain-milli
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc {
> +            compatible = "lltc,ltc2387-16";

Use 4 spaces for example indentation.

Please run dt-check-style.

Best regards,
Krzysztof

