Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdFTQ4Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Jun 2017 12:56:25 -0400
Date: Tue, 20 Jun 2017 17:56:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>, <robh@kernel.org>
Subject: Re: [PATCH v5 3/4] ARM: dts: at91: sama5d2: add ADC hw trigger edge
 type
Message-ID: <20170620175619.0a93d3d2@kernel.org>
In-Reply-To: <1497533097-12052-4-git-send-email-eugen.hristev@microchip.com>
References: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
        <1497533097-12052-4-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Jun 2017 16:24:56 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Added ADTRG edge type property as interrupt edge type value
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Driver support heading upstream.

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   Changes in v4:
>  - Modified bindings to be similar with interrupts
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 8067c71..483a387 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1267,6 +1267,7 @@
>  				atmel,min-sample-rate-hz = <200000>;
>  				atmel,max-sample-rate-hz = <20000000>;
>  				atmel,startup-time-ms = <4>;
> +				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
>  				status = "disabled";
>  			};
>  

