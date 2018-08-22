Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42660 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHVWvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Aug 2018 18:51:07 -0400
Date: Wed, 22 Aug 2018 21:25:18 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: dac: add bindings for ltc1660
Message-ID: <20180822192518.GA694@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
 <20180821193126.15733-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180821193126.15733-2-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 21, 2018 at 09:31:25PM +0200, Marcus Folkesson wrote:
> LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
> with eight individual channels.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Rob, sorry I missed your tag.

Reviewed-by: Rob Herring <robh@kernel.org>

> ---
> 
> Notes:
>     v2:
>     	- rename file, ltc166x -> ltc1660
> 
>  .../devicetree/bindings/iio/dac/ltc1660.txt         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> new file mode 100644
> index 000000000000..c5b5f22d6c64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> @@ -0,0 +1,21 @@
> +* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
> +
> +Required properties:
> + - compatible: Must be one of the following:
> +		"lltc,ltc1660"
> +		"lltc,ltc1665"
> + - reg: SPI chip select number for the device
> + - vref-supply: Phandle to the voltage reference supply
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> +	 Max frequency for this chip is 5 MHz.
> +
> +Example:
> +dac@0 {
> +	compatible = "lltc,ltc1660";
> +	reg = <0>;
> +	spi-max-frequency = <5000000>;
> +	vref-supply = <&vref_reg>;
> +};
> -- 
> 2.11.0.rc2
> 
