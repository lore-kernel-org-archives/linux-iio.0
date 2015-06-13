Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34738 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbbFMLLP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2015 07:11:15 -0400
Received: by qkdm188 with SMTP id m188so7960966qkd.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2015 04:11:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <557BFF3C.1060101@gmx.de>
References: <cover.1433721755.git.knaack.h@gmx.de>
	<52e7c9b1da4e0918722cc993bd3b25287f342e55.1433721755.git.knaack.h@gmx.de>
	<CAEnQRZALJLbyQ9e5_JVr5xi+kH+pEGfPDGisay+C=b0n9XJM8A@mail.gmail.com>
	<557BEB9D.2000800@gmx.de>
	<CAEnQRZBd-1YdFSkG9=3Zhh8K07VWte+2aEDL4ucDOjwtvjR_0Q@mail.gmail.com>
	<557BFF3C.1060101@gmx.de>
Date: Sat, 13 Jun 2015 14:11:14 +0300
Message-ID: <CAFA9rWPqf-eWmmbWdvgV=-bbgOnsequbY85wK_M3AYyMb1d4rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tools:iio:iio_event_monitor: check if event is
 fully read
From: Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jun 13, 2015 at 1:00 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Daniel Baluta schrieb am 13.06.2015 um 10:46:
>> On Sat, Jun 13, 2015 at 11:36 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>> Daniel Baluta schrieb am 10.06.2015 um 22:16:
>>>> On Wed, Jun 10, 2015 at 10:51 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>>>> Check that the read event is of the expected size.
>>>>>
>>>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>>>> ---
>>>>>  tools/iio/iio_event_monitor.c | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>>>>> index 016760e..2559fba 100644
>>>>> --- a/tools/iio/iio_event_monitor.c
>>>>> +++ b/tools/iio/iio_event_monitor.c
>>>>> @@ -299,6 +299,12 @@ int main(int argc, char **argv)
>>>>>                         }
>>>>>                 }
>>>>>
>>>>> +               if (ret != sizeof(event)) {
>>>>> +                       printf("Reading event failed!\n");
>>>>> +                       ret = -EIO;
>>>>> +                       break;
>>>>> +               }
>>>>> +
>>>>
>>>> For a test program this should be good enough, not sure if it does make sense
>>>> to read until we get all data.
>>>
>>> Not sure, if I get your intention here. But as Jonathan suggested, something
>>> went seriously wrong, if the sizes don't match here. Reading further, until
>>> the desired size is reached could result in receiving the missing data, or
>>> getting already partial data from the next event. I would leave it as is for
>>> now and see if anyone ever gets this error. Then we can still dig deeper.
>>
>> Ok.
>>
>>>
>>>>
>>>> Also, we should print the error at stderr.
>>>>
>>>
>>> I basically agree on this one, but since the majority of the error messages
>>> in this file are currently just printed to stdout, I would prefer to take it
>>> as is (for consistency) and have a follow-up patch to send all error messages
>>> to stderr.
>>
>> I've also noticed this. So I agree with you, a follow up patch would be better.
>>
>> Cristina can do this, if you haven't already started working on it.
>>
>
> Sounds good to me. I would have waited with such changes until this set got
> applied, anyway.

Ok then, I'll wait until this patchset gets applied and then make the
requested changes.

>> As a part of Outreachy Program [1] we are also investigating these user space
>> tools plus the IIO dummy driver which hopefully at the end it will be moved
>> out of staging.
>>
>
> From my experience so far, I would regard it a good idea to chop up the
> workflow to get code out of staging:
>   - get all the changes you have in mind applied
>   - announce your intention to move it out in a reasonable time (2 weeks?), so
>     people who mind will feel pressured to have a look at the code and fix
>     issues in staging
>   - move out smoothly ;-)
>
> Also, making use of gits copy detection is a good idea to avoid huge patches,
> which basically just copy/move a file without changes. Makes the reviewers
> life much easier ;-)

Thanks for the tip, I'll make sure to use it when appropriate.

Cristina

> Thanks,
> Hartmut
>
>>
>> Daniel.
>>
>> [1] http://kernelnewbies.org/OutreachyIntro
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
