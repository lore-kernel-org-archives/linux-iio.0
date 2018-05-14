Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33374 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENSi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 May 2018 14:38:27 -0400
Date: Mon, 14 May 2018 19:38:23 +0100
In-Reply-To: <437614c0-a3a8-304b-7dfb-dc90b290f0ea@invensense.com>
References: <20180501175642.8551-1-mkelly@xevo.com> <20180501175642.8551-3-mkelly@xevo.com> <20180506180816.4c15b826@archlinux> <f618c12b-2d79-c6e3-abfa-8c377f07640d@invensense.com> <20180512100412.7cdd58e6@archlinux> <437614c0-a3a8-304b-7dfb-dc90b290f0ea@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: make loop a do-while
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
CC: Martin Kelly <mkelly@xevo.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <602E11C5-9416-4BE0-890D-5581F28E6400@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 14 May 2018 08:36:58 BST, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>
>
>On 12/05/2018 11:04, Jonathan Cameron wrote:
>> CAUTION: This email originated from outside of the organization.
>Please make sure the sender is who they say they are and do not click
>links or open attachments unless you recognize the sender and know the
>content is safe.
>> 
>> 
>> On Tue, 8 May 2018 16:34:30 +0200
>> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>> 
>>> On 06/05/2018 19:08, Jonathan Cameron wrote:
>>>> On Tue,  1 May 2018 10:56:42 -0700
>>>> Martin Kelly <mkelly@xevo.com> wrote:
>>>>
>>>>> Prior to this loop, we check if fifo_count < bytes_per_datum and
>bail if
>>>>> so. This means that when we hit the loop, we know that fifo_count
>>=
>>>>> bytes_per_datum, so the check is unneeded and we can turn the loop
>into
>>>>> a do-while for a slight performance improvement.
>>>>>
>>>>> Signed-off-by: Martin Kelly <mkelly@xevo.com>
>>>> Seems logical to me, but I'd like to give Jean-Baptiste a chance
>>>> to comment on this one.
>>>>
>>>> If it looks like we have forgotten about it in a week or so do
>>>> give me a poke!
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>> Hello,
>>>
>>> no problem for me, looks good. Anyway, I'm planning additionnal
>changes
>>> that are going to change completely this loop.
>> Ah well, Applied anyway in the meantime.
>> 
>> Applied to the togreg branch of iio.git and pushed out as testing for
>the
>> autobuilders to play with it.
>> 
>> Thanks,
>> 
>> Jonathan
>Hello Jonathan,
>
>it's strange, I can't find this patch in the testing branch. Is it
>expected?
>
>Thanks.
>JB
That's usually a sure sign I have been a Muppet and forgotten to push.

Thanks, should be there now.



>
>> 
>>>
>>> JB
>>>>
>>>>> ---
>>>>>    drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>>>>> index 0cb7c20100ca..11593deaaebd 100644
>>>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>>>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>>>>> @@ -174,7 +174,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq,
>void *p)
>>>>>     if (kfifo_len(&st->timestamps) >
>>>>>         fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
>>>>>             goto flush_fifo;
>>>>> -  while (fifo_count >= bytes_per_datum) {
>>>>> +  do {
>>>>>             result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
>>>>>                                       data, bytes_per_datum);
>>>>>             if (result)
>>>>> @@ -188,7 +188,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq,
>void *p)
>>>>>             iio_push_to_buffers_with_timestamp(indio_dev, data,
>timestamp);
>>>>>
>>>>>             fifo_count -= bytes_per_datum;
>>>>> -  }
>>>>> +  } while (fifo_count >= bytes_per_datum);
>>>>>
>>>>>    end_session:
>>>>>     mutex_unlock(&st->lock);
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
