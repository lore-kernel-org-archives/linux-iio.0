Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35824 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966318AbdADNOM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 08:14:12 -0500
Date: Wed, 4 Jan 2017 07:14:10 -0600
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
Subject: Re: [PATCH 07/22] dt-bindings: power: supply: add AXP20X/AXP22X AC
 power supply
Message-ID: <20170104131410.mni7opxnouzagypu@rob-hp-laptop>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-8-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170102163723.7939-8-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 02, 2017 at 05:37:07PM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have an AC entry to supply power to
> the board. They have a few registers dedicated to the status of the AC
> power supply.
> 
> This adds the DT binding documentation for the AC power supply for
> AXP20X and AXP22X PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../bindings/power/supply/axp20x_ac_power.txt      | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> new file mode 100644
> index 0000000..16d0de4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> @@ -0,0 +1,28 @@
> +AXP20X and AXP22X PMICs' AC power supply
> +
> +Required Properties:
> + - compatible: One of:
> +			"x-powers,axp202-ac-power-supply"
> +			"x-powers,axp221-ac-power-supply"
> +
> +More Required Properties for AXP20X PMICs:
> + - io-channels: phandles to ACIN voltage and current ADC channels
> + - io-channel-names = "acin_v", "acin_i";
> +
> +This node is a subnode of the axp20x PMIC.
> +
> +The AXP20X can read the current current and voltage supplied by AC by
> +reading ADC channels from the AXP20X ADC.
> +
> +The AXP22X is only able to tell if an AC power supply is present and
> +usable.
> +
> +Example:
> +
> +&axp209 {
> +	ac_power_supply: ac_power_supply {

power-supply {

> +		compatible = "x-powers,axp202-ac-power-supply";
> +		io-channels = <&axp209_adc 0>, <&axp209_adc 1>;

Is this assignment fixed? If so, then it doesn't need to be in DT.

> +		io-channel-names = "acin_v", "acin_i";
> +	};
> +};
> -- 
> 2.9.3
> 
