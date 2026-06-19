Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8583749E5
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865198; cv=none; b=Ri10nBGAIE1NM1TTUi93wM+h7bjCmE6nKdGT+wQHuk68pYKL2787kiRks11MT6Wu4+PKb7Ep1GUdiZ8GwgWo1mxJ3mliLZf4oUAlc5rJnEii9JB7ILnAzf6atzfaM9M+bu5ulc+jZ79LXKyohoBeWrjmtcxeoz2XZEa8HF60HAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865198; c=relaxed/simple;
	bh=ww1AWBauQ0C8q90nsvZajGEEp7cRi76uQP7EtuMOh8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ft68eH994XhRe/c8wFLQAXMCdt5nTmOCxu+/8AQZPK2taie/shz/DqqcUSAAxogYaFiUuKVYSSQU20/UtD3zSH/IFDVlebuvE3dNtRBIUMHHL5mpGrqvgNcEIa68sYOePUP2D2O5b8iZy6/qt+7vg+5IMbpDXF6WWd66rJR8ZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smjXlOKn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smjXlOKn"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-46066e640easo1209991f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781865194; x=1782469994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woHL+tMyNRNr6hk72r0ayu96UqFzq9L0anUGreDsb2g=;
        b=smjXlOKnZ5KbH2Y3chivO/TLvG5gxjdzPfKjSGj0ICNZrtSK7KJKeAkCXLyiMOroPt
         xh72olaaunXIIX1x8vqIxYpEeQeWd8tiIdz4igkNcx2ZSvrOgs1VCa7Hu+M/b1anS/4n
         Uh5Ao5Xphz9tP+Srj0aQDdsj1+Vl7JsgLWP+RaKE4ApqtGzFwibHrDnI60w8JnYbuulo
         Hy+8HWZ5a2dyIj0AOZbI/IAlhN8J5Nr+46FBWEg/rtB+Z4pzPKJcMx6zqJSqUwVjC5A8
         xTbEFxvx5grqBLTZvdsSfDJRBdYbrk4c5Oz6iKeO17eUs3zh5vDWoqwbcvbxs23gacGc
         9J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781865194; x=1782469994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=woHL+tMyNRNr6hk72r0ayu96UqFzq9L0anUGreDsb2g=;
        b=O1DbkRMFRx2jgSmFCg74xrtiAqbCRXwgEmIZNQy101qz95mtRF61GxJtQPOrBZJ3Yc
         cTDRTks1La1iTa7UxHpZqYMzK27e8XD/duqLnVdCq8AeqyYBA1yOeuRRo5NWkTY2Vz+R
         8KI8+Rg81ThnPs6JbGCMesn9YI0RTDmLq3Hi4Di+vyFQl1tIPdpD3aQMW/pR1f4kme/P
         Y24hUWUDpGlEQ/lS5S9MaoaK1OCHW1pBnm5oeJ0GOvEf166xDGsSx38s8N+7LQr+THZr
         av8TbHAj7cNuKJBdkatHwqvb/cvERzrhwSJC+KENTLp4dypvOxKQYQtebukWhCeMltAv
         9HHw==
X-Forwarded-Encrypted: i=1; AFNElJ9n1nIbhL1Tf8R0nTEWHobh4jFsYljKWhs30OrUq94Zj25AhghvFZO+klBzzqden1TFdbfhN3VSLDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLzQlhM9F9a+jgIDMDbcBfTH52ayI5g1Q0rXa9Fy5xwSrpQws
	JWr4T8G2f7nVLDEOgotySfWLAX1qkpK6aTYH4dlgwxc5Q7VxhILG6icO
X-Gm-Gg: AfdE7cnu3fl2lHlI3VQJ5+tShp0VV7BYO6J+0GfxUbFgK+ogmkBsHUG9nG5bwLP94IE
	dyqwXLOKhY8OetIKT6//dwcvv1HnhYFHR2aBK8bQ3D3POx/ETXhnEO5Rgtm1eMHjCe9KFwny0yr
	fvMPKr8lQIJXAwpV2GlRf3vUEw/svfuqJu4CjcnNoF3CPWGDE5wGwLlkvqss1hC3s+xu36rDRF/
	ygjhf0zqPryJ4AzzAP5EXRu+LNqVza+RIq+R62LbaIiQh/CmYTMF0uElqzF6mowKMuQeBQWEwrh
	CSHP5tdbB+hBbz+3V45i6UvWlXSyV3VihzhGHshE45BLBE4fXNmDXNTC9tXzsYBrDXYF51vuQ+I
	rSauGuiHw5zYWIvTMqtn3Pp2nyfEB0JKu1NGuP8bZ+Zp6PL39sjn7x5pPlr5w4R07NSDt3f/WE4
	wtRcpiFEW/vIOjG4rtUuPtmzsJISgUyoQu5UBTPhx+rKYhncbEsfYW+dZuN7+aaNALFIw=
