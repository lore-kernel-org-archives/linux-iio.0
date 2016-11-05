Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51334 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755089AbcKERpS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 13:45:18 -0400
Subject: Re: [PATCH 1/4] mfd: ti_am335x_tscadc: store physical address
To: Lee Jones <lee.jones@linaro.org>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-2-mugunthanvnm@ti.com> <20160927194045.GK21388@dell>
 <f271b805-82c2-a45e-0de9-39edafd34d2e@ti.com> <20161026121730.GS8574@dell>
 <954adfa7-94d9-f785-aeab-6f20c8f4c3b9@kernel.org>
 <20161031081643.GN13127@dell>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vignesh R <vigneshr@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3f3339b5-3861-832c-a26d-d6fd2d2cfd59@kernel.org>
Date: Sat, 5 Nov 2016 17:45:14 +0000
MIME-Version: 1.0
In-Reply-To: <20161031081643.GN13127@dell>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/16 08:16, Lee Jones wrote:
> On Sun, 30 Oct 2016, Jonathan Cameron wrote:
> 
>> On 26/10/16 13:17, Lee Jones wrote:
>>> On Fri, 30 Sep 2016, Mugunthan V N wrote:
>>>
>>>> On Wednesday 28 September 2016 01:10 AM, Lee Jones wrote:
>>>>> On Wed, 21 Sep 2016, Mugunthan V N wrote:
>>>>>
>>>>>> store the physical address of the device in its priv to use it
>>>>>> for DMA addressing in the client drivers.
>>>>>>
>>>>>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>>>>>> ---
>>>>>>  drivers/mfd/ti_am335x_tscadc.c       | 1 +
>>>>>>  include/linux/mfd/ti_am335x_tscadc.h | 1 +
>>>>>>  2 files changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>>>>>> index c8f027b..0f3fab4 100644
>>>>>> --- a/drivers/mfd/ti_am335x_tscadc.c
>>>>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>>>>>> @@ -183,6 +183,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>>>>>  		tscadc->irq = err;
>>>>>>  
>>>>>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>> +	tscadc->tscadc_phys_base = res->start;
>>>>>
>>>>> This is unusual.  Can't you use a virt_to_phys() variant instead?
>>>>>
>>>>
>>>> I tried using virt_to_phys(), but its not working for me.
>>>> Also saw many drivers uses like this to get physical address
>>>> ("git grep -n " res->start;" drivers/*").
>>>
>>> Very well:
>>>
>>> For my own reference:
>>>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>>
>>> Let me know how you wish this set to be handled.
>> I'm happy to pick up the whole series.  There are some more mfd
>> header changes in patch 2 but as they only add defines, I
>> don't mind that much if I don't an Ack from you on those
>> (btw this got to V3 but as patch 1 didn't change I'll carry
>> your ack forwards).
>>
>> Do you want an immutable branch?  Seems unlikely to cause
>> much trouble even if there is a merge issue on all 10ish
>> lines of mfd code in the next merge window.
> 
> Not at the moment, but if you could set things up so it's possible to
> create one at a later date if things go Pete Tong, that would be
> great.
Couldn't think of an easy way to do this without creating a branch
and merging it into my normal branch.  I'll not push it out to
kernel.org though unless you tell me you need it.

Applied to the togreg branch (indirectly ;) of iio.git pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> 

