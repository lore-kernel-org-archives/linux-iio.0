Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38782 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeANM4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jan 2018 07:56:08 -0500
Date: Sun, 14 Jan 2018 12:56:04 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, lars@metafoo.de
Subject: Re: [PATCH 3/3] staging: iio: docs: add ad7192 doc to detail dt
 usage
Message-ID: <20180114125604.24a3876d@archlinux>
In-Reply-To: <20180110112956.23931-3-alexandru.ardelean@analog.com>
References: <20180110112956.23931-1-alexandru.ardelean@analog.com>
        <20180110112956.23931-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 10 Jan 2018 13:29:56 +0200
<alexandru.ardelean@analog.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> Document the device-tree bindings of the "ad7192" driver.
> Added datasheet references for supported devices,
> explanation for each property supported by the driver,
> and an example.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../staging/iio/Documentation/adc/adi,ad7192.txt   | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 drivers/staging/iio/Documentation/adc/adi,ad7192.txt
> 
> diff --git a/drivers/staging/iio/Documentation/adc/adi,ad7192.txt b/drivers/staging/iio/Documentation/adc/adi,ad7192.txt
> new file mode 100644
> index 000000000000..1f8f769a003f
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/adc/adi,ad7192.txt
> @@ -0,0 +1,71 @@
> +Analog Devices AD719x ADC Driver
> +
> +Reference:
> +[1] http://www.analog.com/en/products/analog-to-digital-converters/ad7190.html
> +[2] http://www.analog.com/en/products/analog-to-digital-converters/ad7192.html
> +[3] http://www.analog.com/en/products/analog-to-digital-converters/ad7193.html
> +[4] http://www.analog.com/en/products/analog-to-digital-converters/ad7195.html
> +
> +Required properties:
> +  - compatible: Should be "adi,ad7190", "adi,ad7192", "adi,ad7193"
> +  or "adi,ad7195"
> +  - reg: SPI chip select number for the device
> +  - spi-cpol, spi-cpha: Controller support only mode 3, so both spi-cpol
> +  and spi-cpha should be present
> +  - spi-max-frequency: Definition as per
> +  see: Documentation/devicetree/bindings/spi/spi-bus.txt
> +  - interrupt-parent: phandle to the parent interrupt controller
> +  see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +  - interrupts: IRQ line for the ADC
> +  see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +Recommended properties:
> +  - adi,clock-source-select: sets the clock source to be used; values are
> +   * 0 - external crystal, connected from pin MCLK1 to MCLK2
> +   * 1 - external clock, applied to MCLK2 pin
> +   * 2 - internal 4.92 Mhz clock; pin MCLK2 is tristated (default)
> +   * 3 - internal 4.92 Mhz clock; internal clock is available on MCLK2

For the external clock there are standard bindings
Documentation/devicetree/bindings/clock/clock-bindings.txt
If one is specified assume it should be used.

For the crystal a quick grep suggests that clocknames are used in somecases
at least to distinguish between osc and xtal.

Final pair probably need a specific devicetree binding like
adi,clockout or something...  (not thought much on that name!)


> +  - adi,external-clock-Hz: if "adi,clock-source-select" is value '1',
> +  this value should be specified to the ADC
> +  - avdd-supply: Analog Supply Voltage, 4.75V to 5.25V. AVDD is
> +  independent of DVDD
> +  - dvdd-supply: Digital Supply Voltage, 2.7V to 5.25V. DVDD
> +  is independent of AVDD

Regulators not values + add a cross reference to the regulator docs.
I would make this required rather than optional.  Easy to supply
fixed regs in devicetree if it makes sense and will simplify
things in the long run if we know they are awlays there.


> +
> +Optional properties:
> +  - adi,refin2-pins-enable: select external reference to be applied
> +  to P1,REFIN2(+) & P0,REFIN2(-) pins instead of REFIN1(+) & REFIN1(-);
> +  not available for "ad7195"
> +  - adi,rejection-60-Hz-enable: enables simultaneous 50/60 Hz rejection
> +  - adi,chop-enable: enable chop to minimize ADC offset and offset drift
> +  - adi,buffer-enable: enables the buffer on the analog inputs
> +  - adi,burnout-currents-enable: when selected, the 500 nA current sources
> +  in the signal path are enabled; can be enabled only when buffer is active
> +  and chop is disabled

These are an oddity.  I'm unclear on whether you would ever have them on
all the time.  Sounds like detection hardware that you'd run in an initial
self test to check your transducer isn't blown.


> +  - adi,sinc3-filter-enable: enables the SINC3 filter; if unset
> +  the SINC4 digital filter is used after the modulator

so this is a selection between two filters.  Good if the naming implies this..

> +  - adi,unipolar-enable: when this is set voltage ranges must be unipolar
> +  (e.g 0 to 5V) versus bipolar voltage ranges (e.g. -5V to 5V)
That isn't close to what I'm reading from the datasheet.

"A bipolar input range does not
imply that the part can tolerate negative voltages with respect to
system AGND. "

This is about using a second input as the differential negative vs using
the common reference input...

> +
> +Example:
> +ad7190@0 {
> +	compatible = "adi,ad7190";
> +	reg = <0>;
> +	spi-max-frequency = <1000000>;
> +	spi-cpol;
> +	spi-cpha;
> +
> +	#interrupt-cells = <2>;
> +	interrupts = <25 0x2>;
> +	interrupt-parent = <&gpio>;
> +	avdd-supply = <&adc_avdd>;
> +
> +	adi,clock-source-select = /bits/ 8 <0>;
> +
> +	adi,refin2-pins-enable;
> +	adi,rejection-60-Hz-enable;
> +	adi,buffer-enable;
> +	adi,burnout-currents-enable;
> +	adi,sinc3-filter-enable;
> +	adi,unipolar-enable;
> +};

