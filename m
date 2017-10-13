Return-Path: <SRS0=/45w=BM=gmail.com=robherring2@kernel.org>
Date: Fri, 13 Oct 2017 16:51:42 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com,
	linux-iio@vger.kernel.org, lars@metafoo.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
	jic23@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: at91-sama5d2_adc: add optional
 dma property
Message-ID: <20171013215142.vlfhzzzetmc7resq@rob-hp-laptop>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
 <1507703732-29175-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507703732-29175-2-git-send-email-eugen.hristev@microchip.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 11, 2017 at 09:35:28AM +0300, Eugen Hristev wrote:
> Added property for DMA configuration of the device.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 552e7a8..5f94d479 100644
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

-names is pointless when there is only one.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
