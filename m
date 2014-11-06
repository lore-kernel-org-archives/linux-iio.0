Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx0a-00158d01.pphosted.com ([208.84.65.189]:15318 "EHLO
	mx0a-00158d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877AbaKFQWN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 6 Nov 2014 11:22:13 -0500
From: Fabien Proriol <Fabien.Proriol@jdsu.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] 0001-xilinx-xadc-core-Fix-voltage-offset.patch
Date: Thu, 6 Nov 2014 16:18:24 +0000
Message-ID: <545B9EF1.8000606@jdsu.com>
References: <545B9479.5030700@jdsu.com> <545B976D.4080303@metafoo.de>
In-Reply-To: <545B976D.4080303@metafoo.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2014 16:44, Lars-Peter Clausen wrote:
> On 11/06/2014 04:33 PM, Fabien Proriol wrote:
>>   From 3f57e39e3c69476513c00cd5ec45703f58334972 Mon Sep 17 00:00:00 2001
>> From: Fabien Proriol <fabien.proriol@jdsu.com>
>> Date: Tue, 4 Nov 2014 17:05:59 +0100
>> Subject: [PATCH] xilinx-xadc-core: Fix voltage offset
>>
>> When xilinx-xadc is used with hwmon driver to read voltage, offset used
>> for temperature is always apply.
>> This patch change the return for IIO_CHAN_INFO_OFFSET to -EINVAL except
>> for temperature to avoid offset.
>
> I think we should rather fix iio_channel_read() to check if the 
> channel supports the property that we try to read. Other drivers are 
> likely to suffer from the same issue and fixing it in a central place 
> fixes them all.
>
> - Lars
>
>

Ok, I can propose this following patch.
With my xilinx-xadc driver, it fix also the same problem...

Fabien


 From d605db8de19687b7271e722aa1fa6028f1472a7b Mon Sep 17 00:00:00 2001
From: Fabien Proriol <fabien.proriol@jdsu.com>
Date: Thu, 6 Nov 2014 17:12:27 +0100
Subject: [PATCH] iio: Fix iio_channel_read return if channel havn't info

iio_channel_read must return an error to avoid offset for channel
without IIO_CHAN_INFO_OFFSET property

Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>
---
  drivers/iio/inkern.c | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1e8e94d..04cb23f 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -419,12 +419,20 @@ static int iio_channel_read(struct iio_channel 
*chan, int *val, int *val2,
         enum iio_chan_info_enum info)
  {
         int unused;
+       int ret;

         if (val2 == NULL)
                 val2 = &unused;

-       return chan->indio_dev->info->read_raw(chan->indio_dev, 
chan->channel,
+       if (!iio_channel_has_info(chan->channel, info)) {
+               ret = -EINVAL;
+               goto err;
+       }
+
+       ret = chan->indio_dev->info->read_raw(chan->indio_dev, 
chan->channel,
                                                 val, val2, info);
+err:
+       return ret;
  }

  int iio_read_channel_raw(struct iio_channel *chan, int *val)
-- 
2.0.4
