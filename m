Return-Path: <SRS0=CF/l=DC=microchip.com=Eugen.Hristev@kernel.org>
Subject: Re: [PATCH v3 2/4] ARM: dts: at91: sama5d2: added dma property for
 ADC device
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <nicolas.ferre@microchip.com>, <linux-iio@vger.kernel.org>,
	<lars@metafoo.de>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ludovic.desroches@microchip.com>, <jic23@kernel.org>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
 <1510750608-8697-3-git-send-email-eugen.hristev@microchip.com>
 <20171129210507.GQ21126@piout.net>
From: Eugen Hristev <eugen.hristev@microchip.com>
Message-ID: <d3024017-0802-92ea-8c28-70c2edfb4669@microchip.com>
Date: Wed, 6 Dec 2017 15:18:43 +0200
MIME-Version: 1.0
In-Reply-To: <20171129210507.GQ21126@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 29.11.2017 23:05, Alexandre Belloni wrote:
> Hi,
> 
> On 15/11/2017 at 14:56:46 +0200, Eugen Hristev wrote:
>> Added DMA property for ADC device
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>> ---
>>   arch/arm/boot/dts/sama5d2.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
> 
> This didn't apply cleanly, please check
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=at91-dt&id=0ae80c039ef2407c08842ddde892af0c9128711b
Hi,

I tested on your tree and looked over the file, and it's all good.
Thanks.

> 
>> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
>> index 38d2216..ca8bf13 100644
>> --- a/arch/arm/boot/dts/sama5d2.dtsi
>> +++ b/arch/arm/boot/dts/sama5d2.dtsi
>> @@ -1430,6 +1430,8 @@
>>   				atmel,min-sample-rate-hz = <200000>;
>>   				atmel,max-sample-rate-hz = <20000000>;
>>   				atmel,startup-time-ms = <4>;
>> +				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
>> +				dma-names = "rx";
>>   				status = "disabled";
>>   			};
>>   
>> -- 
>> 2.7.4
>>
> 
