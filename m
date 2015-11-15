Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46184 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbbKOLT6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 06:19:58 -0500
Subject: Re: [PATCH] iio: light: apds9960: correct ->last_busy count
To: Matt Ranostay <mranostay@gmail.com>
References: <1446956488-8262-1-git-send-email-mranostay@gmail.com>
 <563F668D.7090804@kernel.org>
 <CAKzfze-dhPiOksAdnGW=FjS346LxZ66kFMd30OiRKRg6U57+rw@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56486A5D.6090100@kernel.org>
Date: Sun, 15 Nov 2015 11:19:57 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze-dhPiOksAdnGW=FjS346LxZ66kFMd30OiRKRg6U57+rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/15 21:23, Matt Ranostay wrote:
> On Sun, Nov 8, 2015 at 7:13 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 08/11/15 04:21, Matt Ranostay wrote:
>>> Add missing pm_runtime_mark_last_busy to apds9960_set_power_state
>>> function.
>>>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> Hi Matt,
>>
>> Could you elaborate on what the result of this not being there is?
>> My first thought is that this probably wants to go as a fix, but for
>> that I need details of what the effects of the 'bug' are.
> 
> Unless pm_runtime_mark_last_busy is called the
> pm_runtime_put_autosuspend may put the device into suspend before the
> delay time requested.
Have added this text to the commit message and applied to the
temporary branch
fixes-togreg-post-rc1 which should go out in a few days.

Jonathan
> 
> 
> Thanks,
> 
> Matt
> 
> 
>>
>> Jonathan
>>> ---
>>>  drivers/iio/light/apds9960.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
>>> index 7d269ef..f6a07dc 100644
>>> --- a/drivers/iio/light/apds9960.c
>>> +++ b/drivers/iio/light/apds9960.c
>>> @@ -453,6 +453,7 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
>>>                       usleep_range(data->als_adc_int_us,
>>>                                    APDS9960_MAX_INT_TIME_IN_US);
>>>       } else {
>>> +             pm_runtime_mark_last_busy(dev);
>>>               ret = pm_runtime_put_autosuspend(dev);
>>>       }
>>>
>>>
>>

