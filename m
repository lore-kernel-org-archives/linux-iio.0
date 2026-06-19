Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E438F236
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874011; cv=none; b=ljCe2npG+CAKdpHd8ZYmhnORxlitMTiRxy8dVnAkjQArDGvLMBfkvZP8EMeNUFKBoLl1UoKPjihYxMi0mrQ6NMOf+dEJRVdZ3QZ1BNTVAzKww2SfFAEANCuMdLK6kFOtERKG9H/YKNrcx19e6TNvLtvcsHlb7qwQNf/Dg2LjsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874011; c=relaxed/simple;
	bh=VnzYMuGGOZOFQ0lkAErjhznaopoAsL3miQ4uX60fQMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1wBV9GBj+kdpyYmQU70IFewQXwLaoVpmTvweSJWUOQpTqsJdBc6Lmklqkthonsbz9a4FloZA6rNJPjhWzP9qsLipVpBXNgfnx9ZhXVLlC2UkAr9bgZNzlGFWQGdG+89tIN+PbzpgNbVYYAF2jtEwqlRdCFDlG5zWTMUsAqyAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJsy/YgJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJsy/YgJ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1859055f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874008; x=1782478808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qiZU2ur+yus0frcrsmwpHi+cHkIfW6hKIYxrtn8YRlk=;
        b=eJsy/YgJO8yOtf7gg8rfx16lJcDo/XV/V8kKM6w6CAptkr8JVCqnYtkp+wrocw5Tdh
         OiHZCocnHMGGP51+gSlK7UlvpjDfU4xFhYEFakcmZwHMchbak54dEkW+ItlME47WIc1F
         IFtBS/BDfh3jlVZ+n7xgF2gysunXXAyR4WiWNZz7yC5jzm0FROfZrp/tHZ4VuA3M5KuF
         y2RMp1joeArpSs3C1GZ29a/PLuDHlIO9nXazbvb8RjVH1Cbtw9RzcW3tZWaK6wZzS/UD
         wJbGjELKKpDCDeshL2QOnvLiLCRa9PEpr7yXpIP0sjfTGrIYwXlps/yVS+qpocihVkZq
         wX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874008; x=1782478808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiZU2ur+yus0frcrsmwpHi+cHkIfW6hKIYxrtn8YRlk=;
        b=P7/QDVOIWzxNkqmvqKv4QRFQyz+PUNQQVLFygQ+HAGmTb8iaFDShO6woMz912ndQqy
         WWtqTAyf7+/K+q9G179TUBhPcAkry6XJVJP4z50Vw4PXO6FeZbytkKBtf1R4F54kBGxw
         0kphnsGsHCHVnbHNwgeQiPLmhyX49Kcwez+4XZGI9MfGUvP4pqcjTcQRj2NxZjz7fb6l
         60OQ2NnEq9SlZmqFlVFuKGAOxi37kPAXYwQIK87OzBFl3hr5LVN08wuqnb8lb6e2qvYf
         PXG98i3b+IjpEejYtuVgwjOq1NG1/EhD6LM+bx+W2Y2ZDpi2nnxH9OlWD9NztaP4T8ko
         DESg==
X-Forwarded-Encrypted: i=1; AFNElJ+F7peBfQuOUNZsd0yQ6iTTA5wxGbMLtMGSNcNxAxDAqHjAGe0ZzhIZYFGcZBydyeG61dZCsA/cU8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3UaPy8jLvZaN1mTJ+TK/sqvLTppLK+p5eTV0pgrsLEXqpv6T
	EjyWG6gp63mhyBg+UJAjzGdpoJLrCVsTlx8ngE/4ATu4lzGosiQ2al/U
