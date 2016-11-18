Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36131 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbcKRPfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2016 10:35:30 -0500
Date: Fri, 18 Nov 2016 09:35:28 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] dt-bindings: document devicetree bindings for
 mux-gpio
Message-ID: <20161118153528.tl24bp5xjwpjppk6@rob-hp-laptop>
References: <1479419289-17553-1-git-send-email-peda@axentia.se>
 <1479419289-17553-2-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479419289-17553-2-git-send-email-peda@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 17, 2016 at 10:48:03PM +0100, Peter Rosin wrote:
> ---
>  .../devicetree/bindings/misc/mux-gpio.txt          | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/mux-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/mux-gpio.txt b/Documentation/devicetree/bindings/misc/mux-gpio.txt
> new file mode 100644
> index 000000000000..73699a37824f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/mux-gpio.txt
> @@ -0,0 +1,79 @@
> +GPIO-based multiplexer controller bindings
> +
> +Define what GPIO pins are used to control a multiplexer. Or several
> +multiplexers, if the same pins control more than one multiplexer.

I think this makes sense in your case, but I think it is too complicated 
for a non-shared case. Perhaps mux-gpios should be used directly (i.e. 
in the adc-mux node) and control-muxes only used for the shared case.

Part of me feels like you are working around in DT the GPIO subsystem 
limitation that it can't share GPIO lines. Either this could be fixed 
in some way in the GPIO subsystem, or the mux subsys could deal with it. 
You just have to look up if you already have a mux registered for the 
same GPIOs. Of course, that may make the mux subsys pretty much GPIO 
only, but I'm having a hard time thinking how you would have shared 
muxes that are not GPIO controlled. Any other control would be 
integrated into the mux itself.

> +
> +Required properties:
> +- compatible : "mux-gpio"
> +- mux-gpios : list of gpios used to control the multiplexer, least
> +	      significant bit first.
> +
> +Optional properties:
> +- idle-state : if present, the state the mux will have when idle.

Needs some detail on what the value is. One bit per gpio? One cell per 
gpio?

> +
> +Example:
> +	control_mux: control-adc-mux {
> +		compatible = "mux-gpio";
> +
> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	adc-mux {
> +		compatible = "iio-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +
> +		control-muxes = <&control_mux>;

This is a common name? It should be in a common mux binding doc.

> +		control-mux-names = "mux";

I think this can be dropped at least until you have more than 1.

> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sync-1@0 {
> +			reg = <0>;
> +		};
> +
> +		in@1 {
> +			reg = <1>;
> +		};
> +
> +		out@2 {
> +			reg = <2>;
> +		};
> +
> +		sync-2@3 {
> +			reg = <3>;
> +		};
> +	};
> +
> +	i2c-mux {
> +		compatible = "i2c-mux-simple,mux-locked";
> +		i2c-parent = <&i2c1>;
> +
> +		control-muxes = <&control_mux>;
> +		control-mux-names = "mux";
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
> -- 
> 2.1.4
> 
