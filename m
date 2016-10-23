Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0095.outbound.protection.outlook.com ([104.47.2.95]:18656
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753308AbcJWLeO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Oct 2016 07:34:14 -0400
Subject: Re: [PATCH v2 6/7] dt-bindings: iio: document envelope-detector
 bindings
To: <linux-kernel@vger.kernel.org>
References: <1477176226-10566-1-git-send-email-peda@axentia.se>
 <1477176226-10566-7-git-send-email-peda@axentia.se>
CC: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <f743f779-84e2-ca8f-ec04-dc2e360e934f@axentia.se>
Date: Sun, 23 Oct 2016 11:01:16 +0200
MIME-Version: 1.0
In-Reply-To: <1477176226-10566-7-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-10-23 00:43, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/iio/adc/envelope-detector.txt         | 55 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> new file mode 100644
> index 000000000000..9099531cffff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> @@ -0,0 +1,55 @@
> +Bindings for ADC envelope detector using a DAC and a comparator
> +
> +The DAC is used to find the peak level of an alternating voltage input
> +signal by a binary search using the output of a comparator wired to
> +an interrupt pin. Like so:
> +                          _
> +                         | \
> +    input +------>-------|+ \
> +                         |   \
> +           .-------.     |    }---.
> +           |       |     |   /    |
> +           |    dac|-->--|- /     |
> +           |       |     |_/      |
> +           |       |              |
> +           |       |              |
> +           |    irq|------<-------'
> +           |       |
> +           '-------'
> +
> +Required properties:
> +- compatible: Should be "axentia,tse850-envelope-detector"
> +- io-channels: Channel node of the dac to be used for comparator input.
> +- io-channel-names: Should be "dac".
> +- interrupt specification for one client interrupt,
> +  see ../../interrupt-controller/interrupts.txt for details.
> +- interrupt-names: Should be "comp".
> +
> +Example:
> +
> +	&i2c {
> +		dpot: mcp4651-104@28 {
> +			compatible = "microchip,mcp4651-104";
> +			reg = <0x28>;
> +			#io-channel-cells = <1>;
> +		};
> +	};
> +
> +	dac: dac {
> +		compatible = "dpot-dac";
> +		vref-supply = <&reg_3v3>;
> +		io-channels = <&dpot 0>;
> +		io-channel-names = "dpot";
> +		dpot-dac,max-ohms = <100000>;

Just noticed that this line isn't needed anymore. I'll kill it for v3.

Cheers,
Peter

> +		#io-channel-cells = <1>;
> +	};
> +
> +	envelope-detector {
> +		compatible = "axentia,tse850-envelope-detector";
> +		io-channels = <&dac 0>;
> +		io-channel-names = "dac";
> +
> +		interrupt-parent = <&gpio>;
> +		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names = "comp";
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c8aae24b96b..4b6f6ec1b703 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6118,6 +6118,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
>  F:	drivers/iio/dac/dpot-dac.c
>  
> +IIO ENVELOPE DETECTOR
> +M:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> +
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
>  R:	Hartmut Knaack <knaack.h@gmx.de>
> 

