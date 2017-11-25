Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbdKYOVJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:09 -0500
Date: Sat, 25 Nov 2017 14:05:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/13] iio: health: max30102: Fix missing newline in
 dev_err
Message-ID: <20171125140548.16025bc1@archlinux>
In-Reply-To: <CAJCx=gmyHMH720B2hCKpTbC4FfP0nKibM4W500mO4v3XSt+43A@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-3-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gmyHMH720B2hCKpTbC4FfP0nKibM4W500mO4v3XSt+43A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 12:28:08 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
> > ---
> >  drivers/iio/health/max30102.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index 147a8c1..62b1b35 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -261,7 +261,7 @@ static int max30102_led_init(struct max30102_data *data)
> >
> >         ret = max30102_get_current_idx(val, &reg);
> >         if (ret) {
> > -               dev_err(dev, "invalid IR LED current setting %d", val);
> > +               dev_err(dev, "invalid IR LED current setting %d\n", val);
> >                 return ret;
> >         }
> >
> > --
> > 2.7.4
> >  

