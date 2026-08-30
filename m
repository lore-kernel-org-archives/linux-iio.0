Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5521A434;
	Sun, 30 Aug 2026 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788054835; cv=none; b=qU87e4O6R9rebnTbogBpJPjBf5lUnps1EPXC9s+ZiUy0XtkpHZKskAVMBW68nfmv/RrmIOfsnqZ9lY/zSHnLzbheGlgO5+wILHp9S79URAhykOgG41K7x/tru3sPZ0R+ye0q8pO3HLZnvlZ1LMemjBe+xoK3m0ynuPbQF8kI3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788054835; c=relaxed/simple;
	bh=pTB3XvvAiCD+y/VRSnUlPiLAnbkLYlq89CJD9xHQ/Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+G/BXRhDhsIVnAMGgjvH2gjaubblNHgMMMPcSCEwOJnjk79gwUrj3YxnF07S4FNro++IMrn23PtiDJ2wdny5opwoAA1CJ4p3tIYn8uJnrqfmoA0k/g86GybjsMoKltaHBeHxX7+ljWoMnMGy7Hxmahat5j+ao17mRkOhd7xmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9LdVsmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9LdVsmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474761F000E9;
	Sun, 30 Aug 2026 01:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788054834;
	bh=YZq3Tk9qKnmvU1FZ+VODASllHwtVUNI8FVbWma4zbVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W9LdVsmDnPo7lfAMwXJyclwn7AlgZgwMdD0uJLmWSAIOOPw9LwbaLCmQNjxe0AP64
	 gj1bOVgpx40ktN3tnVhwBHqIvKvlX6+U1HLr4Fz4Dy6+xTlWvoy4bH/A9URzQsFDP/
	 QmVjPBwW0CNSWDVIZaQ/C0To9XH3IeBchhRJzGel23i6JRQbWN/pdsQbfUonuRLlii
	 +tbSUkVOcPHBvrN1LQS2F8WKcLAOYbd/2NB8yP5Cv4QEpviqZfPpTiu7SXHTjeFdjw
	 hkGw4DZ7cBx+qD8qyn5Mdr2BxM8/lA8umLekKanvbRiSuXNxZ630fMbq6vLHvVzsJF
	 7By8yw1qkpS0g==
Date: Sun, 30 Aug 2026 02:53:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
Message-ID: <20260830025349.04ddbd1f@jic23-huawei>
In-Reply-To: <20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
	<20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 01:38:17 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
> integrated PGA, internal reference, excitation and burn-out current
> sources for sensor biasing and diagnostics. The ADS1263 is compatible
> with ADS1262, but includes a second auxiliary ADC (ADC2) to perform main
> channel (ADC1) cross-checking measurements, system background
> measurements, or temperature compensation of the primary sensor.
> 
> Both parts can configure per-channel voltage reference source,
> excitation current sources (IDAC), plus input and IDAC chopping for
> offset and IDAC mismatch cancellation. This lets the device drive and
> ratiometrically measure RTDs and other resistive sensors.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
A few queries in here from me.

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 376 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 382 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> new file mode 100644
> index 000000000000..7e26572388e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml

> +  '#io-channel-cells':
> +    minimum: 1
> +    maximum: 2
> +    description: |
> +      The first cell selects the channel by its reg. The second cell selects
> +      between the main ADC (ADC1) and the auxiliary ADC (ADC2) as follows:
> +        0: ADC1
> +        1: ADC2

This one is odd enough I wonder if we just say it is always 2 and that
for the parts with out an ADC2 the value of the selector cell can only be
0. Also, does this ordering make sense?  Maybe pick the ADC with first
parameter is more natural?

> +
> +  '#gpio-cells':
> +    const: 2

> +patternProperties:

...

> +      reference-sources:
> +        minItems: 2
> +        description:
> +          Indicates the reference sources for this channel. The first and second
> +          items are the positive (REFP) and negative (REFN) sources of the main
> +          ADC (ADC1). The third item is the reference source of the secondary
> +          ADC (ADC2) and must always have a positive differential voltage.

I think it would be good to illustrate the 2 only case in the first example.

> +        items:
> +          - enum: [internal-p, refp1, refp2, refp3, avdd]
> +          - enum: [internal-n, refn1, refn2, refn3, avss]
> +          - enum: [internal, refp1-refn1, refp2-refn2, refp3-refn3, avdd-avss]
> +
> +      ti,reference-reversal:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Indicates that the ADC1 (this has no effect on ADC2) reference voltage
> +          for this channel has negative polarity and thus should be internally
> +          reversed.
> +
> +      excitation-channels:
> +        minItems: 1
> +        maxItems: 2
> +        description:
> +          Selects the pins for the IDAC sources from 0 (AIN0) to 10 (AINCOM).
> +          The first value corresponds to IDAC1 and the second to IDAC2.
> +        items:
> +          minimum: 0
> +          maximum: 10

Why do we allow configurations with just IADC1 (minItems: 1) but not those
with just IADC2?

> +
> +      excitation-current-nanoamp:
> +        minItems: 1
> +        maxItems: 2
> +        description:
> +          The first value corresponds to IDAC1 and the second to IDAC2.
> +        items:
> +          enum: [50000, 100000, 250000, 500000, 750000, 1000000, 1500000,
> +                 2000000, 2500000, 3000000]
> +
> +      excitation-current-chopping: true

> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads1263
> +    then:
> +      properties:
> +        '#io-channel-cells':
> +          minimum: 1
> +          maximum: 2
> +      patternProperties:
> +        "^channel@[0-9]+$":
> +          properties:
> +            reference-sources:
> +              minItems: 3
> +              maxItems: 3
> +              default: [internal-p, internal-n, internal]
> +    else:
> +      properties:
> +        '#io-channel-cells':
> +          const: 1
> +      patternProperties:
> +        "^channel@[0-9]+$":
> +          properties:
> +            reference-sources:
> +              minItems: 2
> +              maxItems: 2
> +              default: [internal-p, internal-n]
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads1262";
> +            reg = <0>;
> +            spi-max-frequency = <8000000>;
> +            spi-cpha;
> +            avdd-supply = <&avdd>;
> +            dvdd-supply = <&dvdd>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "drdy";
> +
> +            /* Typical common mode voltage configuration */
> +            aincom-supply = <&ads1262_vbias>;
> +
> +            regulators {
> +                ads1262_vbias: vbias { };
> +            };
> +
> +            channel@0 {
> +                reg = <0>;
> +                single-channel = <0>;
> +                /* The VBIAS is enabled on pin 10 (AINCOM) */
> +                common-mode-channel = <10>;

As above, I'd like a dual reference source example usage on
a channel here.

> +            };
> +        };
> +    };
