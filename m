Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbdFTQxy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Jun 2017 12:53:54 -0400
Date: Tue, 20 Jun 2017 17:53:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>, <robh@kernel.org>
Subject: Re: [PATCH v5 2/4] Documentation: dt: iio: at91-sama5d2_adc: add hw
 trigger edge binding
Message-ID: <20170620175348.300155bb@kernel.org>
In-Reply-To: <1497533097-12052-3-git-send-email-eugen.hristev@microchip.com>
References: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
        <1497533097-12052-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Jun 2017 16:24:55 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add property for the edge type of the hardware trigger pin ADTRG
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>   Changes in v4:
>  - Modified bindings to be similar with interrupts
> 
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 3223684..552e7a8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> @@ -11,6 +11,11 @@ Required properties:
>    - atmel,min-sample-rate-hz: Minimum sampling rate, it depends on SoC.
>    - atmel,max-sample-rate-hz: Maximum sampling rate, it depends on SoC.
>    - atmel,startup-time-ms: Startup time expressed in ms, it depends on SoC.
> +  - atmel,trigger-edge-type: One of possible edge types for the ADTRG hardware
> +  trigger pin. When the specific edge type is detected, the conversion will
> +  start. Possible values are rising, falling, or both.
> +  This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
> +  IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
>  
>  Example:
>  
> @@ -25,4 +30,5 @@ adc: adc@fc030000 {
>  	atmel,startup-time-ms = <4>;
>  	vddana-supply = <&vdd_3v3_lp_reg>;
>  	vref-supply = <&vdd_3v3_lp_reg>;
> +	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
>  }

