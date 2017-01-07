Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43045 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942078AbdAHJsu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:50 -0500
Subject: Re: [PATCH v7 09/12] dt-bindings: i2c: i2c-mux-simple: document
 i2c-mux-simple bindings
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-10-git-send-email-peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2bf45d81-e5ba-541b-0f39-d300e30917b3@kernel.org>
Date: Sat, 7 Jan 2017 22:28:58 +0000
MIME-Version: 1.0
In-Reply-To: <1483532187-28494-10-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/17 12:16, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
Looks good to me.
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  .../devicetree/bindings/i2c/i2c-mux-simple.txt     | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
> new file mode 100644
> index 000000000000..253d5027843b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
> @@ -0,0 +1,81 @@
> +Simple I2C Bus Mux
> +
> +This binding describes an I2C bus multiplexer that uses a mux controller
> +from the mux subsystem to route the I2C signals.
> +
> +                                  .-----.  .-----.
> +                                  | dev |  | dev |
> +    .------------.                '-----'  '-----'
> +    | SoC        |                   |        |
> +    |            |          .--------+--------'
> +    |   .------. |  .------+    child bus A, on MUX value set to 0
> +    |   | I2C  |-|--| Mux  |
> +    |   '------' |  '--+---+    child bus B, on MUX value set to 1
> +    |   .------. |     |    '----------+--------+--------.
> +    |   | MUX- | |     |               |        |        |
> +    |   | Ctrl |-|-----+            .-----.  .-----.  .-----.
> +    |   '------' |                  | dev |  | dev |  | dev |
> +    '------------'                  '-----'  '-----'  '-----'
> +
> +Required properties:
> +- compatible: i2c-mux-simple,mux-locked or i2c-mux-simple,parent-locked
> +- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
> +  port is connected to.
> +- mux-controls: The phandle of the mux controller to use for operating the
> +  mux.
> +* Standard I2C mux properties. See i2c-mux.txt in this directory.
> +* I2C child bus nodes. See i2c-mux.txt in this directory. The sub-bus number
> +  is also the mux-controller state described in ../mux/mux-controller.txt
> +
> +For each i2c child node, an I2C child bus will be created. They will
> +be numbered based on their order in the device tree.
> +
> +Whenever an access is made to a device on a child bus, the value set
> +in the relevant node's reg property will be set as the state in the
> +mux controller.
> +
> +Example:
> +	mux: mux-controller {
> +		compatible = "mux-gpio";
> +		#mux-control-cells = <0>;
> +
> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
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
> +		i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ssd1307: oled@3c {
> +				compatible = "solomon,ssd1307fb-i2c";
> +				reg = <0x3c>;
> +				pwms = <&pwm 4 3000>;
> +				reset-gpios = <&gpio2 7 1>;
> +				reset-active-low;
> +			};
> +		};
> +
> +		i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			pca9555: pca9555@20 {
> +				compatible = "nxp,pca9555";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x20>;
> +			};
> +		};
> +	};
> 

