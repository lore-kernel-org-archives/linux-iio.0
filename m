Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43482 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934250AbdAHLKN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 06:10:13 -0500
Subject: Re: [PATCH v5 1/2] iio: adc: hx711: Add DT binding for avia,hx711
To: Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20170105175136.GA12210@andreas>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bc214ad9-1597-f32a-c17c-a3f2e3f0e950@kernel.org>
Date: Sun, 8 Jan 2017 11:10:09 +0000
MIME-Version: 1.0
In-Reply-To: <20170105175136.GA12210@andreas>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/17 17:51, Andreas Klinger wrote:
> Add DT bindings for avia,hx711
> Add vendor avia to vendor list
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
> ---
> [PATCH v3 1/2] of this patch was Acked-by: Rob Herring <robh@kernel.org>
> In v4 the regulator (avdd-supply) was added
> 
>  .../devicetree/bindings/iio/adc/avia-hx711.txt         | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> new file mode 100644
> index 000000000000..b3629405f568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -0,0 +1,18 @@
> +* AVIA HX711 ADC chip for weight cells
> +  Bit-banging driver
> +
> +Required properties:
> + - compatible:	Should be "avia,hx711"
> + - sck-gpios:	Definition of the GPIO for the clock
> + - dout-gpios:	Definition of the GPIO for data-out
> +		See Documentation/devicetree/bindings/gpio/gpio.txt
> + - avdd-supply:	Definition of the regulator used as analog supply
> +
> +Example:
> +weight@0 {
> +	compatible = "avia,hx711";
> +	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> +	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +	avdd-suppy = <&avdd>;
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

