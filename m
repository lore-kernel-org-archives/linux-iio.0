Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:52588 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeJGXqO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Oct 2018 19:46:14 -0400
Date: Sun, 7 Oct 2018 17:38:22 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] Add ti,dac7311 device tree bindings in
 documentation
Message-ID: <20181007173822.71e92f57@archlinux>
In-Reply-To: <20181006203108.20439-2-charles-antoine.couret@essensium.com>
References: <20181006203108.20439-1-charles-antoine.couret@essensium.com>
        <20181006203108.20439-2-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  6 Oct 2018 22:31:08 +0200
Charles-Antoine Couret <charles-antoine.couret@essensium.com> wrote:

> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
+ devicetree list and maintainers.

> ---
>  .../bindings/iio/dac/ti,dac7311.txt           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> new file mode 100644
> index 000000000000..77fd4370f815
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> @@ -0,0 +1,20 @@
> +TI DAC7311 DEVICETREE BINDINGS

Why all these capitals?

> +
> +Required properties:
> +
> +- compatible: Must be set to "ti,dac7311", "ti,dac6311" or "ti,dac5311"
> +- reg: spi chip select number for the device
> +- vref-supply: The regulator supply for ADC reference voltage
> +- spi-max-frequency: Max SPI frequency to use (< 50000000)
> +
> +Example:
> +
> +	spi_master {
> +		dac7311: dac7311@0 {
> +			compatible = "ti,dac7311";
> +			reg = <0>; /* CS0 */
> +			spi-max-frequency = <1000000>;
> +			vref-supply = <&vdd_supply>;
> +		};
> +	};
> +
