Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB0388890;
	Tue, 21 Jul 2026 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662355; cv=none; b=HM8rEx3LH/aqf/TRDrGSYBZaNf8n8WzUSibtjPfF8GwVkD+/CL6v1OJbSpFiwSn/zu9VfISA2Cb7p4cDq/j8sUtH0lDJz7SCe2coOHAfxLEuzOVFrULaZ92dvQMnLCK6dzgcYdvbCl1Tv6zsZHQV7Qs5qpFO264WGdqpNLG9K/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662355; c=relaxed/simple;
	bh=OjTbCemIvf4QBgWv3saVUwUUmBNluiZXR45hLg1FwAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zd5wO+g4181bbZgzSkbETyuRQ5Vopa6bbv7dUDm0MKrvVA/VMx90mTOJ6t7gdv7RJIGibdtm5wU2xEdE3TApKWC8Be+v/3MzzbI1ryqwkMe12p+XTTMXA7r0VoBoUyVWdfpHtrOOQ5SJcBnftGDMuHvdISvk+qlAk9REm5i/HlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA501F00A3D;
	Tue, 21 Jul 2026 19:32:29 +0000 (UTC)
Message-ID: <a11988db-7861-4fb5-ba7e-e2be56b2d323@tuxon.dev>
Date: Tue, 21 Jul 2026 22:32:27 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] ARM: dts: microchip: sama7d65: Add ADC node
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 jorge.marques@analog.com, mazziesaccount@gmail.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-9-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260630093603.38663-9-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 6/30/26 12:35, Varshini Rajendran wrote:
> Add node for the ADC controller in sama7d65 SoC. Add the vddout25 fixed
> regulator node which provides the 2.5V reference voltage for the ADC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>   arch/arm/boot/dts/microchip/sama7d65.dtsi | 29 +++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> index 94d49e20dc79..ba775459a816 100644
> --- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> @@ -11,6 +11,7 @@
>   #include <dt-bindings/clock/at91.h>
>   #include <dt-bindings/dma/at91.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/mfd/at91-usart.h>
> @@ -95,6 +96,16 @@ slow_xtal: clock-slowxtal {
>   		};
>   	};
>   
> +	vddout25: fixed-regulator-vddout25 {
> +		compatible = "regulator-fixed";
> +

This line could be dropped.

> +		regulator-name = "VDDOUT25";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-boot-on;
> +		status = "disabled";
> +	};
> +
>   	ns_sram: sram@100000 {
>   		compatible = "mmio-sram";
>   		reg = <0x100000 0x20000>;
> @@ -296,6 +307,24 @@ can4: can@e0838000 {
>   			status = "disabled";
>   		};
>   
> +		adc: adc@e1000000 {
> +			compatible = "microchip,sama7d65-adc";
> +			reg = <0xe1000000 0x200>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_GCK 25>;
> +			assigned-clocks = <&pmc PMC_TYPE_GCK 25>;
> +			assigned-clock-rates = <100000000>;
> +			clock-names = "adc_clk";

clock-names usually goes after clocks.

> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>;
> +			dma-names = "rx";
> +			atmel,min-sample-rate-hz = <200000>;
> +			atmel,max-sample-rate-hz = <20000000>;
> +			atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
> +			atmel,startup-time-ms = <4>;
> +			#io-channel-cells = <1>;

This could be moved before vendor specific properties since it's standard.

I can address all these while applying, if any.

Thank you,
Claudiu

> +			status = "disabled";
> +		};
> +
>   		dma2: dma-controller@e1200000 {
>   			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
>   			reg = <0xe1200000 0x1000>;

