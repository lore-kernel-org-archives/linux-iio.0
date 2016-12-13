Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:39587 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934486AbcLMULX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Dec 2016 15:11:23 -0500
Date: Tue, 13 Dec 2016 21:11:20 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Andreas Klinger <ak@it-klinger.de>
cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org
Subject: Re: [PATCH 1/2] iio: adc: hx711: Add DT binding for avia,hx711
In-Reply-To: <20161213180142.GA3162@andreas>
Message-ID: <alpine.DEB.2.02.1612132110240.8653@pmeerw.net>
References: <20161213180142.GA3162@andreas>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Add DT bindings for avia,hx711
> Add vendor avia to vendor list
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../devicetree/bindings/iio/adc/avia-hx711.txt     | 23 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> new file mode 100644
> index 000000000000..d56f95705fd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -0,0 +1,23 @@
> +* AVIA HX711 ADC chip for weight cells
> +  Bit-banging driver
> +
> +Required properties:
> + - compatible: Should be "avia,hx711"
> + - sck-gpios:	Definition of the GPIO for the clock
> + - dout-gpios:	Definition of the GPIO for Data-Out

data-out (lowercase)


> +		See Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Recommended properties:
> + - gain:	Gain select, can be 32, 64 or 128
> +		default is 128
> +
> +Optional properties:

maybe delete this empty section?

> +
> +Example:
> +weight@0 {
> +	compatible = "avia,hx711";
> +	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> +	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +	gain = <32>
> +};
> +
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 44ddc980b085..4696bb5c2198 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -32,6 +32,7 @@ atlas	Atlas Scientific LLC
>  atmel	Atmel Corporation
>  auo	AU Optronics Corporation
>  avago	Avago Technologies
> +avia	avia semiconductor
>  avic	Shanghai AVIC Optoelectronics Co., Ltd.
>  axis	Axis Communications AB
>  boe	BOE Technology Group Co., Ltd.
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
