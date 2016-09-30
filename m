Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50483 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbcI3Io3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2016 04:44:29 -0400
Subject: Re: [PATCH 1/4] mfd: ti_am335x_tscadc: store physical address
To: Lee Jones <lee.jones@linaro.org>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-2-mugunthanvnm@ti.com> <20160927194045.GK21388@dell>
CC: <linux-iio@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vignesh R <vigneshr@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
From: Mugunthan V N <mugunthanvnm@ti.com>
Message-ID: <f271b805-82c2-a45e-0de9-39edafd34d2e@ti.com>
Date: Fri, 30 Sep 2016 14:13:16 +0530
MIME-Version: 1.0
In-Reply-To: <20160927194045.GK21388@dell>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday 28 September 2016 01:10 AM, Lee Jones wrote:
> On Wed, 21 Sep 2016, Mugunthan V N wrote:
> 
>> store the physical address of the device in its priv to use it
>> for DMA addressing in the client drivers.
>>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> ---
>>  drivers/mfd/ti_am335x_tscadc.c       | 1 +
>>  include/linux/mfd/ti_am335x_tscadc.h | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>> index c8f027b..0f3fab4 100644
>> --- a/drivers/mfd/ti_am335x_tscadc.c
>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>> @@ -183,6 +183,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>  		tscadc->irq = err;
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	tscadc->tscadc_phys_base = res->start;
> 
> This is unusual.  Can't you use a virt_to_phys() variant instead?
> 

I tried using virt_to_phys(), but its not working for me.
Also saw many drivers uses like this to get physical address
("git grep -n " res->start;" drivers/*").

Regards
Mugunthan V N

