Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006072DEA68
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129272; cv=none; b=SOM2/0bBWx0LV2IfssFxX5LIOnYqdCiLX3r8M+kIOdJQHGw/LBdwSy3rd+xMxjiK8RgD3Hgp39xkHSZA/JUOn67DBkQHp7welxT6olN5yBW11bc8pPfNoPR1Xvgdcx0hQlKk46PSKSH+rB7o4IbuimJKwp6byswqdFtYCsC0c/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129272; c=relaxed/simple;
	bh=9mtBIJDUrb1XyeJpw+ZrJUakYThOVEsJb5GfyCDWFNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOhKL3enoFJV1/WoXossBfZzeUftJ/8umbW/Av8VstcRVVBHKD7Nz4MZIp32Hzl+hH4mgT9+Bv/7BeESg7XrfOWmo7/E30lccCvaW6EzqVXdVZnCoxwoB1EZoOoCDk2to2t6dSjIZCbpciGMzgVNQQ0A0mwXBucSamFbueuhWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3ncLWM6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3ncLWM6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so30634725e9.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129269; x=1782734069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVmok++Db2ftqtQ1X1PAbf0zofQ8TM19Nofvq+BJRbM=;
        b=U3ncLWM6OoR0OKiVALfiNp8eA6LfsiUddw1b6zrl1ZoIprHNJtfeQAp61VuJyWbndz
         dP7PpgzX47nReo39b5jsagsCrfIMra6rXsrAa5kjMf/P5G0oUPTlsnmxpxhiMEgEuZlz
         0sTDkmVMoAYA6qFh6wemnUPvaIMaZnMTmdIRoh0YtCRnDb1LHwt8MtYkPC7GbIFY4Nib
         scVRcoifwbSGGNKg7eyqAsnWV/COPMAnDeXWDmmYxGQg2rCSjZj3cqibLi8YFGMXW9Zu
         IrhIheA2Oz4w54+f3/wD78pGhM5qmg3l5QmBMZUMfs3n64kh36+1CuMoYH+EndNqix2a
         1umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129269; x=1782734069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVmok++Db2ftqtQ1X1PAbf0zofQ8TM19Nofvq+BJRbM=;
        b=Nti7iEROXNvN/8B9mCurpOnizrmvgRoduSJQpiZJzhOzbHWsxxvxSt2ccixtB0Uq0M
         5LRBHIaDhRiGtX0XwIIWhrXm7DJh8W7dXGn+6sz4zJ6ZZpd65AQ9J0I85LWeAD46rxX5
         +23aWvFk+yFpsWMfdye2pq/zYQ3HhBaabU8XlosqmSpsjV1g9TeKAPuCeU6DLg+zp1F1
         Y83vJzFwJOiDH21yZif/iKgqMXIL1uo6T1v/odP2q0ztfjlmdQSB5KF1m/wWScyq0/bU
         jAsK+9PGwyDWbQ3ZFTVoC7mTogdVDGZweGqX1lyd6FlQlQP72YidGqQhNT/tuyny7T1b
         gZBQ==
X-Forwarded-Encrypted: i=1; AFNElJ98m2isNNa2STGfwKrSeLdG1e6jD84/Iy4fREgKJxZYVEGXy6la8kYbvX1W/xL1GnMCmf4zHhyskTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznukRTA+88SA37X69O5bd3EJ78nd/4Sp6pGOV8vhO2RVe4NVkC
	xB6ASkinu2Yi15njivyiB8mwXzGPTJHseZG07cXM5xamDuOxXcFoUfq/
X-Gm-Gg: AfdE7cm8d20HsKLlh/JSIypoxZQHmqcx++9o0RVTHrpsFsyCTAJqDay83MTEKNlAUDu
	fqykGmW8GlNwX7+q56sAHsgDhPhRQZHjYwdGFz50efWrSV7XUKBDjaxZZq5F2VKLM0C2qEfRPBi
	kmDTlCY5ZLy7vqhNTMh1D/sFUoUiYGnq5qnRarqFWcRwFxswzqVbM63vd1sqj65jPDRknJFUcVW
	2u/XVzpJFHM1io/NGt10xFYoSY4bB7XlE2Vy5RtWyf0uzJueRyRgo1LqP6TIganRMMVcn+GnhkK
	QuZWN+ebtav3mf+XXAHdI8csHH5wkJB7UvT5gbUl+DLBrP8TMiPemGTV2H4/62r4rPValUYkUE0
	RykvMVj7dQN/sLv2AjIrhwOh1yRZEUE8EA0TEnLlVr4lNfAavtpyinW6SpcMARJZA1ELk0NNLZn
	vpZgQViBCuIGlHMrZFhM+YoK/arj1eWAYVS82Vk8pIsRgPZhrB8a7OAw==
