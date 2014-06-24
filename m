Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:65195 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaFXNjJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jun 2014 09:39:09 -0400
MIME-Version: 1.0
In-Reply-To: <20140624133030.GH5856@leverpostej>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
 <1403612356-23685-2-git-send-email-ch.naveen@samsung.com> <20140624133030.GH5856@leverpostej>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Tue, 24 Jun 2014 19:08:48 +0530
Message-ID: <CAHfPSqBf_DpXx_Ag12OxjqUPK6BKek4t=Ni4jQ4ZyAHqkh56ng@mail.gmail.com>
Subject: Re: [PATCH 1/4] devicetree: bindings: Document murata vendor prefix
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
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Mark,

On 24 June 2014 19:00, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jun 24, 2014 at 01:19:13PM +0100, Naveen Krishna Chatradhi wrote:
>> Add Murata Manufacturing Co., Ltd. to the list of device tree
>> vendor prefixes.
>>
>> Murata manufactures NTC (Negative Temperature Coefficient) based
>> Thermistors for small scale applications like Mobiles and PDAs.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> ---
>> This changes is needed for the following reasons
>>
>> 1. The vendor prefix "ntc" is not defined in vendor-prefixes.txt
>>    Thus, giving an error when checked with scripts/checkpatch.pl
>> 2. Murata Manufacturing Co., Ltd. Is the vendor for the
>>    NTC (Negative Temperature Coefficient) based thermistors.
>>    Hence, "murata" is the right vendor-prefix, Not "ntc".
>> 3. NTC is a technology used, But the prefix "ntc" is wrongly
>>    and heavily used in the driver and the documentation.
>>
>>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 4d7f375..a39b7d7 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -84,6 +84,7 @@ moxa        Moxa
>>  mpl  MPL AG
>>  mundoreader  Mundo Reader S.L.
>>  mxicy        Macronix International Co., Ltd.
>> +murata       Murata Manufacturing Co., Ltd.
>
> Nit: please keep this list in alphabetical order.

Sure, Will rearrange and re-spin.
>
> Otherwise, this looks fine to me. With the order fixed:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks
>
> Mark.
>
>>  national     National Semiconductor
>>  neonode              Neonode Inc.
>>  netgear      NETGEAR
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
