Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56740 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab3IULJL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:09:11 -0400
Message-ID: <523D8C7B.1050205@kernel.org>
Date: Sat, 21 Sep 2013 13:09:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/10] iio:buffer: Add proper locking for iio_update_buffers()
References: <1379534574-11213-1-git-send-email-lars@metafoo.de> <1379534574-11213-9-git-send-email-lars@metafoo.de> <523A0CCE.3010003@metafoo.de> <523D8A27.4010403@kernel.org> <523D7D79.4070206@metafoo.de>
In-Reply-To: <523D7D79.4070206@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/21/13 12:05, Lars-Peter Clausen wrote:
> On 09/21/2013 01:59 PM, Jonathan Cameron wrote:
>> On 09/18/13 21:27, Lars-Peter Clausen wrote:
>>> [...]
>>>> +int iio_update_buffers(struct iio_dev *indio_dev,
>>>> +               struct iio_buffer *insert_buffer,
>>>> +               struct iio_buffer *remove_buffer)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    mutex_lock(&indio_dev->info_exist_lock);
>>>> +    mutex_lock(&indio_dev->mlock);
>>>> +
>>>> +    if (indio_dev->info == NULL)
>>>> +        return -ENODEV;
>>>
>>> Yea, ok that happens when send patches way to late in the evening. Of course we still need to unlock here...
>> Any reason not to do the indio_dev->info test before locking in the first place?
> 
> The check and the updating needs to happen in one atomic step, otherwise the updating might race against the
> iio_disable_all_buffers in the iio_device_unregister function.
Ah, gotcha.  Could you add a trivial comment for idiots like me pointing that out :)
> 
>>>
>>>> +    ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
>>>> +
>>>> +    mutex_unlock(&indio_dev->mlock);
>>>> +    mutex_unlock(&indio_dev->info_exist_lock);
>>>> +
>>>> +    return ret;
>>>> +}
>>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