X-Gm-Gg: AfdE7ck2OVPLZxEDdD3HX7Umacc873Tr2SDr2y5O1d1ETMgCeIrEzIyuSXbfWgKOH/g
	6r+5qvNVKZVnymbSOavSXTyaxB1WIhUJGhyXWDSgItoNBqhWEmqHKTaC3AWdibjLCyMxYPHgr+w
	5+lGLm+c89/YOkMXbUR5iHR34TSLpButhyVOTZRQPGXsNictKv1Plhgd5lrfZJddWu4agK0wHAn
	CI/x+ZRhfTqyyl3s8DXNUPozgOG8+GlHAR5650q/yBEvOWMiIMTFN4i2/sEkrQzGfHpfx3K90w5
	OQ4Pw4BNm8af7ZTP46tCSO06wZlACg7T9NoDaplPjSL5409pGGuCazU5JskJyrBZ122LhjBKsmv
	FTneXEU82huY/EzMgb7ZdDuXXM5vzFCdhGJwDxBJB4bPfK/5Qdgjb/TpArhpw86zdJVOUWBbKcr
	lzRh8=
X-Received: by 2002:a05:6000:611:b0:463:3184:6310 with SMTP id ffacd0b85a97d-4651e7b3b26mr5222838f8f.28.1781874007796;
        Fri, 19 Jun 2026 06:00:07 -0700 (PDT)
