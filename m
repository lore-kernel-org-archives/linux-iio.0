Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:44000 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbeH0SXv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Aug 2018 14:23:51 -0400
Date: Mon, 27 Aug 2018 16:36:55 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH v7 RESEND 1/2] ARM: dts: at91: sama5d2: add channel cells
 for ADC device
Message-ID: <20180827143655.GB23428@piout.net>
References: <1535378233-10901-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535378233-10901-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/08/2018 16:57:12+0300, Eugen Hristev wrote:
> Preparing the ADC device to connect channel consumer drivers
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Resending after merge window that includes the bindings was closed.
> Rebased on 4.19-rc1 : no changes
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

I was going to dig those up, applied now, thanks!

> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 61f68e5..f06ba99 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -47,6 +47,7 @@
>  #include <dt-bindings/dma/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
>  
>  / {
>  	model = "Atmel SAMA5D2 family SoC";
> @@ -1437,6 +1438,7 @@
>  				atmel,max-sample-rate-hz = <20000000>;
>  				atmel,startup-time-ms = <4>;
>  				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
> +				#io-channel-cells = <1>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
