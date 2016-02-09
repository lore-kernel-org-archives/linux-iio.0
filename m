Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44503 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbcBIUtv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 15:49:51 -0500
Subject: Re: using monotonic clok for timstamping
To: Gregor Boirie <gregor.boirie@parrot.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <56B1DCA4.9050903@parrot.com> <56B1E2D8.90308@metafoo.de>
 <56B63C8E.3020309@kernel.org> <56B865FC.7020106@metafoo.de>
 <EDC91D66-140E-4BC1-BA2C-06689BB8FC02@jic23.retrosnub.co.uk>
 <56B9C826.1090309@parrot.com> <56B9F570.1050108@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BA50EB.5040101@kernel.org>
Date: Tue, 9 Feb 2016 20:49:47 +0000
MIME-Version: 1.0
In-Reply-To: <56B9F570.1050108@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/16 14:19, Gregor Boirie wrote:
> On 02/09/2016 12:06 PM, Gregor Boirie wrote:
>> One remaining question is : how do we ensure sample and event timestamps
>> consistency with respect to clock changes ? 2 suggestions:
>> * reject the ability to select a new clock as long as an events chardev is opened
>>   or a buffered samples channel is enabled ;
> Actually, this may be the only viable solution since some drivers save timestamps for
> futur usage (see drivers/iio/accel/bmc150-accel-core.c). Changing reference clock
> between 2 timestamping operations would lead to inconsistencies.
Agreed.  It will want to be locked unless we can be fairly sure it's not in use.
In most cases I can't see why a user wouldn't set it before opening any of the chardevs
so that would cover the direct userspace access case.  The more complex option is in
kernel use of the buffered interface (or events once I we actually add an interface
to get those in client drivers).  As you say, locking when the channel is enabled
would work - or during the buffer set up and unlock in the tear down.  Hold
mlock when updating as well to prevent any odd windows of buffer going up or coming down.

Should work I think.... Though the proof as ever will be in the code!

Jonathan
>> * clock may be changed at any time since it could be implemented in an atomic
>>   way (a simple atomic_t can hold an int / clockid_t if I'm no wrong).
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

