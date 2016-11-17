Return-Path: <lars@metafoo.de>
Subject: Re: [RFC PATCH 4/7] dt-bindings: iio: iio-mux: document iio-mux
 bindings
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1479340111-1259-1-git-send-email-peda@axentia.se>
 <1479340111-1259-5-git-send-email-peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e09b7aa4-8e98-b07c-d0d8-b24d619f9e00@metafoo.de>
Date: Thu, 17 Nov 2016 12:40:15 +0100
MIME-Version: 1.0
In-Reply-To: <1479340111-1259-5-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/17/2016 12:48 AM, Peter Rosin wrote:
> ---
>  .../bindings/iio/multiplexer/iio-mux.txt           | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> new file mode 100644
> index 000000000000..2f5c7fc35a42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> @@ -0,0 +1,59 @@
> +IIO multiplexer bindings
> +
> +If a multiplexer is used to select when hardware signal is fed to
> +e.g. an ADC channel, these bindings describe that situation.
> +
> +Required properties:
> +- compatible : "iio-mux"
> +- io-channels : Channel node of the parent channel that has multiplexed
> +		input.
> +- io-channel-names : Should be "parent".
> +- control-muxes : Node of the multiplexer that controls the input signal.
> +- control-mux-names : Should be "mux".
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +
> +Required properties for iio-mux child nodes:
> +- reg : The multiplexer number.
> +
> +Optional properties for iio-mux child nodes:
> +- iio-ext-info : Array of string pairs, the first item in each pair is the
> +		 iio ext_info attribute name, and the second item in each
> +		 pair is the iio ext_info value for that attribute. The
> +		 mux will write these ext_info values to the corresponding
> +		 ext_info attributes on every multiplexer switch.

This can't go into the devicetree in its current form as it exposes
implementation details of the Linux kernel drivers.
