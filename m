Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:39735 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755921AbcJYGjH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Oct 2016 02:39:07 -0400
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
To: John Syne <john3909@gmail.com>, Mugunthan V N <mugunthanvnm@ti.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>, <linux-iio@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <7024bec3-2ebe-db82-12e2-6d6bcc664c6b@ti.com>
Date: Tue, 25 Oct 2016 12:07:51 +0530
MIME-Version: 1.0
In-Reply-To: <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Tuesday 25 October 2016 11:46 AM, John Syne wrote:
> 
>> On Oct 24, 2016, at 11:01 PM, John Syne <john3909@gmail.com> wrote:
>>
>>>
>>> On Oct 24, 2016, at 10:52 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
>>>
[...]
>>>>>>
>>>>>> ---
>>>>>> include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>> index b9a53e0..96c4207 100644
>>>>>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>>>>>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>> @@ -90,7 +90,7 @@
>>>>>> /* Delay register */
>>>>>> #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>>>>>> #define STEPDELAY_OPEN(val)	((val) << 0)
>>>>>> -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>>>> Wouldn’t this be better to add this to the devicetree?
>>>>
>>>> 	ti,chan-step-avg = <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
>>>> 	ti,chan-step-opendelay = <0x500 0x500 0x500 0x500 0x500 0x500 0x500>;
>>>> 	ti,chan-step-sampledelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
>>>
>>> For a touch screen, there is not need to change in these parameter
>>> settings, so my opinion is to keep it as is. Or am I missing something?
>> I was thinking that if you are using this driver as an ADC, you may want the flexibility to make these changes in the DT. I’m doing this by connecting sensors to the ADC inputs. I’m not using this driver for a touchscreen.
> 

ti_am335x_adc driver already supports above DT parameters and its upto
the user to adjust these parameters as required.

> Here is a DT overlay were this gets using on the BeagleBoneBlack.  
> 
> https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-ADC-00A0.dts
> 
> Besides, these DT features are already implemented in the driver so it is just a matter of adding these entries to the am33xx.dtsi & am4372.dtsi, which you modified in this patch series.
> 

Touchscreen driver (ti_am335x_tsc.c) does not support above DT parameters.

-- 
Regards
Vignesh
