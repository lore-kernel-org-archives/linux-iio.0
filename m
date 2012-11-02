Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52561 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab2KBVRb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 17:17:31 -0400
References: <5093A416.1080409@kernel.org> <20121102162953.GB13600@kroah.com>
In-Reply-To: <20121102162953.GB13600@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PULL] IIO fixes for v3.7-rc1 set 2
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Fri, 02 Nov 2012 21:17:24 +0000
To: Greg KH <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <0b8ea1ef-ab9f-47cc-928b-d4a5e3ecf48b@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Greg KH <gregkh@linuxfoundation.org> wrote:

>On Fri, Nov 02, 2012 at 10:44:38AM +0000, Jonathan Cameron wrote:
>> The following changes since commit
>98f9c3c137cea016c57c9fd60b3caf88eb34e4cd:
>> 
>>   iio: Remove duplicates for light/ in Kconfig and Makefile
>(2012-10-19 19:44:06 +0100)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>tags/iio-fixes-for-3.7b
>> 
>> for you to fetch changes up to
>7243b785c43d9aedc7a584dab81bb3f26989d6a1:
>> 
>>   iio: hid-sensor: Use __devexit annotation for remove() (2012-11-02
>09:57:57 +0000)
>> 
>> ----------------------------------------------------------------
>> Second round of fixes for IIO in 3.7 cycle, applies to 3.7-rc1.
>> 
>> A mixed bag of fixes mainly for drivers but with one core
>> double free fix.
>> 
>> * A couple of little fixlets for the hid-sensors drivers.
>> * Incorrect return value in adt7410
>> * Fix up support for the adis16334 in the adis16400 driver.
>>   Turned out there were some bits and bobs that need to be
>>   handled different for this part.  This seems like a large
>>   patch series but this is mostly because an additional chip
>>   specific callback is needed to handle the variations.
>
>That is a big patch so late in the release cycle, is it really needed?
>Is it a regression from 3.6?  Or does it just fix a problem with a new
>thing that showed up in 3.7-rc1?  If the latter, how about we postpone
>it and just mark the driver BROKEN or something?

I did wonder about this one.  Its one part in lots supported by the driver. It has never worked so lets just leave it for the next merge window and do stable backports if anyone cares.

Will do updated pull requests in a few days as away from my machine.

Thanks

Jonathan 
>
>thanks,
>
>greg k-h

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
