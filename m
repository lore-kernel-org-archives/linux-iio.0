Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36766 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeJEMHO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Oct 2018 08:07:14 -0400
Subject: Re: [PATCH 0/5] ti_am335x_tsc: Enable wakeup capability
From: Vignesh R <vigneshr@ti.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <dcb4a63b-9ecb-a72e-bfb8-ebb62017b4f7@ti.com> <20180718074736.GA4641@dell>
 <20180718170902.vk7rahyoaevucxbi@penguin> <20180723053708.GA4213@dell>
 <2236aa96-ca56-fa30-157d-2f484c6968cc@ti.com> <20180725052621.GB5835@dell>
 <f61848d8-57f6-14c0-eb74-cab488ceda50@ti.com>
Message-ID: <c53a8853-2571-75bc-0cd0-bda9ba906e0a@ti.com>
Date: Fri, 5 Oct 2018 10:41:02 +0530
MIME-Version: 1.0
In-Reply-To: <f61848d8-57f6-14c0-eb74-cab488ceda50@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Friday 28 September 2018 11:42 AM, Vignesh R wrote:
> Hi Lee,
> 
> On Wednesday 25 July 2018 10:56 AM, Lee Jones wrote:
> [...]
>>>>>>>>
>>>>>>>> Vignesh R (5):
>>>>>>>>   mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
>>>>>>>>   Input: ti_am335x_tsc: Mark TSC device as wakeup source
>>>>>>>>   mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup
>>>>>>>>     capable
>>>>>>>>   iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
>>>>>>>>   Input: ti_am335x_tsc: Mark IRQ as wakeup capable
>>>>>>>>
>>>>>>>>  drivers/iio/adc/ti_am335x_adc.c           | 12 ++++--------
>>>>>>>>  drivers/input/touchscreen/ti_am335x_tsc.c | 22 +++++++++++++++++-----
>>>>>>>>  drivers/mfd/ti_am335x_tscadc.c            | 14 +++++++++++++-
>>>>>>>>  3 files changed, 34 insertions(+), 14 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> Gentle ping... Could you review/pick this series? MFD amd IIO bits are
>>>>>>> already ACKed
>>>>>>
>>>>>> MFD patches are reviewed "for my own reference" meaning that we
>>>>>> haven't yet agreed on a merge plan yet.
>>>>>
>>>>> I think this series makes sense to be pushed through a single tree as
>>>>> opposed to being spread between 3, even if it could technically be
>>>>> possible. It looks like Jonathan is fine with going it through either
>>>>> his or some other tree, I am fine with it going through MFD.
>>>>
>>>> I'm happy either way.
>>>>
>>> Thanks Dmitry, Jonathan and Lee Jones!
>>>
>>> Could this be applied to one of the trees now? MFD perhaps?
>>
>> It'll be applied, when it's applied. ;)
> 
> I see that this series was not picked up for v4.19. Could you consider
> this series for v4.20? Patches apply cleanly against linux-next.
> 
> 

Gentle ping...


-- 
Regards
Vignesh
