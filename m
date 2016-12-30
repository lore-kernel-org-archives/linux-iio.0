Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52315 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbcL3RSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 12:18:41 -0500
Subject: Re: [PATCH 1/2 v2] iio: light: add DT bindings for Capella CM3605
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1482098155-16148-1-git-send-email-linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org,
        Capella Microsystems <capellamicro@gmail.com>,
        Kevin Tsai <ktsai@capellamicro.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2d176f85-f5ee-69b1-55a1-404b6eb86a66@kernel.org>
Date: Fri, 30 Dec 2016 17:18:39 +0000
MIME-Version: 1.0
In-Reply-To: <1482098155-16148-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/12/16 21:55, Linus Walleij wrote:
> This adds device tree bindings for the Capella Microsystems CM3605
> ambient light sensor and short range proximity sensor.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Capella Microsystems <capellamicro@gmail.com>
> Cc: Kevin Tsai <ktsai@capellamicro.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied
> ---
> ChangeLog v1->v2:
> - Rename aset-resistance to aset-resistance-ohms
> ---
>  .../devicetree/bindings/iio/light/cm3605.txt       | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/cm3605.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/cm3605.txt b/Documentation/devicetree/bindings/iio/light/cm3605.txt
> new file mode 100644
> index 000000000000..56331a79f9ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/cm3605.txt
> @@ -0,0 +1,41 @@
> +Capella Microsystems CM3605
> +Ambient Light and Short Distance Proximity Sensor
> +
> +The CM3605 is an entirely analog part which however require quite a bit of
> +software logic to interface a host operating system.
> +
> +This ALS and proximity sensor was one of the very first deployed in mobile
> +handsets, notably it is used in the very first Nexus One Android phone from
> +2010.
> +
> +Required properties:
> +- compatible: must be: "capella,cm3605"
> +- aset-gpios: GPIO line controlling the ASET line (drive low
> +  to activate the ALS, should be flagged GPIO_ACTIVE_LOW)
> +- interrupts: the IRQ line (such as a GPIO) that is connected to
> +  the POUT (proximity sensor out) line. The edge detection must
> +  be set to IRQ_TYPE_EDGE_BOTH so as to detect movements toward
> +  and away from the proximity sensor.
> +- io-channels: the ADC channel used for converting the voltage from
> +  AOUT to a digital representation.
> +- io-channel-names: must be "aout"
> +
> +Optional properties:
> +- vdd-supply: regulator supplying VDD power to the component.
> +- capella,aset-resistance-ohms: the sensitivity calibration resistance,
> +  in Ohms. Valid values are: 50000, 100000, 300000 and 600000,
> +  as these are the resistance values that we are supplied with
> +  calibration curves for. If not supplied, 100 kOhm will be assumed
> +  but it is strongly recommended to supply this.
> +
> +Example:
> +
> +cm3605 {
> +	compatible = "capella,cm3605";
> +	vdd-supply = <&foo_reg>;
> +	aset-gpios = <&foo_gpio 1 GPIO_ACTIVE_LOW>;
> +	capella,aset-resistance-ohms = <100000>;
> +	interrupts = <1 IRQ_TYPE_EDGE_BOTH>;
> +	io-channels = <&adc 0x01>;
> +	io-channel-names = "aout";
> +};
> 

