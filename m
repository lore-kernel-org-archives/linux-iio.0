Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4B370AD8;
	Sun, 21 Jun 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782067273; cv=none; b=nSdUYZpQvrnE8wbRapZZv51wLoM1e8Z/PlJMk2FNpZiOLj4pv2HmIlTzR1fmpy4sTi8iCfrlULA2oFtnGgZHhkKbVOivrAivyYXVRFqjAh9t0Qciiyaud5Tqu5D0ZYIg9CiDcrYYhoEIUd34gxMgYe8qf/HN85Jg8Ujb1Ajn2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782067273; c=relaxed/simple;
	bh=dsQ4Ae8F+JT5O/DEKu5JsPkMEqQti42lFa8zOlgYskY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhhtpzZyVKmPAGB9ewOWaZ8VwtATE+ZpJnUdt7g4g+9u+88OMTHuOYVZ5oAh7032BgQzhgyJZUNE7zSt65thgN9TOQn6mM/D/FbxrsCrKuOfUPOEYaftdQz8iBnhE58vOaVIVSfmz2VVfgHZ+S8l0Y3/qeJdB1GMhZKPa139yaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6uAS50k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6uAS50k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502EE1F000E9;
	Sun, 21 Jun 2026 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782067271;
	bh=B8uxtvzXAZ4mCPG2HydV/CVa4cfcEhGQfZwREnSmGvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d6uAS50kBmcMWWC/Xz9wqKt56Cb2kugvVRFEFDHTfkbq+ZSQSWJ3VEBC2KEX6ZVlK
	 V5yaHEv00w2V9/W8/PQSt3ExU+Qpz2fLe2S14qHgCelG0xQNyufbrXvCSeZk/7tRxD
	 upiUmRNzCj8pGVMdLo+eV86bf0KCxfDlc2m69Jqs82aMYMIjMvMQEqMR+3e8PIuUDO
	 66blx00N/2JX9rfP7aKhKr7L1tbS2syUHhmXQX3Dh4sAKHsnEbq6NmACehjSTfFy++
	 751rDs3xCrTKRSt5RYPwik53e+xGMvJ1P1Pl/gx18k9V1nxzG7QWEZhvyNbTBWFiyA
	 HP8eVW+fYQXxw==
Date: Sun, 21 Jun 2026 19:41:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260621194102.08d7fdd6@jic23-huawei>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
	<20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 16:59:59 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add new bindings for ti,ads122c14 and similar devices.
> 
> This is an ADC that is primarily intended for use with temperature
> sensors. There are a few unusual properties because of this. In
> particular, the reference voltage source and current output requirements
> can be different for each measurement, so these are included in the
> channel bindings.
> 
> The REFP/REFN reference voltage is usually just connected to a resistor
> that is being driven by the ADC's current outputs, so there is special
> property for this case rather than requiring a regulator to be defined
> to represent that.
> 
> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> have preferred an enum of strings).
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

A few queries inline though I'm only just starting to get my head
around this device...

Thanks

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
>  3 files changed, 242 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> new file mode 100644
> index 000000000000..dc7f37cad772
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> @@ -0,0 +1,224 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ADS112C14 and similar ADC chips
> +
> +description: |
> +  Supports the following Texas Instruments' ADC chips:
> +  - ADS112C14 (16-bit)
> +  - ADS122C14 (24-bit)
> +
> +  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
> +
> +  These chips are primarily designed for use with temperature sensors such as
> +  RTDs and thermocouples. The channel bindings reflect this in that each channel
> +  represents the conditions required to make a measurement rather than strictly
> +  just the physical input channels.
> +
> +maintainers:
> +  - David Lechner <dlechner@baylibre.com>
> +
> +unevaluatedProperties: false
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads112c14
> +      - ti,ads122c14
> +
> +  reg:
> +    items:
> +      - minimum: 0x40
> +        maximum: 0x47
> +
> +  clocks:
> +    maxItems: 1
> +    description: Optional external clock connected to GPIO3 pin.
> +
> +  avdd-supply: true
> +  dvdd-supply: true
> +
> +  refp-supply: true
> +  refn-supply: true
> +
> +  refp-refn-resistor-ohms:
> +    description:
> +      The resistance of the external resistor between REFP and REFN when using
> +      resistor bridge driven by current outputs for RTD measurements.
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: FAULT interrupt (GPIO2 pin)
> +      - description: DRDY interrupt (GPIO3 pin)
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [fault, drdy]
> +
> +  gpio-controller: true
> +  '#gpio-cells':
> +    const: 2
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  ^channel@[0-7]$:
> +    $ref: adc.yaml
> +
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        maximum: 16 # arbitrary limit, channel@ can be any combination of AIN0-AIN7
> +
> +      single-channel:
> +        maximum: 7
> +
> +      diff-channels:
> +        items:
> +          maximum: 7
> +
> +      bipolar:
> +        description:
> +          Set this flag if the differential input can be negative.

