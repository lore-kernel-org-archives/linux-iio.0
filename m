Return-Path: <lars@metafoo.de>
Message-ID: <4EEE4315.1080200@metafoo.de>
Date: Sun, 18 Dec 2011 20:46:29 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH 1/4] staging:iio: Factor out event handling into its own
 file
References: <1324055542-31272-1-git-send-email-lars@metafoo.de> <4EEE2E9E.7070102@kernel.org> <4EEE2FC3.5000705@kernel.org>
In-Reply-To: <4EEE2FC3.5000705@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/18/2011 07:24 PM, Jonathan Cameron wrote:
> On 12/18/2011 06:19 PM, Jonathan Cameron wrote:
>> On 12/16/2011 05:12 PM, Lars-Peter Clausen wrote:
>>> The core iio file has gotten quite cluttered over time. This patch moves
>>> the event handling code into its own file.
>> A small comment here wrt to ease of review. When doing
>> a whole scale move like this, it is helpful to state
>> where any necessary code changes were... That way I can
>> just assume you cut and paste the rest rather than having
>> to check that.
>>>
>>> This has also the advantage that industrialio-core.c is now closer again to
>>> its counterpart in the outofstaging branch.
>> Definitely in favour of this change.
>>
>> Assuming it isn't in a later patch, there are a few undocumented
>> structure elements that could do with documenting ;)
>> More 'interestingly' there are a few that don't exist and are
>> documented.  All my fault of course, but seeing as you are
>> cleaning this code up... (looks hopeful)
>> Obviously shouldn't be part of this patch.  Either insert
>> one fixing it first, or do it at the end as a cleanup patch.
>>
>> So all in all, the patch is fine, I just noticed some unrelated bits
>> whilst reading it ;)  Events as you have no doubt noticed are
>> probably our most dubious corner (or were until this set).
>>>
> I really ought not to leave my build tests running in the background
> whilst sending emails acking things.  Looks like you have some issues...
> 
> drivers/staging/iio/industrialio-event.c:84:17: error: undefined
> identifier 'TASK_INTERRUPTIBLE'
> drivers/staging/iio/industrialio-event.c:114:23: error: undefined
> identifier 'TASK_INTERRUPTIBLE'
> drivers/staging/iio/industrialio-event.c:114:23: error: undefined
> identifier 'signal_pending'
> drivers/staging/iio/industrialio-event.c:114:23: error: undefined
> identifier 'schedule'
> 
> Can't chase this down right now, but I'm guessing missing header
> at least on arm.
> 
> adding include of sched.h does the job.

Makes me wonder if wait.h should include sched.h. But I'll add it the this
patch as well.
