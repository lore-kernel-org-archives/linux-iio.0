Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:48858 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdBUEqU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 23:46:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170214094112.27426-12-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com> <20170214094112.27426-12-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 21 Feb 2017 12:45:55 +0800
Message-ID: <CAGb2v658e8R+qw1zbqp6rY-dXXSsax7ZZGoL0WTZR=Gya7BbnA@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>
> This patch adds the DT binding documentation for the battery power
> supply which gets various data from the PMIC, such as the battery status
> (charging, discharging, full, dead), current max limit, current current,
> battery capacity (in percentage), voltage max and min limits, current
> voltage and battery capacity (in Ah).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>
> v3:
>  - removed constant charge current property, now should use the WIP
>  battery framework,

IIRC this should also include a property for referencing the battery?

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

>
> v2:
>  - changed DT node name from ac_power_supply to ac-power-supply,
>  - removed io-channels and io-channel-names from DT (the IIO mapping is
>  done in the IIO ADC driver now),
>  - added x-powers,constant-charge-current property to set the maximal
>  default constant current charge of the battery,
>
>  .../bindings/power/supply/axp20x_battery.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> new file mode 100644
> index 0000000..c248866
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -0,0 +1,20 @@
> +AXP20x and AXP22x battery power supply
> +
> +Required Properties:
> + - compatible, one of:
> +                       "x-powers,axp209-battery-power-supply"
> +                       "x-powers,axp221-battery-power-supply"
> +
> +This node is a subnode of the axp20x/axp22x PMIC.
> +
> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
> +ADC.
> +
> +Example:
> +
> +&axp209 {
> +       battery_power_supply: battery-power-supply {
> +               compatible = "x-powers,axp209-battery-power-supply";
> +       }
> +};
> --
> 2.9.3
>
