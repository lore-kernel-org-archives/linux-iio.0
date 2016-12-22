Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35707 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966322AbcLVWiP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Dec 2016 17:38:15 -0500
Date: Thu, 22 Dec 2016 16:38:12 -0600
From: Rob Herring <robh@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v4 1/2] iio: adc: hx711: Add DT binding for avia,hx711
Message-ID: <20161222223812.65oqqmvfcpsrcgsn@rob-hp-laptop>
References: <20161221152442.GA14543@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161221152442.GA14543@andreas>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Dec 21, 2016 at 04:24:42PM +0100, Andreas Klinger wrote:
> Add DT bindings for avia,hx711
> Add vendor avia to vendor list
> 
> [PATCH v3 1/2] of this patch was Acked-by: Rob Herring <robh@kernel.org>
> Sorry, but i had to add the regulator (avdd-supply) and therefore it 
> needs to be acked once again.

This should go after the '---', but otherwise you can keep my ack.

> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
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
> -- 
> 2.1.4
> 
