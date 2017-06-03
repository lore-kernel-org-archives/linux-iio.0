Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdFCJc1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:32:27 -0400
Date: Sat, 3 Jun 2017 10:27:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: stm32-adc: add support for
 STM32H7
Message-ID: <20170603102719.2a1c0abb@kernel.org>
In-Reply-To: <1496050100-25854-2-git-send-email-fabrice.gasnier@st.com>
References: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
        <1496050100-25854-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 May 2017 11:28:16 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Document support for STM32H7 Analog to Digital Converter.
> Main difference is regarding compatible, clock definitions and new
> features like differential channels support:
> STM32H7 ADC block has two clock inputs, common clock for all ADCs.
> One 'bus' clock for registers access, and one optional 'adc' clock
> for analog circuitry (bus clock may be used for conversions).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Given the nature of Robs requested changes I think we are fairly safe
that he will be happy with this.  As it's going to be stuck exposed
only in my testing branch for at least a few days (which I will happily
rebase) there is still time for Rob to take a final look.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v2:
> - remarks from Rob: one compatible per line, s/unused/not present/
> - document resolutions available on stm32h7
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 28 ++++++++++++++++------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index e35f9f1..8310073 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -21,11 +21,19 @@ own configurable sequence and trigger:
>  Contents of a stm32 adc root node:
>  -----------------------------------
>  Required properties:
> -- compatible: Should be "st,stm32f4-adc-core".
> +- compatible: Should be one of:
> +  "st,stm32f4-adc-core"
> +  "st,stm32h7-adc-core"
>  - reg: Offset and length of the ADC block register set.
>  - interrupts: Must contain the interrupt for ADC block.
> -- clocks: Clock for the analog circuitry (common to all ADCs).
> -- clock-names: Must be "adc".
> +- clocks: Core can use up to two clocks, depending on part used:
> +  - "adc" clock: for the analog circuitry, common to all ADCs.
> +    It's required on stm32f4.
> +    It's optional on stm32h7.
> +  - "bus" clock: for registers access, common to all ADCs.
> +    It's not present on stm32f4.
> +    It's required on stm32h7.
> +- clock-names: Must be "adc" and/or "bus" depending on part used.
>  - interrupt-controller: Identifies the controller node as interrupt-parent
>  - vref-supply: Phandle to the vref input analog reference voltage.
>  - #interrupt-cells = <1>;
> @@ -42,14 +50,18 @@ An ADC block node should contain at least one subnode, representing an
>  ADC instance available on the machine.
>  
>  Required properties:
> -- compatible: Should be "st,stm32f4-adc".
> +- compatible: Should be one of:
> +  "st,stm32f4-adc"
> +  "st,stm32h7-adc"
>  - reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
> -- clocks: Input clock private to this ADC instance.
> +- clocks: Input clock private to this ADC instance. It's required only on
> +  stm32f4, that has per instance clock input for registers access.
>  - interrupt-parent: Phandle to the parent interrupt controller.
>  - interrupts: IRQ Line for the ADC (e.g. may be 0 for adc@0, 1 for adc@100 or
>    2 for adc@200).
>  - st,adc-channels: List of single-ended channels muxed for this ADC.
> -  It can have up to 16 channels, numbered from 0 to 15 (resp. for in0..in15).
> +  It can have up to 16 channels on stm32f4 or 20 channels on stm32h7, numbered
> +  from 0 to 15 or 19 (resp. for in0..in15 or in0..in19).
>  - #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
>    Documentation/devicetree/bindings/iio/iio-bindings.txt
>  
> @@ -58,7 +70,9 @@ Optional properties:
>    See ../../dma/dma.txt for details.
>  - dma-names: Must be "rx" when dmas property is being used.
>  - assigned-resolution-bits: Resolution (bits) to use for conversions. Must
> -  match device available resolutions (e.g. can be 6, 8, 10 or 12 on stm32f4).
> +  match device available resolutions:
> +  * can be 6, 8, 10 or 12 on stm32f4
> +  * can be 8, 10, 12, 14 or 16 on stm32h7
>    Default is maximum resolution if unset.
>  
>  Example:

