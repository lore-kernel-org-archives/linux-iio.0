Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42904 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbaFRQdW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 12:33:22 -0400
In-Reply-To: <alpine.DEB.2.01.1406181445290.28014@pmeerw.net>
References: <20140611013007.GA32756@kroah.com> <f0db211a-bf69-4a3e-beda-2101af74ae25@email.android.com> <53998D43.9020209@gmail.com> <53A1895A.4090209@gmail.com> <alpine.DEB.2.01.1406181445290.28014@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: IIO drivers left in drivers/staging/
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 18 Jun 2014 17:33:12 +0100
To: Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
CC: Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <deb944e5-5d43-4048-9a2e-58188e85a0bb@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On June 18, 2014 1:56:52 PM GMT+01:00, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>Hello Kristina,
>
>> > Okay so right now I'm getting the following things I could work on:
>> > 
>> > 1) prefixes on define constants for lpc32xx_ADC (then trying to
>move it
>> > out of staging and seeing what other issues people find?)
>> > 2) resolver/CDC ABI documentation cleanup
>> > 3) dummy driver fake event interrupt hack
>> > 4) Lars may have more ideas?
>> > 
>> > The plan is for me to start working on this stuff full time next
>week,
>> > so if you think of anything more, please let me know!
>> 
>> Haven't heard back from you about this. Have you found anything else
>> that needs to be done with staging IIO drivers before they can be
>moved out?
Sorry, got caught up and failed to get back to you with more stuff.
>
>IIO is a bit problematic since testing usually requires possessing the 
>sensor chip
Whilst true, one can normally assume code as present works. Hence a lot can be done
 without hardware. Just a good idea to keep changes small and make it clear when they are untested.
>
>regarding staging/iio/magnetometer/hmc5843:
>the driver has one specific DEVICE_ATTR left (meas_conf), otherwise
>clean 
>I think; so we could (a) document it as special ABI or (b) drop it
>
>regarding staging/iio/light/isl*:
>drivers have plenty of custom ATTRs and do not follow style 
>(function name prefixes, #define PREFIXes)
>some of the special ATTRs could converted to using SAMPL_FREQ,
>INT_TIME, 
>SCALE
Good points.

A useful if perhaps dull task is to look at interfaces that are not in the ABI and figure out which ones need fixing and which, like those Peter highlights need new interfaces or should not be exposed to userspace at all. 
Killing off remaining bits that are now possible through info_mask_* is also helpful.

I have some patches for this outside staging but plenty to do in the drivers still there.
>
>regards, p.

Looking forward to patches!

J

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
