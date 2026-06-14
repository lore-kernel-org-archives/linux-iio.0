Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48930EF89;
	Sun, 14 Jun 2026 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781466309; cv=none; b=eUZVEMt56+ex9yNYKiE/8/VTXGSZzdpslHwiBRuVWgLMMFkGQ8geI82HvvE7KZzlIVw3SKqbRoDKhjfQQwrbH2lVw9tcYPk3xL5RxEfmyX41ArK1BNdVr7x9kHguWyYWJyIJWsr6tkkoXSWSoL/fpJBJsX62GWvOmsPPCzaWM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781466309; c=relaxed/simple;
	bh=7ha0LiReNGNW/bxB6b9lPIfBwVFFY9y3NVorZGR09fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QY6ntKi4wrzJ1Rn9B9DmJsNvHvM8VUdNzsgC/jRl80c2xRL2jI7z5p3cJmhRGdLO3ASnUUDPiPq/wxeZUSL/r+MgDKQcg+oDQKG6NcvfALQlDKLELWiHRCazt5Ge2YukGEl7UKo06dRVwAn4nnBb5wDRXEAbjAdR/hcrC+/7EqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK/wwZ7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK/wwZ7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DEA1F000E9;
	Sun, 14 Jun 2026 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781466307;
	bh=fMUJLPXzP2s81hMzrXh6+NPZ/9tUeZuJA5qZT/vFyT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kK/wwZ7abRBhC96sNjunOCOKE+Fo9AFHPZ+fO4Te+tKWtJMNNAsvsYjayjimxgQWH
	 D9rii8prKwzUyJYCZmccnI/SzPOFLbgfZi4GANAfohSMdsZ12ikz/a/j1OH0rW+wt5
	 uwnpbmBQBWdFOI07elXGxr42OahnBTUsPrXtSTpH6x5FRU/C0YNI/iq2T90AFqpuNE
	 KszxD+RZgM9ApB0h/X5RaTDnbq1ueF7CHbZLQtZ+A4nC9+Wzg/wclCtoo2mPlxGOSQ
	 ODtZ/xvFwZuaE1X+e0zY5+OGtfB2d9iFoSQCE4mF17wTpC3U0K4+96TEweEXG+uLWr
	 HfLCL2v7zBWAw==
Date: Sun, 14 Jun 2026 20:44:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Janani Sunil
 <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260614204455.408c4d40@jic23-huawei>
In-Reply-To: <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
	<20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
	<25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
	<603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 16:47:23 +0200
Janani Sunil <jan.sun97@gmail.com> wrote:

