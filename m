Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41999 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755949AbcJ3Nf3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 09:35:29 -0400
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: document envelope-detector
 bindings
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1477262381-7800-1-git-send-email-peda@axentia.se>
 <1477262381-7800-8-git-send-email-peda@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0f054fa3-5b38-ce19-d9b6-d5f862f43ee2@kernel.org>
Date: Sun, 30 Oct 2016 13:35:26 +0000
MIME-Version: 1.0
In-Reply-To: <1477262381-7800-8-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/10/16 23:39, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
I'm happy with this, but again it's odd enough I'd like some input from
a device tree bindings maintainer.

Thanks,

Jonathan
> ---
>  .../bindings/iio/adc/envelope-detector.txt         | 54 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> new file mode 100644
> index 000000000000..27544bdd4478
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> @@ -0,0 +1,54 @@
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
> index d7375f45ff0f..fca35d16037d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6119,6 +6119,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
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

