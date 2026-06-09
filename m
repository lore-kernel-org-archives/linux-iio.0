Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F9305665
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016466; cv=none; b=FEWJ5mfekkDInXEImtqMjZkhYrncTl+aY6olu3NLiC2298Y9NkrqN/ydeN0Bbn3F6w/5ioQOcghXbm1A24/hjFOrghIQPdtr3x7zVQ9o6suAoHWhxTIhzaWwYr88Ot7Vmr7tIYwZ6D+cCVsMEFI+f9b+i4IUeaA0fQU3rZQGYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016466; c=relaxed/simple;
	bh=RHnwl20W8+5FJ29Ol8MYnlNwjRMZEERZhaV1mR9cyIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fokoCdcUAN3DWEGPYq4OsJxEZBTK8+vZ5lx9eiWvnaSDiJ9SQjjxZxSttcCIfDY3WvNQgUTNKUwjKpEhb/7ecbI/ZIoLGuzjE+cqf3kLaOuhO//V9o25AAfXP/paFzJBvxskOephtYDxuhhv+H39B5PUBM2jLS5iQleSmhI0kf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqTt3ZrH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqTt3ZrH"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842338c18e0so3931484b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016465; x=1781621265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADHZyv2+9wHkZZb1LmyBnYl5z+jc15TcX4b8qMYvO0Q=;
        b=fqTt3ZrHJ8JFzOSY5n2Qxn/orcSgSn55KefM2i2yd5Qy60e8qUsnI9LyhKH80lr5od
         ZDUfEYM97+bv4VF1kceUPVmuJVsCLSpDCloKD5vAMmuF5AVJpzyAA0cYV7UfVyCcUSBB
         WijGgD8bgkjb7fUFWlWPpTdsdBA85lFwfoEbXqJMADd6UHaLi5pVgHHHg54J1Nsx5R9A
         yikGTa+1c3GkUuh9VSIJSxXbKFSnmicddBHLVJn72F4mEP4Uk2nBHVofn51Sdk3hszwq
         FUZmeg+ibaRfe+I4EHTXq+2QChXyy1HXc+GebCSpERJUmwX6GPcy+1h37KI1Qj4Qecpf
         gpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016465; x=1781621265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADHZyv2+9wHkZZb1LmyBnYl5z+jc15TcX4b8qMYvO0Q=;
        b=k0yWEprn710Xt+aMh8vld8TdWvdD68AtUbweZsRSRJiKakuKDIsNR0E6n7nRXuPU48
         lXwld6H5pKN/HNpRFaQ1kqb+gKWIvf/ZMHTYCEm/m5M+x/vuKb8g6pGe0ptt6530DRPd
         b78ZuO8Dz99ONrxDL/sChfUp//AduyDxDq2j13TIKJs7GYIG7KTwsF5DoYv0G2qdU5gS
         tm8BAUTTPpZGWHfKg5/VV4Mw+5j2sO3xDRXe8vjvAheX3K+S2DgJf1/WEVT4+Ieeb+gi
         ozhljnxcYDc7iSTfWNauW6qWPow672V49yEJBlUDkdTsegmffh+AuVTmaLZ/Sx6fVd++
         c6sg==
X-Gm-Message-State: AOJu0Yz1ZhdpTS7sxeiL6Q/vz9zupLosDgPXbjKfEhLlmPzJtSK1M6qb
	19nrDkUm39qyRBAB7LC9SaDagMIPyclhnipK+94vtnTAnqe3U7e08OQH
X-Gm-Gg: Acq92OFd4KM0JqLi0Ei3ph0Ni9Pv6SyTD96hnPs/ZreouKkZy38IdCmLe5VrGhojDv2
	5AxiztsrpLKAxo5bf6RdGH7ryUefSS5Z/xcKyH6/grew/WByOdUQWO1x2tyfc1OSvh3C+cLDWAQ
	fLD/EvnjZrdLcpI79xVU2dvc3Nf/N19qEv87jbRGUDSxyCCXecMTW5REfK+L4ARO22YbBTPTLnV
	7Zom4dvCs6SoQEaTHxjreAx+e5CYBDLGv2iNrxMTE6PH2TZEiZIXv0lp89FkZVNoP1ewLP9yvEW
	iVAoOG75eddaUBYhd4OKGwtivf8DIKjMRx3z8sbwCIgUFdoQvoqZ9s6LIyp1Pgl5gOO0TWuFJxi
	lYZZNr0s9EKM14t5K3X3mZ+suzP35vBR9byoXexm0dcJmUYnJqIFbbny7j6tQGgmNFk/v//KSZk
	AJxsqvOZxerQf9eFjyAi0+4V/cDL8Oezl/gdco+j9ESu0sPnYZg6nqgbU+mtoWhjGZj7dhbjhri
	hZfB/c=
X-Received: by 2002:a05:6a00:3e05:b0:842:54e8:bdd with SMTP id d2e1a72fcca58-842b0fb4de6mr21207336b3a.40.1781016464749;
        Tue, 09 Jun 2026 07:47:44 -0700 (PDT)
