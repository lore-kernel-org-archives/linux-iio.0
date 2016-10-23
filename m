Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:36378 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbcJWICe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Oct 2016 04:02:34 -0400
Date: Sun, 23 Oct 2016 10:02:31 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Peter Rosin <peda@axentia.se>
cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: iio: document dpot-dac bindings
In-Reply-To: <1477176226-10566-5-git-send-email-peda@axentia.se>
Message-ID: <alpine.DEB.2.02.1610231001110.7656@pmeerw.net>
References: <1477176226-10566-1-git-send-email-peda@axentia.se> <1477176226-10566-5-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


nitpicking below

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/iio/dac/dpot-dac.txt       | 41 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> new file mode 100644
> index 000000000000..4fd5d63cc2d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> @@ -0,0 +1,41 @@
> +Bindings for DAC emulation using a digital potentiometer
> +
> +It is assumed the that the dpot is used as a voltage divider between the

delete 'the' before 'that'

> +current dpot wiper setting and the maximum resistance of the dpot. The
> +divided voltage is provided by a vref regulator.
> +
> +                  .------.
> +   .-----------.  |      |
> +   | vref      |--'    .---.
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

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
