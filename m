Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36289 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933515AbdA0RtV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 12:49:21 -0500
Date: Fri, 27 Jan 2017 11:49:19 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/12] dt-bindings: document devicetree bindings for
 mux-controllers and mux-gpio
Message-ID: <20170127174919.b7yliip6e7zofrbn@rob-hp-laptop>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-3-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484755035-25927-3-git-send-email-peda@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 18, 2017 at 04:57:05PM +0100, Peter Rosin wrote:
> Allow specifying that a single multiplexer controller can be used to control
> several parallel multiplexers, thus enabling sharing of the multiplexer
> controller by different consumers.
> 
> Add a binding for a first mux controller in the form of a GPIO based mux
> controlled.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/mux/mux-controller.txt     | 127 +++++++++++++++++++++
>  Documentation/devicetree/bindings/mux/mux-gpio.txt |  68 +++++++++++
>  MAINTAINERS                                        |   5 +
>  3 files changed, 200 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
>  create mode 100644 Documentation/devicetree/bindings/mux/mux-gpio.txt

A few nits. With those fixed:

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/mux/mux-controller.txt b/Documentation/devicetree/bindings/mux/mux-controller.txt
> new file mode 100644
> index 000000000000..42b2177e5ae1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mux/mux-controller.txt
> @@ -0,0 +1,127 @@
> +Common multiplexer controller bindings
> +======================================
> +
> +A multiplexer (or mux) controller will have one, or several, consumer devices
> +that uses the mux controller. Thus, a mux controller can possibly control
> +several parallel multiplexers. Presumably there will be at least one
> +multiplexer needed by each consumer, but a single mux controller can of course
> +control several multiplexers for a single consumer.
> +
> +A mux controller provides a number of states to its consumers, and the state
> +space is a simple zero-based enumeration. I.e. 0-1 for a 2-way multiplexer,
> +0-7 for an 8-way multiplexer, etc.
> +
> +
> +Consumers
> +---------
> +
> +Mux controller consumers should specify a list of mux controllers that they
> +want to use with a property containing a 'mux-ctrl-list':
> +
> +	mux-ctrl-list ::= <single-mux-ctrl> [mux-ctrl-list]
> +	single-mux-ctrl ::= <mux-ctrl-phandle> [mux-ctrl-specifier]
> +	mux-ctrl-phandle : phandle to mux controller node
> +	mux-ctrl-specifier : array of #mux-control-cells specifying the
> +			     given mux controller (controller specific)
> +
> +Mux controller properties should be named "mux-controls". The exact meaning of
> +each mux controller property must be documented in the device tree binding for
> +each consumer. An optional property "mux-control-names" may contain a list of
> +strings to label each of the mux controllers listed in the "mux-controls"
> +property.
> +
> +Drivers for devices that use more than a single mux controller can use the
> +"mux-control-names" property to map the name of the requested mux controller
> +to an index into the list given by the "mux-controls" property.
> +
> +mux-ctrl-specifier typically encodes the chip-relative mux controller number.
> +If the mux controller chip only provides a single mux controller, the
> +mux-ctrl-specifier can typically be left out.
> +
> +Example:
> +
> +	/* One consumer of a 2-way mux controller (one GPIO-line) */
> +	mux: mux-controller {
> +		compatible = "mux-gpio";
> +		#mux-control-cells = <0>;
> +
> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	adc-mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +		mux-controls = <&mux>;
> +		mux-control-names = "adc";
> +
> +		channels = "sync", "in";
> +	};
> +
> +Note that in the example above, specifying the "mux-control-names" is redundant
> +because there is only one mux controller in the list.
> +
> +	/*
> +	 * Two consumers (one for an ADC line and one for an i2c bus) of
> +	 * parallel 4-way multiplexers controlled by the same two GPIO-lines.
> +	 */
> +	mux: mux-controller {
> +		compatible = "mux-gpio";
> +		#mux-control-cells = <0>;
> +
> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	adc-mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +		mux-controls = <&mux>;
> +
> +		channels = "sync-1", "in", "out", "sync-2";
> +	};
> +
> +	i2c-mux {
> +		compatible = "i2c-mux-simple,mux-locked";
> +		i2c-parent = <&i2c1>;
> +		mux-controls = <&mux>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ssd1307: oled@3c {
> +				/* ... */
> +			};
> +		};
> +
> +		i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			pca9555: pca9555@20 {
> +				/* ... */
> +			};
> +		};
> +	};
> +
> +
> +Mux controller nodes
> +--------------------
> +
> +Mux controller nodes must specify the number of cells used for the
> +specifier using the '#mux-control-cells' property.
> +
> +An example mux controller might look like this:
> +
> +	mux: adg792a@50 {

mux-controller@50

> +		compatible = "adi,adg792a";
> +		reg = <0x50>;
> +		#mux-control-cells = <1>;
> +	};
> diff --git a/Documentation/devicetree/bindings/mux/mux-gpio.txt b/Documentation/devicetree/bindings/mux/mux-gpio.txt
> new file mode 100644
> index 000000000000..8f6bda6f9d78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mux/mux-gpio.txt
> @@ -0,0 +1,68 @@
> +GPIO-based multiplexer controller bindings
> +
> +Define what GPIO pins are used to control a multiplexer. Or several
> +multiplexers, if the same pins control more than one multiplexer.
> +
> +Required properties:
> +- compatible : "mux-gpio"

Just to be consistent with other gpio compatibles: gpio-mux

> +- mux-gpios : list of gpios used to control the multiplexer, least
> +	      significant bit first.
> +- #mux-control-cells : <0>
> +* Standard mux-controller bindings as decribed in mux-controller.txt
> +
> +Optional properties:
> +- idle-state : if present, the state the mux will have when idle.

Why is this gpio specific. Can be a common controller property?

> +
> +The multiplexer state is defined as the number represented by the
> +multiplexer GPIO pins, where the first pin is the least significant
> +bit. An active pin is a binary 1, an inactive pin is a binary 0.
> +
> +Example:
> +
> +	mux: mux-controller {
> +		compatible = "mux-gpio";
> +		#mux-control-cells = <0>;
> +
> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	adc-mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +
> +		mux-controls = <&mux>;
> +
> +		channels = "sync-1", "in", "out", "sync-2";
> +	};
> +
> +	i2c-mux {
> +		compatible = "i2c-mux-simple,mux-locked";
> +		i2c-parent = <&i2c1>;
> +
> +		mux-controls = <&mux>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ssd1307: oled@3c {
> +				/* ... */
> +			};
> +		};
> +
> +		i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			pca9555: pca9555@20 {
> +				/* ... */
> +			};
> +		};
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40de344ba0e6..be57f5b8f2c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8469,6 +8469,11 @@ S:	Orphan
>  F:	drivers/mmc/host/mmc_spi.c
>  F:	include/linux/spi/mmc_spi.h
>  
> +MULTIPLEXER SUBSYSTEM
> +M:	Peter Rosin <peda@axentia.se>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mux/
> +
>  MULTISOUND SOUND DRIVER
>  M:	Andrew Veliath <andrewtv@usa.net>
>  S:	Maintained
> -- 
> 2.1.4
> 
