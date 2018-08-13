Return-Path: <SRS0=912Y=K4=gmail.com=robherring2@kernel.org>
Date: Mon, 13 Aug 2018 17:01:08 -0600
From: Rob Herring <robh@kernel.org>
To: Mircea Caprioru <mircea.caprioru@analog.com>
Cc: no To-header on input <;, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sedat Dilek <sedat.dilek@gmail.com>,
	Rafael Aquini <aquini@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ludovic Desroches <ludovic.desroches@o2linux.fr>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: Add docs for AD5770R DAC
Message-ID: <20180813230108.GA20314@rob-hp-laptop>
References: <20180730135956.4611-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730135956.4611-1-mircea.caprioru@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 30, 2018 at 04:59:55PM +0300, Mircea Caprioru wrote:
> Adding dt-bindings documentation for AD5770R DAC. The bindings follow the
> standard SPI and fixed regulator bindings.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/ad5770r.txt   | 86 +++++++++++++++++++

Preferred filename is matching compatible string if there's only 1 
compatible string.

>  MAINTAINERS                                   |  7 ++
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5770r.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5770r.txt b/Documentation/devicetree/bindings/iio/dac/ad5770r.txt
> new file mode 100644
> index 000000000000..bdd6ee4d5f2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ad5770r.txt
> @@ -0,0 +1,86 @@
> +Analog Devices AD5770R DAC device driver

Bindings aren't device drivers...

> +
> +Required properties for the AD5770R:
> +	- compatible: Must be "adi,ad5770r"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: Max SPI frequency to use (< 10000000, as per
> +			Documentation/devicetree/bindings/spi/spi-bus.txt)
> +	- child nodes: Each child node represents one channel and has
> +		the following required properties:
> +		* num: This represents the channel num

Use reg instead.

> +		* adi,range-microamp: Output range of the channel
> +		The following ranges are supported:
> +		* Channel 0:
> +			* <0 300000> 0 mA to 300 mA
> +			* <(-60000) 0> -60 to 0 mA
> +			* <(-60000) 300000> -60 to 300 mA
> +		* Channel 1:
> +			* <0 140000> 0 to 140 mA
> +			* <0 250000> 0 to 250 mA
> +		* Channel 2:
> +			* <0 55000> 0 to 55 mA
> +			* <0 150000> 0 to 150 mA
> +		* Channel 3 to Channel 5:
> +			* <0 45000> 0 to 45 mA
> +			* <0 100000> 0 to 100 mA
> +
> +Optional properties:
> +
> +- vref: Specify the voltage of the external reference used.
> +		Available reference options are: 1.25 V or 2.5 V. If no
> +		external reference declared then the device will use the
> +		internal reference of 1.25 V.

This should be updated to vref-supply.

> +
> +- reset-gpios: GPIO spec for the RESET pin. If specified, it will be
> +		asserted during driver probe.

Driver probe is not relevant to the binding. 
> +
> +AD5770R Example:
> +
> +	ad5770r@0 {

dac@0

> +		compatible = "ad5770r";
> +		reg = <0>;
> +                spi-max-frequency = <1000000>;

Some whitespace problems here.

> +		vref-supply = <&vref>;
> +
> +		reset-gpios = <&gpio 22 0>;
> +
> +		channel@0 {
> +			num = <0>;
> +			adi,range-microamp = <0 300000>;
> +		};
> +
> +		channel@1 {
> +			num = <1>;
> +			adi,range-microamp = <0 140000>;
> +		};
> +
> +		channel@2 {
> +			num = <2>;
> +			adi,range-microamp = <0 55000>;
> +		};
> +
> +		channel@3 {
> +			num = <3>;
> +			adi,range-microamp = <0 45000>;
> +		};
> +
> +		channel@4 {
> +			num = <4>;
> +			adi,range-microamp = <0 45000>;
> +		};
> +
> +		channel@5 {
> +			num = <5>;
> +			adi,range-microamp = <0 45000>;
> +		};
> +       };
> +
> +External reference example:
> +
> +	vref: fixedregulator@0 {

Unit-address should be dropped (no reg property here).

> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-supply";
> +		regulator-min-microvolt = <1250000>;
> +		regulator-max-microvolt = <1250000>;
> +	};
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f7721d1634c..9c2626079592 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -756,6 +756,13 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
>  S:	Supported
>  F:	drivers/macintosh/ams/
>  
> +ANALOG DEVICES INC AD5770R DRIVER
> +M:	Mircea Caprioru <mircea.caprioru@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/dac/ad5770r.txt
> +
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
>  L:	linux-media@vger.kernel.org
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
