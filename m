Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54173 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbcJVSou (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 14:44:50 -0400
Subject: Re: [PATCH] iio: proximity: pulsedlight-lidar-lite-v2: cleanup power
 management
To: Matt Ranostay <matt@ranostay.consulting>
References: <1476554677-1777-1-git-send-email-matt@ranostay.consulting>
 <4e53b4e7-6529-f120-29aa-f0ab20d0a353@kernel.org>
 <CAJ_EiSQ7UKS6ZacpcgXmmOrzUM+O6jvSX6t201d6nw9ru_-+MA@mail.gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fe5ce635-65a5-5b72-db3c-86c9f7cfca21@kernel.org>
Date: Sat, 22 Oct 2016 19:44:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ_EiSQ7UKS6ZacpcgXmmOrzUM+O6jvSX6t201d6nw9ru_-+MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/10/16 18:52, Matt Ranostay wrote:
> On Sun, Oct 16, 2016 at 6:41 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 15/10/16 19:04, Matt Ranostay wrote:
>>> Remove pm_runtime_mark_last_busy() call that wasn't need in the probe
>>> since the device should be put to sleep
>>>
>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Hi Matt,
>>
>> I don't really follow what you are addressing here.
>> Is the point that without this call it will suspend immediately?
>> I could figure this out from the pm docs based on a quick skim
>> read.
>>
>> Or is it simply that the pm_runtime_idle call following it
>> will suspend immediately whatever this value contains?
> 
> Basically it going to be suspended once pm_runtime_idle() is called,
> and setting the last busy is useless and not needed.
> Clearly this doesn't affect the device running but just makes the code
> more consistent with other uses.

I added a quote of this to the patch description and applied.

Thanks,

Jonathan
> 
>>
>>
>> Jonathan
>>> ---
>>>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> index 3141c3c161bb..1fa9eefa0982 100644
>>> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> @@ -301,8 +301,6 @@ static int lidar_probe(struct i2c_client *client,
>>>       if (ret)
>>>               goto error_unreg_buffer;
>>>       pm_runtime_enable(&client->dev);
>>> -
>>> -     pm_runtime_mark_last_busy(&client->dev);
>>>       pm_runtime_idle(&client->dev);
>>>
>>>       return 0;
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

