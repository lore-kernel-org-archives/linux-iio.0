Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60090 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992509AbbHHSxs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 14:53:48 -0400
Subject: Re: [PATCH 1/2] tools: iio: Set caller's ci_array pointer to NULL
 after free
To: Joo Aun Saw <jasaw@dius.com.au>, Hartmut Knaack <knaack.h@gmx.de>
References: <1437751409-28837-1-git-send-email-jasaw@dius.com.au>
 <1437751409-28837-2-git-send-email-jasaw@dius.com.au>
 <55B28DB7.3050906@gmx.de>
 <CA+0Dg4oT6_RjUL9rBPCKdQ-PJpo-UoGUSSySEMT12LcYkHEYgQ@mail.gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C65038.6030402@kernel.org>
Date: Sat, 8 Aug 2015 19:53:44 +0100
MIME-Version: 1.0
In-Reply-To: <CA+0Dg4oT6_RjUL9rBPCKdQ-PJpo-UoGUSSySEMT12LcYkHEYgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/07/15 06:12, Joo Aun Saw wrote:
> On Sat, Jul 25, 2015 at 5:10 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>
>> Joo Aun Saw schrieb am 24.07.2015 um 17:23:
>>> From: Joo Aun Saw <jasaw@dius.com.au>
>>>
>>> On error, caller's ci_array is freed and set to NULL to avoid
>>> potential double free. Counter is reset to zero for consistency.
>>>
>>
>> Hi,
>> I don't see a second attempt to free the array. In here, just dp gets
>> closed and the scan_el_dir string freed.
>> And in generic_buffer.c where it is accessed in the main function, there
>> is a jump into the error handler in case of an error, which just frees a
>> few strings (datardytrigger, trigger_name and dev_dir_name).
>> Any opinion welcome.
>> Thanks,
>>
>> Hartmut
>>
> Currently, there is no second free attempt in those examples, but
> iio_utils is meant to be used as a library in the future, and
> therefore should not leave a dangling pointer (the caller owns the
> pointer in this case). There is no guarantee what other users of
> iio_utils might do. For example, a caller may have a single clean up
> routine that frees ALL pointers upon failure (to simplify error
> handling), and will encounter double free problem if this is not
> fixed. Additionally, it's good software engineering practice to set
> pointers to NULL after free because the caller may still reference it
> in the future.
Applied with a slight change to the description to say that this was
basically for convenience if some other user was being stupid (but
politer).  Setting pointers after free to null is part of 'some'
best practice.  Assuming that pointers can be anything
after a free is part of others (and by far the safer option).
Still no harm done and it's hardly a fast path.

Jonathan
> 
> Joo.
> 
>>> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
>>> ---
>>>  tools/iio/iio_utils.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>>> index 1dcdf03..8731905 100644
>>> --- a/tools/iio/iio_utils.c
>>> +++ b/tools/iio/iio_utils.c
>>> @@ -529,6 +529,8 @@ error_cleanup_array:
>>>               free((*ci_array)[i].generic_name);
>>>       }
>>>       free(*ci_array);
>>> +     *ci_array = NULL;
>>> +     *counter = 0;
>>>  error_close_dir:
>>>       if (dp)
>>>               if (closedir(dp) == -1)
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

