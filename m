Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43252 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbdAHK32 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 05:29:28 -0500
Subject: Re: [PATCH v7 07/12] dt-bindings: iio: iio-mux: document iio-mux
 bindings
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-8-git-send-email-peda@axentia.se>
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
Message-ID: <7e3e79a6-12a5-d253-e855-a4de209e9513@kernel.org>
Date: Sun, 8 Jan 2017 10:29:25 +0000
MIME-Version: 1.0
In-Reply-To: <1483532187-28494-8-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/17 12:16, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  .../bindings/iio/multiplexer/io-channel-mux.txt    | 39 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> new file mode 100644
> index 000000000000..c82794002595
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> @@ -0,0 +1,39 @@
> +I/O channel multiplexer bindings
> +
> +If a multiplexer is used to select which hardware signal is fed to
> +e.g. an ADC channel, these bindings describe that situation.
> +
> +Required properties:
> +- compatible : "io-channel-mux"
> +- io-channels : Channel node of the parent channel that has multiplexed
> +		input.
> +- io-channel-names : Should be "parent".
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +- mux-controls : Mux controller node to use for operating the mux
> +- channels : List of strings, labeling the mux controller states.
> +
> +For each non-empty string in the channels property, an io-channel will
> +be created. The number of this io-channel is the same as the index into
> +the list of strings in the channels property, and also matches the mux
> +controller state. The mux controller state is described in
> +../mux/mux-controller.txt
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
> +	adc-mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +
> +		mux-controls = <&mux>;
> +
> +		channels = "sync", "in", "system-regulator";
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebe96f3e25a0..91775f2be209 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6274,6 +6274,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
>  F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
>  F:	drivers/iio/adc/envelope-detector.c
>  
> +IIO MULTIPLEXER
> +M:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> +
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
>  R:	Hartmut Knaack <knaack.h@gmx.de>
> 

