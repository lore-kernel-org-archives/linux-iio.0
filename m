Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:60730 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932761AbaKSWDF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 19 Nov 2014 17:03:05 -0500
Message-ID: <546D1380.6040209@gmx.de>
Date: Wed, 19 Nov 2014 23:02:40 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org,
	jic23@kernel.org
CC: pmeerw@pmeerw.net, daniel.baluta@intel.com, k.wrona@samsung.com
Subject: Re: [RFC v2 2/3] iio: bindings: Add TI afe4403 heart monitor
 documentation
References: <1415287106-13491-1-git-send-email-dmurphy@ti.com> <1415287106-13491-2-git-send-email-dmurphy@ti.com>
In-Reply-To: <1415287106-13491-2-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dan Murphy schrieb am 06.11.2014 16:18:
> Add the TI afe4403 heart monitor device tree
> binding documentation.  heart_monitors directory
> created under iio.
> 
I found a small typo in the comment.
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Updated per v1 comments - http://marc.info/?l=linux-iio&m=141331404132215&w=2
> 
>  .../bindings/iio/heart_monitor/ti_afe4403.txt      | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt b/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
> new file mode 100644
> index 0000000..cf75b5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/heart_monitor/ti_afe4403.txt
> @@ -0,0 +1,23 @@
> +* Texas Instruments - AFE4403 Heart rate and Pulse Oximeter
> +
> +The device consists of a low-noise receiver channel
> +with an integrated analog-to-digital converter (ADC),
> +an LED transmit section, and diagnostics for sensor and LED fault detection.
Typo: a LED ...
> +
> +Required properties:
> +  - compatible: Must contain "ti,afe4403".
> +  - ste-gpio: GPIO for the spi control line
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
> 

