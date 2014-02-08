Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41330 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaBHMHr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 07:07:47 -0500
Message-ID: <52F61E31.6050909@kernel.org>
Date: Sat, 08 Feb 2014 12:08:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC]iio:industrialio-event fix error-handling in iio_device_add_event
References: <52C00D75.70302@gmx.de> <52C40E53.1040906@kernel.org> <52F57539.7070903@gmx.de> <52F60388.1050606@kernel.org> <52F6185D.1040507@gmx.de>
In-Reply-To: <52F6185D.1040507@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/14 11:43, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>>
>> On 08/02/14 00:07, Hartmut Knaack wrote:
>>> Jonathan Cameron schrieb:
>>>> On 29/12/13 11:54, Hartmut Knaack wrote:
>>>>> __iio_add_chan_devattr returns -EBUSY, when registering the event-interface of
>>>>> ad799x, but iio_device_add_event does not catch it. So, handle it like in
>>>>> iio_device_add_info_mask_type. Not sure, if this is the right solution, but it
>>>>> makes the ad799x (and possibly others as well) usable.
>>>>>
>>>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>>> I think the fix is correct, but I'm not entirely sure what is triggering
>>>> the bug in this particular driver. All of the elements of ad799x_events
>>>> are in mask separate so shared_by should be IIO_SEPARATE for all calls
>>>> to this function.
>>>>
>>>> Lars, any idea's on what Hartmut is hitting?
>>>> Also, is the below patch as valid as it appears at first glance?
>>> I've been digging a bit more into the event interface registration,
>>> and it turned out that the problem is a typo in the ad799x driver. A
>>> patch is on the way. While debugging, I always encountered crashes of
>>> my machine, about 15 seconds after the device-initialization failed.
>>> You can find a short video of the screen capture at [1]. This was
>>> taken on a Linux 3.13.1 (with slight changes to ad799x_core.c for
>>> working without platform_data and fix the irq-issue). Any ideas,
>>> where to start looking for that problems?
>> Not a clue I'm afraid.  I guess we need to do some failure case testing.
>> Entirely plausible there are some issues hiding in the more obscure paths.
>>
>>> Besides, I'm a bit confused
>>> with all the branches of the iio.git repo. Which one shall be used,
>>> when developing for the iio subsystem (that contains all the patches
>>> you accepted)?
>> Unfortunately there is never a one true branch for new development.  It is
>> in the nature of maintainers trees that there are almost always two branches.
>> The first is for fixes for the current kernel version that is going through
>> release candidates (fixes-to-greg, though occasionally I have extra branches
>> around the merge window to separate out different dependencies).
>> New work for the next merge window sits in the togreg branch.  This 'typically'
>> goes upstream into staging-next every week or two and from there into linux-next.
>>
>> The key thing is that patches should not be in both the fixes branch and the new
>> stuff (togreg) branch.  They should only come together futher upstream - typically
>> first in linux-next and a week or so later in staging-next depending on cross
>> dependencies.
>>
>> The other branch that is commonly used in the iio.git tree is testing.  That exists
>> purely to allow the autobuilders to run on a branch that I am happy to rebase.
>> I try never to rebase the other trees though it can happen if I mess something
>> up spectacularly.
>>
>> I should probably have started with the short answer.  Unless you are depending on
>> new stuff coming through, the best bet is to either base on Linus' tree (usually
>> the last rc to have been tagged), or staging/staging-next.  If you are basing on
>> one of the iio.git branches, then fixes that need to go through fast should be
>> on the fixes-to-greg branch, or if that's lagging too much as it was until 2 mins
>> ago (this happens around merge windows), then base on whereever is most relevant.
>> The upshot is that all patches in all trees will go upstream at somepoint, its just
>> a case of ordering.
>>
>> Hmm.. I'm sure that's as clear as mud.
>>
>> Jonathan
> Thanks, I appreciate your detailed explanation. There is another
> thing I would like to get your comment about: When reading through
> the code, I noticed in some functions if an error-check was positive,
> the return variable got the error code and then there is a "goto
> error_ret", which returns the return variable. According to my
> understanding of good coding practice, if an error occurs, the
> function should return the error code as quick as possible. So, is
> this structure intentional? And how are the chances, that a clean-up
> of these occurrences get applied? Thanks
Yes. The gotos are a bit of historical mess that we are 'slowly' getting
rid of.   They should be there if there is any clean up to do (releasing locks
etc).  Otherwise they should not.  Some are left over from devm conversions
which have gotten rid of their original purpose.

I'm happy to take patches with this sort of cleanup.


>
> Hartmut
>>> [1] http://www.upitus.net/36zhlrijl9lh
>>>>> ---
>>>>> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
>>>>> index c10eab6..d37a907 100644
>>>>> --- a/drivers/iio/industrialio-event.c
>>>>> +++ b/drivers/iio/industrialio-event.c
>>>>> @@ -362,7 +362,9 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>>>>>     			&indio_dev->event_interface->dev_attr_list);
>>>>>     		kfree(postfix);
>>>>>
>>>>> -		if (ret)
>>>>> +		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
>>>>> +			continue;
>>>>> +		else if (ret < 0)
>>>>>     			return ret;
>>>>>
>>>>>     		attrcount++;
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

