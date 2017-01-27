Return-Path: <SRS0=+/jt=ZK=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v8 02/12] dt-bindings: document devicetree bindings for
 mux-controllers and mux-gpio
To: Rob Herring <robh@kernel.org>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-3-git-send-email-peda@axentia.se>
 <20170127174919.b7yliip6e7zofrbn@rob-hp-laptop>
CC: <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mark
 Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut
 Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <14d9b8c9-849d-07bc-1b4d-a337a8c6db70@axentia.se>
Date: Fri, 27 Jan 2017 19:57:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170127174919.b7yliip6e7zofrbn@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 2017-01-27 18:49, Rob Herring wrote:
> On Wed, Jan 18, 2017 at 04:57:05PM +0100, Peter Rosin wrote:
>> Allow specifying that a single multiplexer controller can be used to control
>> several parallel multiplexers, thus enabling sharing of the multiplexer
>> controller by different consumers.
>>
>> Add a binding for a first mux controller in the form of a GPIO based mux
>> controlled.
>>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  .../devicetree/bindings/mux/mux-controller.txt     | 127 +++++++++++++++++++++
>>  Documentation/devicetree/bindings/mux/mux-gpio.txt |  68 +++++++++++
>>  MAINTAINERS                                        |   5 +
>>  3 files changed, 200 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
>>  create mode 100644 Documentation/devicetree/bindings/mux/mux-gpio.txt
> 
> A few nits. With those fixed:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
>>
>> diff --git a/Documentation/devicetree/bindings/mux/mux-controller.txt b/Documentation/devicetree/bindings/mux/mux-controller.txt
>> new file mode 100644
>> index 000000000000..42b2177e5ae1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mux/mux-controller.txt
>> @@ -0,0 +1,127 @@
>> +Common multiplexer controller bindings
>> +======================================
>> +
>> +A multiplexer (or mux) controller will have one, or several, consumer devices
>> +that uses the mux controller. Thus, a mux controller can possibly control
>> +several parallel multiplexers. Presumably there will be at least one
>> +multiplexer needed by each consumer, but a single mux controller can of course
>> +control several multiplexers for a single consumer.
>> +
>> +A mux controller provides a number of states to its consumers, and the state
>> +space is a simple zero-based enumeration. I.e. 0-1 for a 2-way multiplexer,
>> +0-7 for an 8-way multiplexer, etc.
>> +
>> +
>> +Consumers
>> +---------
>> +
>> +Mux controller consumers should specify a list of mux controllers that they
>> +want to use with a property containing a 'mux-ctrl-list':
>> +
>> +	mux-ctrl-list ::= <single-mux-ctrl> [mux-ctrl-list]
>> +	single-mux-ctrl ::= <mux-ctrl-phandle> [mux-ctrl-specifier]
>> +	mux-ctrl-phandle : phandle to mux controller node
>> +	mux-ctrl-specifier : array of #mux-control-cells specifying the
>> +			     given mux controller (controller specific)
>> +
>> +Mux controller properties should be named "mux-controls". The exact meaning of
>> +each mux controller property must be documented in the device tree binding for
>> +each consumer. An optional property "mux-control-names" may contain a list of
>> +strings to label each of the mux controllers listed in the "mux-controls"
>> +property.
>> +
>> +Drivers for devices that use more than a single mux controller can use the
>> +"mux-control-names" property to map the name of the requested mux controller
>> +to an index into the list given by the "mux-controls" property.
>> +
>> +mux-ctrl-specifier typically encodes the chip-relative mux controller number.
>> +If the mux controller chip only provides a single mux controller, the
>> +mux-ctrl-specifier can typically be left out.
>> +
>> +Example:
>> +
>> +	/* One consumer of a 2-way mux controller (one GPIO-line) */
>> +	mux: mux-controller {
>> +		compatible = "mux-gpio";
>> +		#mux-control-cells = <0>;
>> +
>> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	adc-mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc 0>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&mux>;
>> +		mux-control-names = "adc";
>> +
>> +		channels = "sync", "in";
>> +	};
>> +
>> +Note that in the example above, specifying the "mux-control-names" is redundant
>> +because there is only one mux controller in the list.
>> +
>> +	/*
>> +	 * Two consumers (one for an ADC line and one for an i2c bus) of
>> +	 * parallel 4-way multiplexers controlled by the same two GPIO-lines.
>> +	 */
>> +	mux: mux-controller {
>> +		compatible = "mux-gpio";
>> +		#mux-control-cells = <0>;
>> +
>> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
>> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	adc-mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc 0>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&mux>;
>> +
>> +		channels = "sync-1", "in", "out", "sync-2";
>> +	};
>> +
>> +	i2c-mux {
>> +		compatible = "i2c-mux-simple,mux-locked";
>> +		i2c-parent = <&i2c1>;
>> +		mux-controls = <&mux>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		i2c@0 {
>> +			reg = <0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			ssd1307: oled@3c {
>> +				/* ... */
>> +			};
>> +		};
>> +
>> +		i2c@3 {
>> +			reg = <3>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			pca9555: pca9555@20 {
>> +				/* ... */
>> +			};
>> +		};
>> +	};
>> +
>> +
>> +Mux controller nodes
>> +--------------------
>> +
>> +Mux controller nodes must specify the number of cells used for the
>> +specifier using the '#mux-control-cells' property.
>> +
>> +An example mux controller might look like this:
>> +
>> +	mux: adg792a@50 {
> 
> mux-controller@50

Right, adding that to my queue.

>> +		compatible = "adi,adg792a";
>> +		reg = <0x50>;
>> +		#mux-control-cells = <1>;
>> +	};
>> diff --git a/Documentation/devicetree/bindings/mux/mux-gpio.txt b/Documentation/devicetree/bindings/mux/mux-gpio.txt
>> new file mode 100644
>> index 000000000000..8f6bda6f9d78
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mux/mux-gpio.txt
>> @@ -0,0 +1,68 @@
>> +GPIO-based multiplexer controller bindings
>> +
>> +Define what GPIO pins are used to control a multiplexer. Or several
>> +multiplexers, if the same pins control more than one multiplexer.
>> +
>> +Required properties:
>> +- compatible : "mux-gpio"
> 
> Just to be consistent with other gpio compatibles: gpio-mux

Sure, I'll also rename mux-gpio.txt to gpio-mux.txt and mux-adg792a.txt
to adi,adg792a.txt so that the file names match the compatible string.

>> +- mux-gpios : list of gpios used to control the multiplexer, least
>> +	      significant bit first.
>> +- #mux-control-cells : <0>
>> +* Standard mux-controller bindings as decribed in mux-controller.txt
>> +
>> +Optional properties:
>> +- idle-state : if present, the state the mux will have when idle.
> 
> Why is this gpio specific. Can be a common controller property?

The binding isn't appropriate for e.g. adg792a and it will not be
appropriate for any mux chip with more than one mux controller. But
sure, there could be a generic binding for all chips with a single
mux controller...

So, do you still think idle-state should be a generic binding?

Cheers,
peda
