Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbeKYXUA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 18:20:00 -0500
Date: Sun, 25 Nov 2018 12:28:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Coffey <cmc@babblebit.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: potentiometer: Add Microchip
 MCP41xxx/42xxx
Message-ID: <20181125122857.129b91b2@archlinux>
In-Reply-To: <20181120141713.9963-2-cmc@babblebit.net>
References: <20181120141713.9963-1-cmc@babblebit.net>
        <20181120141713.9963-2-cmc@babblebit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Nov 2018 14:17:12 +0000
Chris Coffey <cmc@babblebit.net> wrote:

> This patch adds device tree documentation for the Microchip
> MCP41xxx/42xxx family of digital potentiometers.
> 
> Signed-off-by: Chris Coffey <cmc@babblebit.net>
> ---
>  .../bindings/iio/potentiometer/mcp41010.txt        | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> new file mode 100644
> index 0000000000..7dcf2071b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> @@ -0,0 +1,29 @@
> +* Microchip MCP41010/41050/41100/42010/42050/42100 Digital Potentiometer
> +  driver
I'll channel my inner Rob ;)  Bindings are for devices, not drivers
(basically don't mention driver anywhere)

It's trivial (and common) so I just tidied it up whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> +
> +Datasheet publicly available at:
> +http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
> +
> +The node for this driver must be a child node of a SPI controller, hence
> +all mandatory properties described in
> +
> +        Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +must be specified.
> +
> +Required properties:
> +	- compatible:  	Must be one of the following, depending on the
> +			model:
> +			"microchip,mcp41010"
> +			"microchip,mcp41050"
> +			"microchip,mcp41100"
> +			"microchip,mcp42010"
> +			"microchip,mcp42050"
> +			"microchip,mcp42100"
> +
> +Example:
> +potentiometer@0 {
> +	compatible = "microchip,mcp41010";
> +	reg = <0>;
> +	spi-max-frequency = <500000>;
> +};