Received: from nsa ([185.128.9.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650b67a253sm8027816f8f.23.2026.06.19.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:00:07 -0700 (PDT)
Date: Fri, 19 Jun 2026 14:01:08 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Janani Sunil <jan.sun97@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <ajU73_TkKrSbqD4f@nsa>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
 <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
 <25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
 <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
 <20260614204455.408c4d40@jic23-huawei>
 <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
 <20260619-obstinate-polo-a230bef97fda@spud>
 <20260619-bunch-diocese-dd7805cc17ff@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260619-bunch-diocese-dd7805cc17ff@spud>

On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrote:
> On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote:
> > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote:
> > > 
> > > On 6/14/26 21:44, Jonathan Cameron wrote:
> > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > 
> > > > > On 5/26/26 15:11, Rodrigo Alencar wrote:
> > > > > > On 26/05/19 05:42PM, Janani Sunil wrote:
> > > > > > > Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> > > > > > > buffered voltage output digital-to-analog converter (DAC) with an
> > > > > > > integrated precision reference.
> > > > > > ...
> > > > > > Probably others may comment on that, but...
> > > > > > 
> > > > > > This parent node may support device addressing for multi-device support through
> > > > > > those ID pins. I suppose that each device may have its own power supplies or
> > > > > > other resources like the toggle pins or reset and enable.
> > > > > > 
> > > > > > That way I suppose that an example would look like...
> > > > > > > +
> > > > > > > +patternProperties:
> > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > +    type: object
> > > > > > > +    description: Child nodes for individual channel configuration
> > > > > > > +
> > > > > > > +    properties:
> > > > > > > +      reg:
> > > > > > > +        description: Channel number.
> > > > > > > +        minimum: 0
> > > > > > > +        maximum: 15
> > > > > > > +
> > > > > > > +      adi,output-range-microvolt:
> > > > > > > +        description: |
> > > > > > > +          Output voltage range for this channel as [min, max] in microvolts.
> > > > > > > +          If not specified, defaults to 0V to 5V range.
> > > > > > > +        oneOf:
> > > > > > > +          - items:
> > > > > > > +              - const: 0
> > > > > > > +              - enum: [5000000, 10000000, 20000000, 40000000]
> > > > > > > +          - items:
> > > > > > > +              - const: -5000000
> > > > > > > +              - const: 5000000
> > > > > > > +          - items:
> > > > > > > +              - const: -10000000
> > > > > > > +              - const: 10000000
> > > > > > > +          - items:
> > > > > > > +              - const: -15000000
> > > > > > > +              - const: 15000000
> > > > > > > +          - items:
> > > > > > > +              - const: -20000000
> > > > > > > +              - const: 20000000
> > > > > > > +
> > > > > > > +    required:
> > > > > > > +      - reg
> > > > > > > +
> > > > > > > +    additionalProperties: false
> > > > > > > +
> > > > > > > +required:
> > > > > > > +  - compatible
> > > > > > > +  - reg
> > > > > > > +  - vdd-supply
> > > > > > > +  - avdd-supply
> > > > > > > +  - hvdd-supply
> > > > > > > +
> > > > > > > +dependencies:
> > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > +
> > > > > > > +allOf:
> > > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > +
> > > > > > > +unevaluatedProperties: false
> > > > > > > +
> > > > > > > +examples:
> > > > > > > +  - |
> > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > +
> > > > > > > +    spi {
> > > > > > > +        #address-cells = <1>;
> > > > > > > +        #size-cells = <0>;
> > > > > > > +
> > > > > > > +        dac@0 {
> > > > > > > +            compatible = "adi,ad5529r-16";
> > > > > > > +            reg = <0>;
> > > > > > > +            spi-max-frequency = <25000000>;
> > > > > > > +
> > > > > > > +            vdd-supply = <&vdd_regulator>;
> > > > > > > +            avdd-supply = <&avdd_regulator>;
> > > > > > > +            hvdd-supply = <&hvdd_regulator>;
> > > > > > > +            hvss-supply = <&hvss_regulator>;
> > > > > > > +
> > > > > > > +            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > +
> > > > > > > +            #address-cells = <1>;
> > > > > > > +            #size-cells = <0>;
> > > > > > > +
> > > > > > > +            channel@0 {
> > > > > > > +                reg = <0>;
> > > > > > > +                adi,output-range-microvolt = <0 5000000>;
> > > > > > > +            };
> > > > > > > +
> > > > > > > +            channel@1 {
> > > > > > > +                reg = <1>;
> > > > > > > +                adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > > +            };
> > > > > > > +
> > > > > > > +            channel@2 {
> > > > > > > +                reg = <2>;
> > > > > > > +                adi,output-range-microvolt = <0 40000000>;
> > > > > > > +            };
> > > > > > > +        };
> > > > > > > +    };
> > > > > > ...
> > > > > > 
> > > > > > 	spi {
> > > > > > 		#address-cells = <1>;
> > > > > > 		#size-cells = <0>;
> > > > > > 
> > > > > > 		multi-dac@0 {
> > > > > > 			compatible = "adi,ad5529r-16";
> > > > > > 			reg = <0>;
> > > > > > 			spi-max-frequency = <25000000>;
> > > > > > 
> > > > > > 			#address-cells = <1>;
> > > > > > 			#size-cells = <0>;
> > > > > > 
> > > > > > 			dac@0 {
> > > > > > 				reg = <0>;
> > > > > > 				vdd-supply = <&vdd_regulator>;
> > > > > > 				avdd-supply = <&avdd_regulator>;
> > > > > > 				hvdd-supply = <&hvdd_regulator>;
> > > > > > 				hvss-supply = <&hvss_regulator>;
> > > > > > 
> > > > > > 				reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > 
> > > > > > 				#address-cells = <1>;
> > > > > > 				#size-cells = <0>;
> > > > > > 
> > > > > > 				channel@0 {
> > > > > > 					reg = <0>;
> > > > > > 					adi,output-range-microvolt = <0 5000000>;
> > > > > > 				};
> > > > > > 
> > > > > > 				channel@1 {
> > > > > > 					reg = <1>;
> > > > > > 					adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > 				};
> > > > > > 
> > > > > > 				channel@2 {
> > > > > > 					reg = <2>;
> > > > > > 					adi,output-range-microvolt = <0 40000000>;
> > > > > > 				};
> > > > > > 			}
> > > > > > 
> > > > > > 			dac@1 {
> > > > > > 				reg = <1>;
> > > > > > 				vdd-supply = <&vdd_regulator>;
> > > > > > 				avdd-supply = <&avdd_regulator>;
> > > > > > 				hvdd-supply = <&hvdd_regulator>;
> > > > > > 				hvss-supply = <&hvss_regulator>;
> > > > > > 
> > > > > > 				reset-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
> > > > > > 
> > > > > > 				#address-cells = <1>;
> > > > > > 				#size-cells = <0>;
> > > > > > 
> > > > > > 				channel@0 {
> > > > > > 					reg = <0>;
> > > > > > 					adi,output-range-microvolt = <0 5000000>;
> > > > > > 				};
> > > > > > 
> > > > > > 				channel@1 {
> > > > > > 					reg = <1>;
> > > > > > 					adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > 				};
> > > > > > 			}
> > > > > > 		};
> > > > > > 	};
> > > > > > 
> > > > > > then you might need something like:
> > > > > > 
> > > > > > 	patternProperties:
> > > > > > 		"^dac@[0-3]$":
> > > > > > 
> > > > > > and put most of the things under this node pattern.
> > > > > > 
> > > > > > So the main driver that you're putting together might need to handle up to four instances.
> > > > > > Even if your current driver cannot handle this, the dt-bindings might need cover that.
> > > > > > 
> > > > > > Need to double check if each dac node needs a separate compatible, so you would maybe populate
> > > > > > a platform data to be shared with the child nodes, which would be a separate driver.
> > > > > > (not sure if it would make sense to mix and match ad5529r-16 and ad5529r-12).
> > > > > Hi Rodrigo,
> > > > > 
> > > > > Thank you for looking at this.
> > > > > 
> > > > > For now, I would prefer to keep the binding scoped to a single AD5529R device instance. The current
> > > > > hardware/use case we have only needs one device node and the driver is written around that model as well.
> > > > > While the device addressing pins could allow multi-device topology, we do not have an actual platform using
> > > > > that configuration at the moment, so I would prefer not to introduce an extra parent/child binding structure
> > > > > speculatively without a validating use case.
> > > > Interesting feature - kind of similar to address control on a typical i2c bus device, or
> > > > looking at it another way a kind of distributed SPI mux.
> > > > 
> > > > Challenge of a binding is we need to anticipate the future.  So I think we do need something
> > > > like Rodrigo is suggesting even if we only (for now) support a single instance in the driver.
> > > > That would leave the path open to supporting the addressing at a later date.
> > > > An alternative might be to look at it like a chained device setup. In those we pretend there
> > > > is just one device with a lot of channels etc.  The snag is that here things are more loosely
> > > > coupled whereas for those devices it tends to be you have to read / write the same register
> > > > in all devices in the chain as one big SPI message.
> > > > 
> > > > +CC Mark Brown as he may know of some precedence for this feature. For his reference..
> > > > - Each of these device has 2 ID pins.  The SPI transfers have to contain the 2 bit
> > > > value that matches that or they are ignored.  Thus a single bus + 1 chip select can
> > > > be used to talk to 4 devices.  Question is what that looks like in device tree + I guess
> > > > longer term how to support it cleanly in SPI.
> > 
> > I'd swear I have seen this before, from some Microchip devices. Let me
> > see if I can find what I am thinking of...
> 
> 
> microchip,mcp3911 and microchip,mcp3564 both seem to do this with
> slightly different properties.
> 
>   microchip,device-addr:
>     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
>     $ref: /schemas/types.yaml#/definitions/uint32
>     enum: [0, 1, 2, 3]
>     default: 0
> 
> and
> 
> 
>   microchip,hw-device-address:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     minimum: 0
>     maximum: 3
>     description:
>       The address is set on a per-device basis by fuses in the factory,
>       configured on request. If not requested, the fuses are set for 0x1.
>       The device address is part of the device markings to avoid
>       potential confusion. This address is coded on two bits, so four possible
>       addresses are available when multiple devices are present on the same
>       SPI bus with only one Chip Select line for all devices.
>       Each device communication starts by a CS falling edge, followed by the
>       clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
>       which is first one on the wire).
> 
> This sounds exactly like the sort of feature that you're dealing with
> here?
> 

The core idea yes but for this chip, things are a bit more annoying (but
Janani can correct me if I'm wrong). Here, each device can, in theory,
have it's own supplies, pins and at the very least, channels with maybe
different scales. That is why Janani is proposing dac nodes. Given I
honestly don't like much of that "adi,ad5529r-bus" compatible I wondered
about solving this at the spi level.

Ah and to make it more annoying, we can also mix 12 and 16 bits variants
together in the same bus.

- Nuno Sá


