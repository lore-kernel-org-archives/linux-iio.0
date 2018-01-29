Return-Path: <SRS0=BDVa=EY=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH v2 01/16] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, davem@davemloft.net,
 hans.verkuil@cisco.com, mchehab@kernel.org, rask@formelder.dk,
 clabbe.montjoie@gmail.com, sean@mess.org, krzk@kernel.org,
 quentin.schulz@free-electrons.com, icenowy@aosc.io, edu.molinas@gmail.com,
 singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-2-embed3d@gmail.com>
 <20180129091937.w3c3btvva5yaqlf6@flea.lan>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <a107f74a-00dd-26e5-69df-0a62a4cf8525@gmail.com>
Date: Mon, 29 Jan 2018 13:30:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180129091937.w3c3btvva5yaqlf6@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

>> +Example for A33:
>>   	ths: ths@1c25000 {
>>   		compatible = "allwinner,sun8i-a33-ths";
>>   		reg = <0x01c25000 0x100>;
>> @@ -17,6 +40,27 @@ Example:
>>   		#io-channel-cells = <0>;
>>   	};
>>   
>> +Example for H3:
>> +	ths: thermal-sensor@1c25000 {
>> +		compatible = "allwinner,sun8i-h3-ths";
>> +		reg = <0x01c25000 0x400>;
>> +		clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
>> +		clock-names = "bus", "mod";
>> +		resets = <&ccu RST_BUS_THS>;
>> +		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> +		#thermal-sensor-cells = <0>;
>> +		#io-channel-cells = <0>;
>> +	};
>> +
>> +Example for A83T:
>> +	ths: thermal-sensor@1f04000 {
>> +		compatible = "allwinner,sun8i-a83t-ths";
>> +		reg = <0x01f04000 0x100>;
>> +		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>> +		#thermal-sensor-cells = <1>;
>> +		#io-channel-cells = <0>;
>> +	};
>> +
> 
> I'm wondering if this is actually needed. We've used this convoluted
> constructs to be compatible with the old driver, but I'm not sure this
> is actually worth it now, and this is causing several issues, among
> which:
>    - We need to have a bunch of quirks to handle all the DT cases.
>    - We need to have an MFD, which isn't really optimal
> 
> So I'd rather introduce a new compatible for the old SoCs, keep the
> old driver around, and simplify a lot that driver code that will ease
> further developments. And we can also get rid of the MFD in the
> process. I discussed it with Quentin, and he was ok with it, what do
> you think?
> 
> (and that would involve creating a new file for the bindings you
> introduce here).
> 
> Maxime
> 

I think this is a good idea, and the desired way to rework the driver.

To sum up what we talked on IRC:

This will end up in removing the MFD driver and moving the interrupt 
handling into the iio driver. At the end this will also simplify the IRQ 
part.

Philipp
