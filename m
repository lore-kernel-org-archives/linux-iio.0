Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0050.outbound.protection.outlook.com ([104.47.42.50]:62080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751771AbdHJGb0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Aug 2017 02:31:26 -0400
Subject: Re: [PATCH] iio: adc: Fix coding style violations
To: Joe Perches <joe@perches.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>
CC: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <d310ac06b13cf803bd3a2a6bcfb92169445f929c.1502193860.git.michal.simek@xilinx.com>
 <1502207564.2219.35.camel@perches.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <1613ba5c-9441-4aa8-6cdf-28af790eeaa6@xilinx.com>
Date: Thu, 10 Aug 2017 08:31:00 +0200
MIME-Version: 1.0
In-Reply-To: <1502207564.2219.35.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8.8.2017 17:52, Joe Perches wrote:
> On Tue, 2017-08-08 at 14:04 +0200, Michal Simek wrote:
>> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> []
>> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> []
>> @@ -76,7 +76,7 @@ struct xadc_ops {
>>  	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev,
>>  			int irq);
>>  	void (*update_alarm)(struct xadc *, unsigned int);
>> -	unsigned long (*get_dclk_rate)(struct xadc *);
>> +	unsigned long (*get_dclk_rate)(struct xadc *xadc);
>>  	irqreturn_t (*interrupt_handler)(int, void *);
> 
> Doesn't it seem odd to you that the lines above and below
> have the same form?
> 
> checkpatch is an imperfect tool.
> It will always be imperfect.
> Please use your eyes and mind too.

You are right. I have missed that in internal review. Fixed in v2.

Thanks,
Michal


