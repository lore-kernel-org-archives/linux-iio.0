Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57831 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2993409AbdDZFEH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 01:04:07 -0400
Subject: Re: [PATCH] iio: inkern: fix a static checker error
To: Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1492722117-19618-1-git-send-email-peda@axentia.se>
 <9b2138e1-11a1-a923-4c9c-7091b3e54f99@metafoo.de>
 <7b6ad5b7-a538-9007-8981-f36f9877a8e3@axentia.se>
 <60934fcd-214e-3618-84ff-46484197e737@axentia.se>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <809cc676-36fe-0c54-466d-541979af2d08@kernel.org>
Date: Wed, 26 Apr 2017 06:04:00 +0100
MIME-Version: 1.0
In-Reply-To: <60934fcd-214e-3618-84ff-46484197e737@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/17 10:32, Peter Rosin wrote:
> On 2017-04-20 23:13, Peter Rosin wrote:
>> On 2017-04-20 23:12, Lars-Peter Clausen wrote:
>>> On 04/20/2017 11:01 PM, Peter Rosin wrote:
>>>> Avoid this smatch error:
>>>> drivers/iio/inkern.c:751 iio_read_avail_channel_raw() error: double unlock 'mutex:&chan->indio_dev->info_exist_lock'
>>>
>>> Looks good, but it's not just the smatch error, this is a real issue. This
>>> even seems to be a endless loop, always jumping back to err_unlock.
>>
>> Yes, it should probably go to stable too...
> 
> Nope, not an endless loop, but I of course only noticed after sending
> a v2 [1] which falsely stated just that. Ignore that v2 patch and take
> this one instead, for the reasons stated in my followup [2] to that
> message.
> 
> Involving stable is probably not needed either...
Applied to the togreg branch of iio.git.  Thanks,

Jonathan
> 
> Cheers,
> peda
> 
> [1] https://lkml.org/lkml/2017/4/24/179
> [2] https://lkml.org/lkml/2017/4/24/221
> 
>>>>
>>>> Fixes: 00c5f80c2fad ("iio: inkern: add helpers to query available values from channels")
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>
>>>> ---
>>>>  drivers/iio/inkern.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>>>> index 7a13535dc3e9..a3941bade6a7 100644
>>>> --- a/drivers/iio/inkern.c
>>>> +++ b/drivers/iio/inkern.c
>>>> @@ -750,11 +750,9 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
>>>>  err_unlock:
>>>>  	mutex_unlock(&chan->indio_dev->info_exist_lock);
>>>>  
>>>> -	if (ret >= 0 && type != IIO_VAL_INT) {
>>>> +	if (ret >= 0 && type != IIO_VAL_INT)
>>>>  		/* raw values are assumed to be IIO_VAL_INT */
>>>>  		ret = -EINVAL;
>>>> -		goto err_unlock;
>>>> -	}
>>>>  
>>>>  	return ret;
>>>>  }
>>>>
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

