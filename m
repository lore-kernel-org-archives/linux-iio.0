Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41263 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbcBFSvQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:51:16 -0500
Subject: Re: [PATCH v5 1/4] Documentation: afe4404: Add DT bindings for the
 AFE4404 heart monitor
To: "Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1454435446-20586-1-git-send-email-afd@ti.com>
 <1454435446-20586-2-git-send-email-afd@ti.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B6409D.1030501@kernel.org>
Date: Sat, 6 Feb 2016 18:51:09 +0000
MIME-Version: 1.0
In-Reply-To: <1454435446-20586-2-git-send-email-afd@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/02/16 17:50, Andrew F. Davis wrote:
> Add the TI afe4404 heart monitor DT bindings documentation.
> Create health directory created under iio.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Nothing terribly controversial in here I think and its been around in roughly this
form for a long time so I'm applying this now.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to test the other patches in the series.

Jonathan
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

