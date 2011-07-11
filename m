Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E1B27C9.7060404@cam.ac.uk>
Date: Mon, 11 Jul 2011 17:41:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Splitting trigger header in two and barriers.
References: <4E1B1BF9.4000707@cam.ac.uk> <4E1B2001.2030409@cam.ac.uk>
In-Reply-To: <4E1B2001.2030409@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/11/11 17:08, Jonathan Cameron wrote:
> On 07/11/11 16:51, Jonathan Cameron wrote:
>> Hi All,
>>
>> The trigger.h file merges elements I'd really rather were separate.
>> There are some parts that belong to drivers acting as consumers
>> and others to those acting as producers of triggers.
>> In a few cases  (e.g. lis3l02dq_ring.c) the consumer and trigger
>> are in the same file, but in many others the driver only supports
>> one or the other or has them in separate source files.
>>
>> The main block to this bit of reorganization ist that some drivers
>> explicitly put the trigger and detach from it in their 'ring cleanup'
>> functions (see ad7298_ring.c ad7298_ring_cleanup.)
>>
>> My original intent was that if a trigger had not been detached from
>> in userspace, it would not be possible to remmove the driver, so
>> no cleanup would occur. (basically it counts as being 'in use').
>>
>> Is there a usecase that demands this explicity disconnect, or
>> is it simply a case that the reference counting is going wrong
>> somewhere and hence this was needed in the drivers?
>>
>> Failing a good description of why this is there in these drivers,
>> I'd like to clean it out.  Will give us a much easier to follow
>> interface for the triggers.
> oops, just noticed I did this first in max1363. Will hammer that hard
> and see whether everything works as I think it should!
Ah, definitely doesn't work as I thought it did. Will fix and repost
when I have a simple solution to that.  Guess when one sees unexpected
code, one should expect it to have a reason for being there!

Sorry for the noise, though the basic question still stands, even if
a little more work is needed to fix the core first.

Jonathan
