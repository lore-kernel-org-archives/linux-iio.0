Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40249 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbaKVLoN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Nov 2014 06:44:13 -0500
Message-ID: <54707707.5040200@kernel.org>
Date: Sat, 22 Nov 2014 11:44:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Fabien Proriol <Fabien.Proriol@jdsu.com>,
	Michal Simek <michal.simek@xilinx.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] 0001-xilinx-xadc-core-Fix-voltage-offset.patch
References: <545B9479.5030700@jdsu.com> <545B976D.4080303@metafoo.de> <545B9EF1.8000606@jdsu.com> <545BA105.70105@metafoo.de> <545BA802.5090206@jdsu.com> <54690AE5.4050900@metafoo.de> <5469B725.8080908@jdsu.com> <5469B7FF.6050500@metafoo.de>
In-Reply-To: <5469B7FF.6050500@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/11/14 08:55, Lars-Peter Clausen wrote:
> On 11/17/2014 09:53 AM, Fabien Proriol wrote:
>>  From bdeab2d72a00587eac15eb91ec0820ff6d11bfe8 Mon Sep 17 00:00:00 2001
>> From: Fabien Proriol <fabien.proriol@jdsu.com>
>> Date: Mon, 17 Nov 2014 09:46:02 +0100
>> Subject: [PATCH] iio: Fix iio_channel_read return if channel havn't info
>>
>> iio_channel_read must return an error to avoid offset for channel
>> without IIO_CHAN_INFO_OFFSET property
>>
>> Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Thanks.
Hi

This patch appears to be against a relatively ancient kernel.
Would you mind rebasing it on linus' current tree?

Thanks,

Jonathan

> 
>> ---
>>   drivers/iio/inkern.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index 1e8e94d..917eb00 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -423,6 +423,9 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>>       if (val2 == NULL)
>>           val2 = &unused;
>>
>> +    if(!iio_channel_has_info(chan->channel, info))
Space after if.
>> +        return -EINVAL;
>> +
>>       return chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
>>                           val, val2, info);
>>   }
>>
> 

