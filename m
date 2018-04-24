Return-Path: <SRS0=Zl54=HN=gmail.com=robherring2@kernel.org>
Date: Tue, 24 Apr 2018 11:27:21 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, alexandre.torgue@st.com, mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com, lars@metafoo.de, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: stm32-adc: add support for
 STM32MP1.
Message-ID: <20180424162721.qbfsc7j3syzzykeh@rob-hp-laptop>
References: <1524065874-434-1-git-send-email-fabrice.gasnier@st.com>
 <1524065874-434-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524065874-434-2-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 18, 2018 at 05:37:52PM +0200, Fabrice Gasnier wrote:
> Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
> Introduce "st,stm32mp1-adc" compatible to handle variants of this
> hardware such as vregready flag, interrupts, clock rate.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index e8bb824..9994384 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -24,8 +24,11 @@ Required properties:
>  - compatible: Should be one of:
>    "st,stm32f4-adc-core"
>    "st,stm32h7-adc-core"
> +  "st,stm32mp1-adc-core"
>  - reg: Offset and length of the ADC block register set.
> -- interrupts: Must contain the interrupt for ADC block.
> +- interrupts: One or more interrupts for ADC block. Some parts like stm32f4
> +  and stm32h7 share a common ADC interrupt line. stm32mp1 has separate
> +  lines for each ADC within ADC block.

How many interrupt lines is that?

>  - clocks: Core can use up to two clocks, depending on part used:
>    - "adc" clock: for the analog circuitry, common to all ADCs.
>      It's required on stm32f4.
> @@ -53,6 +56,7 @@ Required properties:
>  - compatible: Should be one of:
>    "st,stm32f4-adc"
>    "st,stm32h7-adc"
> +  "st,stm32mp1-adc"
>  - reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
>  - clocks: Input clock private to this ADC instance. It's required only on
>    stm32f4, that has per instance clock input for registers access.
> -- 
> 1.9.1
> 