X-Received: by 2002:a5d:6143:0:b0:460:67b0:7544 with SMTP id ffacd0b85a97d-465071f9c24mr4055283f8f.7.1781865193657;
        Fri, 19 Jun 2026 03:33:13 -0700 (PDT)
Received: from ?IPV6:2a00:1e:db84:b301:2dd5:b6ee:bd0f:4c9f? ([2a00:1e:db84:b301:2dd5:b6ee:bd0f:4c9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-465090c5176sm6709556f8f.12.2026.06.19.03.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 03:33:13 -0700 (PDT)
Message-ID: <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
Date: Fri, 19 Jun 2026 12:33:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
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
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
 <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
 <25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
 <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
 <20260614204455.408c4d40@jic23-huawei>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20260614204455.408c4d40@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/14/26 21:44, Jonathan Cameron wrote:
> On Tue, 9 Jun 2026 16:47:23 +0200
> Janani Sunil <jan.sun97@gmail.com> wrote:
>
>> On 5/26/26 15:11, Rodrigo Alencar wrote:
>>> On 26/05/19 05:42PM, Janani Sunil wrote:
>>>> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
>>>> buffered voltage output digital-to-analog converter (DAC) with an
>>>> integrated precision reference.
>>> ...
>>> Probably others may comment on that, but...
>>>
>>> This parent node may support device addressing for multi-device support through
>>> those ID pins. I suppose that each device may have its own power supplies or
>>> other resources like the toggle pins or reset and enable.
>>>
>>> That way I suppose that an example would look like...
>>>   
>>>> +
>>>> +patternProperties:
>>>> +  "^channel@([0-9]|1[0-5])$":
>>>> +    type: object
>>>> +    description: Child nodes for individual channel configuration
>>>> +
>>>> +    properties:
>>>> +      reg:
>>>> +        description: Channel number.
>>>> +        minimum: 0
>>>> +        maximum: 15
>>>> +
>>>> +      adi,output-range-microvolt:
>>>> +        description: |
>>>> +          Output voltage range for this channel as [min, max] in microvolts.
>>>> +          If not specified, defaults to 0V to 5V range.
>>>> +        oneOf:
>>>> +          - items:
>>>> +              - const: 0
>>>> +              - enum: [5000000, 10000000, 20000000, 40000000]
>>>> +          - items:
>>>> +              - const: -5000000
>>>> +              - const: 5000000
>>>> +          - items:
>>>> +              - const: -10000000
>>>> +              - const: 10000000
>>>> +          - items:
>>>> +              - const: -15000000
>>>> +              - const: 15000000
>>>> +          - items:
>>>> +              - const: -20000000
>>>> +              - const: 20000000
>>>> +
>>>> +    required:
>>>> +      - reg
>>>> +
>>>> +    additionalProperties: false
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - vdd-supply
>>>> +  - avdd-supply
>>>> +  - hvdd-supply
>>>> +
>>>> +dependencies:
>>>> +  spi-cpha: [ spi-cpol ]
>>>> +  spi-cpol: [ spi-cpha ]
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>> +
>>>> +unevaluatedProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>> +
>>>> +    spi {
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        dac@0 {
>>>> +            compatible = "adi,ad5529r-16";
>>>> +            reg = <0>;
>>>> +            spi-max-frequency = <25000000>;
>>>> +
>>>> +            vdd-supply = <&vdd_regulator>;
>>>> +            avdd-supply = <&avdd_regulator>;
>>>> +            hvdd-supply = <&hvdd_regulator>;
>>>> +            hvss-supply = <&hvss_regulator>;
>>>> +
>>>> +            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
>>>> +
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <0>;
>>>> +
>>>> +            channel@0 {
>>>> +                reg = <0>;
>>>> +                adi,output-range-microvolt = <0 5000000>;
>>>> +            };
>>>> +
>>>> +            channel@1 {
>>>> +                reg = <1>;
>>>> +                adi,output-range-microvolt = <(-10000000) 10000000>;
>>>> +            };
>>>> +
>>>> +            channel@2 {
>>>> +                reg = <2>;
>>>> +                adi,output-range-microvolt = <0 40000000>;
>>>> +            };
>>>> +        };
>>>> +    };
>>> ...
>>>
>>> 	spi {
>>> 		#address-cells = <1>;
>>> 		#size-cells = <0>;
>>>
>>> 		multi-dac@0 {
>>> 			compatible = "adi,ad5529r-16";
>>> 			reg = <0>;
>>> 			spi-max-frequency = <25000000>;
>>>
>>> 			#address-cells = <1>;
>>> 			#size-cells = <0>;
>>>
>>> 			dac@0 {
>>> 				reg = <0>;
>>> 				vdd-supply = <&vdd_regulator>;
>>> 				avdd-supply = <&avdd_regulator>;
>>> 				hvdd-supply = <&hvdd_regulator>;
>>> 				hvss-supply = <&hvss_regulator>;
>>>
>>> 				reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
>>>
>>> 				#address-cells = <1>;
>>> 				#size-cells = <0>;
>>>
>>> 				channel@0 {
>>> 					reg = <0>;
>>> 					adi,output-range-microvolt = <0 5000000>;
>>> 				};
>>>
>>> 				channel@1 {
>>> 					reg = <1>;
>>> 					adi,output-range-microvolt = <(-10000000) 10000000>;
>>> 				};
>>>
>>> 				channel@2 {
>>> 					reg = <2>;
>>> 					adi,output-range-microvolt = <0 40000000>;
>>> 				};
>>> 			}
>>>
>>> 			dac@1 {
>>> 				reg = <1>;
>>> 				vdd-supply = <&vdd_regulator>;
>>> 				avdd-supply = <&avdd_regulator>;
>>> 				hvdd-supply = <&hvdd_regulator>;
>>> 				hvss-supply = <&hvss_regulator>;
>>>
>>> 				reset-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
>>>
>>> 				#address-cells = <1>;
>>> 				#size-cells = <0>;
>>>
>>> 				channel@0 {
>>> 					reg = <0>;
>>> 					adi,output-range-microvolt = <0 5000000>;
>>> 				};
>>>
>>> 				channel@1 {
>>> 					reg = <1>;
>>> 					adi,output-range-microvolt = <(-10000000) 10000000>;
>>> 				};
>>> 			}
>>> 		};
>>> 	};
>>>
>>> then you might need something like:
>>>
>>> 	patternProperties:
>>> 		"^dac@[0-3]$":
>>>
>>> and put most of the things under this node pattern.
>>>
>>> So the main driver that you're putting together might need to handle up to four instances.
>>> Even if your current driver cannot handle this, the dt-bindings might need cover that.
>>>
>>> Need to double check if each dac node needs a separate compatible, so you would maybe populate
>>> a platform data to be shared with the child nodes, which would be a separate driver.
>>> (not sure if it would make sense to mix and match ad5529r-16 and ad5529r-12).
>> Hi Rodrigo,
>>
>> Thank you for looking at this.
>>
>> For now, I would prefer to keep the binding scoped to a single AD5529R device instance. The current
>> hardware/use case we have only needs one device node and the driver is written around that model as well.
>> While the device addressing pins could allow multi-device topology, we do not have an actual platform using
>> that configuration at the moment, so I would prefer not to introduce an extra parent/child binding structure
>> speculatively without a validating use case.
> Interesting feature - kind of similar to address control on a typical i2c bus device, or
> looking at it another way a kind of distributed SPI mux.
>
> Challenge of a binding is we need to anticipate the future.  So I think we do need something
> like Rodrigo is suggesting even if we only (for now) support a single instance in the driver.
> That would leave the path open to supporting the addressing at a later date.
> An alternative might be to look at it like a chained device setup. In those we pretend there
> is just one device with a lot of channels etc.  The snag is that here things are more loosely
> coupled whereas for those devices it tends to be you have to read / write the same register
> in all devices in the chain as one big SPI message.
>
> +CC Mark Brown as he may know of some precedence for this feature. For his reference..
> - Each of these device has 2 ID pins.  The SPI transfers have to contain the 2 bit
> value that matches that or they are ignored.  Thus a single bus + 1 chip select can
> be used to talk to 4 devices.  Question is what that looks like in device tree + I guess
> longer term how to support it cleanly in SPI.
>
> Jonathan

Hi Jonathan, Rob, Krzysztof, Conor,

One possible model that would also allow mixing the 12-bit and 16-bit variants would be to treat the parent node
as the shared SPI transport only, and let each dac@N child carry its own compatible.

Rob, Krzysztof, Conor — wanted to get your input on whether this is an acceptable binding pattern.

properties:
   compatible:
     const: adi,ad5529r-bus

patternProperties:
   "^dac@[0-3]$":
     type: object
     properties:
       compatible:
         enum:
           - adi,ad5529r-16
           - adi,ad5529r-12
       reg:
         minimum: 0
         maximum: 3

With a DT example such as:

ad5529r@0 {
         compatible = "adi,ad5529r-bus";
         reg = <0>;

         dac@0 {
                 compatible = "adi,ad5529r-16";
                 reg = <0>;
         };

         dac@1 {
                 compatible = "adi,ad5529r-12";
                 reg = <1>;
         };
};

The downside is that it introduces adi,ad5529r-bus as a compatible that does not correspond to an actual
standalone device variant - it would require a parent driver to manage the shared SPI transport and enumerate the
child devices. The actual DAC functionality is handled by the matching per-child compatibles(12 or 16 bit).
Is this an acceptable pattern, or is there a preferred way to model this type of addressing scheme?

Regards,
Janani Sunil

