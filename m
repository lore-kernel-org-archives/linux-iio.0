Return-Path: <SRS0=BDVa=EY=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH v2 13/16] arm: dts: sun8i: h3: add thermal zone to H3
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
 <20180128232919.12639-14-embed3d@gmail.com>
 <20180129095034.5crx7ydq5k6f7omv@flea.lan>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <e3b3e604-1155-804e-b7b0-a670b954a876@gmail.com>
Date: Mon, 29 Jan 2018 12:56:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180129095034.5crx7ydq5k6f7omv@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 29.01.2018 10:50, Maxime Ripard wrote:
> On Mon, Jan 29, 2018 at 12:29:16AM +0100, Philipp Rossak wrote:
>> This patch adds the thermal zones to the H3. We have only one sensor and
>> that is placed in the cpu.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index fbb007e5798e..3f83f6a27c74 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -72,6 +72,15 @@
>>   		};
>>   	};
>>   
>> +	thermal-zones {
>> +		cpu-thermal {
>> +			/* milliseconds */
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +			thermal-sensors = <&ths 0>;
> 
> if the thermal-sensor-cells value is indeed 0, the phandle parsing
> will be broken here.
> 
> Maxime
> 

Ok, then I will remove the 0.

Thanks,

Philipp
