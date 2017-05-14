Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46959 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759207AbdENPfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 11:35:20 -0400
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: add driver for the
 ti-adc084s021 chip
To: =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
References: <1494345901-4714-1-git-send-email-marten.lindahl@axis.com>
 <1494345901-4714-2-git-send-email-marten.lindahl@axis.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3596a197-aebb-f43e-079a-cad9abd7866a@kernel.org>
Date: Sun, 14 May 2017 16:35:17 +0100
MIME-Version: 1.0
In-Reply-To: <1494345901-4714-2-git-send-email-marten.lindahl@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/17 17:05, Mårten Lindahl wrote:
> From: Mårten Lindahl <martenli@axis.com>
> 
> This adds support for the Texas Instruments ADC084S021 ADC chip.
> 
> Signed-off-by: Mårten Lindahl <martenli@axis.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied
> ---
> Changes in v4:
> - Added Rob's Acked-by tag
> 
> Changes in v3:
> - No updates since v2
> 
> Changes in v2:
> - Updated the 'Required properties' section
> - Removed the 'Optional properties' section
> 
>   .../devicetree/bindings/iio/adc/ti-adc084s021.txt     | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> new file mode 100644
> index 0000000..4259e50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> @@ -0,0 +1,19 @@
> +* Texas Instruments' ADC084S021
> +
> +Required properties:
> + - compatible        : Must be "ti,adc084s021"
> + - reg               : SPI chip select number for the device
> + - vref-supply       : The regulator supply for ADC reference voltage
> + - spi-cpol          : Per spi-bus bindings
> + - spi-cpha          : Per spi-bus bindings
> + - spi-max-frequency : Per spi-bus bindings
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,adc084s021";
> +	reg = <0>;
> +	vref-supply = <&adc_vref>;
> +	spi-cpol;
> +	spi-cpha;
> +	spi-max-frequency = <16000000>;
> +};
> 

