Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45633 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbaFMNJR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 13 Jun 2014 09:09:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1WvREI-0007n6-PD
	for linux-iio@vger.kernel.org; Fri, 13 Jun 2014 15:09:14 +0200
Received: from 146.187.3.109.rev.sfr.net ([109.3.187.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Fri, 13 Jun 2014 15:09:14 +0200
Received: from josselin.costanzi by 146.187.3.109.rev.sfr.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Fri, 13 Jun 2014 15:09:14 +0200
To: linux-iio@vger.kernel.org
From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: Re: [PATCH v2] iio: make blocking read wait for data
Date: Fri, 13 Jun 2014 15:09:05 +0200
Message-ID: <lnet5h$iu$1@ger.gmane.org>
References: <1402417591-32536-1-git-send-email-josselin.costanzi@mobile-devices.fr> <5399A09B.2070608@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars-Peter Clausen wrote:

> On 06/10/2014 06:26 PM, Josselin Costanzi wrote:
>> Currently the IIO buffer blocking read only wait until at least one
>> data element is available.
>> This patch adds the possibility for the userspace to to blocking calls
>> for multiple elements. This should limit the read() calls count when
>> trying to get data in batches.
>> This commit also fix a bug where data is lost if an error happens
>> after some data is already read.
>>
>> Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
> 
> This is going into the right direction. But where did that timeout come 
> from? If a user wants a timeout on the read() call they should open the 
> device in non-blocking mode and use poll() with a timeout. I dont think we 
> should add a different way of doing this since the poll() method already 
> works fine.
> Also read() should still return once it got data and not wait until the full 
> buffer has been read. 

The idea was to implement something like SO_RCVLOWAT and SO_RCVTIMEO (or VMIN
and VTIME for ttys) hence the two sysfs entries for watermark and timeout.

As far as I understand the problem, there is at least two ABI functions that
can be impacted by adding a watermark: poll and read.

We should change poll() to return POLLIN only when there is enough data to 
reach the watermark. Non blocking read returns whatever data is available.

However, for blocking read, maybe the watermark could still be respected if
it's set? It's what is done in tcp_recvmsg but then we need the timeout so it's
maybe not worth the effort and complexity. OTOH, if we don't do this, then 
the blocking read isn't really useful anymore because the userspace needs 
to call poll() to check the watermark. What do you think?

> Also poll() should not return until there is more data 
> than the watermark in the buffer. So this means the pollq of the buffer 
> should not be woken up until more data is in the buffer then the watermark. 
> E.g. in iio_store_to_kfifo
> 
> if (kfifo_len(&kf->kf) >= kf->buffer.watermark)
> 	wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);

Indeed, this needs to be implemented.

> iio_kfifo_buf_data_available() can be re-factored to return the amount of 
> data that is available rather than just if data is available or not.
> 
> In iio_buffer_data_available() you can then compare the result of the 
> data_available() callback with the watermark and return true or false 
> depending on that.

Ok, I'll have a look.

> 
> There is one more case that needs to be handled which is the buffer being 
> disabled. When the buffer is disabled iio_buffer_data_available() should 
> return true if there is data in the buffer regardless of whether it is above 
> or below the watermark. This also means that the pollq needs to be woken up 
> when the buffer is disabled. This should be done in iio_buffer_deactivate() 
> before the iio_buffer_put().

Yes, will check

