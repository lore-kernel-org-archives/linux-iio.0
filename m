Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35148 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130Ab1LJCwU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2011 21:52:20 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F3E6221091
	for <linux-iio@vger.kernel.org>; Fri,  9 Dec 2011 21:52:19 -0500 (EST)
Date: Fri, 9 Dec 2011 07:11:18 -0800
From: Greg KH <greg@kroah.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:kfifo_buf: Fix potential buffer overflow
 in iio_read_first_n_kfifo
Message-ID: <20111209151118.GB18821@kroah.com>
References: <1323365753-7645-1-git-send-email-lars@metafoo.de>
 <1323365753-7645-2-git-send-email-lars@metafoo.de>
 <20111208201722.GA31926@kroah.com>
 <4EE1DBBB.7060609@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EE1DBBB.7060609@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Dec 09, 2011 at 10:58:19AM +0100, Lars-Peter Clausen wrote:
> On 12/08/2011 09:17 PM, Greg KH wrote:
> > On Thu, Dec 08, 2011 at 06:35:52PM +0100, Lars-Peter Clausen wrote:
> >> n is the number of bytes to read, not the number of samples. So if there is
> >> enough data available we will write to the userspace buffer beyond its bounds.
> >> Fix this by copying n bytes maximum. Also round n down to the next multiple of
> >> the sample size, so we will only read complete samples. If the buffer is too
> >> small to hold at least one sample return -EINVAL.
> >>
> >> Also update the documentation of read_first_n to reflect the fact that 'n' is
> >> supposed to be in bytes and not in samples.
> >>
> >> Acked-by: Jonathan Cameron <jic23@kernel.org>
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >> ---
> >>  drivers/staging/iio/buffer.h    |    2 +-
> > 
> > This patch no longer applies to my tree, care to refresh it and resend
> > it?
> 
> Hi Greg,
> 
> I just rebased the patch on top of the current staging-next and it is
> identically to this one. Could you try to re-apply it, if you still have it?
> Otherwise I'll send it out again.

Can you resend it?  I don't know what I did wrong here...

greg k-h
