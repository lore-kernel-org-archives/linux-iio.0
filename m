Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53045 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935509AbcJVOxN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 10:53:13 -0400
Subject: Re: [PATCH 3/4] dt-bindings: iio: document envelope-detector bindings
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
 <1476955562-13673-4-git-send-email-peda@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a97858d3-16b4-838c-c46c-a197318264bf@kernel.org>
Date: Sat, 22 Oct 2016 15:53:07 +0100
MIME-Version: 1.0
In-Reply-To: <1476955562-13673-4-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/10/16 10:26, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
Definitely going to need device tree maintainer input!  (though as Lars
and you discussed some mods to this in the cover letter discussion,
perhaps they should wait for V2).
> ---
>  .../bindings/iio/adc/envelope-detector.txt         | 65 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> new file mode 100644
> index 000000000000..0e26299516fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
> @@ -0,0 +1,65 @@
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
> +- compatible: Should be "envelope-detector"
Agreed with the discussion in the cover letter responses.  Needs
to be more specific as lots of ways of skinning this cat.
Hehe, just occurred to me that your Maintainer entry below
makes you responsible for all of them.. Acked!

> +- io-channels: Channel node of the dac to be used for comparator input.
> +- io-channel-names: Should be "dac".
> +- interrupt specification for one client interrupt,
> +  see ../../interrupt-controller/interrupts.txt for details.
> +- interrupt-names: Should be "comp".
> +- envelope-detector,dac-max: The maximum raw input value for the dac.
I guess the available stuff you have brought up to date should deal with this
one without needing another param.

> +- envelope-detector,comp-interval-ms: How long to wait for the comparator
> +  to trigger before moving on to another DAC level. This interval needs to
> +  relate to the lowest possible frequency of the above input signal.
This is an odd one and definitely a case for the device tree guys.

It's not generic enough to not have a 'manufacturer' in the param name,
but there isn't really a manufacturer as anyone with a few chips can build
one of these (using the 'wiring' diagram above ;)

So what should the prefix be?

> +
> +Optional properties:
> +- envelope-detector,inverted: If the input signal is centered around the
> +  dac-max voltage (instead of zero), this property causes the detector to
> +  search for the lowest DAC value that does not triggers the comparator
> +  (instead of the highest). The result is also inverted so that a lower DAC
> +  reading yields a higher voltage value.
As discussed, this is fundamental enough that it should probably
be based on the compatible string rather than a separate item.
> +
> +
> +Example:
> +
> +	&spi {
> +		dac: ad7303@4 {
> +			compatible = "adi,ad7303";
> +			reg = <4>;
> +			spi-max-frequency = <10000000>;
> +			Vdd-supply = <&vdd_supply>;
> +			adi,use-external-reference;
> +			REF-supply = <&vref_supply>;
> +			#io-channel-cells = <1>;
> +		};
> +	};
> +
> +	envelope-detector {
> +		compatible = "envelope-detector";
> +		io-channels = <&dac 0>;
> +		io-channel-names = "dac";
> +
> +		interrupt-parent = <&gpio>;
> +		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names = "comp";
> +
> +		envelope-detector,dac-max = <255>;
> +		envelope-detector,comp-interval-ms = <50>;
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

