Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdIMREW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Sep 2017 13:04:22 -0400
Date: Wed, 13 Sep 2017 18:04:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Himanshi Jain <himshijain.hj@gmail.com>,
        outreachy-kernel@googlegroups.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        nick.desaulniers@gmail.com, daniel.baluta@gmail.com
Subject: Re: [Outreachy kernel] [PATCH v2 0/2] Rewrite the
 IIO_DEVICE_ATTR_NAMED API to pass name as string.
Message-ID: <20170913180418.66e31657@archlinux>
In-Reply-To: <alpine.DEB.2.20.1709131046240.2850@hadrien>
References: <cover.1505291907.git.himshijain.hj@gmail.com>
        <alpine.DEB.2.20.1709131046240.2850@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 13 Sep 2017 10:46:59 +0200 (CEST)
Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Wed, 13 Sep 2017, Himanshi Jain wrote:
> 
> > This patchset is to rewrite the IIO_DEVICE_ATTR_NAMED API to pass name
> > as string.  
> 
> You need to indicate what has changed in the v2, either here or in the
> individual patches.
> 
> julia

Absolutely agree with Julia.  However, I'd wait for a day or so
to see if anything else comes up rather than immediately sending
a v3 with a correct change log.

Thanks,

Jonathan
> 
> 
> >
> > Himanshi Jain (2):
> >   include: linux: sysfs: Add __ATTR_NAMED macro
> >   iio: Change to __ATTR_NAMED()
> >
> >  drivers/iio/adc/ad7793.c          | 2 +-
> >  drivers/staging/iio/adc/ad7192.c  | 2 +-
> >  drivers/staging/iio/adc/ad7280a.c | 4 ++--
> >  include/linux/iio/sysfs.h         | 6 +++++-
> >  include/linux/sysfs.h             | 7 +++++++
> >  5 files changed, 16 insertions(+), 5 deletions(-)
> >
> > --
> > 1.9.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/cover.1505291907.git.himshijain.hj%40gmail.com.
> > For more options, visit https://groups.google.com/d/optout.
> >  

