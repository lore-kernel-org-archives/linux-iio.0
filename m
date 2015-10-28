Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46319 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756004AbbJ1Wra (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2015 18:47:30 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DBE562028E
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2015 18:47:29 -0400 (EDT)
Date: Thu, 29 Oct 2015 07:47:22 +0900
From: Greg KH <greg@kroah.com>
To: Ioana Ciornei <ciorneiioana@gmail.com>
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
	cristina.opriceana@gmail.com
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: dummy: complete IIO
 events delivery to userspace
Message-ID: <20151028224722.GA31531@kroah.com>
References: <1445971256-22474-1-git-send-email-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445971256-22474-1-git-send-email-ciorneiioana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 27, 2015 at 08:40:56PM +0200, Ioana Ciornei wrote:
> Starting with commit fd2bb310ca (Staging: iio: Move evgen interrupt
> generation to irq_work) event processing is handled by calling
> both the top half and the threaded part properly simulating real
> hardware interrupts making use of threaded interrupts.
> This way the processing is split in 2 parts:
> 
> * the IRQ handler that runs in IRQ context and only saves the event
> timestamp
> * the threaded handler that runs in process context, reads the events
> and pushes the in the userspace.
> 
> If the IRQ handler returns IRQ_HANDLED the threaded handler is not
> even being called since the interrupt is considered to be processed.
> Because the iio dummy driver processes the events in the threaded
> handler the IRQ handler must return IRQ_WAKE_THREAD so that the
> threaded part would be awakened and called.
> 
> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
> Fixes: fd2bb310ca ("Staging: iio: Move evgen interrupt generation to irq_work")
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
> rebased on linux-iio tree

Daniel, can you forward this to the iio developers, I can't take this as
it doesn't apply to my tree :(

thanks,

greg k-h
