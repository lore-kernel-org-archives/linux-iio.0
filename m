Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44636 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757286AbcAYUGj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jan 2016 15:06:39 -0500
Date: Mon, 25 Jan 2016 21:06:38 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: "Andrew F. Davis" <afd@ti.com>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Documentation: afe4404: Add DT bindings for the
 AFE4404 heart monitor
In-Reply-To: <1453742941-12086-2-git-send-email-afd@ti.com>
Message-ID: <alpine.DEB.2.02.1601252105090.14521@pmeerw.net>
References: <1453742941-12086-1-git-send-email-afd@ti.com> <1453742941-12086-2-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Jan 2016, Andrew F. Davis wrote:

> Add the TI afe4404 heart monitor DT bindings documentation.
> Create health directory created under iio.

comment below
 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/iio/health/afe4404.txt     | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/afe4404.txt b/Documentation/devicetree/bindings/iio/health/afe4404.txt
> new file mode 100644
> index 0000000..de69f20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/afe4404.txt
> @@ -0,0 +1,30 @@
> +Texas Instruments AFE4404 Heart rate and Pulse Oximeter
> +
> +Required properties:
> + - compatible		: Should be "ti,afe4404".
> + - reg			: I2C address of the device.
> + - tx-supply		: Regulator supply to transmitting LEDs.
> + - interrupt-parent	: Phandle to he parent interrupt controller.
> + - interrupts		: The interrupt line the device ADC_RDY pin is
> +			  connected to. For details refer to,
> +			  ../interrupt-controller/interrupts.txt.
> +
> +Optional properties:
> + - reset-gpios		: GPIO used to reset the device.
> +			  For details refer to, ../gpio/gpio.txt.

remove ',' after 'to'

> +
> +Example:
> +
> +&i2c2 {
> +	heart_mon@58 {
> +		compatible = "ti,afe4404";
> +		reg = <0x58>;
> +
> +		tx-supply = <&vbat>;
> +
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <28 IRQ_TYPE_EDGE_RISING>;
> +
> +		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +	};
> +};
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
