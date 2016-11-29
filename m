Return-Path: <peda@axentia.se>
Subject: Re: [PATCH v5 4/9] dt-bindings: iio: iio-mux: document iio-mux
 bindings
To: <linux-kernel@vger.kernel.org>
References: <1480414245-14034-1-git-send-email-peda@axentia.se>
 <1480414245-14034-5-git-send-email-peda@axentia.se>
CC: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut
 Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <b00ae997-4466-29b8-b484-3a0970e65386@axentia.se>
Date: Tue, 29 Nov 2016 16:56:37 +0100
MIME-Version: 1.0
In-Reply-To: <1480414245-14034-5-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-11-29 11:10, Peter Rosin wrote:
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
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mux-controls = <&mux>;
> +
> +		sync@0 {
> +			reg = <0>;
> +		};
> +
> +		in@1 {
> +			reg = <1>;
> +		};
> +
> +		system-regulator@2 {
> +			reg = <2>;
> +		};
> +	};

Hmmm, a more compact binding would be to just use an array of strings
instead of a list of children for the mux channels, and use the array
index as channel number, like so:

	adc-mux {
		compatible = "iio-mux";
		io-channels = <&adc 0>;
		io-channel-names = "parent";

		mux-controls = <&mux>;

		channels = "sync", "in", "system-regulator";
	};

If you need to skip a low-number channel, you'd just put an empty string
for that channel. If you need to skip channels at the end, just stop
short.

Can anyone think of any reason to add anything to the channel nodes
that makes the string-array ineffective? If so, or if that comes up
later, it could be optional and in that case you could look for the
channels property first and then, if not present, iterate over child
nodes.

Opinions? I like it, it's a lot more compact...

Cheers,
Peter
