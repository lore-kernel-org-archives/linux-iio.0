Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314637F8BC;
	Thu, 13 Aug 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640271; cv=none; b=XH7vmk+BdlclpC0aOEHL9CNy4yFiWgzqRoWFnpxLth3ZLSv1/+R34M+h4mTugXhJpo5bP3NhVe5ZEEh6+al01quWRPW2T9c6YgnDYHGNlfjX2bpMz/ii449ydkUI1iGomnH53xTw34O1qC11t5db/aQv8F5yQ1L93n2ck3dnMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640271; c=relaxed/simple;
	bh=ZfxzHOqUt7VtQWz+0x3Kti3u9lFKTwZXzho0nnkkCWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PW4ZQ5FtYdXdQ1quX9Ay9XbZhLWEKtOIt4zAC+wcnq2eGe5zKv2ZIlHx2Fdgx6W9FXgj1+/X9qkx/iItlM5VJPl1Aa6XSLanqd/2yJjPQ3zjkNJyTzyWXvfGVGvJcsSjQqXEC+Y0v1W2lCvDqsNaucvWkoGacwvuFbhOESkxGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cksg9at1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cksg9at1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC501F000E9;
	Thu, 13 Aug 2026 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786640269;
	bh=SnwT1cEHRJvEYqBT7Fjk6kDERfhS+0474YvEZn9Xqh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cksg9at1sQGUSS0NrCzd8ull+5iK8CkNXs0UW0P0SaSc6zgAxQuXKVXKxt3zt9q6Q
	 qqGTClvV3J6P6igpJ0EHo5A+ByQHvtCwjLpKfyiIm5a43YSmEKYfyH5bX2TQW1qkF0
	 p1ZIMxjfUbwl5nQenvb3anYnJn9rRpQ/PjZ177Dqtg2dOBWk8JDR2gxDm5gmWL+lRD
	 pYk1JNQ1RwMI+AFHZWnCmIPWbgukaTvPkRuVztKXbO5+nELZtOg2PTgqqjKEtNl2U0
	 YlNXAVWd49pLN+NIJ73QoM5aPCrF6WoXNG+N2EoIcRQXjdBWz/JB3Qph+PUenRcWB6
	 Vkwt4WfJY7tUA==
Date: Thu, 13 Aug 2026 11:57:48 -0500
From: Rob Herring <robh@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
Message-ID: <20260813165748.GA2065977-robh@kernel.org>
References: <20260813-ti-ads112c04-driver-v5-0-79dff9e249cd@gmail.com>
 <20260813-ti-ads112c04-driver-v5-1-79dff9e249cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-ti-ads112c04-driver-v5-1-79dff9e249cd@gmail.com>

On Thu, Aug 13, 2026 at 11:06:02AM +0800, Kyle Hsieh wrote:
> Add device tree binding documentation for Texas Instruments ADS112C04
> I2C Analog-to-Digital Converters.
> 
> These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> interrupt output.
> 
> The binding uses child nodes to dynamically define the connected
> single-ended or differential channels.
> 
> Excitation current, burn-out current, and reference source properties
> are also included to fully describe the chip's hardware capabilities,
> aligned with the ti,ads112c14 binding conventions.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 148 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 154 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> new file mode 100644
> index 000000000000..68a0df21cedd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c04.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS112C04 ADC
> +
> +maintainers:
> +  - Kyle Hsieh <kylehsieh1995@gmail.com>
> +
> +description:
> +  The ADS112C04 (16-bit) are precision analog-to-digital converters (ADCs)
> +  with an I2C interface. They feature a flexible input multiplexer, a
> +  low-noise programmable gain amplifier (PGA), two programmable excitation
> +  current sources, a voltage reference, and a precision temperature sensor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads112c04
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Data ready (DRDY) interrupt output.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the RESET pin. Active low.
> +
> +  avdd-supply: true
> +  dvdd-supply: true
> +
> +  refp-supply: true
> +  refn-supply: true
> +
> +  ti,refp-refn-resistor-ohms:
> +    description: Resistance of the external resistor between REFP and REFN.
> +
> +patternProperties:
> +  "^channel@[0-9a-b]$":
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        items:
> +          - maximum: 11
> +
> +      single-channel:
> +        maximum: 3
> +
> +      diff-channels:
> +        items:
> +          maximum: 3
> +
> +      excitation-channels:
> +        maxItems: 2
> +        items:
> +          maximum: 5
> +        description:
> +          Additionally to AIN0-AIN3, IDAC1/IDAC2 can also be routed to
> +          REFP0 (4) and REFN0 (5).
> +
> +      excitation-current-nanoamp:
> +        items:
> +          - enum: [10000, 50000, 100000, 250000, 500000, 1000000, 1500000]

Drop 'items'. Just enum is enough.

> +
> +      burn-out-current-nanoamp:
> +        items:
> +          - const: 10000

Just 'const'

> +
> +      reference-sources:
> +        items:
> +          - enum: [internal, external, avdd]
> +            default: internal

default for an items entry doesn't make sense as the entry has to be 
present. Instead (at the same level as 'items'):

default: [ internal ]

> +
> +    dependencies:
> +      excitation-channels: [ excitation-current-nanoamp ]
> +      excitation-current-nanoamp: [ excitation-channels ]
> +
> +    oneOf:
> +      - required: [ single-channel ]
> +      - required: [ diff-channels ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - dvdd-supply
> +
> +dependencies:
> +  refn-supply: [ refp-supply ]
> +
> +oneOf:
> +  - required:
> +      - refp-supply

Just to make sure, refp-supply is allowed without refn-supply? If not, 
either this should be refn or the dependencies reversed.

Rob
