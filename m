Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8C3793DE;
	Thu, 28 May 2026 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959240; cv=none; b=rmFhyovGn2OMJf3Tp7CqV4cUr2GRfUIJ7iiB+ZKgAm7dW0k4BpjCi8NoJY5Z/9d9KbTldUopI+ef9oxsPVEGXpdcex6PkoNAMxEh3vtJmviOkDxXbwv6BZv6+c4DA4Mjx9KqUBqcYvDpTc0VVchpJioubmO89atTUoH6bzfVE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959240; c=relaxed/simple;
	bh=pBUV/qqsAToVM4YaqruCuxCjqkrECwFPrqgInLPJAEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoI9ja9hQrUdqtEncem1WHPMJSahOsT0Z8d4bV7eNMljet9D4tR8RknTcljOi98Fo59GOQBANKF9RLogyQokzBCbxzcFf1qwVr4WI/gvg6dRuRAZJds/s6IF2OcBwKe5ZWhdOn76kHndwaSY8+FhZvoF9+N4WKUUY5PoAMa8g28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJyoDuh1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJyoDuh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38641F000E9;
	Thu, 28 May 2026 09:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779959238;
	bh=qMPMXxAUDVsD0np3R3kkzvjrDQ5Nfd5UlkCs9CF8CCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LJyoDuh1dEBymd5DJRFyAuJK6hT00yZefGULLaugdejZqSPG3dGr2tWiBMJRqBRPQ
	 3jpj9f0KE6LMSlyLLv3B7J1flp/GOHAdLxR9Q/fPTCG4kuRQka88/4/EIT80vEWOJX
	 VGceulGKzhXjWBtp2K7Z4hqIVpSitUCE+5HEHoWWnUzIYr2qzfAGJCopEuYzCOTliS
	 smqYquUkD6V0IoaHSNS92TmijQklQh9j44GRNZaeIs1AAmhItpNxffMciDd61hPe5n
	 wC0fD9b5wPYxXpilcGtBCgrc8BFfH4aiHq8ZJ2gI4c/Wv5U6JMeHrWmGsuSV5hdYfy
	 RH/ggntWOGLlQ==
Date: Thu, 28 May 2026 11:07:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Andreas Klinger <ak@it-klinger.de>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260528-transparent-adventurous-python-af8f69@quoll>
References: <20260524205112.26638-1-wafgo01@gmail.com>
 <20260527184257.141635-1-wafgo01@gmail.com>
 <20260527184257.141635-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527184257.141635-3-wafgo01@gmail.com>

On Wed, May 27, 2026 at 08:42:53PM +0200, Wadim Mueller wrote:
> Document the bindings for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  The family currently covers the
> SLF3S-0600F, SLF3S-1300F, and SLF3S-4000B variants.
> 
> Variants share the same register map and differ only in the flow
> scale factor and calibrated measurement range, both of which are
> auto-detected at probe time via the product-information register.
> Per-variant compatible strings are accepted for documentation and
> future-proofing; new variants will fall back on the generic
> "sensirion,slf3s" compatible without a driver update.
> 
> The data-ready interrupt is optional; without it the driver falls
> back to polled I2C reads.
> 
> A sensirion,medium property is added so that the driver can start
> the sensor with either the H2O or the IPA factory calibration
> (default H2O).

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Andreas Klinger <ak@it-klinger.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-hwmon@vger.kernel.org

No need for cc of maintainers here which are output by
get_maintainers.pl. get_maintainers.pl provides that basically.

Anyway, your SoB must be the last.

> Cc: Maxwell Doose <m32285159@gmail.com>

...

> +description:
> +  Family of digital liquid-flow sensors from Sensirion with I2C interface.
> +  All family members share the same register map; sub-types differ only in
> +  the flow scale factor and the calibrated measurement range, both of
> +  which are detected at probe time via the product-information register.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sensirion,slf3s-0600f
> +              - sensirion,slf3s-1300f
> +              - sensirion,slf3s-4000b
> +          - const: sensirion,slf3s
> +      - const: sensirion,slf3s

That's confusing - why do you have generic compatible allowed to be
alone?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Optional data-ready interrupt line.  If omitted the driver falls
> +      back to polled I2C reads.
> +
> +  vdd-supply: true
> +
> +  sensirion,medium:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ water, ipa ]
> +    default: water
> +    description:
> +      Calibration medium the sensor is configured for at probe time.
> +      SLF3S sensors are factory-calibrated for both water and
> +      isopropyl alcohol (IPA); this property selects which calibration
> +      to activate.  Defaults to water when omitted.

Sounds like you configure driver probe behavior. Why this is board-level
static configuration (DT)?

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flow-sensor@8 {
> +            compatible = "sensirion,slf3s-0600f", "sensirion,slf3s";
> +            reg = <0x08>;
> +            vdd-supply = <&reg_3v3>;

Please make example complete - add all properties.

> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06a8c7457..096ef2fe7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24187,6 +24187,14 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
>  F:	drivers/iio/chemical/sgp40.c
>  
> +SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
> +M:	Wadim Mueller <wafgo01@gmail.com>
> +R:	Maxwell Doose <m32285159@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml

> +F:	drivers/iio/flow/

Drop, you don't maintain that directory here.

> +
>  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> -- 
> 2.52.0
> 
