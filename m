Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50622 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758191Ab3CYRwx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Mar 2013 13:52:53 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so1161792pad.31
        for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2013 10:52:53 -0700 (PDT)
Date: Mon, 25 Mar 2013 10:51:42 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO cleanups, new drivers and fixes (IIO set 1 for the
 3.10 cycle)
Message-ID: <20130325175142.GA19706@kroah.com>
References: <514D89C4.60609@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <514D89C4.60609@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 23, 2013 at 10:53:56AM +0000, Jonathan Cameron wrote:
> The following changes since commit a14592896023adcab12307774c89284ce0744ce2:
> 
>   staging: comedi: ni_labpc: fix common detach (2013-03-15 09:17:21 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.10a

Note, I had to merge one of the files in this pull request, so you might
want to verify I got it right (I did it backwards the first time, and it
failed to build, so I'm guessing I did it correctly the second time
around...)

thanks,

greg k-h

