Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35268 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759550AbdACXVI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2017 18:21:08 -0500
Date: Tue, 3 Jan 2017 17:20:35 -0600
From: Rob Herring <robh@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH 01/22] dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT
 binding
Message-ID: <20170103232035.wwsqmea5dxzu2r5m@rob-hp-laptop>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-2-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170102163723.7939-2-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 02, 2017 at 05:37:01PM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> battery voltage, battery charge and discharge currents, AC-in and VBUS
> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
> 
> This adds the device tree binding documentation for the X-Powers AXP20X
> and AXP22X PMICs ADCs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/iio/adc/axp20x_adc.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> new file mode 100644
> index 0000000..1b60065
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> @@ -0,0 +1,24 @@
> +X-Powers AXP20X and AXP22X PMIC Analog to Digital Converter (ADC)
> +
> +The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> +battery voltage, battery charge and discharge currents, AC-in and VBUS
> +voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
> +
> +The AXP22X PMICs do not have all ADCs of the AXP20X though.
> +
> +Required properties:
> + - compatible, one of:
> +			"x-powers,axp209-adc"
> +			"x-powers,axp221-adc"
> + - #io-channel-cells = <1>;
> +
> +This is a subnode of the AXP20X PMIC.
> +
> +Example:
> +
> +&axp209 {
> +	axp209_adc: axp209_adc {

Use 'adc' for node name:

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "x-powers,axp209-adc";
> +		#io-channel-cells = <1>;
> +	};
> +};
> -- 
> 2.9.3
> 
