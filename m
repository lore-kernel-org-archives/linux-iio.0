Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34026 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938026AbcIFRKM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Sep 2016 13:10:12 -0400
Received: by mail-pa0-f54.google.com with SMTP id to9so34464175pac.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Sep 2016 10:10:12 -0700 (PDT)
Date: Tue, 6 Sep 2016 10:10:09 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ensure ret is initialized to zero before entering
 do loop
Message-ID: <20160906171008.GA1264@localhost>
References: <20160905143906.13579-1-colin.king@canonical.com>
 <59ac3528-2245-ea61-f7e7-847bc5fe90b9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59ac3528-2245-ea61-f7e7-847bc5fe90b9@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Mon, Sep 05, 2016 at 09:03:26PM +0100, Jonathan Cameron wrote:
> On 05/09/16 15:39, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > A recent fix to iio_buffer_read_first_n_outer removed ret from being set by
> > a return from wait_event_interruptible and also added a continue in a loop
> > which causes the variable ret to not be set when it reaches the end of the
> > loop.  Fix this by initializing ret to zero.
> > 
> > Also remove extraneous white space at the end of the loop.
> > 
> > Fixes: fcf68f3c0bb2a5 ("fix sched WARNING "do not call blocking ops when !TASK_RUNNING")

Not that it really matters, but if the commit is still going to be
amended at all, the subject was "iio: fix ...", not just "fix ...".
Definitely not important though.

> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Good find.  Strange that got through 0-day without a warning...
> 
> Cc'd Brian as author of the fix this is fixing.
> Brian can you sanity check this patch as well.

Indeed, looks fine, and works fine:

Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks for the fix Colin, and sorry for not noticing that error :(

> Applied to the fixes-togreg branch of iio.git and marked for stable.
> Ah well, another one for the statistics on stable patches that introduce bugs while
> fixing other bugs.
> 
> Pretty unlikely this will be hit I think, but in theory you never know.
> 
> Jonathan
> > ---
> >  drivers/iio/industrialio-buffer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 49bf9c5..158aaf4 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -110,7 +110,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
> >  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >  	size_t datum_size;
> >  	size_t to_wait;
> > -	int ret;
> > +	int ret = 0;
> >  
> >  	if (!indio_dev->info)
> >  		return -ENODEV;
> > @@ -153,7 +153,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
> >  		ret = rb->access->read_first_n(rb, n, buf);
> >  		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
> >  			ret = -EAGAIN;
> > -	 } while (ret == 0);
> > +	} while (ret == 0);

Personally, I avoided the temptation to fix the whitespace error in a
bugfix patch. But this does scratch my itch :)

Brian

> >  	remove_wait_queue(&rb->pollq, &wait);
> >  
> >  	return ret;
> > 
> 
