Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:49102 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdBUE4K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 23:56:10 -0500
MIME-Version: 1.0
In-Reply-To: <6a678b03-124a-76b3-066e-858731fc6c80@free-electrons.com>
References: <20170215004646.23607-1-liam@networkimprov.net> <6a678b03-124a-76b3-066e-858731fc6c80@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 21 Feb 2017 12:55:44 +0800
Message-ID: <CAGb2v67913XnRNv9bYty5WcGLAWHYMM6=M9BVmTZ3wjReh_UBg@mail.gmail.com>
Subject: Re: [PATCH v3 01/18] dt-bindings: power: battery: add
 constant-charge-current property
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Liam Breck <liam@networkimprov.net>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 15, 2017 at 4:53 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Hi,
>
> On 15/02/2017 01:46, Liam Breck wrote:
>>
>> On Tue, 14 Feb 2017 10:40:55 +0100 Quentin Schulz wrote:
>>> This adds the constant-charge-current property to the list of optional
>>> properties of the battery.
>>>
>>> The constant charge current is critical for batteries as they can't
>>> handle all charge currents.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> ---
>>>
>>> added in v3
>>>
>>>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
>>
>> Is constant-charge-current dependent on the battery (e.g. capacity, nominal voltage, etc) or the
>> system (charger chip, input current/voltage, etc)?
>>
>> It belongs in Doc.../power/supply/battery.txt if it's a characteristic of the battery.
>>
>> Note, this page asserts that constant-current charging applies to NiMH batteries:
>> http://power-topics.blogspot.com/2016/05/constant-voltage-constant-current.html
>>
>> Related properties to be added to battery.txt near-future in a patchset for the BQ24190
>> charger are as follows. These are not currently in enum power_supply_property, so the actual names
>> are still to be decided.
>>
>> precharge-current-microamp:
>>    maximum charge current during precharge phase (typically 20% of battery capacity)
>>
>> termination-current-microamp (or endcharge-current):
>>    a charge cycle terminates when the battery voltage is above recharge threshold,
>>    and the current is below this setting (typically 10% of battery capacity)
>>
>
> We have a client with a board whose battery accepts a maximum of 300mA
> for charging. So depending on the battery, we cannot have any charging
> current we want. The AXP PmMICs set constant charge current in a range
> of 300mA-1800mA, so it is enforced by the charger but needs to be
> adapted depending on the battery present in the system.

May I ask the capacity of the battery in question?

Typically one charges LiPo batteries at no more than 1C. So if it's
a 1800 mAh battery, the charge current should be no more than 1800 mA.

ChenYu

> The AXP PMICs charge battery with constant current (Ichrg) between the
> trickle voltage (Vtrkl which is ~3.0V) and the targeted voltage (Vtrgt;
> which seems to be the voltage telling the battery is fully charged).
>
> So if I understand correctly, "my" constant-charge-current would be
> located in the charging cycle between your precharge-current-microamp
> and the termination-current-microamp as it is the current for the
> charging process as a whole.
>
> See here[1] for the explanation in the datasheet (page 20).
>
> That would definitely match what is explained in your link for constant
> current.
>
> [1] http://dl.linux-sunxi.org/AXP/AXP209_Datasheet_v1.0en.pdf
>
> Let me know if something seems odd,
> Thanks,
> Quentin
>
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
