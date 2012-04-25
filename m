Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48534 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab2DYPDX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 11:03:23 -0400
Message-ID: <4F981239.8080902@cam.ac.uk>
Date: Wed, 25 Apr 2012 16:03:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/14] IIO: Move from staging to drivers/iio
References: <1335096819-19565-1-git-send-email-jic23@kernel.org> <4F97BD2E.40706@metafoo.de> <4F97CC11.8010006@cam.ac.uk> <4F97E465.1070802@metafoo.de>
In-Reply-To: <4F97E465.1070802@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/25/2012 12:47 PM, Lars-Peter Clausen wrote:
> On 04/25/2012 12:04 PM, Jonathan Cameron wrote:
>> On 4/25/2012 10:00 AM, Lars-Peter Clausen wrote:
>>> On 04/22/2012 02:13 PM, Jonathan Cameron wrote:
>>>> Hi All,
>>>>
>>>> This series is mostly what was discussed in
>>>> IIO: move out of staging plan.
>>>>
>>>> It sits on top of the series
>>>> Staging:iio: Cleanup and refactor pre multibuffer.
>>>> which has gone to Greg already.
>>>>
>>>> However, a few things I'd neglected there came up and occur
>>>> before the final 3 patches that actually do the main movement.
>>>> Basically if we had just done the move we would have introduced
>>>> selection of elements not in staging by driver in staging.  This
>>>> breaks the rule that code in staging should not effect any that
>>>> isn't.  Hence I've flipped all the selects to the equivalent
>>>> depends on lines.
>>> I think the rule is that non-staging code should not depend on staging code,
>>> but I haven't heard yet that staging code shouldn't select non-staging.
>> Look around there are quite a few drivers already selecting elements that
>> aren't
>> in staging so I guess it's not an issue.  Will revert this change.
>>> E.g. there is a lot of infrastructure and helper code which is not user
>>> selectable. Not allowing this to be selected by staging drivers would make
>>> those helper functions inaccessible to it. Most of lib/ for example.
>>>
>>> And I think at least the buffer implementations falls into this category.
>>> There is no point of including them in the kernel image, if we have no
>>> driver using them. And in fact all except one driver do select them instead
>>> of depending on them. I think the best is to make them non user selectable
>>> and let drivers which need them depend on them.
>> Take into account that we don't actually want to go out of our way to stop
>> people building drivers out of tree.  So I'd rather keep these user
>> selectable if
>> nothing needs them.
> In my opinion the rule of thumb should be to either let Kconfig items be
> user-selectable and let drivers depend on them or let them be
> non-user-selectable and let drivers select them, but ok.
Would be nice... maybe we'll make this decision sometime in the future...
>
>>> Triggers are a bit of a different story here. While all drivers select them
>>> instead of depending on them there is also a different group which depends
>>> on the trigger infrastructure. Namely the standalone trigger implementations.
>>>
>>> But with a dependency like 'depends on !IIO_BUFFER || IIO_TRIGGER' the
>>> driver will be available without IIO_BUFFER being select or when both
>>> IIO_BUFFER and IIO_TRIGGER are selected, but not if IIO_BUFFER is selected
>>> and not IIO_TRIGGER. This is a bit confusing in my opinion.
>>>
>>> One way to solve this would be to make IIO_BUFFER and IIO_TRIGGER more
>>> tightly coupled. In reality we never really use one without the other, so
>>> there is not much gain from making them selectable independently and may
>>> even cause some confusion.
>> We do use the separately in all hardware buffers.  There triggers often
>> don't have
>> any meaning (or at least we can't get to them so no point in exposing
>> userspace interfaces).
> I meant the generic trigger infrastructure (i.e. everything that's pulled in
> by IIO_TRIGGER), not the individual trigger implementations. I think there
> is only one driver with buffer support which does not depend on IIO_TRIGGER
> (or selects it).
Probably true, but there are a few drivers that should be in this state 
and aren't either
because they don't support buffers or do it horribly wrong (the impact 
sensor under
accel for starters with it's horrible binary sysfs files).
>
>
>>> But for now we can just make the buffer implementation of drivers which have
>>> optional buffer support depend on both IIO_BUFFER and IIO_TRIGGER.
>>>
>>> i.e. 's/#ifdef CONFIG_IIO_BUFFER/if defined(CONFIG_IIO_BUFFER)&&
>>> defined(CONFIG_IIO_TRIGGER)'
>>>
>>> I can take care of this if you want to.
>> That would indeed be cleaner than the current stack of selects.  Would be
>> great if
>> you can do this.
>>
>> So I'll drop my select->depends patches and move on with the rest of the move.
>> Clearly the change you suggest can stand separately anyway.
> I think it is still worth converting 'select IIO_BUFFER' to 'depends
> IIO_BUFFER'.
Sounds reasonable, but given the stage we are at in the merge cycle I've 
left this for
now.
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

