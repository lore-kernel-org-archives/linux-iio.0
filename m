Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52959 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935782AbcJVOgV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 10:36:21 -0400
Subject: Re: [PATCH 1/4] dt-bindings: iio: document dpot-dac bindings
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
 <1476955562-13673-2-git-send-email-peda@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <704ce511-e82f-6881-ed1f-24ac77ba473e@kernel.org>
Date: Sat, 22 Oct 2016 15:36:19 +0100
MIME-Version: 1.0
In-Reply-To: <1476955562-13673-2-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/10/16 10:25, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
I like this, but will need some device tree maintainer input on it.

To my mind we are explicitly describing hardware connectivity here so it should
be fine.  No where near as controversial as a certain other IIO binding ;)


>  .../devicetree/bindings/iio/dac/dpot-dac.txt       | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> new file mode 100644
> index 000000000000..a381188676c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> @@ -0,0 +1,43 @@
> +Bindings for DAC emulation using a digital potentiometer
> +
> +It is assumed the that the dpot is used as a voltage divider between the
> +current dpot wiper setting and the maximum resistance of the dpot. The
> +divided voltage is provided by a vref regulator.
> +
> +                  .------.
> +   .-----------.  |      |
> +   | Vref      |--'    .---.
> +   | regulator |--.    |   |
> +   '-----------'  |    | d |
> +                  |    | p |
> +                  |    | o |  wiper
> +                  |    | t |<---------+
> +                  |    |   |
> +                  |    '---'       dac output voltage
> +                  |      |
> +                  '------+------------+
> +
> +Required properties:
> +- compatible: Should be "dpot-dac"
> +- vref-supply: The regulator supplying the voltage divider.
> +- io-channels: Channel node of the dpot to be used for the voltage division.
> +- io-channel-names: Should be "dpot".
> +- dpot-dac,max-ohms: The maximum resistance of the dpot.
> +
> +Example:
> +
> +	&i2c {
> +		dpot: mcp4651-503@28 {
> +			compatible = "microchip,mcp4651-503";
> +			reg = <0x28>;
> +			#io-channel-cells = <1>;
> +		};
> +	};
> +
> +	dac {
> +		compatible = "dpot-dac";
> +		vref-supply = <&reg_3v3>;
> +		io-channels = <&dpot 0>;
> +		io-channel-names = "dpot";
> +		dpot-dac,max-ohms = <50000>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1cd38a7e0064..c68b72088945 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6111,6 +6111,12 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/rc/iguanair.c
>  
> +IIO DIGITAL POTENTIOMETER DAC
> +M:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> +
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
>  R:	Hartmut Knaack <knaack.h@gmx.de>
> 

