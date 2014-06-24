Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35781 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbaFXNmA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jun 2014 09:42:00 -0400
MIME-Version: 1.0
In-Reply-To: <20140624133314.GJ5856@leverpostej>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
 <1403612356-23685-4-git-send-email-ch.naveen@samsung.com> <20140624133314.GJ5856@leverpostej>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Tue, 24 Jun 2014 19:11:39 +0530
Message-ID: <CAHfPSqAEuFRSrv5BHw05aK7TiMzXxveriKx9vdqhLc7AxF=i9Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: DTS: use new compatible string as per the documentation
To: Mark Rutland <mark.rutland@arm.com>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"kgene.kim@samsung.com" <kgene.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"cpgs@samsung.com" <cpgs@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Mark,

On 24 June 2014 19:03, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jun 24, 2014 at 01:19:15PM +0100, Naveen Krishna Chatradhi wrote:
>> As Murata is the Manufactures the NTC thermistors. The vendor
>> name in the compatibility is preposed to change to "murata, ncpXXX"
>>
>> This patch uses the new compatibility string in exynos4412 based
>> Trats2 board.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> 1. Updates the thermistor node in Exynos4412 based Trats2 dts
>>    using the new DT bindings for NTC thermistors updated with vendor-prefix
>>
>>  arch/arm/boot/dts/exynos4412-trats2.dts |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
>> index 11967f4..d35755a 100644
>> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
>> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
>> @@ -771,7 +771,7 @@
>>       };
>>
>>       thermistor-ap@0 {
>> -             compatible = "ntc,ncp15wb473";
>> +             compatible = "murata,ncp15wb473";
>
> So the previous patch woul have broken this board?

Will keep the deprecated binding. But, still change here.
As, this is the only board currently using the NTC thermistors.

>
> Mark.
>
>>               pullup-uv = <1800000>;   /* VCC_1.8V_AP */
>>               pullup-ohm = <100000>;   /* 100K */
>>               pulldown-ohm = <100000>; /* 100K */
>> @@ -779,7 +779,7 @@
>>       };
>>
>>       thermistor-battery@1 {
>> -             compatible = "ntc,ncp15wb473";
>> +             compatible = "murata,ncp15wb473";
>>               pullup-uv = <1800000>;   /* VCC_1.8V_AP */
>>               pullup-ohm = <100000>;   /* 100K */
>>               pulldown-ohm = <100000>; /* 100K */
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>



-- 
Shine bright,
(: Nav :)
