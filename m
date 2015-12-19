Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56172 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932811AbbLSQjZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 11:39:25 -0500
Subject: Re: [PATCH 1/3] iio: light: us5182d: Fix enable status inconcistency
To: Adriana Reus <adriana.reus@intel.com>
References: <1449661244-18692-1-git-send-email-adriana.reus@intel.com>
 <1449661244-18692-2-git-send-email-adriana.reus@intel.com>
 <566C35F3.408@kernel.org> <566E88B5.4080104@intel.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5675883C.2060202@kernel.org>
Date: Sat, 19 Dec 2015 16:39:24 +0000
MIME-Version: 1.0
In-Reply-To: <566E88B5.4080104@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/12/15 09:15, Adriana Reus wrote:
> 
> 
> On 12.12.2015 16:57, Jonathan Cameron wrote:
>> On 09/12/15 11:40, Adriana Reus wrote:
>>> When setting als only or proximity only modes make sure that we mark the other
>>> component as disabled.
>>>
>>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>> Hi Adriana
>>
>> When you send a fix of any type, please describe the effects of the bug.
>> That way I have more information to figure out if the bug is tidying up
>> a loose end or fixing a critical bug and hence judge which path it takes
>> to upstream.
> Long story short it's a tidy up that prevents a bug that would occur
> once events are added (patch 2 of this series adds events). The exact
> use case is: if user polls proximity px_enabled will be set to true,
> user then polls als, and sets the mode to ALS_ONLY, while px_enabled
> wrongfully remains true, at this point if events are enabled proximity
> won't actually get to be enabled in the chip and will not deliver
> events. For this reason it has to be applied before or at the same time
> with the patch that adds events and interrupt support.

Thanks
>>
>> Please let me know for this one as I can't immediately pick out what the
>> effects will be.
>>
>> Jonathan
>>> ---
>>>   drivers/iio/light/us5182d.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
>>> index 256c4bc..f24b687 100644
>>> --- a/drivers/iio/light/us5182d.c
>>> +++ b/drivers/iio/light/us5182d.c
>>> @@ -238,8 +238,12 @@ static int us5182d_als_enable(struct us5182d_data *data)
>>>       int ret;
>>>       u8 mode;
>>>
>>> -    if (data->power_mode == US5182D_ONESHOT)
>>> -        return us5182d_set_opmode(data, US5182D_ALS_ONLY);
>>> +    if (data->power_mode == US5182D_ONESHOT) {
>>> +        ret = us5182d_set_opmode(data, US5182D_ALS_ONLY);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        data->px_enabled = false;
>>> +    }
>>>
>>>       if (data->als_enabled)
>>>           return 0;
>>> @@ -260,8 +264,12 @@ static int us5182d_px_enable(struct us5182d_data *data)
>>>       int ret;
>>>       u8 mode;
>>>
>>> -    if (data->power_mode == US5182D_ONESHOT)
>>> -        return us5182d_set_opmode(data, US5182D_PX_ONLY);
>>> +    if (data->power_mode == US5182D_ONESHOT) {
>>> +        ret = us5182d_set_opmode(data, US5182D_PX_ONLY);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        data->als_enabled = false;
>>> +    }
>>>
>>>       if (data->px_enabled)
>>>           return 0;
>>>
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

