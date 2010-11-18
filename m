Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:34699 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048Ab0KRRrz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2010 12:47:55 -0500
Message-ID: <4CE5684A.8070404@cam.ac.uk>
Date: Thu, 18 Nov 2010 17:54:18 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Drivers <Drivers@analog.com>, stable@kernel.org,
	torvalds@linux-foundation.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: patch "Staging: iio: adis16220: fix up some sysfs attribute permissions"
 added to staging tree
References: <12899355293477@site> <4CE55CC1.6010507@cam.ac.uk> <20101118171950.GB4283@suse.de>
In-Reply-To: <20101118171950.GB4283@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/18/10 17:19, Greg KH wrote:
> On Thu, Nov 18, 2010 at 05:05:05PM +0000, Jonathan Cameron wrote:
>> On 11/16/10 19:25, gregkh@suse.de wrote:
>>>
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     Staging: iio: adis16220: fix up some sysfs attribute permissions
>>>
>>> to my staging git tree which can be found at
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6.git
>>> in the staging-linus branch.
>>>
>>> The patch will show up in the next release of the linux-next tree
>>> (usually sometime within the next 24 hours during the week.)
>>>
>>> The patch will hopefully also will be merged in Linus's tree for the
>>> next -rc kernel release.
>>>
>>> If you have any questions about this process, please let me know.
>>>
>>>
>>> >From 1d904e8950c86e670ace237eaea1d48cd81e94df Mon Sep 17 00:00:00 2001
>>> From: Greg Kroah-Hartman <gregkh@suse.de>
>>> Date: Tue, 16 Nov 2010 11:19:53 -0800
>>> Subject: Staging: iio: adis16220: fix up some sysfs attribute permissions
>>>
>>> They should not be writable by any user
>> Sorry Greg, it may be jet lag related, but I really don't see how this change
>> makes sense...  Doesn't this take a write only parameter and make it read only
>> with no read function defined?  Was the intent to restrict who could write
>> to this attribute?
> 
> Ah crap.
> 
>>>  #define IIO_DEV_ATTR_CAPTURE(_store)				\
>>> -	IIO_DEVICE_ATTR(capture, S_IWUGO, NULL, _store, 0)
>>> +	IIO_DEVICE_ATTR(capture, S_IRUSR, NULL, _store, 0)
> 
> This should be S_IWUSR, right?
Equivalent with that in and I'm happy to add my ack. 

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Thanks,

Jonathan
> 
> Did I just get all of these wrong?  I'll go verify them...
> 
> thanks,
> 
> greg k-h
> 

