Return-Path: <SRS0=BDVa=EY=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH v2 11/16] arm: dts: sunxi-h3-h5: add support for the
 thermal sensor in H3 and H5
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
 <20180128232919.12639-12-embed3d@gmail.com>
 <20180129094918.4fvxpmoftgxxkqg3@flea.lan>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <afdf049d-c037-1e0e-359e-faa7a38730d9@gmail.com>
Date: Mon, 29 Jan 2018 12:54:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180129094918.4fvxpmoftgxxkqg3@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 29.01.2018 10:49, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Jan 29, 2018 at 12:29:14AM +0100, Philipp Rossak wrote:
>> As we have gained the support for the thermal sensor in H3 and H5,
>> we can now add its device nodes to the device tree. The H3 and H5 share
>> most of its compatible. The compatible and the thermal sensor cells
>> will be added in an additional patch per device.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>> index 7a83b15225c7..413c789b588d 100644
>> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>> @@ -426,6 +426,15 @@
>>   			};
>>   		};
>>   
>> +		ths: thermal-sensor@1c25000 {
>> +			reg = <0x01c25000 0x100>;
> 
> The size is 0x400
> 
> Maxime
> 

Ok, I will fix this.

Philipp
