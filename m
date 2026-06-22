Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A2363C61;
	Mon, 22 Jun 2026 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122160; cv=none; b=SyA9YLKOlh8Xhv1M+3L18ReQx1jO36jaD5psfsO+nLmYoiCAqNjaEEXTdiJljQ3+FyaaSJjpYOTmmsLRtOpCtQwYNxrmoJSoeimgev8K6TIbV8rxI9/chdD0JFl+Hioah3Mh/hzkdXjEjdRvbdUvwnj2tuHsniNYxbbsVZAnR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122160; c=relaxed/simple;
	bh=0PFmxB9yvjZBueZq0DUUoCe7WTIyG/RThyKdOs2mtBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNU9USufQiBaJptM+LsBj1Qf3MtfCQiCH6t7scngZi7mshkHyMoC8P4chbw8TKn6fm8EgrgV5fxgV6rCfPv1iiRoZ1Usbz1Wkz8L31rViBX7KzrTsP+Dx4QbAnIP5eDsZvlhh6jj0O3yGl45pPPlIpJEkEP+79yRtQDf4LcmWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q18OySl5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q18OySl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD0D1F000E9;
	Mon, 22 Jun 2026 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122154;
	bh=J0E9tHA7sG8Cc+rACPVbxq2K6JfqmnGnnt0wIHMnA/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q18OySl5nLo/47A0teZqei9YfHqcKlxvmGrOOqALq/zsi3/1vRN2izxOLjOmOsrhG
	 eJEmuTkH7NuE42OYVzpM2kZ1DvfWMx/3B/myS+U0yiPJfwyxkB1coeZq8TUCcfNC16
	 Bsq4VhqW4rXGXGs5P+tPbfzspaLjdJGr7DW5muGhM0h8hFDwTSjDNWSaXK8fgEV/rZ
	 Swq8Y+JePGPFK8bd8I67nyrKv6+X7XZSBAJQCjFTmeftpfhfB7kvf22FUU7/ACLVEZ
	 DXMeuuZg0xJ81gYhafqhI2BqxzjQpMHORgOySrwvK/2HKgGwt4pzYVAneZUM2UpH0U
	 YPMUH5Zj9GL8Q==
Date: Mon, 22 Jun 2026 10:55:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260622105546.69c6b4bb@jic23-huawei>
In-Reply-To: <da875b00-6f93-444b-982c-30b8001dd8e0@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
	<20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
	<20260621194102.08d7fdd6@jic23-huawei>
	<da875b00-6f93-444b-982c-30b8001dd8e0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jun 2026 16:14:57 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/21/26 1:41 PM, Jonathan Cameron wrote:
