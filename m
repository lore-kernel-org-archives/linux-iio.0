Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:59140 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1CXLC6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2011 07:02:58 -0400
Message-ID: <4D8B252E.8020405@cam.ac.uk>
Date: Thu, 24 Mar 2011 11:04:14 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jon Brenner <jbrenner@TAOSinc.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Interrupt_req vs. iio_register_interrupt_line
References: <B4B07CCC7B7A084E989CF9386538EA1D63A8EA@exchsrvr.taosinc.com>
In-Reply-To: <B4B07CCC7B7A084E989CF9386538EA1D63A8EA@exchsrvr.taosinc.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/23/11 19:45, Jon Brenner wrote:
> Hello,
> Can someone please explain the purpose / advantage of using:
> 'iio_register_interrupt_line' vs. just using using 'request_irq'?
> It appears that the iio_register_interrupt_line uses request_irq.
The main difference is the fact that iio_register_interrupt_line
wraps up a call to iio_allocate_interrupt. That function sets up the
event list handling. The event lists are then used to keep track of
which events are turned on.

Hence it's pretty much a convenience wrapper to cut down on code
repetition.  Allows us to change the internal handling of that
stuff without having to edit lots of drivers ;) That stuff really
comes into it's own when you have events where you cannot identify
them without querying multiple registers.  It is probably overkill
if all your events are of the shared handler variety.

Avoiding the various convenience functions in general is fine with
me, but beware the core code is going to change a fair bit as we try
to move out of staging and this may well become harder to do.
(see the channel registration code just as soon as I finish writing it!)


> Can direct me to iio documentation that would present this.lin
Err.  The code?  Not great I know, but that stuff is likely to change and
any documentation is unlikely to be kept up to date. Sorry!
> 
> Thanks!
> Jon
> 
> jbrenner@taosinc.com
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

