Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-037.synserver.de ([212.40.185.37]:1081 "EHLO
	smtp-out-036.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751505Ab3JLLi1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 07:38:27 -0400
Message-ID: <5259352B.5070906@metafoo.de>
Date: Sat, 12 Oct 2013 13:40:27 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 18/20] staging:iio:ad799x: Use event spec for threshold
 hysteresis
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-18-git-send-email-lars@metafoo.de> <52593A44.3080007@kernel.org>
In-Reply-To: <52593A44.3080007@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/2013 02:02 PM, Jonathan Cameron wrote:
> On 10/07/13 15:11, Lars-Peter Clausen wrote:
>> Register the event threshold hysteresis attributes by using the new
>> IIO_EV_INFO_HYSTERESIS event spec type. This allows us to throw away a good
>> portion of boiler-plate code.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Applied, as here as it is a great improvement.
> 
> I do wonder if we can handle the EITHER direction of the event more
> cleanly, now we have the different event masks.
> 
> Maybe that is even uglier than the current option.
> 
> What do you think?
[...]
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_EITHER,
>> +		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
> This is a little ugly, but I can see why you did it.  Do we need to allow an additional
> event_mask, perhaps
> mask_shared_by_both_directions ?
> 
> Then we could drop the IIO_EV_DIR_EITHER direction entirely.

Yes, you are right this is not exactly beautiful. I had to struggle with
myself a bit to convince me that it could go in as it is. I've tried a few
alternatives, but couldn't really find anything better. The problem is that
the setting whether we want to share the attribute by event direction and
e.g. by channel type are orthogonal. It is possible that an attribute is
shared by both event direction and channel type. That's why a separate event
mask doesn't work. The other two options I saw were:
1) Encoding the direction directly in the bit mask like we did before with
the old style event mask and the IIO_EV_BIT() macro. E.g. something like:
.mask_separate = IIO_EV_BIT(IIO_EV_DIR_EITHER, IIO_EV_INFO_HYSTERESIS)

The problem with this approach is that it takes up a lot of space in the
mask and limits the number of info attributes we can have.

2) Have one entry in the event spec array for each attribute e.g.

{
	.type = IIO_EV_TYPE_THRESH.
	.dir = IIO_EV_DIR_EITHER,
	.info = IIO_EV_INFO_HYSTERESIS,
	.shared_by = IIO_SEPARATE,
}

This again takes up extra space considering that the type and direction are
usually shared between the event attributes.

So the current approach is kind of a hybrid between the two. It allows you
to have multiple entries when necessary, but also allows you to group
similar attributes together.

- Lars

