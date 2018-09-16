Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbeIPO7P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 10:59:15 -0400
Date: Sun, 16 Sep 2018 10:36:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: YueHaibing <yuehaibing@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: potentiometer: mcp4018: merge calls to
 of_match_device and of_device_get_match_data
Message-ID: <20180916103657.10cfb5ed@archlinux>
In-Reply-To: <9f3c9f9a-6bb4-19ba-65ad-53f7edd2af20@axentia.se>
References: <20180915105241.22584-1-yuehaibing@huawei.com>
        <9f3c9f9a-6bb4-19ba-65ad-53f7edd2af20@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 15 Sep 2018 13:35:06 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-09-15 12:52, YueHaibing wrote:
> > Drop call to of_match_device, which is subsumed by the subsequent
> > call to of_device_get_match_data.  The code becomes simpler, and a
> > temporary variable can be dropped.
> > 
> > Found by coccinelle.
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>  
> 
> Acked-by: Peter Rosin <peda@axentia.se>
Similar change already in place from Julia Lawall back in May but
looks like that just missed the last set for the merge window
after I managed to loose it and only picked up again when Peter
pointed it out in August.

However, something odd is going on as these are not currently in
next.

Ah, looks line staging-next was updated 2 days ago and last linux-next
is just before that.  So I'm afraid you hit some very unfortunate
timing or this would have been there when you were looking.

Thanks,

Jonathan

> 
> Cheers,
> Peter
