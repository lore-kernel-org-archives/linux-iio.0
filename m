Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47446 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbKASbs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2015 13:31:48 -0500
Subject: Re: [PATCH] iio: lidar: return -EIO on invalid signal
To: Matt Ranostay <mranostay@gmail.com>
References: <1445814438-17163-1-git-send-email-mranostay@gmail.com>
 <563489F0.3000301@kernel.org>
 <CAKzfze-oSF7V2ht-6GUYkRSjYRcCg2KK7ocf9vNXp=m5vN0EzQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56365A92.8060400@kernel.org>
Date: Sun, 1 Nov 2015 18:31:46 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze-oSF7V2ht-6GUYkRSjYRcCg2KK7ocf9vNXp=m5vN0EzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/11/15 00:47, Matt Ranostay wrote:
> Actually the INVALID status happens even it isn't out of range
> sometimes roughly once every second or two. This can be from an
> invalid second signal return path and etc..
> 
> So there are spurious zero readings from the triggered buffer, and
> warning messages in the kernel log.
Thanks for the clarification.  I've added a version of this response
to the patch description and applied to the fixes-togreg-post-rc1
branch I'm running at the moment as we have a few outstanding fixes
for stuff going in during the merge window that is opening very soon.

> 
> Thanks,
> 
> Matt
> 
> On Sat, Oct 31, 2015 at 2:29 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 25/10/15 23:07, Matt Ranostay wrote:
>>> Returning zero from the measurment function has the side effect of
>>> corrupting the triggered buffer readings, better to use -EIO than a
>>> zero measurement reading.
>> When you say 'corrupting' what do you mean?  As far as I can quickly see
>> it will give a spurious 0 distance when it really means a long distance.
>> Is that what you are referring to?
>>
>> Jonathan
>>>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>> ---
>>>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> index 961f9f99..359beac 100644
>>> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> @@ -130,10 +130,10 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>>>               if (ret < 0)
>>>                       break;
>>>
>>> -             /* return 0 since laser is likely pointed out of range */
>>> +             /* return -EIO since laser is likely pointed out of range */
>>>               if (ret & LIDAR_REG_STATUS_INVALID) {
>>>                       *reg = 0;
>>> -                     ret = 0;
>>> +                     ret = -EIO;
>>>                       break;
>>>               }
>>>
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

