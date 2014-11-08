Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37223 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbaKHLsp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Nov 2014 06:48:45 -0500
Message-ID: <545E031A.7050302@kernel.org>
Date: Sat, 08 Nov 2014 11:48:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
CC: pmeerw@pmeerw.net, daniel.baluta@intel.com, k.wrona@samsung.com,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [RFC v2 2/3] iio: bindings: Add TI afe4403 heart monitor documentation
References: <1415287106-13491-1-git-send-email-dmurphy@ti.com> <1415287106-13491-2-git-send-email-dmurphy@ti.com>
In-Reply-To: <1415287106-13491-2-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/14 15:18, Dan Murphy wrote:
> Add the TI afe4403 heart monitor device tree
> binding documentation.  heart_monitors directory
> created under iio.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
As a device tree binding this MUST go to the device tree list
and maintainers.  Cc'd.

I suspect from my review of the driver that there will be a
whole load more stuff to go in here...

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
> +
> +Required properties:
> +  - compatible: Must contain "ti,afe4403".
> +  - ste-gpio: GPIO for the spi control line
> +  - data-ready-gpio: GPIO interrupt when the afe4403 has data
Does this actually need to be a gpio?  Doesn't look like it from the driver.
As such should be handled as a generic interrupt both here and in the driver.

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

