Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35860 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbcFXRTy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2016 13:19:54 -0400
Date: Fri, 24 Jun 2016 12:19:52 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: Re: [PATCH 1/2] iio: magn: DT bindings for AK8974
Message-ID: <20160624171952.GA23588@rob-hp-laptop>
References: <1466608276-10401-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466608276-10401-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 22, 2016 at 05:11:16PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the AK8974 magnetometer, similar
> to those for the AK8975.

Seems like they should be shared, but there don't appear to be any 
datasheets for 8974 to really tell. Really only matters if the 
programming models are similar.

> 
> Cc: devicetree@vger.kernel.org
> Cc: Samu Onkalo <samu.p.onkalo@nokia.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/iio/magnetometer/ak8974.txt           | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
> new file mode 100644
> index 000000000000..967f8e9b9319
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
> @@ -0,0 +1,28 @@
> +* Asahi Kasei AK8974 magnetometer sensor
> +
> +Required properties:
> +
> +- compatible : should be "asahi-kasei,ak8974"
> +- reg : the I2C address of the magnetometer
> +
> +Optional properties:
> +
> +- avdd-supply: regulator supply for the analog voltage
> +  (see regulator/regulator.txt)
> +- dvdd-supply: regulator supply for the digital voltage
> +  (see regulator/regulator.txt)

This is probably more correct than single vdd-supply for 8975 which in 
fact has 2 supplies.

> +- interrupts: data ready (DRDY) and interrupt (INT1) lines
> +  from the chip, the DRDY interrupt must be placed first.
> +  The interrupts can be triggered on rising or falling
> +  edges alike.

The ak8975 probably should be an interrupt instead of gpio, too...

> +
> +Example:
> +
> +ak8974@0f {
> +	compatible = "asahi-kasei,ak8974";
> +	reg = <0x0f>;
> +	avdd-supply = <&foo_reg>;
> +	dvdd-supply = <&bar_reg>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
> +		     <1 IRQ_TYPE_EDGE_RISING>;
> +};
> -- 
> 2.4.11
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