> > On Mon, 15 Jun 2026 16:59:59 -0500
> > "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> >   
> >> Add new bindings for ti,ads122c14 and similar devices.
> >>
> >> This is an ADC that is primarily intended for use with temperature
> >> sensors. There are a few unusual properties because of this. In
> >> particular, the reference voltage source and current output requirements
> >> can be different for each measurement, so these are included in the
> >> channel bindings.
> >>
> >> The REFP/REFN reference voltage is usually just connected to a resistor
> >> that is being driven by the ADC's current outputs, so there is special
> >> property for this case rather than requiring a regulator to be defined
> >> to represent that.
> >>
> >> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> >> have preferred an enum of strings).
> >>
> >> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>  
> > 
> > A few queries inline though I'm only just starting to get my head
> > around this device...
> > 
> > Thanks
> > 
> > Jonathan
> >   
> >> ---
> >>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++++++++++
> >>  MAINTAINERS                                        |   7 +
> >>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
> >>  3 files changed, 242 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> >> new file mode 100644
> >> index 000000000000..dc7f37cad772
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> >> @@ -0,0 +1,224 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Texas Instruments' ADS112C14 and similar ADC chips
> >> +
> >> +description: |
> >> +  Supports the following Texas Instruments' ADC chips:
> >> +  - ADS112C14 (16-bit)
> >> +  - ADS122C14 (24-bit)
> >> +
> >> +  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
> >> +
> >> +  These chips are primarily designed for use with temperature sensors such as
> >> +  RTDs and thermocouples. The channel bindings reflect this in that each channel
> >> +  represents the conditions required to make a measurement rather than strictly
> >> +  just the physical input channels.
> >> +
> >> +maintainers:
> >> +  - David Lechner <dlechner@baylibre.com>
> >> +
> >> +unevaluatedProperties: false
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - ti,ads112c14
> >> +      - ti,ads122c14
> >> +
> >> +  reg:
> >> +    items:
> >> +      - minimum: 0x40
> >> +        maximum: 0x47
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +    description: Optional external clock connected to GPIO3 pin.
> >> +
> >> +  avdd-supply: true
> >> +  dvdd-supply: true
> >> +
> >> +  refp-supply: true
> >> +  refn-supply: true
> >> +
> >> +  refp-refn-resistor-ohms:
> >> +    description:
> >> +      The resistance of the external resistor between REFP and REFN when using
> >> +      resistor bridge driven by current outputs for RTD measurements.
> >> +
> >> +  interrupts:
> >> +    minItems: 1
> >> +    items:
> >> +      - description: FAULT interrupt (GPIO2 pin)
> >> +      - description: DRDY interrupt (GPIO3 pin)
> >> +
> >> +  interrupt-names:
> >> +    minItems: 1
> >> +    maxItems: 2
> >> +    items:
> >> +      enum: [fault, drdy]
> >> +
> >> +  gpio-controller: true
> >> +  '#gpio-cells':
> >> +    const: 2
> >> +
> >> +  '#address-cells':
> >> +    const: 1
> >> +
> >> +  '#size-cells':
> >> +    const: 0
> >> +
> >> +patternProperties:
> >> +  ^channel@[0-7]$:
> >> +    $ref: adc.yaml
> >> +
> >> +    unevaluatedProperties: false
> >> +
> >> +    properties:
> >> +      reg:
> >> +        maximum: 16 # arbitrary limit, channel@ can be any combination of AIN0-AIN7
> >> +
> >> +      single-channel:
> >> +        maximum: 7
> >> +
> >> +      diff-channels:
> >> +        items:
> >> +          maximum: 7
> >> +
> >> +      bipolar:
> >> +        description:
> >> +          Set this flag if the differential input can be negative.  
> > 
> > I'd leave that description to adc.yaml   Maybe that doc could be improved though
> > given it basically says bipolar == bipolar mode ;)  
> 
> It seems not always obvious to me which properties from adc.yaml apply
> and which ones don't to a given ADC that makes use of it. So I was
> hoping to have some way of saying that bipolar is applicable to this
> chip. 

bipolar: true

should be enough I think.

> 
> >   
> >> +
> >> +      excitation-channels:
> >> +        description: AINx pins used as current output.
> >> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +        minItems: 1
> >> +        maxItems: 2
> >> +        items:
> >> +          maximum: 7
> >> +
> >> +      excitation-current-microamp:  
> > 
> > There seem to be separate controls. Are their usecases where this needs
> > to be in array?  
> 
> I'll have to ask, but probably yes since there are separate controls
> so `maxItems: 2` would be appropriate.
> 
> >   
> >> +        description: The current output of the excitation channels in microamps.
> >> +        minimum: 1
> >> +        maximum: 1000
> >> +
> >> +      current-chopping:
> >> +        $ref: /schemas/types.yaml#/definitions/flag
> >> +        description:
> >> +          If provided, the two excitation channels are to be used with current
> >> +          chopping enabled.  
> > 
> > Can I have a reference for that? My initial read suggests it's the input channels  
> 
> No. :-)
> 
> I must have got two ideas mixed together in my head to come up with
> this. Clearly this should be `input-channel-rotation` or something like
> that (we discussed in another thread already). Also curious if you thing
> any of these properties are common enough to promote to adc.yaml or if we
> should just make them e.g. `ti,input-channel-rotation` (you might not have
> had time to read the threads on that yet).

It's turned up in a couple of drivers and the concept is fairly standard I think
so I'm fine with promoting this to a top level property if the definition can
be generic enough.

For a non TI example, the LTC2893 has this as well for it's thermistor settings.
It might be worth comparing the approach given here with what we have there.
In that case there are specific node types for different types of things that
are wired up with constraints on things like excitation currents.
It kind of constrains things to the sane known use cases.  However that is
partly because that device does (I think) more type specific handling than
we have here.



