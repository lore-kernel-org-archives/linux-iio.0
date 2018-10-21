Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:47220 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeJUXND (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Oct 2018 19:13:03 -0400
Date: Sun, 21 Oct 2018 15:58:24 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] Add ti,dac7311 device tree bindings in
 documentation
Message-ID: <20181021155811.0530ec23@archlinux>
In-Reply-To: <20181017203738.13477-2-charles-antoine.couret@essensium.com>
References: <20181017203738.13477-1-charles-antoine.couret@essensium.com>
        <20181017203738.13477-2-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 17 Oct 2018 22:37:38 +0200
Charles-Antoine Couret <charles-antoine.couret@essensium.com> wrote:

Would be good to have a small amount of description here + it seems you didn't
sign off on this patch so we can't apply it to the kernel.

Please cc devicetree list and maintainers for any devicetree bindings.
+cc Rob, Mark and list.

Thanks,

Jonathan
> ---
>  .../bindings/iio/dac/ti,dac7311.txt           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> new file mode 100644
> index 000000000000..771414024cd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> @@ -0,0 +1,20 @@
> +TI DAC7311 device tree bindings
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
Not sure why you need the pre colon bit here.

Also I'd imagine the standard naming for a dac is probably
dac@0
(I haven't checked the devicetree spec to see if they actually
have that one in there as I'm on a train with dodgy wifi).

Jonathan
> +			compatible = "ti,dac7311";
> +			reg = <0>; /* CS0 */
> +			spi-max-frequency = <1000000>;
> +			vref-supply = <&vdd_supply>;
> +		};
> +	};
> +
