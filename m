Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37480 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdBSMUR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 07:20:17 -0500
Subject: Re: [PATCH 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
 <1487177757-19427-2-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c2b73482-ae01-34b5-3c16-b7e63893259e@kernel.org>
Date: Sun, 19 Feb 2017 12:09:09 +0000
MIME-Version: 1.0
In-Reply-To: <1487177757-19427-2-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/17 16:55, Fabrice Gasnier wrote:
> Add documentation for 'st,adc-res' dt optional property.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I'm happy with this, but would like to leave time for a device tree review.

Ultimately we may well want to make this a generic property and call it something
like adc-resolution but perhaps we need to wait until we have a few more devices
supporting setting it via device tree to figure out what the best interface is.
It would exactly be a problem to support this as a deprecated binding at that
point.

Give me a poke if we hear nothing from Rob or Mark for say another week.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 5dfc88e..45f7ff2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -57,6 +57,9 @@ Optional properties:
>  - dmas: Phandle to dma channel for this ADC instance.
>    See ../../dma/dma.txt for details.
>  - dma-names: Must be "rx" when dmas property is being used.
> +- st,adc-res: Resolution (bits) to use for conversions. Must match device
> +  available resolutions (e.g. can be 6, 8, 10 or 12 on stm32f4). Default
> +  is maximum resolution if unset.
>  
>  Example:
>  	adc: adc@40012000 {
> @@ -84,6 +87,7 @@ Example:
>  			st,adc-channels = <8>;
>  			dmas = <&dma2 0 0 0x400 0x0>;
>  			dma-names = "rx";
> +			st,adc-res = <8>;
>  		};
>  		...
>  		other adc child nodes follow...
> 

