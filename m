Return-Path: <SRS0=NR6Q=EV=gmail.com=embed3d@kernel.org>
Subject: Re: [linux-sunxi] [PATCH 16/16] arm: dts: sun8i: a83t: add thermal
 zone to A83T
To: Samuel Holland <samuel@sholland.org>, lee.jones@linaro.org,
 robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com,
 wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, davem@davemloft.net,
 hans.verkuil@cisco.com, mchehab@kernel.org, rask@formelder.dk,
 clabbe.montjoie@gmail.com, sean@mess.org, krzk@kernel.org,
 quentin.schulz@free-electrons.com, icenowy@aosc.io, edu.molinas@gmail.com,
 singhalsimran0@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com
References: <20180126151941.12183-1-embed3d@gmail.com>
 <20180126151941.12183-17-embed3d@gmail.com>
 <6ee10c04-6602-b927-5f47-64d6beb10625@sholland.org>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <c4153c3b-ff8d-0607-f3f4-3a7827f23348@gmail.com>
Date: Fri, 26 Jan 2018 18:35:38 +0100
MIME-Version: 1.0
In-Reply-To: <6ee10c04-6602-b927-5f47-64d6beb10625@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 26.01.2018 17:25, Samuel Holland wrote:
> On 01/26/18 09:19, Philipp Rossak wrote:
>> This patch adds the thermal zones to the A83T. Sensor 0 is located in the
>> cpu cluster 0. Sensor 1 is located in cluster 1 and Sensor 3 is located
>> in the gpu.
> 
> You mention sensor 3 here, but have sensor 2 in the device tree.
That is a typo/wrong counting error. This should be sensor 2.

I will fix that in the next version of this patch series.

>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   arch/arm/boot/dts/sun8i-a83t.dtsi | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
>> index 9e53ff5ac4ed..4259a8726031 100644
>> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
>> @@ -747,4 +747,24 @@
>>   			#size-cells = <0>;
>>   		};
>>   	};
>> +
>> +	thermal-zones {
>> +		cpu0_thermal: cpu0-thermal {
>> +			polling-delay-passive = <1000>;
>> +			polling-delay = <5000>;
>> +			thermal-sensors = <&ths 0>;
>> +		};
>> +
>> +		cpu1_thermal: cpu1-thermal {
>> +			polling-delay-passive = <1000>;
>> +			polling-delay = <5000>;
>> +			thermal-sensors = <&ths 1>;
>> +		};
>> +
>> +		gpu_thermal: gpu-thermal {
>> +			polling-delay-passive = <1000>;
>> +			polling-delay = <5000>;
>> +			thermal-sensors = <&ths 2>;
> 
>                                             ^^^^ here
> 
>> +		};
>> +	};
>>   };
>>
> 
> Thanks,
> Samuel
> 

Thanks,
Philipp
