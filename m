Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:48372 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJVBB2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Oct 2018 21:01:28 -0400
Date: Sun, 21 Oct 2018 17:46:26 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 2/2] Add AD7949 device tree bindings in documentation
Message-ID: <20181021174626.7540c524@archlinux>
In-Reply-To: <20181017203954.13744-2-charles-antoine.couret@essensium.com>
References: <20181017203954.13744-1-charles-antoine.couret@essensium.com>
        <20181017203954.13744-2-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 17 Oct 2018 22:39:54 +0200
Charles-Antoine Couret <charles-antoine.couret@essensium.com> wrote:

+CC device tree list list and maintainers.

> Add AD7949 device tree bindings in documentation
> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> ---
>  .../devicetree/bindings/iio/adc/ad7949.txt     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> new file mode 100644
> index 000000000000..9ecb84188d83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> @@ -0,0 +1,18 @@
> +* Analog Devices AD7949/AD7682/AD7689
> +
> +Required properties:
> + - compatible: Should be one of
> +	* "ad7949"
> +	* "ad7682"
> +	* "ad7689"
As Alex pointed out, adi,ad7949 etc

> + - reg: spi chip select number for the device
> + - vref-supply: The regulator supply for ADC reference voltage
> + - spi-max-frequency: Max SPI frequency to use (< 33000000)
> +
> +Example:
> +adc@0 {
> +	compatible = "ad7949";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <200000>;
> +};
