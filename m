Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46998 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdA1SkN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 13:40:13 -0500
Subject: Re: [PATCH v2 4/7] Documentation: dt: iio: stm32-adc: optional dma
 support
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
 <1485440915-30119-5-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <467e84b4-58f7-a650-b233-46c5fc8232ee@kernel.org>
Date: Sat, 28 Jan 2017 18:39:58 +0000
MIME-Version: 1.0
In-Reply-To: <1485440915-30119-5-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/17 14:28, Fabrice Gasnier wrote:
> STM32 ADC can use dma. Add dt documentation for optional dma support.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied.
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 49ed82e..5dfc88e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -53,6 +53,11 @@ Required properties:
>  - #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
>    Documentation/devicetree/bindings/iio/iio-bindings.txt
>  
> +Optional properties:
> +- dmas: Phandle to dma channel for this ADC instance.
> +  See ../../dma/dma.txt for details.
> +- dma-names: Must be "rx" when dmas property is being used.
> +
>  Example:
>  	adc: adc@40012000 {
>  		compatible = "st,stm32f4-adc-core";
> @@ -77,6 +82,8 @@ Example:
>  			interrupt-parent = <&adc>;
>  			interrupts = <0>;
>  			st,adc-channels = <8>;
> +			dmas = <&dma2 0 0 0x400 0x0>;
> +			dma-names = "rx";
>  		};
>  		...
>  		other adc child nodes follow...
> 

