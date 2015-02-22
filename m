Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38469 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbBVJsI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Feb 2015 04:48:08 -0500
Message-ID: <54E9A5D3.1090305@kernel.org>
Date: Sun, 22 Feb 2015 09:48:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Karol Wrona <k.wrona@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: common: ssp_sensors: Protect PM-only functions
 to kill warning
References: <1424259586-29334-1-git-send-email-geert@linux-m68k.org> <54E4886A.5080902@samsung.com>
In-Reply-To: <54E4886A.5080902@samsung.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/02/15 12:41, Karol Wrona wrote:
> On 02/18/2015 12:39 PM, Geert Uytterhoeven wrote:
>> If CONFIG_PM_SLEEP=n:
>>
>>     drivers/iio/common/ssp_sensors/ssp_dev.c:644: warning: ‘ssp_suspend’ defined but not used
>>     drivers/iio/common/ssp_sensors/ssp_dev.c:669: warning: ‘ssp_resume’ defined but not used
>>
>> Protect the unused functions by #ifdef CONFIG_PM_SLEEP to fix this.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> v2:
>>   - Fix driver name in one-line summary
>> ---
>>  drivers/iio/common/ssp_sensors/ssp_dev.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
>> index 52d70435f5a11c55..55a90082a29bd484 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
>> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
>> @@ -640,6 +640,7 @@ static int ssp_remove(struct spi_device *spi)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_PM_SLEEP
>>  static int ssp_suspend(struct device *dev)
>>  {
>>  	int ret;
>> @@ -688,6 +689,7 @@ static int ssp_resume(struct device *dev)
>>  
>>  	return 0;
>>  }
>> +#endif /* CONFIG_PM_SLEEP */
>>  
>>  static const struct dev_pm_ops ssp_pm_ops = {
>>  	SET_SYSTEM_SLEEP_PM_OPS(ssp_suspend, ssp_resume)
>>
> 
> Acked-by: Karol Wrona <k.wrona@samsung.com>
Applied to the fixes-post-3.20-rc1 branch which I'll sort out once rc1 is
tagged.

Thanks,

Jonathan
> 
> Thanks for doing that.
> Karol
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

