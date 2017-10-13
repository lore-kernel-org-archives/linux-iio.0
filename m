Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:48858 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbdJMPLh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Oct 2017 11:11:37 -0400
Subject: Re: [PATCH 3/3] arm64: dts: mt2712: Add auxadc device node.
To: Jonathan Cameron <jic23@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, srv_heupstream@mediatek.com,
        liguo.zhang@mediatek.com, yingjoe.chen@mediatek.com,
        sean.wang@mediatek.com, yt.shen@mediatek.com,
        s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
 <1505957212-13402-4-git-send-email-zhiyong.tao@mediatek.com>
 <20170924164705.78cbb856@archlinux>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <0e1bac27-18ca-121c-f1d7-8063af177a8b@gmail.com>
Date: Fri, 13 Oct 2017 17:11:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170924164705.78cbb856@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 09/24/2017 05:47 PM, Jonathan Cameron wrote:
> On Thu, 21 Sep 2017 09:26:52 +0800
> Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> 
>> Add auxadc device node for MT2712.
>>
>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> 
> I've applied the IIO patches to make this work, so assume this will get
> picked up in due course.
> 

pushed now to v4.14-next/dts64
Thanks.

> Jonathan
> 
>> ---
>> This patch dependents on "Mediatek MT2712 clock and scpsys support"[1].
>> Please accept this patch together with [1].
>> [1]http://lists.infradead.org/pipermail/linux-mediatek/2017-September/010461.html
>> ---
>>   arch/arm64/boot/dts/mediatek/mt2712-evb.dts |    4 ++++
>>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi   |    9 +++++++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>> index 14163b9..76cbf4a 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>> @@ -28,6 +28,10 @@
>>   	};
>>   };
>>   
>> +&auxadc {
>> +	status = "okay";
>> +};
>> +
>>   &uart0 {
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> index 3232e4e..bf65c92 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> @@ -225,6 +225,15 @@
>>   			 (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_HIGH)>;
>>   	};
>>   
>> +	auxadc: adc@11001000 {
>> +		compatible = "mediatek,mt2712-auxadc";
>> +		reg = <0 0x11001000 0 0x1000>;
>> +		clocks = <&pericfg CLK_PERI_AUXADC>;
>> +		clock-names = "main";
>> +		#io-channel-cells = <1>;
>> +		status = "disabled";
>> +	};
>> +
>>   	uart0: serial@11002000 {
>>   		compatible = "mediatek,mt2712-uart",
>>   			     "mediatek,mt6577-uart";
> 
