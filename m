Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48423 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932987AbbLVRiP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2015 12:38:15 -0500
Subject: Re: [PATCH v3 4/5] Documentation: afe4403: Add DT bindings for the
 AFE4403 heart monitor
To: "Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1450132561-5245-1-git-send-email-afd@ti.com>
 <1450132561-5245-5-git-send-email-afd@ti.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56798A85.30706@kernel.org>
Date: Tue, 22 Dec 2015 17:38:13 +0000
MIME-Version: 1.0
In-Reply-To: <1450132561-5245-5-git-send-email-afd@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/12/15 22:36, Andrew F. Davis wrote:
> Add the TI AFE4403 heart monitor DT bindings documentation.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Nothing terribly controversial in here that I can spot
so looks good to me.

Jonathan
> ---
>  .../devicetree/bindings/iio/health/afe4403.txt     | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/afe4403.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/afe4403.txt b/Documentation/devicetree/bindings/iio/health/afe4403.txt
> new file mode 100644
> index 0000000..2fffd70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/afe4403.txt
> @@ -0,0 +1,34 @@
> +Texas Instruments AFE4403 Heart rate and Pulse Oximeter
> +
> +Required properties:
> + - compatible		: Should be "ti,afe4403".
> + - reg			: SPI chip select address of device.
> + - tx-supply		: Regulator supply to transmitting LEDs.
> + - interrupt-parent	: Phandle to he parent interrupt controller.
> + - interrupts		: The interrupt line the device ADC_RDY pin is
> +			  connected to. For details refer to,
> +			  ../../interrupt-controller/interrupts.txt.
> +
> +Optional properties:
> + - reset-gpios		: GPIO used to reset the device.
> +			  For details refer to, ../../gpio/gpio.txt.
> +
> +For other required and optional properties of SPI slave nodes
> +please refer to ../../spi/spi-bus.txt.
> +
> +Example:
> +
> +&spi0 {
> +	heart_mon@0 {
> +		compatible = "ti,afe4403";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
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

