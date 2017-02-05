Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35502 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdBEJ4Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 04:56:24 -0500
Subject: Re: [PATCH v2 1/5] Documentation: dt: iio: document stm32 adc trigger
 polarity
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
 <1485786840-4557-2-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        Thomas Gleixner <tglx@linutronix.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1b326a3d-522f-b76e-0bc3-656b5fd2a8ae@kernel.org>
Date: Sun, 5 Feb 2017 09:56:18 +0000
MIME-Version: 1.0
In-Reply-To: <1485786840-4557-2-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/17 14:33, Fabrice Gasnier wrote:
> STM32 ADC trigger polarity can be set to either rising, falling
> or both edges. Allow to configure it from dt.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
This falls into the same question of whether this is really an interrupt
(be it one that linux can't see) or not.

It certainly similar enough I'd like to see us use as much of the
interrupt bindings as possible rather than reinventing the wheel.

cc'd Thomas Gleixner.

Thomas, what we have here effectively an interrupt that we have the option
to directly route to the hardware block to initialize an ADC sample
(rather than bouncing through the kernel).  It can also be directly
exposed as a real interrupt and the chances are we are going to end
up with a mixture of the two depending on who is interesting in the
'interrupt'.

Any thoughts?

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 5dfc88e..6c6d968 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -57,6 +57,8 @@ Optional properties:
>  - dmas: Phandle to dma channel for this ADC instance.
>    See ../../dma/dma.txt for details.
>  - dma-names: Must be "rx" when dmas property is being used.
> +- st,trigger-polarity: Must be 0 (default), 1 or 2 to set default trigger
> +  polarity to respectively "rising-edge", "falling-edge" or "both-edges".
>  
>  Example:
>  	adc: adc@40012000 {
> @@ -84,6 +86,7 @@ Example:
>  			st,adc-channels = <8>;
>  			dmas = <&dma2 0 0 0x400 0x0>;
>  			dma-names = "rx";
> +			st,trigger-polarity = <1>;
>  		};
>  		...
>  		other adc child nodes follow...
> 

