Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56669 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbcDVNd2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Apr 2016 09:33:28 -0400
Subject: Re: [PATCH RFT V2 3/3] iio: mxs-lradc: implement suspend/resume
 support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
 <1461269478-449-4-git-send-email-stefan.wahren@i2se.com>
 <20160421210810.GC25466@dtor-ws>
Cc: Marek Vasut <marex@denx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <571A27FC.4030301@i2se.com>
Date: Fri, 22 Apr 2016 15:32:44 +0200
MIME-Version: 1.0
In-Reply-To: <20160421210810.GC25466@dtor-ws>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dmitry,

Am 21.04.2016 um 23:08 schrieb Dmitry Torokhov:
> On Thu, Apr 21, 2016 at 08:11:18PM +0000, Stefan Wahren wrote:
>> This patch implements suspend/resume support for mxs-lradc.
>> It's possible to use the touchscreen as wakeup source.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/iio/adc/mxs-lradc.c |   61 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
>> index cfc558f..6bd387f 100644
>> --- a/drivers/iio/adc/mxs-lradc.c
>> +++ b/drivers/iio/adc/mxs-lradc.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm.h>
>>  #include <linux/slab.h>
>>  #include <linux/stmp_device.h>
>>  #include <linux/sysfs.h>
>> @@ -1745,10 +1746,70 @@ static int mxs_lradc_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static int __maybe_unused mxs_lradc_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *iio = dev_get_drvdata(dev);
>> +	struct mxs_lradc *lradc = iio_priv(iio);
>> +	struct input_dev *input = lradc->ts_input;
>> +	int ret = 0;
>> +
>> +	if (input) {
>> +		mutex_lock(&input->mutex);
>> +
>> +		/* Enable touchscreen wakeup irq */
>> +		if (input->users && device_may_wakeup(dev))
>> +			ret = enable_irq_wake(lradc->irq[0]);
>> +		else
>> +			mxs_lradc_disable_ts(lradc);
>> +
>> +		mutex_unlock(&input->mutex);
>> +	}
>> +
>> +	if (ret)
>> +		return ret;
> I'd rather we had it right after we do:
>
> 			ret = enable_irq_wake(lradc->irq[0]);

but we must unlock the mutex first before return. An option would be to
place the return inside the input branch.

Stefan


