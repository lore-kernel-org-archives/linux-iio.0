Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43034 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbeGKN2f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jul 2018 09:28:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so18196281wrv.10
        for <linux-iio@vger.kernel.org>; Wed, 11 Jul 2018 06:24:14 -0700 (PDT)
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: irq not handled unless data pushed
 to buffers
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <1531297928-3824-1-git-send-email-jramirez@baylibre.com>
 <20180711122953.GC3871@localhost.localdomain>
From: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Message-ID: <2d1f0810-a6d0-3785-6692-003bb3f817e0@baylibre.com>
Date: Wed, 11 Jul 2018 15:24:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180711122953.GC3871@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/11/2018 02:29 PM, Lorenzo Bianconi wrote:
>> Currently IRQ_NONE is returned only when there is no data on the fifo.
>>
>> When there is no data on the fifo the driver can not push to the
>> buffers and therefore user space readers polling for data available
>> will not be awoken and continue to wait.
>>
>> This commit just extends the same semantics to fifo read errors.
> Hi Jorge,
>
> IRQ_NONE is used to indicate this interrupt is not intended for this driver
> (this could happen if the irq line is in open-drain). If the interrupt is for
> st_lsm6dsx I would prefer to return IRQ_HANDLED even in case of error.

yes I understand.

This was just a trivial attempt (I guess a really bad idea) to get some 
debug info (via /proc/irq/.../spurious) any time the driver read 
(spi/i2c) fails when processing the data ready irq.
do you think it would make sense to add a dev_err to 
st_lsm6dsx_i2c_read/st_lsm6dsx_spi_read? at the moment the driver would 
fail silently

thanks for coming back to me despite the bad patch

>
> Regards,
> Lorenzo
>
>> Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
>> ---
>>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> index 4994f92..4959923 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> @@ -472,7 +472,7 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>>   	count = st_lsm6dsx_read_fifo(hw);
>>   	mutex_unlock(&hw->fifo_lock);
>>   
>> -	return !count ? IRQ_NONE : IRQ_HANDLED;
>> +	return (!count || count < 0) ? IRQ_NONE : IRQ_HANDLED;
>>   }
>>   
>>   static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
>> -- 
>> 2.7.4
>>

