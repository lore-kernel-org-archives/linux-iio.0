Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-017.synserver.de ([212.40.185.17]:1062 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750931Ab3EVITs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 04:19:48 -0400
Message-ID: <519C7F93.9010606@metafoo.de>
Date: Wed, 22 May 2013 10:19:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: Guillaume Ballet <gballetwork@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: Why is only one int returned in iio_read_channel_processed?
References: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com> <519C7C29.9040707@jic23.retrosnub.co.uk>
In-Reply-To: <519C7C29.9040707@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/22/2013 10:04 AM, Jonathan Cameron wrote:
> On 22/05/13 08:49, Guillaume Ballet wrote:
>> Hello,
>>
>> The read_raw operation in iio_info has a signature that takes two
>> integer as in/out parameters. This lets the driver return values with
>> micro- or nano-unit precision.
>>
>> However, the high-level iio_read_channel_raw and
>> iio_read_channel_processed
> Do we even have an iio_read_channel_processed? I think you are referring
> to the in kernel consumer interface.  In iio/consumer.h we have an
> iio_read_channel_raw but unless I am going mad no iio_read_channel_processed
> (as of yet).
> 
> https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/include/linux/iio/consumer.h?h=togreg
> 
> (is the latest development tree).
> 
> Which tree are you looking at?

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/iio/consumer.h#n145

> 
>> functions' signature only has one integer
>> in/out parameter. That makes sense in the context of _raw because the
>> value isn't yet processed.
>>
>> However, as the scale is a number encoded over two ints, the
>> _processed value should also span two ints. Is there a reason why it's
>> still only one int?
> No it certainly should not be one int for exactly the reasons you have stated.
>>

I'm not to sure about that. I'd rather add a scale parameter to the
iio_read_channel_processed, just in the same way the
convert_raw_to_processed function takes a scale parameter.

- Lars

