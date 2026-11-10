Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337711;
	b=wRODWCoxYRl8JTpxpUk0mbo1pCngaLAQZVP79zUkWhduQ7uZhjMUIWRIhLuvRMN7ODF5
	 +OK44t0R47AFPqitZcwOkZxRmnwwQpDt5V8p21JYjb0yscr8iYZ1w6Jhnw71VkvNITkuR
	 wDZvbsDoIpcKtcWa8dJ0IoVjCus8SeL53zlmXfVeyj5oObooQjw2kMHR/mKtn3NM9hzbT
	 vaJ/8jxVTxMnmMO6szhROk/l6oiv4rhJHgVZwo5QxgvnoHwWFCuk8+UdI+0yNTo14lkGX
	 C8phiJXJN/2HhiiEgfaDrEK0PL1VnOh7pdWrNknsiHTZAOpFsSf7mc+KUpeYt5RmaJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337711;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Z6pS0ch2CwFHPRRjJX7/z7pWv4eyopkIkegoRahrCwo=;
	b=ozSJ01UWiSdRAcNYU+wYRX4YJ88y1f4NnQByw2HdcqmAEQlT2d6ffjzesPM6HeR/So9U
	 FMGPvNx3/QYVk16kO0S7ObwF0G0cRdJwTDVQEtcNqp90m801Fijtbo/o/Dy6KeSSwxqJH
	 QCdhktxVjq+aMA1xBA+J+dckccr9LaqYgwwWiBzCi1JaycWf1ADyw7fbiGimlTxK79z3O
	 4q8dKT0fwclwWb5MIjaDoQWGM6+pCOF6Utc7SSj2KsYLSO++ftfAyWrzuVKOPhxOWx77H
	 Zgg3RqSzHJE5KHfKSnCgDSdluwzJke8UQJiJg+3oo2vKn4xW8do/XYwOE5ZsHmEVQxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUFKC5k3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08539606A31C;
	Tue, 10 Nov 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUFKC5k3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B871F0089F;
	Tue, 10 Nov 2026 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337710;
	bh=Z6pS0ch2CwFHPRRjJX7/z7pWv4eyopkIkegoRahrCwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DUFKC5k33lGxs951RApJ8qlUjrgqKsXofFFAM8hutRwdx5PHD6pzfNSZD8OnDd2Sl
	 PBKgPByVdl/Mj0TaSzI5LmCgcmQueELQHX89qeDcYPDijMw1Rc0YuD0gsDpTjyqYDy
	 7ue5FpAlufjswMLX7fswVWUgux2W460gJU6/kHPN1Z0IdLRdcI0uNTQindAUxy1wzo
	 OA7QKoARBYa8JmW1lP168Q41vt8pf/X0uCvNwnCCXStnLbjgIVXVDfazoa/YL5Ol80
	 8T9AXVMNVl00H2ThsrmOGmQFt4uC0qqp0vy4TsWyARecs/wN9I4sPXzXvzqHXfcoKl
	 wx/CaW2Rw0f9g==
Date: Tue, 10 Nov 2026 13:08:27 -0600
From: Rob Herring <robh@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Message-ID: <20261110190827.GA1322356-robh@kernel.org>
References: <20261104091136.151269-1-cwweng.linux@gmail.com>
 <20261104091136.151269-2-cwweng.linux@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104091136.151269-2-cwweng.linux@gmail.com>

On Wed, Nov 04, 2026 at 05:11:35PM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add a binding for the Enhanced Analog-to-Digital Converter found on
> Nuvoton MA35D1 SoCs.
> 
> The controller has eight external analog inputs. They can be used as
> single-ended inputs or as the four fixed differential pairs 0-4, 1-5,
> 2-6 and 3-7.
> 
> Use the common ADC channel properties to describe the physical input
> independently of the logical channel index.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> new file mode 100644
> index 000000000000..85b0feac0236
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
> +
> +maintainers:
> +  - Chi-Wen Weng <cwweng@nuvoton.com>
> +
> +description: |
> +  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
> +  12-bit successive approximation converter with eight external analog
> +  inputs and one internally connected VBAT input.
> +
> +  The external inputs can be used as eight single-ended channels or as
> +  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
> +  connected VBAT input is not described by a channel child node.
> +
> +  The controller provides four interrupt outputs, ADINT0 through ADINT3.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-eadc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: ADINT0
> +      - description: ADINT1
> +      - description: ADINT2
> +      - description: ADINT3
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      Optional external reference voltage connected to the VREF pin. If this
> +      supply is absent, the controller uses its internal 1.6 V reference.
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx
> +
> +  '#io-channel-cells':
> +    const: 1
> +    description:
> +      The cell selects the logical EADC channel identified by the reg value
> +      of the corresponding channel child node.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^channel@[0-7]$':
> +    type: object
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    description: |
> +      External EADC channel description. The reg property identifies the
> +      logical IIO channel index.
> +
> +      A single-ended channel may use single-channel to select an external
> +      analog input independently of reg. If single-channel and diff-channels
> +      are both absent, the external analog input is selected by reg.
> +
> +      A differential channel uses diff-channels to select one of the fixed
> +      hardware input pairs: 0-4, 1-5, 2-6 or 3-7. Each single-ended input
> +      and each differential input pair may be described at most once.
> +
> +    properties:
> +      reg:
> +        maximum: 7
> +
> +      single-channel:
> +        maximum: 7
> +
> +      diff-channels:
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - const: 4
> +          - items:
> +              - const: 1
> +              - const: 5
> +          - items:
> +              - const: 2
> +              - const: 6
> +          - items:
> +              - const: 3
> +              - const: 7
> +
> +    allOf:
> +      - not:
> +          required:
> +            - single-channel
> +            - diff-channels
> +
> +    required:
> +      - reg

The allOf and required are effectively covered by adc.yaml already.

Rob
