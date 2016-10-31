Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51538 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935685AbcJaLkZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2016 07:40:25 -0400
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
To: John Syne <john3909@gmail.com>, Lee Jones <lee.jones@linaro.org>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com> <20161025063847.GD8574@dell>
 <CC15CFB4-60D0-4A63-A3D3-2079CFA31274@gmail.com> <20161026084811.GI8574@dell>
 <A5F6974F-5793-4E85-BF82-2D9309980991@gmail.com>
CC: Mugunthan V N <mugunthanvnm@ti.com>, <linux-iio@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <d7fadbf6-8026-d821-1ef8-981f536a8fdf@ti.com>
Date: Mon, 31 Oct 2016 17:09:50 +0530
MIME-Version: 1.0
In-Reply-To: <A5F6974F-5793-4E85-BF82-2D9309980991@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Friday 28 October 2016 02:47 AM, John Syne wrote:

>>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>> include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
>>>>>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>>> index b9a53e0..96c4207 100644
>>>>>>>>>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>>> @@ -90,7 +90,7 @@
>>>>>>>>>> /* Delay register */
>>>>>>>>>> #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>>>>>>>>>> #define STEPDELAY_OPEN(val)	((val) << 0)
>>>>>>>>>> -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>>>>>>>> Wouldn’t this be better to add this to the devicetree?
>>>>>>>>
>>>>>>>> 	ti,chan-step-avg = <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
>>>>>>>> 	ti,chan-step-opendelay = <0x500 0x500 0x500 0x500 0x500 0x500 0x500>;
>>>>>>>> 	ti,chan-step-sampledelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
>>>>>>>
>>>>>>> For a touch screen, there is not need to change in these parameter
>>>>>>> settings, so my opinion is to keep it as is. Or am I missing something?
>>>>>> I was thinking that if you are using this driver as an ADC, you may want the flexibility to make these changes in the DT. I’m doing this by connecting sensors to the ADC inputs. I’m not using this driver for a touchscreen. 
>>>>>
>>>>> Here is a DT overlay were this gets using on the BeagleBoneBlack.  
>>>>>
>>>>> https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-ADC-00A0.dts
>>>>>
>>>>> Besides, these DT features are already implemented in the driver so it is just a matter of adding these entries to the am33xx.dtsi & am4372.dtsi, which you modified in this patch series.
>>>>
>>>> This looks like configuration, no?
>>>>
>>>> DT should be used to describe the hardware.
>>> You may be right, but how is this different to setting the baud rate on a serial channel or sampling rate on a audio channel? Looking through the DT, there are many configuration settings, so I’m not sure what is the correct way to handle this. Surely it is better to handle this in DT vs hard coding these settings?
>>
>> I think setting the UART baud rate is also an invalid DT entry.
>>
>> It's okay to list all of the options in DT, but to actually select
>> one, that should be done either in userspace or as a kernel option.
>> Perhaps as a Kconfig selection.
> Yeah, this has been inconsistent for a long time. My only point was that these DT parameters had already been implemented in the ti_am335x_adc KM and I thought that this was better than hard coding these settings. Implementing this in Kconfig means rebuilding the KM, which isn’t desirable. 

>Perhaps this should be done via sysfs attributes so as you say, a userspace app can configure this driver. 

This was discussed when DT properties were added.  Patches are welcome
to add sysfs entries. There is nothing wrong with specifying an initial
value in the DT.

>I guess the DT code in ti_am335x_adc.c should be removed. 
> 

Removing DT properties is not an option as it will break DT backward
compatibility.

-- 
Regards
Vignesh
