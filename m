Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:16040
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750960AbeEUSmu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 May 2018 14:42:50 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: advertise max and min freqs
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org
References: <20180515215349.27482-1-mkelly@xevo.com>
 <379508e0-0e27-6df6-f29d-1f892745c606@invensense.com>
 <356e12db-bddc-69c2-e3a3-3c9eb7adcef2@xevo.com>
 <20180520112838.3149f0f1@archlinux>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <90c03965-09d1-ebd0-1990-d8306815d41e@xevo.com>
Date: Mon, 21 May 2018 11:42:42 -0700
MIME-Version: 1.0
In-Reply-To: <20180520112838.3149f0f1@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/20/2018 03:28 AM, Jonathan Cameron wrote:
> On Wed, 16 May 2018 09:07:53 -0700
> Martin Kelly <mkelly@xevo.com> wrote:
> 
>> On 05/16/2018 12:51 AM, Jean-Baptiste Maneyrol wrote:
>>>
>>>
>>> On 15/05/2018 23:53, Martin Kelly wrote:
>>>> CAUTION: This email originated from outside of the organization.
>>>> Please make sure the sender is who they say they are and do not click
>>>> links or open attachments unless you recognize the sender and know the
>>>> content is safe.
>>>>
>>>>
>>>> Currently, we allow a minimum FIFO rate of 4 and a max of 1000, but we
>>>> advertise down to only 10 and up to 1000. Expand the advertised range to
>>>> reflect the full available range.
>>>>
>>>> Signed-off-by: Martin Kelly <mkelly@xevo.com>
>>>> ---
>>>>    drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>>> index 43fba5f7532b..3f4862f09db3 100644
>>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>>> @@ -799,7 +799,7 @@ static const struct iio_chan_spec
>>>> inv_mpu_channels[] = {
>>>>    };
>>>>
>>>>    /* constant IIO attribute */
>>>> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
>>>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4 10 20 50 100 200 500 1000");
>>>>    static IIO_CONST_ATTR(in_anglvel_scale_available,
>>>>                                             "0.000133090 0.000266181
>>>> 0.000532362 0.001064724");
>>>>    static IIO_CONST_ATTR(in_accel_scale_available,
>>>> -- 
>>>> 2.11.0
>>>>   
>>>
>>> Hello,
>>>
>>> in fact we advertise only frequencies that are supported by the low-pass
>>> filter. Filter bandwidths are: 5Hz, 10Hz, 20Hz, 42Hz (~50), 98Hz (~100),
>>> 188Hz (~200), which are corresponding to a sampling rate of (x2): 10Hz,
>>> 20Hz, ~50Hz, ~200Hz, ~400Hz. Only 500Hz is a little out of specs, since
>>> 400Hz is not a possible frequency.
>>>
>>> You can always set the frequency to any supported values, but you can
>>> suffer from aliasing.
>>>
>>> I strongly suggest we just keep it like it is today. Better not
>>> advertise frequencies that are not correctly filtered.
>>>
>>> JB
>>
>> OK, that makes sense and is fine with me. Perhaps I should instead just
>> add a comment explaining the situation, since I couldn't tell from the
>> code itself.
> Hmm. If this wasn't already the case I would advocate never allowing the
> user to pick frequencies where the device effectively won't work properly.
> 
> Ah well, too late now as they are in the ABI.  Agreed a comment would
> avoid anyone trying to figure this out in future.
> 
> Jonathan
> 

OK, I sent a patch adding an explanatory comment.
