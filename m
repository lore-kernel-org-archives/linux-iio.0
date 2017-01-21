Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34855 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdAUNWG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 08:22:06 -0500
Subject: Re: [PATCHv5 2/2] dt-bindings: iio: document MAX11100 ADC
To: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        marek.vasut@gmail.com, geert@linux-m68k.org, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1484757053-7102-1-git-send-email-jacopo+renesas@jmondi.org>
 <1484757053-7102-3-git-send-email-jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ff915715-98c4-9792-eae7-9f466d5fa459@kernel.org>
Date: Sat, 21 Jan 2017 13:22:03 +0000
MIME-Version: 1.0
In-Reply-To: <1484757053-7102-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/01/17 16:30, Jacopo Mondi wrote:
> Add device tree bindings documentation for Maxim MAX11100 single-channel
> ADC
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Simple enough I'm happy to take it without bothering Rob or Mark. 
However, any device tree bindings at all should be cc'd to them and to the devicetree
list.

Done in case anyone wants to comment.
> ---
>  .../devicetree/bindings/iio/adc/max11100.txt          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/max11100.txt b/Documentation/devicetree/bindings/iio/adc/max11100.txt
> new file mode 100644
> index 0000000..ad0bc31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/max11100.txt
> @@ -0,0 +1,19 @@
> +* Maxim max11100 Analog to Digital Converter (ADC)
> +
> +Required properties:
> +  - compatible: Should be "maxim,max11100"
> +  - reg: the adc unit address
> +  - vref-supply: phandle to the regulator that provides reference voltage
> +
> +Optional properties:
> +  - spi-max-frequency: SPI maximum frequency
> +
> +Example:
> +
> +max11100: adc@0 {
> +        compatible = "maxim,max11100";
> +        reg = <0>;
> +        vref-supply = <&adc0_vref>;
> +        spi-max-frequency = <240000>;
> +};
> +
> 

