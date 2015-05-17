Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60052 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbEQMv5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 08:51:57 -0400
Message-ID: <55588EEC.6000901@kernel.org>
Date: Sun, 17 May 2015 13:51:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: bindings: Add TI afe4403 heart monitor documentation
References: <1431374726-23383-1-git-send-email-dmurphy@ti.com> <1431374726-23383-3-git-send-email-dmurphy@ti.com>
In-Reply-To: <1431374726-23383-3-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/05/15 21:05, Dan Murphy wrote:
> Add the TI afe4403 heart monitor device tree
> binding documentation.  health directory
> created under iio.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
A few bits popped up when reviewing the driver.
> ---
>  .../devicetree/bindings/iio/health/ti_afe4403.txt  | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/ti_afe4403.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt b/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt
> new file mode 100644
> index 0000000..b196b17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt
> @@ -0,0 +1,26 @@
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
This is an interrupt as far as the device is concerned, not a gpio. hence the
binding should reflect that.  Not all interrupt capable devices are even capable
of reading out their current value, let alone acting as outputs as well!
> +  - led-supply: Chip supply to the device
> +
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
> +
> +Technical Datasheet:
> +http://www.ti.com/product/AFE4403/datasheet
> 

