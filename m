Return-Path: <SRS0=r0JI=GQ=gmail.com=robherring2@kernel.org>
Date: Mon, 26 Mar 2018 17:23:26 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: wrapper: add
 io-channel-unit-converter
Message-ID: <20180326222326.sxdeawy5x5bjkla4@rob-hp-laptop>
References: <20180319170246.26830-1-peda@axentia.se>
 <20180319170246.26830-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319170246.26830-3-peda@axentia.se>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 19, 2018 at 06:02:45PM +0100, Peter Rosin wrote:
> Allow linear scaling and modification of the type of an io-channel.
> 
> When an ADC channel measures the midpoint of a voltage divider, the
> interesting voltage is often the voltage over the full resistance
> of the divider. Likewise, measuring the voltage over a resistor is
> often a way to get to the current through it.
> 
> This binding allows description of such hardware which is external
> to the ADC.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../iio/wrapper/io-channel-unit-converter.txt      | 84 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> new file mode 100644
> index 000000000000..23af661abe32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> @@ -0,0 +1,84 @@
> +I/O channel unit converter bindings
> +
> +Allow linear scaling and modification of the type of an io-channel.
> +
> +When an ADC channel measures the midpoint of a voltage divider, the
> +interesting voltage is often the voltage over the full resistance
> +of the divider. Likewise, measuring the voltage over a resistor is
> +often a way to get to the current through it.
> +
> +Required properties:
> +- compatible : "io-channel-unit-converter"

Would this apply to something besides ADCs?

> +- io-channels : Channel node of the parent channel.
> +- io-channel-names : Should be "parent".
> +
> +Optional properties:
> +- numerator : The parent channel scale is multiplied by this value (default 1).
> +- denominator : The parent channel scale is divided by this value (default 1).
> +- type : The type of the wrapped channel is modified to this type. The default
> +	 is to use the same type as the parent channel. Recognized types are:
> +		"voltage"
> +		"current"

This seems overly complicated for just describing a couple of resistors 
on an ADC. OTOH, keeping the ADC node and what's attached to the ADC 
separate 

Perhaps the type should be part of the compatible. For example, if you 
have a current measurement resistor/circuit, then the compatible should 
be based on that.

> +
> +Example 1:
> +The system voltage is circa 12V, but divided down with a 22/200
> +voltage divider to adjust it to the ADC range.
> +
> +SYSV        ADC       GND
> +  +          +         +
> +  |  .-----. | .----.  |
> +  '--| 200 |-+-| 22 |--'
> +     '-----'   '----'
> +
> +sysv {
> +	compatible = "io-channel-unit-converter";
> +	io-channles = <&maxadc 1>;
> +	io-channel-names = "parent";

parent doesn't seem to describe something about the h/w.

> +
> +	/* multiply the ADC voltage by 222/22 to get the system voltage */
> +	numerator = <222>; /* 200 + 22 */
> +	denominator = <22>;
> +}
> +
> +&spi {
> +	maxadc: adc@0 {
> +		compatible = "maxim,max1027";
> +	      	reg = <0>;
> +		#io-channel-cells = <1>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> +		spi-max-frequency = <1000000>;
> +	};
> +};
> +
> +Example 2:
> +The system current is measured by measuring the voltage over a
> +3.3 ohm resistor.
> +
> +sysi {
> +	compatible = "io-channel-unit-converter";
> +	io-channles = <&tiadc 0>;
> +	io-channel-names = "parent";
> +
> +	/* divide the ADC voltage by 33/10 (i.e. 3.3) to get current */
> +	numerator = <10>;
> +	denominator = <33>;
> +	type = "current";
> +}
> +
> +&i2c {
> +	tiadc: adc@48 {
> +		compatible = "ti,ads1015";
> +	      	reg = <0x48>;
> +		#io-channel-cells = <1>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		channel@0 { /* IN0,IN1 differential */
> +			reg = <0>;
> +			ti,gain = <1>;
> +			ti,datarate = <4>;
> +		};
> +	};
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96e5503bfb60..5dd555c7b1b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6884,6 +6884,12 @@ F:	drivers/staging/iio/
>  F:	include/linux/iio/
>  F:	tools/iio/
>  
> +IIO UNIT CONVERTER
> +M:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> +
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
>  M:	Stanislaw Gruszka <stf_xl@wp.pl>
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
