Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34787 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756987AbcJPRwT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2016 13:52:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id f6so5469067qtd.1
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2016 10:52:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e53b4e7-6529-f120-29aa-f0ab20d0a353@kernel.org>
References: <1476554677-1777-1-git-send-email-matt@ranostay.consulting> <4e53b4e7-6529-f120-29aa-f0ab20d0a353@kernel.org>
From: Matt Ranostay <matt@ranostay.consulting>
Date: Sun, 16 Oct 2016 10:52:18 -0700
Message-ID: <CAJ_EiSQ7UKS6ZacpcgXmmOrzUM+O6jvSX6t201d6nw9ru_-+MA@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: pulsedlight-lidar-lite-v2: cleanup power management
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Oct 16, 2016 at 6:41 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 15/10/16 19:04, Matt Ranostay wrote:
>> Remove pm_runtime_mark_last_busy() call that wasn't need in the probe
>> since the device should be put to sleep
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Hi Matt,
>
> I don't really follow what you are addressing here.
> Is the point that without this call it will suspend immediately?
> I could figure this out from the pm docs based on a quick skim
> read.
>
> Or is it simply that the pm_runtime_idle call following it
> will suspend immediately whatever this value contains?

Basically it going to be suspended once pm_runtime_idle() is called,
and setting the last busy is useless and not needed.
Clearly this doesn't affect the device running but just makes the code
more consistent with other uses.

>
>
> Jonathan
>> ---
>>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> index 3141c3c161bb..1fa9eefa0982 100644
>> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> @@ -301,8 +301,6 @@ static int lidar_probe(struct i2c_client *client,
>>       if (ret)
>>               goto error_unreg_buffer;
>>       pm_runtime_enable(&client->dev);
>> -
>> -     pm_runtime_mark_last_busy(&client->dev);
>>       pm_runtime_idle(&client->dev);
>>
>>       return 0;
>>
>
