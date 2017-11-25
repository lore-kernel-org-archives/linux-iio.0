Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdKYOVH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:07 -0500
Date: Sat, 25 Nov 2017 14:04:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 01/13] iio: health: max30102: Temperature should be
 in milli Celsius
Message-ID: <20171125140419.5b944c0a@archlinux>
In-Reply-To: <CAJCx=gm46LQhRgAOWAeFvvU94zu9RCMH2qe6YrzB3CJYTA-TWA@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-2-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gm46LQhRgAOWAeFvvU94zu9RCMH2qe6YrzB3CJYTA-TWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 13:09:34 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> > As per ABI temperature should be in milli Celsius after scaling,
> > not Celsius  
> 
> Good catch...Thanks
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

I've also added a brief not to emphasise that is breaking the ABI
hence I want it fixed in stable...  (just hammering the point
home ;)

Thanks

Jonathan
> 
> >
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/health/max30102.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index 203ffb9..147a8c1 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -371,7 +371,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
> >                 mutex_unlock(&indio_dev->mlock);
> >                 break;
> >         case IIO_CHAN_INFO_SCALE:
> > -               *val = 1;  /* 0.0625 */
> > +               *val = 1000;  /* 62.5 */
> >                 *val2 = 16;
> >                 ret = IIO_VAL_FRACTIONAL;
> >                 break;
> > --
> > 2.7.4
> >  

