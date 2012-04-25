Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34515 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab2DYSNX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 14:13:23 -0400
Received: by pbbro12 with SMTP id ro12so1756025pbb.19
        for <linux-iio@vger.kernel.org>; Wed, 25 Apr 2012 11:13:23 -0700 (PDT)
Date: Wed, 25 Apr 2012 11:13:19 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/5] IIO: Move the core out of staging.
Message-ID: <20120425181319.GA22984@kroah.com>
References: <1335365700-1138-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335365700-1138-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 25, 2012 at 03:54:55PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> Here is the promised patch series.
> 
> I stalled it for a few days over whether we should switch some of the
> Kconfig selects to depends.  Lars-Peter talked me out of it arguing
> it made little sense to users.  There are some cleanups to be made
> there but they can occur at a later date.
> 
> Clearly there are lots more docs to move, but some of those need going
> over with a fine toothed comb as they have rotted somewhat.  We'll
> work on that in the near future.

Very nicely done, I've applied this to the staging-next tree.

Congrats, now the real work begins :)

greg k-h
