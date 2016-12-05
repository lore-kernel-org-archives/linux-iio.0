Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36090 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbcLEX03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 18:26:29 -0500
Date: Mon, 5 Dec 2016 17:26:24 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 4/9] dt-bindings: iio: iio-mux: document iio-mux
 bindings
Message-ID: <20161205232624.5wjvmchd6jxd24ir@rob-hp-laptop>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-5-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480493823-21462-5-git-send-email-peda@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 30, 2016 at 09:16:58AM +0100, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/iio/multiplexer/iio-mux.txt           | 40 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt

I'm still not convinced about this binding, but don't really have more 
comments ATM. Sending 6 versions in 2 weeks or so doesn't really help 
either.

> diff --git a/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> new file mode 100644
> index 000000000000..8080cf790d82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> @@ -0,0 +1,40 @@
> +IIO multiplexer bindings
> +
> +If a multiplexer is used to select which hardware signal is fed to
> +e.g. an ADC channel, these bindings describe that situation.
> +
> +Required properties:
> +- compatible : "iio-mux"

This is a Linuxism. perhaps "adc-mux".

> +- io-channels : Channel node of the parent channel that has multiplexed
> +		input.
> +- io-channel-names : Should be "parent".
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +- mux-controls : Mux controller node to use for operating the mux
> +- channels : List of strings, labeling the mux controller states.
> +
> +The multiplexer state as described in ../misc/mux-controller.txt
> +
> +For each non-empty string in the channels property, an iio channel will
> +be created. The number of this iio channel is the same as the index into
> +the list of strings in the channels property, and also matches the mux
> +controller state.
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
> +		compatible = "iio-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +
> +		mux-controls = <&mux>;
> +
> +		channels = "sync", "in", system-regulator";
> +	};