> On 5/26/26 15:11, Rodrigo Alencar wrote:
> > On 26/05/19 05:42PM, Janani Sunil wrote:  
> >> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> >> buffered voltage output digital-to-analog converter (DAC) with an
> >> integrated precision reference.  
> > ...
> > Probably others may comment on that, but...
> >
> > This parent node may support device addressing for multi-device support through
> > those ID pins. I suppose that each device may have its own power supplies or
> > other resources like the toggle pins or reset and enable.
> >
> > That way I suppose that an example would look like...
> >  
> >> +
> >> +patternProperties:
> >> +  "^channel@([0-9]|1[0-5])$":
> >> +    type: object
> >> +    description: Child nodes for individual channel configuration
> >> +
> >> +    properties:
> >> +      reg:
> >> +        description: Channel number.
> >> +        minimum: 0
> >> +        maximum: 15
> >> +
> >> +      adi,output-range-microvolt:
> >> +        description: |
> >> +          Output voltage range for this channel as [min, max] in microvolts.
> >> +          If not specified, defaults to 0V to 5V range.
> >> +        oneOf:
> >> +          - items:
> >> +              - const: 0
> >> +              - enum: [5000000, 10000000, 20000000, 40000000]
> >> +          - items:
> >> +              - const: -5000000
> >> +              - const: 5000000
> >> +          - items:
> >> +              - const: -10000000
> >> +              - const: 10000000
> >> +          - items:
> >> +              - const: -15000000
> >> +              - const: 15000000
> >> +          - items:
> >> +              - const: -20000000
> >> +              - const: 20000000
> >> +
> >> +    required:
> >> +      - reg
> >> +
> >> +    additionalProperties: false
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - vdd-supply
> >> +  - avdd-supply
> >> +  - hvdd-supply
> >> +
> >> +dependencies:
> >> +  spi-cpha: [ spi-cpol ]
> >> +  spi-cpol: [ spi-cpha ]
> >> +
> >> +allOf:
> >> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >> +
> >> +unevaluatedProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/gpio/gpio.h>
> >> +
> >> +    spi {
> >> +        #address-cells = <1>;
> >> +        #size-cells = <0>;
> >> +
> >> +        dac@0 {
> >> +            compatible = "adi,ad5529r-16";
> >> +            reg = <0>;
> >> +            spi-max-frequency = <25000000>;
> >> +
> >> +            vdd-supply = <&vdd_regulator>;
> >> +            avdd-supply = <&avdd_regulator>;
> >> +            hvdd-supply = <&hvdd_regulator>;
> >> +            hvss-supply = <&hvss_regulator>;
> >> +
> >> +            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> >> +
> >> +            #address-cells = <1>;
> >> +            #size-cells = <0>;
> >> +
> >> +            channel@0 {
> >> +                reg = <0>;
> >> +                adi,output-range-microvolt = <0 5000000>;
> >> +            };
> >> +
> >> +            channel@1 {
> >> +                reg = <1>;
> >> +                adi,output-range-microvolt = <(-10000000) 10000000>;
> >> +            };
> >> +
> >> +            channel@2 {
> >> +                reg = <2>;
> >> +                adi,output-range-microvolt = <0 40000000>;
> >> +            };
> >> +        };
> >> +    };  
> > ...
> >
> > 	spi {
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> >
> > 		multi-dac@0 {
> > 			compatible = "adi,ad5529r-16";
> > 			reg = <0>;
> > 			spi-max-frequency = <25000000>;
> >
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> >
> > 			dac@0 {
> > 				reg = <0>;
> > 				vdd-supply = <&vdd_regulator>;
> > 				avdd-supply = <&avdd_regulator>;
> > 				hvdd-supply = <&hvdd_regulator>;
> > 				hvss-supply = <&hvss_regulator>;
> >
> > 				reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> >
> > 				#address-cells = <1>;
> > 				#size-cells = <0>;
> >
> > 				channel@0 {
> > 					reg = <0>;
> > 					adi,output-range-microvolt = <0 5000000>;
> > 				};
> >
> > 				channel@1 {
> > 					reg = <1>;
> > 					adi,output-range-microvolt = <(-10000000) 10000000>;
> > 				};
> >
> > 				channel@2 {
> > 					reg = <2>;
> > 					adi,output-range-microvolt = <0 40000000>;
> > 				};
> > 			}
> >
> > 			dac@1 {
> > 				reg = <1>;
> > 				vdd-supply = <&vdd_regulator>;
> > 				avdd-supply = <&avdd_regulator>;
> > 				hvdd-supply = <&hvdd_regulator>;
> > 				hvss-supply = <&hvss_regulator>;
> >
> > 				reset-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
> >
> > 				#address-cells = <1>;
> > 				#size-cells = <0>;
> >
> > 				channel@0 {
> > 					reg = <0>;
> > 					adi,output-range-microvolt = <0 5000000>;
> > 				};
> >
> > 				channel@1 {
> > 					reg = <1>;
> > 					adi,output-range-microvolt = <(-10000000) 10000000>;
> > 				};
> > 			}
> > 		};
> > 	};
> >
> > then you might need something like:
> >
> > 	patternProperties:
> > 		"^dac@[0-3]$":
> >
> > and put most of the things under this node pattern.
> >
> > So the main driver that you're putting together might need to handle up to four instances.
> > Even if your current driver cannot handle this, the dt-bindings might need cover that.
> >
> > Need to double check if each dac node needs a separate compatible, so you would maybe populate
> > a platform data to be shared with the child nodes, which would be a separate driver.
> > (not sure if it would make sense to mix and match ad5529r-16 and ad5529r-12).  
> 
> Hi Rodrigo,
> 
> Thank you for looking at this.
> 
> For now, I would prefer to keep the binding scoped to a single AD5529R device instance. The current
> hardware/use case we have only needs one device node and the driver is written around that model as well.
> While the device addressing pins could allow multi-device topology, we do not have an actual platform using
> that configuration at the moment, so I would prefer not to introduce an extra parent/child binding structure
> speculatively without a validating use case.

Interesting feature - kind of similar to address control on a typical i2c bus device, or
looking at it another way a kind of distributed SPI mux.

Challenge of a binding is we need to anticipate the future.  So I think we do need something
like Rodrigo is suggesting even if we only (for now) support a single instance in the driver.
That would leave the path open to supporting the addressing at a later date.
An alternative might be to look at it like a chained device setup. In those we pretend there
is just one device with a lot of channels etc.  The snag is that here things are more loosely
coupled whereas for those devices it tends to be you have to read / write the same register
in all devices in the chain as one big SPI message.

+CC Mark Brown as he may know of some precedence for this feature. For his reference..
- Each of these device has 2 ID pins.  The SPI transfers have to contain the 2 bit
value that matches that or they are ignored.  Thus a single bus + 1 chip select can
be used to talk to 4 devices.  Question is what that looks like in device tree + I guess
longer term how to support it cleanly in SPI.

Jonathan


> 
> Best Regards,
> Janani Sunil
> 
> 

