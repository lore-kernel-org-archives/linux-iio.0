Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750988AbdJALA5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Oct 2017 07:00:57 -0400
Date: Sun, 1 Oct 2017 12:00:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dummy: evgen: use irq_sim
Message-ID: <20171001120053.6256b31b@archlinux>
In-Reply-To: <CAMRc=Md=EkmMevbn-a3K9=Tk67f4tuvqsLu2sGmD6swV9sYe2w@mail.gmail.com>
References: <20170928105641.11793-1-brgl@bgdev.pl>
 <40d29879-54ee-f7eb-ce83-bedd066c0fa3@metafoo.de>
 <CAMRc=Md=EkmMevbn-a3K9=Tk67f4tuvqsLu2sGmD6swV9sYe2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 Sep 2017 16:52:26 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> 2017-09-29 15:15 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
> > On 09/28/2017 12:56 PM, Bartosz Golaszewski wrote:  
> >> Switch to using the recently added interrupt simulator for dummy irqs.
> >>
> >> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>  
> >
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> > Tested-by: Lars-Peter Clausen <lars@metafoo.de>
> >
> > I've backported irq_sim to v4.9 for testing and got compile errors due to a
> > missing slab.h include. In upstream this include comes implicit through
> > irq.h (coincidentally added by you), I wonder if we should still add it to
> > irq_sim.c since it is explicitly using the allocation API.  
> 
> Thanks for the hint, I'll send it together with other updates (e.g.
> the reverse irq lookup).

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

