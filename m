Return-Path: <SRS0=8Vvv=A2=csie.org=wens@kernel.org>
MIME-Version: 1.0
In-Reply-To: <D7CAB179-F2AF-434F-82F7-07F146842FCF@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io> <20170920151814.22461-7-icenowy@aosc.io>
 <7ce5c53e-70ba-456e-ecf7-5132ef2c2c64@free-electrons.com> <D7CAB179-F2AF-434F-82F7-07F146842FCF@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 25 Sep 2017 17:19:07 +0800
Message-ID: <CAGb2v64rBQ33aqhPSksBB88GGQTJsPyeebD0ixT=ehBYA5tSEA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [RFC PATCH 6/7] arm64: allwinner: a64: add
 power supply nodes in AXP803 DTSI
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-iio@vger.kernel.org,
	linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Sep 25, 2017 at 5:14 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> =E4=BA=8E 2017=E5=B9=B49=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
5:11:57, Quentin Schulz <quentin.schulz@free-electrons.com> =E5=86=99=E5=88=
=B0:
>>Hi Icenowy,
>>
>>On 20/09/2017 17:18, Icenowy Zheng wrote:
>>> AXP803 PMIC features AC/USB/Battery power supplies.
>>>
>>> As we have now the device tree bindings for them, add device tree
>>> nodes for them.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi
>>b/arch/arm64/boot/dts/allwinner/axp803.dtsi
>>> index ff8af52743ff..3a8615231b7c 100644
>>> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
>>> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
>>> @@ -49,6 +49,16 @@
>>>      interrupt-controller;
>>>      #interrupt-cells =3D <1>;
>>>
>>> +    ac_power_supply: ac-power-supply {
>>> +            compatible =3D "x-powers,axp221-ac-power-supply";
>>> +            status =3D "disabled";
>>> +    };
>>> +
>>> +    battery_power_supply: battery-power-supply {
>>> +            compatible =3D "x-powers,axp803-battery-power-supply";
>>> +            status =3D "disabled";
>>> +    };
>>> +
>>>      regulators {
>>>              /* Default work frequency for buck regulators */
>>>              x-powers,dcdc-freq =3D <3000>;
>>> @@ -147,4 +157,9 @@
>>>                      regulator-name =3D "rtc-ldo";
>>>              };
>>>      };
>>> +
>>> +    usb_power_supply: usb_power_supply {
>>> +            compatible =3D "x-powers,axp803-usb-power-supply";
>>> +            status =3D "disabled";
>>> +    };
>>
>>No. You have added support for the AC and battery power supply drivers
>>in this patchset, not for USB.
>
> But I added its device tree binding.

Please do both at the same time. If you only add the binding without
the driver, how can you be sure the binding would be a proper fit?
Moreover, no one can actually test it.

ChenYu
