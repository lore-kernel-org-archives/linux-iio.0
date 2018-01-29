Return-Path: <SRS0=BDVa=EY=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable H3 sid controller
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
 <20180128232919.12639-15-embed3d@gmail.com>
 <20180129095200.attg7cgvpifpchtn@flea.lan>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
Date: Mon, 29 Jan 2018 13:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180129095200.attg7cgvpifpchtn@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 29.01.2018 10:52, Maxime Ripard wrote:
> On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
>> This patch enables the the sid controller in the H3. It can be used
>> for thermal calibration data.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index 3f83f6a27c74..9bb5cc29fec5 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -72,6 +72,13 @@
>>   		};
>>   	};
>>   
>> +	soc {
>> +		sid: eeprom@1c14000 {
>> +			compatible = "allwinner,sun8i-h3-sid";
>> +			reg = <0x01c14000 0x400>;
>> +		};
>> +	};
>> +
> 
> Shouldn't you also use a nvmem-cells property to the THS node?
> 
> Maxime
> 

Oh seems like I forgot that.
As related to the wiki [1] this should be 64 bit wide at the address 
0x34. I will add that in the next version.


[1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE

Thanks,
Philipp
