Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdI3SEw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 14:04:52 -0400
Date: Sat, 30 Sep 2017 19:04:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
Cc: Harinath Nampally <harinath922@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH v3 3/3] iio: accel: mma8452: Rename read/write event
 value callbacks to generic function name.
Message-ID: <20170930190447.0e474760@archlinux>
In-Reply-To: <6a0f1676591c924b9d93cdb0b98ba7f9@posteo.de>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
        <1506336008-4480-4-git-send-email-harinath922@gmail.com>
        <6a0f1676591c924b9d93cdb0b98ba7f9@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Sep 2017 08:46:27 +0200
Martin Kepplinger <martink@posteo.de> wrote:

> Am 25.09.2017 12:40 schrieb Harinath Nampally:
> > 'mma8452_read_thresh' and 'mma8452_write_thresh' functions
> > does more than just read/write threshold values.
> > They also handle  IIO_EV_INFO_HIGH_PASS_FILTER_3DB and
> > IIO_EV_INFO_PERIOD therefore renaming to generic names.
> > 
> > Improves code readability, no impact on functionality.
> > 
> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>  
> 
> Acked-by: Martin Kepplinger <martink@posteo.de>

Just this patch 3 applied for now to the togreg branch of iio.git and
pushed out as testing for the autobuilders to play with.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

