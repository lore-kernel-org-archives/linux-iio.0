Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51332 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdANMxh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 07:53:37 -0500
Subject: Re: [PATCH 1/3] DT/bindings: Add bindings for TI ADS7950 A/DC chips
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <1484157171-15571-1-git-send-email-david@lechnology.com>
 <1484157171-15571-2-git-send-email-david@lechnology.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f1e845c4-7db0-c6fe-fbd2-420902110be9@kernel.org>
Date: Sat, 14 Jan 2017 12:53:35 +0000
MIME-Version: 1.0
In-Reply-To: <1484157171-15571-2-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/17 17:52, David Lechner wrote:
> This adds device tree bindings for the TI ADS7950 family of A/DC chips.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
This is in of itself good, but we may need to have some deprecated
elements to continue supporting what was implicitly happening with
the missnaming so as to avoid accidentally breaking someone's device
tree.

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/ti-ads7950.txt     | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
> new file mode 100644
> index 0000000..e77a6f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
> @@ -0,0 +1,23 @@
> +* Texas Instruments ADS7950 family of A/DC chips
> +
> +Required properties:
> + - compatible: Must be one of "ti,ads7950", "ti,ads7951", "ti,ads7952",
> +   "ti,ads7953", "ti,ads7954", "ti,ads7955", "ti,ads7956", "ti,ads7957",
> +   "ti,ads7958", "ti,ads7959", "ti,ads7960", or "ti,ads7961"
> + - reg: SPI chip select number for the device
> + - #io-channel-cells: Must be 1 as per ../iio-bindings.txt
> + - vref-supply: phandle to a regulator node that supplies the 2.5V or 5V
> +   reference voltage
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,ads7957";
> +	reg = <0>;
> +	#io-channel-cells = <1>;
> +	vref-supply = <&refin_supply>;
> +	spi-max-frequency = <10000000>;
> +};
> 

