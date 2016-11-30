Return-Path: <peda@axentia.se>
Subject: Re: [PATCH v6 4/9] dt-bindings: iio: iio-mux: document iio-mux
 bindings
To: <linux-kernel@vger.kernel.org>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-5-git-send-email-peda@axentia.se>
CC: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>,
	"Hartmut Knaack" <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Jonathan Corbet
	<corbet@lwn.net>, "Arnd Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <ed072eb4-382d-f2cc-ed95-6a09c3528177@axentia.se>
Date: Wed, 30 Nov 2016 09:52:32 +0100
MIME-Version: 1.0
In-Reply-To: <1480493823-21462-5-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

Hi,

v6 was apparently rushed a little bit too much, but I really wanted to
supersede the stupidity I found elsewhere in v5. Perhaps I shouldn't
have bolted on the changes for the iio-mux bindings, but so I did...

On 2016-11-30 09:16, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/iio/multiplexer/iio-mux.txt           | 40 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> 
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
> +- io-channels : Channel node of the parent channel that has multiplexed
> +		input.
> +- io-channel-names : Should be "parent".
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +- mux-controls : Mux controller node to use for operating the mux
> +- channels : List of strings, labeling the mux controller states.
> +
> +The multiplexer state as described in ../misc/mux-controller.txt

Delete the above non-sentence, but reintroduce the gist of it...

> +For each non-empty string in the channels property, an iio channel will
> +be created. The number of this iio channel is the same as the index into
> +the list of strings in the channels property, and also matches the mux
> +controller state.

...at the end of the above sentence instead.

I'm holding off v7 pending more important changes.

Cheers,
Peter
