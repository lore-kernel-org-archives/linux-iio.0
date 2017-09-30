Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdI3R7S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 13:59:18 -0400
Date: Sat, 30 Sep 2017 18:59:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
Cc: Harinath Nampally <harinath922@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH v3 1/3] iio: accel: mma8452: Rename structs holding
 event configuration registers to more appropriate names.
Message-ID: <20170930185913.4a2c85e3@archlinux>
In-Reply-To: <768af6828fe70f4a0bd7ef402073d9f3@posteo.de>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
        <1506336008-4480-2-git-send-email-harinath922@gmail.com>
        <768af6828fe70f4a0bd7ef402073d9f3@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Sep 2017 08:52:54 +0200
Martin Kepplinger <martink@posteo.de> wrote:

> Am 25.09.2017 12:40 schrieb Harinath Nampally:
> > Improves code readability, no impact on functionality.
> > 
> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>
> > ---  
> 
> I'd prefer a shorter subject line here too, see patch 2/3

Agreed.  I'm unconvinced the change helps.  Perhaps that is
because I don't fully understand why you are making the change?

Thanks,

Jonathan