Received: from ?IPV6:2a02:3037:27a:7db9:c4f0:a82b:c075:e2fb? ([2a02:3037:27a:7db9:c4f0:a82b:c075:e2fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm26203734b3a.26.2026.06.09.07.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:47:44 -0700 (PDT)
Message-ID: <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
Date: Tue, 9 Jun 2026 16:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
 <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
 <25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/26/26 15:11, Rodrigo Alencar wrote:
> On 26/05/19 05:42PM, Janani Sunil wrote:
>> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
>> buffered voltage output digital-to-analog converter (DAC) with an
>> integrated precision reference.
> ...
> Probably others may comment on that, but...
>
> This parent node may support device addressing for multi-device support through
> those ID pins. I suppose that each device may have its own power supplies or
> other resources like the toggle pins or reset and enable.
>
> That way I suppose that an example would look like...
>
>> +
>> +patternProperties:
>> +  "^channel@([0-9]|1[0-5])$":
>> +    type: object
>> +    description: Child nodes for individual channel configuration
>> +
>> +    properties:
>> +      reg:
>> +        description: Channel number.
>> +        minimum: 0
>> +        maximum: 15
>> +
>> +      adi,output-range-microvolt:
>> +        description: |
>> +          Output voltage range for this channel as [min, max] in microvolts.
>> +          If not specified, defaults to 0V to 5V range.
>> +        oneOf:
>> +          - items:
>> +              - const: 0
>> +              - enum: [5000000, 10000000, 20000000, 40000000]
>> +          - items:
>> +              - const: -5000000
>> +              - const: 5000000
>> +          - items:
>> +              - const: -10000000
>> +              - const: 10000000
>> +          - items:
>> +              - const: -15000000
>> +              - const: 15000000
>> +          - items:
>> +              - const: -20000000
>> +              - const: 20000000
>> +
>> +    required:
>> +      - reg
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vdd-supply
>> +  - avdd-supply
>> +  - hvdd-supply
>> +
>> +dependencies:
>> +  spi-cpha: [ spi-cpol ]
>> +  spi-cpol: [ spi-cpha ]
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        dac@0 {
>> +            compatible = "adi,ad5529r-16";
>> +            reg = <0>;
>> +            spi-max-frequency = <25000000>;
>> +
>> +            vdd-supply = <&vdd_regulator>;
>> +            avdd-supply = <&avdd_regulator>;
>> +            hvdd-supply = <&hvdd_regulator>;
>> +            hvss-supply = <&hvss_regulator>;
>> +
>> +            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            channel@0 {
>> +                reg = <0>;
>> +                adi,output-range-microvolt = <0 5000000>;
>> +            };
>> +
>> +            channel@1 {
>> +                reg = <1>;
>> +                adi,output-range-microvolt = <(-10000000) 10000000>;
>> +            };
>> +
>> +            channel@2 {
>> +                reg = <2>;
>> +                adi,output-range-microvolt = <0 40000000>;
>> +            };
>> +        };
>> +    };
> ...
>
> 	spi {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
>
> 		multi-dac@0 {
> 			compatible = "adi,ad5529r-16";
> 			reg = <0>;
> 			spi-max-frequency = <25000000>;
>
> 			#address-cells = <1>;
> 			#size-cells = <0>;
>
> 			dac@0 {
> 				reg = <0>;
> 				vdd-supply = <&vdd_regulator>;
> 				avdd-supply = <&avdd_regulator>;
> 				hvdd-supply = <&hvdd_regulator>;
> 				hvss-supply = <&hvss_regulator>;
>
> 				reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
>
> 				#address-cells = <1>;
> 				#size-cells = <0>;
>
> 				channel@0 {
> 					reg = <0>;
> 					adi,output-range-microvolt = <0 5000000>;
> 				};
>
> 				channel@1 {
> 					reg = <1>;
> 					adi,output-range-microvolt = <(-10000000) 10000000>;
> 				};
>
> 				channel@2 {
> 					reg = <2>;
> 					adi,output-range-microvolt = <0 40000000>;
> 				};
> 			}
>
> 			dac@1 {
> 				reg = <1>;
> 				vdd-supply = <&vdd_regulator>;
> 				avdd-supply = <&avdd_regulator>;
> 				hvdd-supply = <&hvdd_regulator>;
> 				hvss-supply = <&hvss_regulator>;
>
> 				reset-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
>
> 				#address-cells = <1>;
> 				#size-cells = <0>;
>
> 				channel@0 {
> 					reg = <0>;
> 					adi,output-range-microvolt = <0 5000000>;
> 				};
>
> 				channel@1 {
> 					reg = <1>;
> 					adi,output-range-microvolt = <(-10000000) 10000000>;
> 				};
> 			}
> 		};
> 	};
>
> then you might need something like:
>
> 	patternProperties:
> 		"^dac@[0-3]$":
>
> and put most of the things under this node pattern.
>
> So the main driver that you're putting together might need to handle up to four instances.
> Even if your current driver cannot handle this, the dt-bindings might need cover that.
>
> Need to double check if each dac node needs a separate compatible, so you would maybe populate
> a platform data to be shared with the child nodes, which would be a separate driver.
> (not sure if it would make sense to mix and match ad5529r-16 and ad5529r-12).

Hi Rodrigo,

Thank you for looking at this.

For now, I would prefer to keep the binding scoped to a single AD5529R device instance. The current
hardware/use case we have only needs one device node and the driver is written around that model as well.
While the device addressing pins could allow multi-device topology, we do not have an actual platform using
that configuration at the moment, so I would prefer not to introduce an extra parent/child binding structure
speculatively without a validating use case.

Best Regards,
Janani Sunil

