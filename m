Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35371 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbdBVV0c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2017 16:26:32 -0500
Date: Wed, 22 Feb 2017 15:25:28 -0600
From: Rob Herring <robh@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, wens@csie.org, sre@kernel.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        lee.jones@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH v3 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Message-ID: <20170222212528.vo7fbayactwfzgao@rob-hp-laptop>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-2-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170214094112.27426-2-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 14, 2017 at 10:40:55AM +0100, Quentin Schulz wrote:
> This adds the constant-charge-current property to the list of optional
> properties of the battery.
> 
> The constant charge current is critical for batteries as they can't
> handle all charge currents.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> added in v3
> 
>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index d78a4aa..3e830fe 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -7,6 +7,7 @@ Optional Properties:
>   - voltage-min-design-microvolt: drained battery voltage
>   - energy-full-design-microwatt-hours: battery design energy
>   - charge-full-design-microamp-hours: battery design capacity
> + - constant-charge-current-microamp: battery constant charge current

Kind of long, though so are the others. Maybe just 
"constant-charge-microamp" as uA implies current.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
