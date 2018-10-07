Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:54374 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJGXIS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Oct 2018 19:08:18 -0400
Date: Sun, 7 Oct 2018 17:00:31 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] Add ad7949 device tree bindings in documentation
Message-ID: <20181007170031.71287a1c@archlinux>
In-Reply-To: <20181006203036.20338-2-charles-antoine.couret@essensium.com>
References: <20181006203036.20338-1-charles-antoine.couret@essensium.com>
        <20181006203036.20338-2-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  6 Oct 2018 22:30:36 +0200
Charles-Antoine Couret <charles-antoine.couret@essensium.com> wrote:

> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Device tree bindings should be cc'd to the devicetree maintainers
and mailing list for review.

As has been shown far too many times, I'm not very good and
spotting the detail issues in these! So over to Rob and Mark's
eagle eyes.

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/ad7949.txt     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> new file mode 100644
> index 000000000000..4dc921961df7
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
> + - reg: spi chip select number for the device
> + - vref-supply: The regulator supply for ADC reference voltage
> + - spi-max-frequency: Max SPI frequency to use (< 33000000)
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,adc0832";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <200000>;
> +};
