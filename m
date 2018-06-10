Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753431AbeFJMfQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Jun 2018 08:35:16 -0400
Date: Sun, 10 Jun 2018 13:35:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 8/9] ARM: dts: at91: sama5d2: add channel cells for
 ADC device
Message-ID: <20180610133509.2063cd35@archlinux>
In-Reply-To: <1526975559-18966-9-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-9-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 May 2018 10:52:38 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Preparing the ADC device to connect channel consumer drivers
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
The driver for the touchscreen is no in the IIO tree, but it wasn't
early enough (due to a block on a fix working it's way in) for this
merge window.  Will be going upstream in the next merge window.

Thanks,

Jonathan

> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
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

