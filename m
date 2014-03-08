Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42250 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaCHRzo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Mar 2014 12:55:44 -0500
In-Reply-To: <20140308161126.GA24802@kroah.com>
References: <5318CB62.2020103@kernel.org> <20140306193355.GA12474@kroah.com> <531B3C25.90609@metafoo.de> <20140308161126.GA24802@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PULL] IIO new drivers, features and cleanups for 3.15 - set 3
From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 08 Mar 2014 17:55:39 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Message-ID: <9766334b-bc85-4585-85a9-a1c5ebb5810c@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On March 8, 2014 4:11:26 PM GMT+00:00, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>On Sat, Mar 08, 2014 at 04:49:57PM +0100, Lars-Peter Clausen wrote:
>> On 03/06/2014 08:33 PM, Greg Kroah-Hartman wrote:
>> > On Thu, Mar 06, 2014 at 07:24:18PM +0000, Jonathan Cameron wrote:
>> >> The following changes since commit
>aa256f8d0dd9c2dff872849418d8e09e5d06718f:
>> >>
>> >>    Merge tag 'iio-for-3.15b' of
>git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into
>staging-next (2014-02-23 09:08:34 -0800)
>> >>
>> >> are available in the git repository at:
>> >>
>> >>
>> >>    git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>tags/iio-for-3.15c
>> >
>> > Pulled and pushed out.
>> >
>> > What's the status of the remaining drivers/staging/iio/ stuff? 
>Anything
>> > major keeping them from all moving out of staging sometime soon?
>> 
>> I think we are past the point were we can move big chunks of drivers.
>The 
>> drivers that are in good shape have already been moved. What's left
>has 
>> issues, some smaller, some bigger. Moving things out of staging is 
>> progressing, but it is progressing one driver at a time.
>
>Fair enough.  How about the "dummy" drivers?  I don't see them listed
>in
>the TODO file, is there a description of what needs to be done for
>those
>that could be done by someone who is new to kernel development to get a
>wider range of developers working on this?
>
I think the main issue remaining there is the dubious sysfs interface to create event 'interrupts'. iio_dummy_evgen.c it uses a chained interrupt call so doesn't allow a top
 half and hence doesn't really illustrate a typical driver.

The way it is done in the sysfs trigger is much nicer. However I have been meaning to
 see if there is a general test interrupt source or if not any interest in having one.


>thanks,
>
>greg k-h
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
