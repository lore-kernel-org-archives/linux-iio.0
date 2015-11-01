Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35255 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbKAArL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 20:47:11 -0400
Received: by lfbn126 with SMTP id n126so48751547lfb.2
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2015 17:47:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <563489F0.3000301@kernel.org>
References: <1445814438-17163-1-git-send-email-mranostay@gmail.com>
	<563489F0.3000301@kernel.org>
Date: Sat, 31 Oct 2015 17:47:09 -0700
Message-ID: <CAKzfze-oSF7V2ht-6GUYkRSjYRcCg2KK7ocf9vNXp=m5vN0EzQ@mail.gmail.com>
Subject: Re: [PATCH] iio: lidar: return -EIO on invalid signal
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Actually the INVALID status happens even it isn't out of range
sometimes roughly once every second or two. This can be from an
invalid second signal return path and etc..

So there are spurious zero readings from the triggered buffer, and
warning messages in the kernel log.

Thanks,

Matt

On Sat, Oct 31, 2015 at 2:29 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 25/10/15 23:07, Matt Ranostay wrote:
>> Returning zero from the measurment function has the side effect of
>> corrupting the triggered buffer readings, better to use -EIO than a
>> zero measurement reading.
> When you say 'corrupting' what do you mean?  As far as I can quickly see
> it will give a spurious 0 distance when it really means a long distance.
> Is that what you are referring to?
>
> Jonathan
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> index 961f9f99..359beac 100644
>> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> @@ -130,10 +130,10 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>>               if (ret < 0)
>>                       break;
>>
>> -             /* return 0 since laser is likely pointed out of range */
>> +             /* return -EIO since laser is likely pointed out of range */
>>               if (ret & LIDAR_REG_STATUS_INVALID) {
>>                       *reg = 0;
>> -                     ret = 0;
>> +                     ret = -EIO;
>>                       break;
>>               }
>>
>>
>
