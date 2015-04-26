Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41973 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbDZRaw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 13:30:52 -0400
Message-ID: <553D20CA.7090107@kernel.org>
Date: Sun, 26 Apr 2015 18:30:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: bindings: Add TI afe4403 heart monitor documentation
References: <1429720331-1900-1-git-send-email-dmurphy@ti.com> <1429720331-1900-3-git-send-email-dmurphy@ti.com>
In-Reply-To: <1429720331-1900-3-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/04/15 17:32, Dan Murphy wrote:
> Add the TI afe4403 heart monitor device tree
> binding documentation.  heart_monitors directory
> created under iio.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/iio/heart_monitor/ti_afe4403.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt b/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
> new file mode 100644
> index 0000000..b196b17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
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
This gpio needs more info here.  From description it sounds like a chip select
and those obviously don't need to be specified at driver level.

> +  - data-ready-gpio: GPIO interrupt when the afe4403 has data
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

