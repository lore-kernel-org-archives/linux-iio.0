Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933447AbdDETEe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 5 Apr 2017 15:04:34 -0400
MIME-Version: 1.0
In-Reply-To: <bdc43a73-a2d6-01ae-8113-277f7174697c@aosc.io>
References: <20170402133304.56824-1-icenowy@aosc.io> <20170402133304.56824-2-icenowy@aosc.io>
 <20170404144715.fa5sy427u2cz4e6z@rob-hp-laptop> <bdc43a73-a2d6-01ae-8113-277f7174697c@aosc.io>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Apr 2017 14:04:02 -0500
Message-ID: <CAL_Jsq+iE97RbtY6PZ9nNDhdekK=P1wozC=vHkx3wj9-RQumsA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: update the Allwinner GPADC device
 tree binding for H3
To: Icenowy Zheng <icenowy@aosc.io>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 4, 2017 at 10:02 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> 在 2017年04月04日 22:47, Rob Herring 写道:
>>
>> On Sun, Apr 02, 2017 at 09:33:01PM +0800, Icenowy Zheng wrote:
>>>
>>> Allwinner H3 features a thermal sensor like the one in A33, but has its
>>> register re-arranged, the clock divider moved to CCU (originally the
>>> clock divider is in ADC) and added a pair of bus clock and reset.
>>>
>>> Update the binding document to cover H3.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 23
>>> ++++++++++++++++++++--
>>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>> b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>> index badff3611a98..7753133ca0ff 100644
>>> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>> @@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also act as
>>> a thermal sensor
>>>  and sometimes as a touchscreen controller.
>>>
>>>  Required properties:
>>> -  - compatible: "allwinner,sun8i-a33-ths",
>>> +  - compatible: must contain one of the following compatibles:
>>> +               - "allwinner,sun8i-a33-ths"
>>> +               - "allwinner,sun8i-h3-ths"
>>>    - reg: mmio address range of the chip,
>>>    - #thermal-sensor-cells: shall be 0,
>>>    - #io-channel-cells: shall be 0,
>>>
>>> -Example:
>>> +Required properties for the following compatibles:
>>> +               - "allwinner,sun8i-h3-ths"
>>> +  - clocks: the bus clock and the input clock of the ADC,
>>> +  - clock-names: should be "bus" and "ths",
>>> +  - resets: the bus reset of the ADC,
>>> +
>>> +Example for A33:
>>>         ths: ths@01c25000 {
>>>                 compatible = "allwinner,sun8i-a33-ths";
>>>                 reg = <0x01c25000 0x100>;
>>> @@ -17,6 +25,17 @@ Example:
>>>                 #io-channel-cells = <0>;
>>>         };
>>>
>>> +Example for H3:
>>> +       ths: ths@01c25000 {
>>
>>
>> adc@...
>
>
> It's a thermal sensor, so I think call it THS is more appropriate
> here. It's implemented as an ADC driver just because the internal
> code reusing of Linux. From device tree binding view I choose to
> call it ths.

There's numerous occurrences in this file and the filename that call it an ADC.

Furthermore, node names are supposed to be generic, not part #'s or
whatever you decide to make up. So pick from adc or temperature-sensor
as those are the standard names .

Rob
