Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43501 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJXAJb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2018 20:09:31 -0400
Date: Tue, 23 Oct 2018 10:45:34 -0500
From: Rob Herring <robh@kernel.org>
To: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 2/2] doc:devicetree: Add ti,dac7311 device tree
 bindings in documentation
Message-ID: <20181023154534.GA31053@bogus>
References: <20181022210340.1136-1-charles-antoine.couret@essensium.com>
 <20181022210340.1136-2-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181022210340.1136-2-charles-antoine.couret@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 22, 2018 at 11:03:40PM +0200, Charles-Antoine Couret wrote:
> Description how to invoke ti-dac7311 driver from device tree file.

Same comments on the subject.

> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> ---
> 
> V1 to V3:
> * Cosmetic changes
> * Improve description of the patch
> 
>  .../bindings/iio/dac/ti,dac7311.txt           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> new file mode 100644
> index 000000000000..b681060579b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> @@ -0,0 +1,20 @@
> +TI DAC7311 device tree bindings
> +
> +Required properties:
> +
> +- compatible: Must be set to "ti,dac7311", "ti,dac6311" or "ti,dac5311"

Please format one per line.

> +- reg: spi chip select number for the device
> +- vref-supply: The regulator supply for ADC reference voltage
> +- spi-max-frequency: Max SPI frequency to use (< 50000000)

Same comment here.

> +
> +Example:
> +
> +	spi_master {
> +		dac: dac7311@0 {

Node names should be generic reflecting their class:

dac@0

> +			compatible = "ti,dac7311";
> +			reg = <0>; /* CS0 */
> +			spi-max-frequency = <1000000>;
> +			vref-supply = <&vdd_supply>;
> +		};
> +	};
> +
> -- 
> 2.19.1
> 
