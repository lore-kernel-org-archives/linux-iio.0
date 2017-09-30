Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752217AbdI3SFP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 14:05:15 -0400
Date: Sat, 30 Sep 2017 19:05:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
Cc: Harinath Nampally <harinath922@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH v3 2/3] iio: accel: mma8452: Rename time step look up
 struct to generic name as the values are same for all the events.
Message-ID: <20170930190511.2832064c@archlinux>
In-Reply-To: <9e6c13a7d4a6cd342a650b3bd626a162@posteo.de>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
        <1506336008-4480-3-git-send-email-harinath922@gmail.com>
        <9e6c13a7d4a6cd342a650b3bd626a162@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Sep 2017 08:51:26 +0200
Martin Kepplinger <martink@posteo.de> wrote:

> Am 25.09.2017 12:40 schrieb Harinath Nampally:
> > Improves code readability, no impact on functionality.
> > 
> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>  
> 
> Please make the headline shorter and put some of it in the git commit 
> message.
> (And please just resend it "--in-reply-to" this conversation, this patch 
> nr 2 of 3)

>From a patch management point of view I actually disagree with this.
I would prefer to see a clean fresh series.  Otherwise it very rapidly
gets hard to be sure that I am picking up the latest versions.

Obviously drop any patches that have already been taken.
In this case it will be a v4 series containing patches 1 and 2 only.

Thanks

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