X-Received: by 2002:a05:600c:c0c3:10b0:492:488c:f630 with SMTP id 5b1f17b1804b1-492488cf777mr112632345e9.34.1782129269052;
        Mon, 22 Jun 2026 04:54:29 -0700 (PDT)
Received: from ?IPV6:2a02:3038:288:e57:59d:91ae:1c45:fb41? ([2a02:3038:288:e57:59d:91ae:1c45:fb41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249455302sm211953905e9.15.2026.06.22.04.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 04:54:28 -0700 (PDT)
Message-ID: <caa54d52-72db-4c58-ae3f-1d1343bd7845@gmail.com>
Date: Mon, 22 Jun 2026 13:54:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
 Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
References: <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
 <20260619-obstinate-polo-a230bef97fda@spud>
 <20260619-bunch-diocese-dd7805cc17ff@spud> <ajU73_TkKrSbqD4f@nsa>
 <20260619-concierge-doozy-9c161533c369@spud> <ajVlD-j0nIGrRVow@nsa>
 <20260621153330.79b6600c@jic23-huawei>
 <20260621-nutmeg-coauthor-715189372230@spud> <ajj6nEb4tATM3C7b@nsa>
 <20260622102722.5900592f@jic23-huawei> <ajkILRPq_g24g4dH@nsa>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <ajkILRPq_g24g4dH@nsa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/22/26 12:17, Nuno Sá wrote:
> On Mon, Jun 22, 2026 at 10:27:22AM +0100, Jonathan Cameron wrote:
>> On Mon, 22 Jun 2026 10:07:01 +0100
>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>
>>> On Sun, Jun 21, 2026 at 07:35:42PM +0100, Conor Dooley wrote:
>>>> On Sun, Jun 21, 2026 at 03:33:40PM +0100, Jonathan Cameron wrote:
>>>>> On Fri, 19 Jun 2026 16:54:11 +0100
>>>>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>>>>    
>>>>>> On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wrote:
>>>>>>> On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno Sá wrote:
>>>>>>>> On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrote:
>>>>>>>>> On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote:
>>>>>>>>>> On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote:
>>>>>>>>>>> On 6/14/26 21:44, Jonathan Cameron wrote:
>>>>>>>>>>>> On Tue, 9 Jun 2026 16:47:23 +0200
>>>>>>>>>>>> Janani Sunil <jan.sun97@gmail.com> wrote:
>>>>>>>>>>>>      
>>>>>>>>>>>>> On 5/26/26 15:11, Rodrigo Alencar wrote:
>>>>>>>>>>>>>> On 26/05/19 05:42PM, Janani Sunil wrote:
>>>>>>>>>>>>>>> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
>>>>>>>>>>>>>>> buffered voltage output digital-to-analog converter (DAC) with an
>>>>>>>>>>>>>>> integrated precision reference.
>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>> Probably others may comment on that, but...
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This parent node may support device addressing for multi-device support through
>>>>>>>>>>>>>> those ID pins. I suppose that each device may have its own power supplies or
>>>>>>>>>>>>>> other resources like the toggle pins or reset and enable.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> That way I suppose that an example would look like...
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +patternProperties:
>>>>>>>>>>>>>>> +  "^channel@([0-9]|1[0-5])$":
>>>>>>>>>>>>>>> +    type: object
>>>>>>>>>>>>>>> +    description: Child nodes for individual channel configuration
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +    properties:
>>>>>>>>>>>>>>> +      reg:
>>>>>>>>>>>>>>> +        description: Channel number.
>>>>>>>>>>>>>>> +        minimum: 0
>>>>>>>>>>>>>>> +        maximum: 15
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +      adi,output-range-microvolt:
>>>>>>>>>>>>>>> +        description: |
>>>>>>>>>>>>>>> +          Output voltage range for this channel as [min, max] in microvolts.
>>>>>>>>>>>>>>> +          If not specified, defaults to 0V to 5V range.
>>>>>>>>>>>>>>> +        oneOf:
>>>>>>>>>>>>>>> +          - items:
>>>>>>>>>>>>>>> +              - const: 0
>>>>>>>>>>>>>>> +              - enum: [5000000, 10000000, 20000000, 40000000]
>>>>>>>>>>>>>>> +          - items:
>>>>>>>>>>>>>>> +              - const: -5000000
>>>>>>>>>>>>>>> +              - const: 5000000
>>>>>>>>>>>>>>> +          - items:
>>>>>>>>>>>>>>> +              - const: -10000000
>>>>>>>>>>>>>>> +              - const: 10000000
>>>>>>>>>>>>>>> +          - items:
>>>>>>>>>>>>>>> +              - const: -15000000
>>>>>>>>>>>>>>> +              - const: 15000000
>>>>>>>>>>>>>>> +          - items:
>>>>>>>>>>>>>>> +              - const: -20000000
>>>>>>>>>>>>>>> +              - const: 20000000
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +    required:
>>>>>>>>>>>>>>> +      - reg
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +    additionalProperties: false
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +required:
>>>>>>>>>>>>>>> +  - compatible
>>>>>>>>>>>>>>> +  - reg
>>>>>>>>>>>>>>> +  - vdd-supply
>>>>>>>>>>>>>>> +  - avdd-supply
>>>>>>>>>>>>>>> +  - hvdd-supply
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +dependencies:
>>>>>>>>>>>>>>> +  spi-cpha: [ spi-cpol ]
>>>>>>>>>>>>>>> +  spi-cpol: [ spi-cpha ]
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +allOf:
>>>>>>>>>>>>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +unevaluatedProperties: false
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +examples:
>>>>>>>>>>>>>>> +  - |
>>>>>>>>>>>>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +    spi {
>>>>>>>>>>>>>>> +        #address-cells = <1>;
>>>>>>>>>>>>>>> +        #size-cells = <0>;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +        dac@0 {
>>>>>>>>>>>>>>> +            compatible = "adi,ad5529r-16";
>>>>>>>>>>>>>>> +            reg = <0>;
>>>>>>>>>>>>>>> +            spi-max-frequency = <25000000>;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +            vdd-supply = <&vdd_regulator>;
>>>>>>>>>>>>>>> +            avdd-supply = <&avdd_regulator>;
>>>>>>>>>>>>>>> +            hvdd-supply = <&hvdd_regulator>;
>>>>>>>>>>>>>>> +            hvss-supply = <&hvss_regulator>;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +            #address-cells = <1>;
>>>>>>>>>>>>>>> +            #size-cells = <0>;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +            channel@0 {
>>>>>>>>>>>>>>> +                reg = <0>;
>>>>>>>>>>>>>>> +                adi,output-range-microvolt = <0 5000000>;
>>>>>>>>>>>>>>> +            };
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +            channel@1 {
>>>>>>>>>>>>>>> +                reg = <1>;
>>>>>>>>>>>>>>> +                adi,output-range-microvolt = <(-10000000) 10000000>;
>>>>>>>>>>>>>>> +            };
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +            channel@2 {
>>>>>>>>>>>>>>> +                reg = <2>;
>>>>>>>>>>>>>>> +                adi,output-range-microvolt = <0 40000000>;
>>>>>>>>>>>>>>> +            };
>>>>>>>>>>>>>>> +        };
>>>>>>>>>>>>>>> +    };
>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 	spi {
>>>>>>>>>>>>>> 		#address-cells = <1>;
>>>>>>>>>>>>>> 		#size-cells = <0>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 		multi-dac@0 {
>>>>>>>>>>>>>> 			compatible = "adi,ad5529r-16";
>>>>>>>>>>>>>> 			reg = <0>;
>>>>>>>>>>>>>> 			spi-max-frequency = <25000000>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 			#address-cells = <1>;
>>>>>>>>>>>>>> 			#size-cells = <0>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 			dac@0 {
>>>>>>>>>>>>>> 				reg = <0>;
>>>>>>>>>>>>>> 				vdd-supply = <&vdd_regulator>;
>>>>>>>>>>>>>> 				avdd-supply = <&avdd_regulator>;
>>>>>>>>>>>>>> 				hvdd-supply = <&hvdd_regulator>;
>>>>>>>>>>>>>> 				hvss-supply = <&hvss_regulator>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				#address-cells = <1>;
>>>>>>>>>>>>>> 				#size-cells = <0>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				channel@0 {
>>>>>>>>>>>>>> 					reg = <0>;
>>>>>>>>>>>>>> 					adi,output-range-microvolt = <0 5000000>;
>>>>>>>>>>>>>> 				};
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				channel@1 {
>>>>>>>>>>>>>> 					reg = <1>;
>>>>>>>>>>>>>> 					adi,output-range-microvolt = <(-10000000) 10000000>;
>>>>>>>>>>>>>> 				};
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				channel@2 {
>>>>>>>>>>>>>> 					reg = <2>;
>>>>>>>>>>>>>> 					adi,output-range-microvolt = <0 40000000>;
>>>>>>>>>>>>>> 				};
>>>>>>>>>>>>>> 			}
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 			dac@1 {
>>>>>>>>>>>>>> 				reg = <1>;
>>>>>>>>>>>>>> 				vdd-supply = <&vdd_regulator>;
>>>>>>>>>>>>>> 				avdd-supply = <&avdd_regulator>;
>>>>>>>>>>>>>> 				hvdd-supply = <&hvdd_regulator>;
>>>>>>>>>>>>>> 				hvss-supply = <&hvss_regulator>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				reset-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				#address-cells = <1>;
>>>>>>>>>>>>>> 				#size-cells = <0>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				channel@0 {
>>>>>>>>>>>>>> 					reg = <0>;
>>>>>>>>>>>>>> 					adi,output-range-microvolt = <0 5000000>;
>>>>>>>>>>>>>> 				};
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 				channel@1 {
>>>>>>>>>>>>>> 					reg = <1>;
>>>>>>>>>>>>>> 					adi,output-range-microvolt = <(-10000000) 10000000>;
>>>>>>>>>>>>>> 				};
>>>>>>>>>>>>>> 			}
>>>>>>>>>>>>>> 		};
>>>>>>>>>>>>>> 	};
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> then you might need something like:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 	patternProperties:
>>>>>>>>>>>>>> 		"^dac@[0-3]$":
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> and put most of the things under this node pattern.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> So the main driver that you're putting together might need to handle up to four instances.
>>>>>>>>>>>>>> Even if your current driver cannot handle this, the dt-bindings might need cover that.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Need to double check if each dac node needs a separate compatible, so you would maybe populate
>>>>>>>>>>>>>> a platform data to be shared with the child nodes, which would be a separate driver.
>>>>>>>>>>>>>> (not sure if it would make sense to mix and match ad5529r-16 and ad5529r-12).
>>>>>>>>>>>>> Hi Rodrigo,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thank you for looking at this.
>>>>>>>>>>>>>
>>>>>>>>>>>>> For now, I would prefer to keep the binding scoped to a single AD5529R device instance. The current
>>>>>>>>>>>>> hardware/use case we have only needs one device node and the driver is written around that model as well.
>>>>>>>>>>>>> While the device addressing pins could allow multi-device topology, we do not have an actual platform using
>>>>>>>>>>>>> that configuration at the moment, so I would prefer not to introduce an extra parent/child binding structure
>>>>>>>>>>>>> speculatively without a validating use case.
>>>>>>>>>>>> Interesting feature - kind of similar to address control on a typical i2c bus device, or
>>>>>>>>>>>> looking at it another way a kind of distributed SPI mux.
>>>>>>>>>>>>
>>>>>>>>>>>> Challenge of a binding is we need to anticipate the future.  So I think we do need something
>>>>>>>>>>>> like Rodrigo is suggesting even if we only (for now) support a single instance in the driver.
>>>>>>>>>>>> That would leave the path open to supporting the addressing at a later date.
>>>>>>>>>>>> An alternative might be to look at it like a chained device setup. In those we pretend there
>>>>>>>>>>>> is just one device with a lot of channels etc.  The snag is that here things are more loosely
>>>>>>>>>>>> coupled whereas for those devices it tends to be you have to read / write the same register
>>>>>>>>>>>> in all devices in the chain as one big SPI message.
>>>>>>>>>>>>
>>>>>>>>>>>> +CC Mark Brown as he may know of some precedence for this feature. For his reference..
>>>>>>>>>>>> - Each of these device has 2 ID pins.  The SPI transfers have to contain the 2 bit
>>>>>>>>>>>> value that matches that or they are ignored.  Thus a single bus + 1 chip select can
>>>>>>>>>>>> be used to talk to 4 devices.  Question is what that looks like in device tree + I guess
>>>>>>>>>>>> longer term how to support it cleanly in SPI.
>>>>>>>>>> I'd swear I have seen this before, from some Microchip devices. Let me
>>>>>>>>>> see if I can find what I am thinking of...
>>>>>>>>>
>>>>>>>>> microchip,mcp3911 and microchip,mcp3564 both seem to do this with
>>>>>>>>> slightly different properties.
>>>>>>>>>
>>>>>>>>>    microchip,device-addr:
>>>>>>>>>      description: Device address when multiple MCP3911 chips are present on the same SPI bus.
>>>>>>>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>>>>      enum: [0, 1, 2, 3]
>>>>>>>>>      default: 0
>>>>>>>>>
>>>>>>>>> and
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>    microchip,hw-device-address:
>>>>>>>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>>>>      minimum: 0
>>>>>>>>>      maximum: 3
>>>>>>>>>      description:
>>>>>>>>>        The address is set on a per-device basis by fuses in the factory,
>>>>>>>>>        configured on request. If not requested, the fuses are set for 0x1.
>>>>>>>>>        The device address is part of the device markings to avoid
>>>>>>>>>        potential confusion. This address is coded on two bits, so four possible
>>>>>>>>>        addresses are available when multiple devices are present on the same
>>>>>>>>>        SPI bus with only one Chip Select line for all devices.
>>>>>>>>>        Each device communication starts by a CS falling edge, followed by the
>>>>>>>>>        clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
>>>>>>>>>        which is first one on the wire).
>>>>>>>>>
>>>>>>>>> This sounds exactly like the sort of feature that you're dealing with
>>>>>>>>> here?
>>>>>>>>>      
>>>>>>>> The core idea yes but for this chip, things are a bit more annoying (but
>>>>>>>> Janani can correct me if I'm wrong). Here, each device can, in theory,
>>>>>>>> have it's own supplies, pins and at the very least, channels with maybe
>>>>>>>> different scales. That is why Janani is proposing dac nodes. Given I
>>>>>>>> honestly don't like much of that "adi,ad5529r-bus" compatible I wondered
>>>>>>>> about solving this at the spi level.
>>>>>>>>
>>>>>>>> Ah and to make it more annoying, we can also mix 12 and 16 bits variants
>>>>>>>> together in the same bus.
>>>>>>> I'm definitely missing something, because that property for the
>>>>>>> microchip devices is not impacted what else is on the bus. AFAICT, you
>>>>>>> could have an mcp3911 and an mcp3564 on the same bus even though both
>>>>>>> are completely different devices with different drivers. They have
>>>>>>> individual device nodes and their own supplies etc etc. These aren't
>>>>>>> per-channel properties on an adc or dac, they're per child device on a
>>>>>>> spi bus.
>>>>>> Maybe I'm the one missing something :). IIRC, spi would not allow two
>>>>>> devices on the same CS right? Because for this chip we would need
>>>>>> something like:
>>>>>>
>>>>>> spi {
>>>>>> 	dac@0 {
>>>>>> 		reg = <0>;
>>>>>> 		adi,pin-id = <0>;
>>>>>> 	};
>>>>>>
>>>>>> 	dac@1 {
>>>>>> 		reg = <0>; // which seems already problematic?
>>>>>> 		adi,pin-id <1>;
>>>>>> 	};
>>>>>>
>>>>>> 	...
>>>>>>
>>>>>> 	//up to 4
>>>>>> };
>>>>> Yeah. It's not clear to me how that works for the microchip devices
>>>>> (I suspect it doesn't!)
>>>>>
>>>>> Just thinking as I type, but could we do something a bit nasty with
>>>>> a gpio mux that doesn't actually switch but represents the GPIO being
>>>>> shared?  Given this is all tied to the spi bus that should all happen
>>>>> under serializing locks.
>>>>>
>>>>> Agreed though that this would be nicer as an SPI thing that let
>>>>> us specify that a single CS is share by multiple devices and their
>>>>> is some other signal acting to select which one we are talking to.
>>>> Whether it works or not, I think it is the more correct approach. Messing
>>>> with gpio muxes seems completely wrong, given the chip select may not be
>>>> a gpio at all.
>>>>
>>>> Why do you think the microchip devices won't work? Does the spi core
>>>> reject multiple devices with the same chip select being registered or
>>>> something like that?
>>> Not sure how things work atm. But I'm fairly sure it used to be like
>>> that. SPI would reject devices on the same controller and CS. Now that
>>> we support more than one CS per controller, not sure how things work.
>> We always supported more than one per CS per controller. I guess you mean
>> per device.
> Obviously :)
>>> Janani, maybe you can give it a try?
>> I think we'd need to get it to work with shared gpio proxy which maybe
>> will just get set up under the hood.  This used to be opt in, but seems
>> that changed fairly recently so maybe some of us are working with out
>> of date knowledge!  I haven't played with it yet, so might not be
>> that simple.
>>
> What I meant for Janani was basically testing two devices on the same CS
> as in my pseudo DT. For the GPIO, you mean having a way to select
> between devices on the same CS?
>
> For these devices the pin id numbers get's setted up as part of the spi message
> so my assumption is that all of them will receive the message but only one acks it.
>
> - Nuno Sá

Hi Everyone,

I tested the case where there are two devices on the same CS. The SPI core does reject it at spi_dev_check_cs():
https://github.com/torvalds/linux/blob/master/drivers/spi/spi.c#L631

-Janani Sunil

>
>> Jonathan
>>
>>> - Nuno Sá
>>>
