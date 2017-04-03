Return-Path: <SRS0=KBst=3L=aosc.io=icenowy@kernel.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: update the Allwinner GPADC device
 tree binding for H3
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-2-icenowy@aosc.io>
 <20170403091523.6atl7nq4m2qkpn3d@lukather>
Cc: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <e4d50e78-afe7-6107-6d9a-15e4c732d79a@aosc.io>
Date: Mon, 3 Apr 2017 17:31:11 +0800
MIME-Version: 1.0
In-Reply-To: <20170403091523.6atl7nq4m2qkpn3d@lukather>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



=E5=9C=A8 2017=E5=B9=B404=E6=9C=8803=E6=97=A5 17:15, Maxime Ripard =E5=86=
=99=E9=81=93:
> On Sun, Apr 02, 2017 at 09:33:01PM +0800, Icenowy Zheng wrote:
>> Allwinner H3 features a thermal sensor like the one in A33, but has it=
s
>> register re-arranged, the clock divider moved to CCU (originally the
>> clock divider is in ADC) and added a pair of bus clock and reset.
>>
>> Update the binding document to cover H3.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 23 +++++++++++++=
+++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/D=
ocumentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> index badff3611a98..7753133ca0ff 100644
>> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> @@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also act=
 as a thermal sensor
>>  and sometimes as a touchscreen controller.
>>
>>  Required properties:
>> -  - compatible: "allwinner,sun8i-a33-ths",
>> +  - compatible: must contain one of the following compatibles:
>> +		- "allwinner,sun8i-a33-ths"
>> +		- "allwinner,sun8i-h3-ths"
>>    - reg: mmio address range of the chip,
>>    - #thermal-sensor-cells: shall be 0,
>>    - #io-channel-cells: shall be 0,
>>
>> -Example:
>> +Required properties for the following compatibles:
>> +		- "allwinner,sun8i-h3-ths"
>> +  - clocks: the bus clock and the input clock of the ADC,
>> +  - clock-names: should be "bus" and "ths",
>
> I guess mod instead of ths would be more consistent.

In fact I will prefer "sample" here if not "ths", as it's used
for the sampling, not like other mod clocks, which controls
all the IP block's logic.

>
> Maxime
>