I'd leave that description to adc.yaml   Maybe that doc could be improved though
given it basically says bipolar == bipolar mode ;)

> +
> +      excitation-channels:
> +        description: AINx pins used as current output.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 2
> +        items:
> +          maximum: 7
> +
> +      excitation-current-microamp:

There seem to be separate controls. Are their usecases where this needs
to be in array?

> +        description: The current output of the excitation channels in microamps.
> +        minimum: 1
> +        maximum: 1000
> +
> +      current-chopping:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          If provided, the two excitation channels are to be used with current
> +          chopping enabled.

Can I have a reference for that? My initial read suggests it's the input channels
that are chopped.  For GC_EN
"When enabled, the device automatically swaps
the analog inputs and takes the average of two consecutive conversions to
cancel the internal offset voltage"


> +
> +      ti,vref-source:
> +        description: |
> +          Indicates the source for the reference voltage for this channel.
> +          0 - Internal 2.5V reference
> +          1 - Internal 1.25V reference
> +          2 - External reference (REFP-REFN)
> +          3 - AVDD as reference
> +
> +          For convenience, macros for these values are available in
> +          dt-bindings/iio/adc/ti,ads112c14.h.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 3
> +        default: 0
> +
> +    dependencies:
> +      excitation-channels: [ excitation-current-microamp ]
> +      excitation-current-microamp: [ excitation-channels ]
> +      current-chopping: [ excitation-channels ]
> +
> +    oneOf:
> +      - required: [ single-channel ]
> +      - required: [ diff-channels ]

> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/ti,ads112c14.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@40 {
> +            compatible = "ti,ads112c14";
> +            reg = <0x40>;
> +
> +            avdd-supply = <&avdd>;
> +            dvdd-supply = <&dvdd>;
> +
> +            /* 3-Wire RTD: Two IDACs, One Measurement (AIN1-AIN2) */
> +
> +            refp-refn-resistor-ohms = <500>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +              reg = <0>;
> +              diff-channels = <1>, <2>;
> +              excitation-channels = <0>, <3>;
> +              excitation-current-microamp = <500>;
> +              current-chopping;
> +              ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
> +              label = "rtd";
> +            };
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/iio/adc/ti,ads112c14.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@40 {
> +            compatible = "ti,ads112c14";
> +            reg = <0x40>;
> +
> +            avdd-supply = <&avdd>;
> +            dvdd-supply = <&dvdd>;
> +
> +            /* Resistive Bridge Measurement With a Thermistor for Temperature Compensation*/
> +
> +            refp-supply = <&avdd>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +              reg = <0>;
> +              diff-channels = <6>, <7>;
> +              bipolar;
> +              ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
> +              label = "bridge";
> +            };
> +
> +            channel@1 {
> +              reg = <1>;
> +              diff-channels = <1>, <2>;
> +              ti,vref-source = <ADS112C14_VREF_SOURCE_INTERNAL_2_5V>;
> +              label = "thermistor";

Hmm. I'm interested to see where this goes, but generally when we have
a thermistor we attempt to ultimately convert it to a temperature
channel and I'm not seeing info here to allow us to do that.

> +            };
> +        };
> +    };


