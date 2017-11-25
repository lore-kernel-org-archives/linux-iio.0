Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751658AbdKYOVN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:13 -0500
Date: Sat, 25 Nov 2017 14:08:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 05/13] iio: health: max30102: Check retval of
 powermode function
Message-ID: <20171125140851.1c933583@archlinux>
In-Reply-To: <CAJCx=gn5WgkOujfr3aMgUpK_kpSc9mBZGV=AcF4a0i8+jLtuNw@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-6-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gn5WgkOujfr3aMgUpK_kpSc9mBZGV=AcF4a0i8+jLtuNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 12:43:09 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.
> 
> > ---
> >  drivers/iio/health/max30102.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index 13d5312..389a483 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -423,7 +423,10 @@ static int max30102_probe(struct i2c_client *client,
> >                 dev_err(&client->dev, "regmap initialization failed\n");
> >                 return PTR_ERR(data->regmap);
> >         }
> > -       max30102_set_powermode(data, false);
> > +
> > +       ret = max30102_set_powermode(data, false);
> > +       if (ret)
> > +               return ret;
> >
> >         ret = max30102_chip_init(data);
> >         if (ret)
> > --
> > 2.7.4
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

