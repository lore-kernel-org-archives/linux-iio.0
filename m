Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbdLJQoS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 11:44:18 -0500
Date: Sun, 10 Dec 2017 16:44:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, icenowy@aosc.io,
        linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH 4/8] dt-bindings: power: supply: axp20x: add AXP813
 battery DT binding
Message-ID: <20171210164411.01d28afb@archlinux>
In-Reply-To: <bf3682e87c75532884881d7b08840c61678cbce1.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
        <bf3682e87c75532884881d7b08840c61678cbce1.1512396054.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  4 Dec 2017 15:12:50 +0100
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> The AXP813 can have a battery as power supply, so let's add it to the
> list of compatibles.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 +++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> index c248866..4614c8e 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -4,12 +4,12 @@ Required Properties:
>   - compatible, one of:
>  			"x-powers,axp209-battery-power-supply"
>  			"x-powers,axp221-battery-power-supply"
> +			"x-powers,axp813-battery-power-supply"
>  
> -This node is a subnode of the axp20x/axp22x PMIC.
> +This node is a subnode of the axp20x/axp22x/axp81x PMIC.
>  
> -The AXP20X and AXP22X can read the battery voltage, charge and discharge
> -currents of the battery by reading ADC channels from the AXP20X/AXP22X
> -ADC.
> +The AXP20X, AXP22X and AXP81X can read the battery voltage, charge and
> +discharge currents of the battery by reading ADC channels from the ADC.
Might just be me, but this looks like a recipe for unneeded churn in future.

The supported devices can read...

Maybe also

This node is a subnode of the PMIC with the same part number. ?

I don't really care though!

>  
>  Example:
>  

