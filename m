Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60018 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbdCEMQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 07:16:37 -0500
Subject: Re: [PATCH v3 3/6] dt-bindings: iio: document interrupt trigger
 support
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-4-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        linus.walleij@linaro.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e6e2f05f-0dc0-f2a3-064b-268776a413c5@kernel.org>
Date: Sun, 5 Mar 2017 12:16:28 +0000
MIME-Version: 1.0
In-Reply-To: <1488300679-3259-4-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/02/17 16:51, Fabrice Gasnier wrote:
> Document interrupt trigger that takes a generic interrupt, and
> can be used as trigger source for sampling devices such as sensors,
> ADCs...
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I'm not convinced we want the earlier device tree binding doc at all.
In the vast majority of cases that chunk on providers is irrelevant.
What matters is to document the specific case as you have done here.

So this one I like, the earlier document less so, simply because
it repeats what this more specific document has described.

So Rob, what do you think of 'just' this bit?
> ---
>  .../bindings/iio/trigger/iio-trig-interrupt.txt    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt b/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt
> new file mode 100644
> index 0000000..9de9856
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt
> @@ -0,0 +1,22 @@
> +Interrupt based trigger
> +
> +Any internal or external interrupt may be used as trigger source for
> +devices like sensors, ADCs... As an example, external signal can be
> +routed to a GPIO, and turned into an interrupt driven trigger.
> +
> +Required properties:
> +- compatible: Should be "interrupt-trigger"
> +- interrupts: The interrupt used as trigger. Generic interrupt client node as
> +  described in ../../interrupt-controller/interrupts.txt
> +
> +Optional properties:
> +- #io-trigger-cells = <0>; See the IIO bindings, IIO trigger providers
> +  and consumers sections in ../iio-bindings.txt
> +
> +Example:
> +	trig0: interrupt-trigger0 {
> +		#io-trigger-cells = <0>;
> +		compatible = "interrupt-trigger";
> +		interrupts = <11 0>;
> +		interrupt-parent = <&gpioa>;
> +	}
> 

