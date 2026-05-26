Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55133FA5C6
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801114; cv=none; b=ZA0rh4fAaAVPf+GakhfUs+68NKCObodNANp2mFwSzFJjwuJXSN5rPu3SKsxlJwEnxW6/QEITpjd7OvscmFN2MhziNRbidRjiokjluz7CMNXQfmD5HHodnUI/p5lkY4sZ2NxAa/o6iktlR2hog3s65ckLSvhjdXWi41Egt7gU4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801114; c=relaxed/simple;
	bh=z+TQ3T9Oy+ZZa2gZfsK8H+btrtS2pPvwQYb90T0bJv8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9j9zvA1NGg9BS6pXMkh4tkuZ6wjXtIM7BW0jEngH/58KOH5W/C9GRmTRe67Dr0eCbuUXQXmORUIRN4MxokAhWX7fdmCWVAp+Q+33g827Vw06ywfTShheZ2IVcAZkmPAcdYYgdceMaGKI9Qxqt0zdxPKzsxOpUoORhMn/eMz95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wds0qgyf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wds0qgyf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso29713015e9.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779801111; x=1780405911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WqOvSJUHAXMpiDAGk3rY9rJLyQCFTcUSCPYqn0vZPF0=;
        b=Wds0qgyfFbrkOkWjqMSXAzGM30h8xhtaRKYhjuTsogLxIWzzSqIhfr4LC2G/x8CZs/
         qmj4IkXmw2cIjIITxFpKvvlYn1L6MbUDecrl8n/aOSrd0xMwgBfamKZpXVT7D7HjWttV
         weFESA6rz5C2WkmuizEhr80M9gEit3HU42YfghiQK6AgbQlY8ezI05YYHhYlafzijLTd
         Doz1aG+pf4kz4x5EWUKJdFcQ+61d2FzCa/pUMO54FmqSsMSK17YmJbCwZSl7E/RlDdyx
         ef5K6AMQtUWBSxdQIKAa5IiPNAA/ojgVbRlyMlbBBWF9hOrpGKVXm2mOYXQV3QQL+MST
         Zgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801111; x=1780405911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqOvSJUHAXMpiDAGk3rY9rJLyQCFTcUSCPYqn0vZPF0=;
        b=IojjLztdT5oQlgfZQy+PUJkY7k/CZ+6Iq6ap6qwLHBQzcQwFe0DPfy/NCgbaibWGJY
         goRM69MUsMalWV05OWc5EfcHffh1GvPCcr1o+WupagcPdDeBugXBSv2xiHO9vI5sgjE/
         LAdp9bCBRHnRRFifPNOCnCpFNvvP6XWNgWpZq6rJh29HsK2HAJy6QcjBfpV+UaTiBskF
         jMltQALJZdQs4H8e/5xSDCEQHGp0XZtapMS18RHHOle5kgxzltub99LqNMUpNCVBOgJI
         8Y3dYupF9MoRj031N8BzRHIwcZjpEGqKiHGz5Keow0SDAyHb07pehTWDPGWkgGHLfugw
         0F4A==
X-Gm-Message-State: AOJu0Yzvku1XN02mngDZW/yUEVbfBbHafB6E8y8vhQGekTtC6zSjrr6v
	slyBdGkBxyq5TGjP5pn2ckxMgbAkRCudSpBubzDpZlDMgEpKPWI5KDpx
X-Gm-Gg: Acq92OFPSbaX89vDPs6Rzz4vDXrT00vTE/KHSKI+BP1H+CJV+VfciA0tJh3O70XZ9bK
	T2tgLXvWZs5Y9lzfBACD7nqwzepqUfplCXlkp/70bbUJa3Z2UzL2uXwSKOiMVe18/aDjDjaKkkv
	k7rlW0SbmrpX+ifLOPiesK8DU/gTGt5ajQbPRjTKRjx3cb2xvrw1QkulMl+brqU6rKQFlCIR2D/
	p4k0YCRZUgCYRhMqySEMPL1dM78r5t16AeeVWU7UEsffNRuaB0YbaSuzLwy+7lH5NUIz2PbpjNR
	IXmgEbFnYzHTpTs5gt6+TNqTAKYzNreSYVW1iidy2cb/KGK+XfPKyaI5/pFA6MhEzX4d4UTg7gw
	1s66JPU3ZAVg1jaXYnr3pHLf6ygzqE2+ajYjFSL4NTbBTQK9mmPsQxyHgCyqaAisu08fzNulFCk
	WaeV0L2nvetESXr5khExQhzlqtTRtOSzxAQ7P/qlOozc7/18vvEvyRoBz9kB55r1NfSpje03Bb6
	yIpl0gS9Qdez4ZPjVe3/xNOPRYkwG6ENvmJ5HRPmbegkO0GdLpAqd+nt4WO
X-Received: by 2002:a05:600c:a011:b0:490:50ff:7943 with SMTP id 5b1f17b1804b1-49050ff7b15mr238902025e9.5.1779801110828;
        Tue, 26 May 2026 06:11:50 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042487609sm170628755e9.3.2026.05.26.06.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:50 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 26 May 2026 14:11:45 +0100
To: Janani Sunil <janani.sunil@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
 <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>

On 26/05/19 05:42PM, Janani Sunil wrote:
> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> buffered voltage output digital-to-analog converter (DAC) with an
> integrated precision reference.

...

> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5529r-16   # 16-bit variant
> +      - adi,ad5529r-12   # 12-bit variant
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +    description:
> +      Maximum SPI frequency. The device supports SPI Mode 0 and Mode 3.
> +      Read operations are limited to 25MHz maximum.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the RESET pin. Active low. When asserted low,
> +      performs a power-on reset and initializes the device to its default state.
> +
> +  clear-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the CLEAR pin. Active low. When asserted low,
> +      clears all DAC data registers without affecting configuration settings.
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt connected to the ALARM pin. Active low interrupt output
> +      for overtemperature conditions, SPI CRC errors, and function completion.
> +
> +  tg0-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the TG0 toggle pin. Pulsing this pin allows all
> +      selected DACs to be updated synchronously for coordinated output changes.
> +
> +  tg1-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the TG1 toggle pin. Pulsing this pin allows all
> +      selected DACs to be updated synchronously for coordinated output changes.
> +
> +  tg2-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the TG2 toggle pin. Pulsing this pin allows all
> +      selected DACs to be updated synchronously for coordinated output changes.
> +
> +  tg3-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the TG3 toggle pin. Pulsing this pin allows all
> +      selected DACs to be updated synchronously for coordinated output changes.

Those toggle pins might need to be connected to a pwm source, rather than using
them as regular gpios (or maybe allow for both).

> +
> +  io-channels:
> +    maxItems: 1
> +    description:
> +      ADC channel connected to the MUXOUT pin for monitoring output voltage,
> +      load current sense, and die temperature.
> +
> +  io-channel-names:
> +    const: muxout
> +
> +  vdd-supply:
> +    description: Digital power supply (1.08V to 1.98V)
> +
> +  avdd-supply:
> +    description: Analog power supply (4.75V to 5.25V)
> +
> +  hvdd-supply:
> +    description:
> +      High voltage positive supply (7V to 45V). Supply voltage should be chosen
> +      based on configured output ranges (see datasheet Table 9).
> +
> +  hvss-supply:
> +    description:
> +      High voltage negative supply (-22.5V to 0V). Required only when using bipolar
> +      output ranges (±5V, ±10V, ±15V, ±20V). Supply voltage should be
> +      chosen based on configured output ranges (see datasheet Table 9).
> +
> +  vref-supply:
> +    description:
> +      External voltage reference supply (4.056V to 4.136V, typically 4.096V).
> +      When specified, the device uses external reference mode and the VREF pin becomes an
> +      input. The device uses the internal 4.096V precision reference otherwise.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