> 
> > that are chopped.  For GC_EN
> > "When enabled, the device automatically swaps
> > the analog inputs and takes the average of two consecutive conversions to
> > cancel the internal offset voltage"
> > 
> >   
> >> +
> >> +      ti,vref-source:
> >> +        description: |
> >> +          Indicates the source for the reference voltage for this channel.
> >> +          0 - Internal 2.5V reference
> >> +          1 - Internal 1.25V reference
> >> +          2 - External reference (REFP-REFN)
> >> +          3 - AVDD as reference
> >> +
> >> +          For convenience, macros for these values are available in
> >> +          dt-bindings/iio/adc/ti,ads112c14.h.
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        maximum: 3
> >> +        default: 0
> >> +
> >> +    dependencies:
> >> +      excitation-channels: [ excitation-current-microamp ]
> >> +      excitation-current-microamp: [ excitation-channels ]
> >> +      current-chopping: [ excitation-channels ]
> >> +
> >> +    oneOf:
> >> +      - required: [ single-channel ]
> >> +      - required: [ diff-channels ]  
> >   
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/iio/adc/ti,ads112c14.h>
> >> +
> >> +    i2c {
> >> +        #address-cells = <1>;
> >> +        #size-cells = <0>;
> >> +
> >> +        adc@40 {
> >> +            compatible = "ti,ads112c14";
> >> +            reg = <0x40>;
> >> +
> >> +            avdd-supply = <&avdd>;
> >> +            dvdd-supply = <&dvdd>;
> >> +
> >> +            /* 3-Wire RTD: Two IDACs, One Measurement (AIN1-AIN2) */
> >> +
> >> +            refp-refn-resistor-ohms = <500>;
> >> +
> >> +            #address-cells = <1>;
> >> +            #size-cells = <0>;
> >> +
> >> +            channel@0 {
> >> +              reg = <0>;
> >> +              diff-channels = <1>, <2>;
> >> +              excitation-channels = <0>, <3>;
> >> +              excitation-current-microamp = <500>;
> >> +              current-chopping;
> >> +              ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
> >> +              label = "rtd";
> >> +            };
> >> +        };
> >> +    };
> >> +  - |
> >> +    #include <dt-bindings/iio/adc/ti,ads112c14.h>
> >> +
> >> +    i2c {
> >> +        #address-cells = <1>;
> >> +        #size-cells = <0>;
> >> +
> >> +        adc@40 {
> >> +            compatible = "ti,ads112c14";
> >> +            reg = <0x40>;
> >> +
> >> +            avdd-supply = <&avdd>;
> >> +            dvdd-supply = <&dvdd>;
> >> +
> >> +            /* Resistive Bridge Measurement With a Thermistor for Temperature Compensation*/
> >> +
> >> +            refp-supply = <&avdd>;
> >> +
> >> +            #address-cells = <1>;
> >> +            #size-cells = <0>;
> >> +
> >> +            channel@0 {
> >> +              reg = <0>;
> >> +              diff-channels = <6>, <7>;
> >> +              bipolar;
> >> +              ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
> >> +              label = "bridge";
> >> +            };
> >> +
> >> +            channel@1 {
> >> +              reg = <1>;
> >> +              diff-channels = <1>, <2>;
> >> +              ti,vref-source = <ADS112C14_VREF_SOURCE_INTERNAL_2_5V>;
> >> +              label = "thermistor";  
> > 
> > Hmm. I'm interested to see where this goes, but generally when we have
> > a thermistor we attempt to ultimately convert it to a temperature
> > channel and I'm not seeing info here to allow us to do that.  
> 
> Since the hardware doesn't have any special features for handling
> specific sensor types, it seems like a case of the driver trying to
> do things that the hardware doesn't do, which we generally try to
> avoid in the kernel.
> 
> For cases where we want a quick and easy (and not necessarily accurate)
> temperature conversion done in the kernel, we could make a generic thermistor
> analog front end binding and driver like we already have for RTDs and
> (linear) temperature transducers. This seems more sensible to me rather
> than having to re-implement such a thing in each ADC that could be used
> with a thermistor.

Agreed. That would cover this case.  I'll be honest I thought we had
one already ;)


> 
> >   
> >> +            };
> >> +        };
> >> +    };  
> > 
> >   
> 

