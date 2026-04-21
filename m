Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F4382F04;
	Tue, 21 Apr 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759797; cv=none; b=HmBtkHJrftP8bOy3PfiVfpuEckLOZjLaoHqkaiwf00YQNjMbDoqgFxpPno06ZeJYKSChu4cfJAlR6NGwrhdcaaQY6cVL4WFrUQZ4l9qeFXKlBctB+WRQyrg3ga1gOBTzdqp+sTYEiXEm7rx9HEmWBJ3V4dW2hVt0yHZnb0v5z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759797; c=relaxed/simple;
	bh=CUWdgVUjk8fsSZY0BYXBcqu/M7mJziD0R8DviS34dkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RF/j3/gzGbZ9QzZoIl3j8qlVkA/eNTumCxDfywE66rwbRAVnT8yB4bd6TDvK9nCpxCf2gu0cZLEUD5RXkT+Uvec+8lHF7S0iFpif3/5f8pjUYFyQpOwZ4pjDgDBj1JjU2oWbDe/4f8aDhEBjde+gD/iaLZHBEwnpO7Pa3sknuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/uJupka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/uJupka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327D0C2BCB0;
	Tue, 21 Apr 2026 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776759796;
	bh=CUWdgVUjk8fsSZY0BYXBcqu/M7mJziD0R8DviS34dkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/uJupka8lwcIQcUmdYiZeodZvAMLHzeWNIVbsLlUaGfAYifT4k4GVUlRTpKJEieT
	 86+Zjrs5g2fgTiY2Ng0PrXC0exbAiqYgGVbpbH/2vu/j/S9hhjr07ch2Hh+l2P5k3B
	 Z75qzJ7GRMsk46DHfe29tt1gAihTWYG4aokAUgsEAupkgOtryuZEV8JLOsRAeZ6reY
	 gRrfM3na14aBVMqVYJM+8Fn3mg5A+IUT31PqJlzyYmesqTyNuUJ6gUV+wlbWiAoKtF
	 T/YiIFY/zqWgL6wOlK22EvSxaKb1CgG0xd6fpcgNl5lKmM4UQUQBZeCkhi9azcPkYQ
	 7f+p6n1rB+Ekw==
Date: Tue, 21 Apr 2026 10:23:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: jic23@kernel.org, ak@it-klinger.de, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: avia-hx711: add
 avia,hx710b compatible
Message-ID: <20260421-heavy-amigurumi-badger-c7ef9f@quoll>
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
 <20260419174654.683692-2-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260419174654.683692-2-piyushpatle228@gmail.com>

On Sun, Apr 19, 2026 at 11:16:39PM +0530, Piyush Patle wrote:
>  description: |
> -  Bit-banging driver using two GPIOs:
> -  - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
> -    and up to 3 cycles for selection of the input channel and gain for the
> -    next measurement
> -  - dout-gpio is the sensor data the sensor responds to the clock
> +  The HX711 is a 24-bit ADC with selectable gain (32/64/128) and two
> +  differential input channels. Channel A supports gain 64 and 128;
> +  channel B supports gain 32.
>  
> -  Specifications about the driver can be found at:
> -  http://www.aviaic.com/ENProducts.aspx
> +  The HX710B is a 24-bit ADC with fixed gain of 128. Channel 0 is the
> +  differential input and channel 1 measures the DVDD-AVDD supply
> +  voltage difference.
>  
>  properties:
>    compatible:
>      enum:
> +      - avia,hx710b
>        - avia,hx711
>  
>    sck-gpios:
> @@ -40,13 +40,45 @@ properties:
>  
>    avdd-supply:
>      description:
> -      Definition of the regulator used as analog supply
> +      Analog supply voltage (AVDD). Also serves as the voltage reference on
> +      both chips; no separate vref-supply is required.

There is no such thing as vref-supply.

> +
> +  dvdd-supply:
> +    description:
> +      Digital supply voltage (DVDD). HX711 only.
> +
> +  vsup-supply:
> +    description:
> +      Supply voltage for the on-chip regulator (VSUP). HX711 only.
> +
> +  rate-gpios:
> +    description:
> +      GPIO connected to the RATE pin (HX711 only). When driven low the
> +      output data rate is 10 SPS; when driven high it is 80 SPS. If
> +      omitted the RATE pin state is determined by the board wiring.
> +    maxItems: 1
>  
>    clock-frequency:
> +    description:
> +      Controls the SCK bit-bang timing. The value is used to derive the
> +      delay between SCK edges; keep the SCK high time below 60 us to
> +      avoid triggering chip power-down mode. Defaults to 400 kHz if not
> +      specified.

Don't repeat constraints in free form text. Drop last sentence.

>      minimum: 20000
>      maximum: 2500000
>      default: 400000
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: avia,hx710b
> +    then:
> +      properties:
> +        vsup-supply: false
> +        dvdd-supply: false
> +        rate-gpios: false
> +
>  required:
>    - compatible
>    - sck-gpios
> @@ -58,10 +90,19 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> -    weight {
> +    weight0 {

Don't change the node names.

>          compatible = "avia,hx711";
>          sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>          dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>          avdd-supply = <&avdd>;
>          clock-frequency = <100000>;
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    weight1 {
> +        compatible = "avia,hx710b";
> +        sck-gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
> +        dout-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
> +        avdd-supply = <&avdd>;

Why no clock-frequency? So basically difference is one property? Then no
need for new example, less code to maintain.

But OTOH, where is vsup and dvdd?

> +    };
> -- 
> 2.43.0
> 
