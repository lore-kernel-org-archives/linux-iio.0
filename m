Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33942 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753872AbdBRTWi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2017 14:22:38 -0500
Subject: Re: [RFC 3/4] dt-bindings: iio: add support for GPIO triggers
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <1487347429-31761-4-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        linus.walleij@linaro.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <01819bd3-3d24-b1fc-04aa-52348ff7f3bf@kernel.org>
Date: Sat, 18 Feb 2017 19:22:35 +0000
MIME-Version: 1.0
In-Reply-To: <1487347429-31761-4-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/02/17 16:03, Fabrice Gasnier wrote:
> Document Industrial I/O GPIO trigger support.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Whilst I think this needs redoing for the interrupt trigger driver,
please be aware that bindings must be OS agnostic i.e. you can't
name things after linux specific subsystem.  We get a lot
of stick for the iio-hwmon bindings specifically for doing this!

Which makes this 'interesting' to describe.

Once we have it updated feedback from Rob and Mark will definitely be needed on
this one.

Jonathan
> ---
>  .../bindings/iio/trigger/iio-trig-gpio.txt         | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/trigger/iio-trig-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/trigger/iio-trig-gpio.txt b/Documentation/devicetree/bindings/iio/trigger/iio-trig-gpio.txt
> new file mode 100644
> index 0000000..a8dbf5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/trigger/iio-trig-gpio.txt
> @@ -0,0 +1,26 @@
> +Industrial I/O - GPIO based trigger
> +
> +GPIOs may be used as IIO trigger provider, when trigger is connected to
> +GPIO lines.
> +
> +Required properties:
> +- compatible: Should be "iio-gpio-trigger"
> +- gpios: Should specify one GPIO line used as trigger source.
> +  See Documentation/devicetree/bindings/gpio/gpio.txt
> +- #io-trigger-cells: Should be 0, as simple trigger provider.
> +  See Documentation/devicetree/bindings/iio/iio-bindings.txt
> +
> +Optional properties:
> +- label: String to specifiy trigger name.
> +- gpio-trigger-rising-edge: A rising edge on GPIO will trigger.
> +- gpio-trigger-falling-edge: A falling edge on GPIO will trigger.
> +  Note: Both rising and falling edge may be used. In case none of
> +  rising or falling edge is selected, rising edge is selected by
> +  default.
> +
> +Example:
> +	gpiotrig0: iio-gpio-trigger0 {
> +		#io-trigger-cells = <0>;
> +		compatible = "iio-gpio-trigger";
> +		gpios = <&gpioa 11 0>;
> +	}
> 

