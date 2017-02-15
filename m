Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35021 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdBOAsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2017 19:48:03 -0500
From: Liam Breck <liam@networkimprov.net>
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH v3 01/18] dt-bindings: power: battery: add constant-charge-current property
Date: Tue, 14 Feb 2017 16:46:46 -0800
Message-Id: <20170215004646.23607-1-liam@networkimprov.net>
In-Reply-To: <20170214094112.27426-2-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Tue, 14 Feb 2017 10:40:55 +0100 Quentin Schulz wrote:
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

Is constant-charge-current dependent on the battery (e.g. capacity, nominal voltage, etc) or the 
system (charger chip, input current/voltage, etc)?

It belongs in Doc.../power/supply/battery.txt if it's a characteristic of the battery.

Note, this page asserts that constant-current charging applies to NiMH batteries:
http://power-topics.blogspot.com/2016/05/constant-voltage-constant-current.html

Related properties to be added to battery.txt near-future in a patchset for the BQ24190 
charger are as follows. These are not currently in enum power_supply_property, so the actual names 
are still to be decided.

precharge-current-microamp:
   maximum charge current during precharge phase (typically 20% of battery capacity)

termination-current-microamp (or endcharge-current):
   a charge cycle terminates when the battery voltage is above recharge threshold,
   and the current is below this setting (typically 10% of battery capacity)


~.~
