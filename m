Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35271 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbdHQPLD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2017 11:11:03 -0400
Date: Thu, 17 Aug 2017 10:10:59 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        alexandre.belloni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 1/3] Documentation: dt: iio: at91-sama5d2_adc: add
 optional dma property
Message-ID: <20170817151059.ptnzqsrzray26zlr@rob-hp-laptop>
References: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
 <1502368499-6739-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502368499-6739-2-git-send-email-eugen.hristev@microchip.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 10, 2017 at 03:34:57PM +0300, Eugen Hristev wrote:
> Added property for DMA configuration of the device.

"dt-bindings: iio: ..." is preferred for subject.

> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 552e7a8..5f94d47 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> @@ -17,6 +17,11 @@ Required properties:
>    This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
>    IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
>  
> +Optional properties:
> +  - dmas: Phandle to dma channel for the ADC.
> +  See ../../dma/dma.txt for details.
> +  - dma-names: Must be "rx" when dmas property is being used.

*-names is pointless when there's only one.

> +
>  Example:
>  
>  adc: adc@fc030000 {
> @@ -31,4 +36,6 @@ adc: adc@fc030000 {
>  	vddana-supply = <&vdd_3v3_lp_reg>;
>  	vref-supply = <&vdd_3v3_lp_reg>;
>  	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
> +	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
> +	dma-names = "rx";
>  }
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
