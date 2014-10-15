Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:45470 "EHLO mail.pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226AbaJOKDe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 15 Oct 2014 06:03:34 -0400
Date: Wed, 15 Oct 2014 11:52:56 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Dan Murphy <dmurphy@ti.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [RFC Patch 2/3] iio: bindings: Add TI afe4403 heart monitor
 documentation
In-Reply-To: <1413314032-923-3-git-send-email-dmurphy@ti.com>
Message-ID: <alpine.DEB.2.02.1410151057340.2173@pmeerw.net>
References: <1413314032-923-1-git-send-email-dmurphy@ti.com> <1413314032-923-3-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Add the TI afe4403 heart monitor device tree
> binding documentation.  heart_monitors directory
> created under iio.


> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/iio/heart_monitors/ti_afe4403.txt     |   23 ++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/heart_monitors/ti_afe4403.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/heart_monitors/ti_afe4403.txt b/Documentation/devicetree/bindings/iio/heart_monitors/ti_afe4403.txt
> new file mode 100644
> index 0000000..d612dd6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/heart_monitors/ti_afe4403.txt
> @@ -0,0 +1,23 @@
> +* Texas Instruments - AFE4403 Heart rate and Pulse Oximeter
> +
> +The device consists of a low-noise receiver channel
> +with an integrated analog-to-digital converter (ADC),
> +an LED transmit section, and diagnostics for sensor and LED fault detection.
> +
> +Required properties:
> +  - compatible: Must contain "ti,afe4403".
> +  - ste-gpio: GPIO for the spi control line
> +  - data-ready-gpio: GPIO interrupt when the afe4403 has data
> +  - led-supply: Chip supply to the device
> +  - 

extra -

> +Optional properties:
> +  - reset-gpio: GPIO used to reset the device via HW
> +
> +Example:
> +
> +&heart_rate {
> +	compatible = "ti,afe4403";
> +	ste-gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +	data-ready-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	led-supply = <&vbat>;
> +};
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
