Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKVhP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 16:37:15 -0500
Date: Sun, 11 Nov 2018 11:48:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com,
        broonie@kernel.org
Subject: Re: [PATCH 4/6] dt-bindings:iio:resolver: Add docs for ad2s90
Message-ID: <20181111114848.266d3937@archlinux>
In-Reply-To: <20181109220044.24843-5-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
        <20181109220044.24843-5-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  9 Nov 2018 20:00:42 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds the device tree binding documentation for the ad2s90
> resolver-to-digital converter.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  .../bindings/iio/resolver/ad2s90.txt          | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> new file mode 100644
> index 000000000000..b42cc7752ffd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> @@ -0,0 +1,26 @@
> +Analog Devices AD2S90 Resolver-to-Digital Converter
> +
> +https://www.analog.com/en/products/ad2s90.html
> +
> +Required properties:
> +  - compatible : should be "adi,ad2s90"
> +  - reg : SPI chip select number for the device
> +  - spi-max-frequency : set maximum clock frequency, must be 830000
> +  - spi-cpol and spi-cpha : must be defined to enable SPI mode 3

As the part only works in mode 3, my gut feeling is that this belongs
in the driver, not here.  Rob, what do you think?

> +
> +Note about max frequency:
> +    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a 600ns
> +    delay is expected between the application of a logic LO to CS and the
> +    application of SCLK, as also specified. And since the delay is not
> +    implemented in the spi code, to satisfy it, SCLK's period should be at most
> +    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which gives
> +    roughly 830000Hz.
> +
> +Example:
> +resolver@0 {
> +	compatible = "adi,ad2s90";
> +	reg = <0>;
> +	spi-max-frequency = <830000>;
> +	spi-cpol;
> +	spi-cpha;
> +};
