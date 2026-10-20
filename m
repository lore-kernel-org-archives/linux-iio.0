Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482254;
	b=jbwMybS76X65KRDEHC7cCGvn+LfUaIASyTeRtNl73m8DJ2dtOE9JdnIDzP52xRkNOhr7
	 q2uSiu0T/IQx4WPiM5heWHxeAqYM1WEo43VI5RrFNkBPk2zQH+6nvGiZ1OaKE8Apbribh
	 TC6rrVlTnLCH11a+Dx24bu24djiejmeEKx/Lcmo4mk1XTBcSiUFw/GV4yFOpqf2JMcMIa
	 4+T7zmy42Anz2QEWXO8SJXBv7YDDTbn+Y2C7A69sqzzR58p1TtzXN8tDxHKqZLGIZ2GIi
	 fwLMfJmJZ2gJUB90rap4KHbMhujzVYBZSIZP54x6OxMuqXcwsuQSQbUBRD5Na1YrGWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482254;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7Y4VaQCrShEsWxxC8upZ8USfPAGufEQjClAhPLxVnY8=;
	b=0SXGOwYBpMo33ZwdXe32yfoMLStm8/ei7yE5Ym9IEdtHBNfDKlsRSHF56tnhr1x58ucU
	 E8NoMAYfytdLBbsGGyXU463RX3gyeXnsqKfVuaxze507DpMTwmSEnpfUkAjSqZKVLQCM4
	 JbUk6i7dWkpjEf/8R0bQDXhQ9z5Nw1O/REsLXiIi65+NvnkhTliy2Xo6PNUBs8upue1Mz
	 phOGYMTTu9uc11VdxzNTo/QY1TkwCC0OTJVpZtW7DLq+FprTaBN3rwEQRT+XcliPqGboD
	 eZ7XZhyUFAhzoH3Gq/bqv81sjszJJfvTumGovx5A42f/QMUCYyRX5gyRzB8Ja2hoOHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCv57Sxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467A606A31B;
	Tue, 20 Oct 2026 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCv57Sxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90DD1F000C4;
	Tue, 20 Oct 2026 07:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792482253;
	bh=7Y4VaQCrShEsWxxC8upZ8USfPAGufEQjClAhPLxVnY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SCv57SxiiuXtOSfzY0OYUlA0539SNx5dCCUTriu5hhXsrUAnxP4MafOSj4vu2pV1q
	 9AYylJK2787bqXFQi6vE5KgasL4iCvHptC1a5VAt2zXoTeXBu6xx6Vr+/IKQUdaz1+
	 4Y9uiuz/JsMJ+lk/bSD7KDqq5AocERifQq9awsUt51srkOwRBn+pzuloD/KtbVA3zW
	 7MQA9HF1815+OqA2HxYr1g7prR8Up189vK2aC9C5s2pVBAbPqnFFQP0SktdEKQ7ZRZ
	 FY6AepX5XJGJfh442KWGPXPNolXVyZ8Rc+0tqlgdr0PW246Lh909TDhM2NXX9f2LT/
	 Kr692trdJ4w5Q==
Date: Tue, 20 Oct 2026 09:44:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add TI ADS1299
Message-ID: <20261020-fast-amber-myna-10b121@quoll>
References: <20261019001247.483005-1-stephanbrrs8@gmail.com>
 <20261019001247.483005-2-stephanbrrs8@gmail.com>
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
In-Reply-To: <20261019001247.483005-2-stephanbrrs8@gmail.com>

On Sun, Oct 18, 2026 at 09:12:46PM -0300, Stephan Costa Barros wrote:
> The ADS1299 is an 8-channel, 24-bit, simultaneous-sampling biopotential
> (EEG) analog front-end with an SPI interface. The ADS1299-6 and ADS1299-4
> are the same part with six and four channels.
> 
> One converter can drive its clock out of its CLK pin to the others
> (#clock-cells), and converters sharing a chip select in daisy-chain mode
> are described as one node with #daisy-chained-devices.
> 
> Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1299.yaml          | 221 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 227 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml
> new file mode 100644
> index 000000000..a8966cd07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml
> @@ -0,0 +1,221 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1299.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS1299 biopotential analog front-end
> +
> +maintainers:
> +  - Stephan Costa Barros <stephanbrrs8@gmail.com>
> +
> +description: |
> +  Texas Instruments ADS1299 family: low-noise, 24-bit, simultaneous-sampling
> +  biopotential (EEG) analog front-ends with an SPI interface. The ADS1299 has
> +  eight channels, the ADS1299-6 six and the ADS1299-4 four.
> +
> +  Each channel has its own programmable gain amplifier and a multiplexer that
> +  can select the electrode inputs, a shorted input, the internal test signal,
> +  the supply or the temperature sensor. The part also provides lead-off
> +  detection and a bias drive amplifier for the driven reference electrode.
> +
> +  The converter signals a completed conversion on its DRDY output and is read
> +  over SPI in mode 1 (CPOL=0, CPHA=1).
> +
> +  Several converters can share one SPI bus in two ways. In cascaded mode each
> +  has its own chip select and its own node; one of them can drive its internal
> +  oscillator out of its CLK pin (#clock-cells) for the others to use as their
> +  external clock. In daisy-chain mode they share the chip select and DIN, the
> +  DOUT of each one feeds the DAISY_IN of the one before it, and the chain is a
> +  single node with #daisy-chained-devices. A daisy chain shares DIN, so every
> +  register write reaches every device: the devices run with one configuration
> +  and from one external clock, and the bias drive amplifier cannot be used.
> +
> +  https://www.ti.com/lit/gpn/ads1299
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1299

This should be then "-8" variant?

> +      - ti,ads1299-4
> +      - ti,ads1299-6
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      The DRDY output of the converter, asserted low when a conversion is
> +      ready to be read.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: The active-low RESET input of the converter.
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      The active-low PWDN input.
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      External clock on the CLK pin, used when the CLKSEL pin selects an
> +      external clock. Omit when the part runs from its internal oscillator.
> +
> +  clock-names:
> +    const: clk

Drop clock-names

> +
> +  '#clock-cells':
> +    const: 0
> +    description:
> +      The CLK pin as a clock output, for a part whose CLKSEL pin selects the
> +      internal oscillator.
> +
> +  clock-output-names:
> +    maxItems: 1

Best regards,
Krzysztof