Probably others may comment on that, but...

This parent node may support device addressing for multi-device support through
those ID pins. I suppose that each device may have its own power supplies or
other resources like the toggle pins or reset and enable.

That way I suppose that an example would look like...

> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +    description: Child nodes for individual channel configuration
> +
> +    properties:
> +      reg:
> +        description: Channel number.
> +        minimum: 0
> +        maximum: 15
> +
> +      adi,output-range-microvolt:
> +        description: |
> +          Output voltage range for this channel as [min, max] in microvolts.
> +          If not specified, defaults to 0V to 5V range.
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - enum: [5000000, 10000000, 20000000, 40000000]
> +          - items:
> +              - const: -5000000
> +              - const: 5000000
> +          - items:
> +              - const: -10000000
> +              - const: 10000000
> +          - items:
> +              - const: -15000000
> +              - const: 15000000
> +          - items:
> +              - const: -20000000
> +              - const: 20000000
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - avdd-supply
> +  - hvdd-supply
> +
> +dependencies:
> +  spi-cpha: [ spi-cpol ]
> +  spi-cpol: [ spi-cpha ]
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,ad5529r-16";
> +            reg = <0>;
> +            spi-max-frequency = <25000000>;
> +
> +            vdd-supply = <&vdd_regulator>;
> +            avdd-supply = <&avdd_regulator>;
> +            hvdd-supply = <&hvdd_regulator>;
> +            hvss-supply = <&hvss_regulator>;
> +
> +            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                adi,output-range-microvolt = <0 5000000>;
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                adi,output-range-microvolt = <(-10000000) 10000000>;
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +                adi,output-range-microvolt = <0 40000000>;
> +            };
> +        };
> +    };

...

	spi {
		#address-cells = <1>;
		#size-cells = <0>;

		multi-dac@0 {
			compatible = "adi,ad5529r-16";
			reg = <0>;
			spi-max-frequency = <25000000>;

			#address-cells = <1>;
			#size-cells = <0>;

			dac@0 {
				reg = <0>;
				vdd-supply = <&vdd_regulator>;
				avdd-supply = <&avdd_regulator>;
				hvdd-supply = <&hvdd_regulator>;
				hvss-supply = <&hvss_regulator>;

				reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;

				#address-cells = <1>;
				#size-cells = <0>;

				channel@0 {
					reg = <0>;
					adi,output-range-microvolt = <0 5000000>;
				};

				channel@1 {
					reg = <1>;
					adi,output-range-microvolt = <(-10000000) 10000000>;
				};

				channel@2 {
					reg = <2>;
					adi,output-range-microvolt = <0 40000000>;
				};
			}

			dac@1 {
				reg = <1>;
				vdd-supply = <&vdd_regulator>;
				avdd-supply = <&avdd_regulator>;
				hvdd-supply = <&hvdd_regulator>;
				hvss-supply = <&hvss_regulator>;

				reset-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;

				#address-cells = <1>;
				#size-cells = <0>;

				channel@0 {
					reg = <0>;
					adi,output-range-microvolt = <0 5000000>;
				};

				channel@1 {
					reg = <1>;
					adi,output-range-microvolt = <(-10000000) 10000000>;
				};
			}
		};
	};

then you might need something like:

	patternProperties:
		"^dac@[0-3]$":

and put most of the things under this node pattern.

So the main driver that you're putting together might need to handle up to four instances.
Even if your current driver cannot handle this, the dt-bindings might need cover that.

Need to double check if each dac node needs a separate compatible, so you would maybe populate
a platform data to be shared with the child nodes, which would be a separate driver.
(not sure if it would make sense to mix and match ad5529r-16 and ad5529r-12).

-- 
Kind regards,

Rodrigo Alencar
