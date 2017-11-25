Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbdKYOVK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:10 -0500
Date: Sat, 25 Nov 2017 14:06:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 03/13] iio: health: max30102: Remove inconsistent
 full stop in error message
Message-ID: <20171125140633.193aa3c8@archlinux>
In-Reply-To: <CAJCx=gkGB_HUgLTKiyzcnWaEDZ-Q5QC-G_YgpxyUQELGNian5A@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-4-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gkGB_HUgLTKiyzcnWaEDZ-Q5QC-G_YgpxyUQELGNian5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 12:28:46 -0800
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
> >  drivers/iio/health/max30102.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index 62b1b35..6ca6182 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -420,7 +420,7 @@ static int max30102_probe(struct i2c_client *client,
> >
> >         data->regmap = devm_regmap_init_i2c(client, &max30102_regmap_config);
> >         if (IS_ERR(data->regmap)) {
> > -               dev_err(&client->dev, "regmap initialization failed.\n");
> > +               dev_err(&client->dev, "regmap initialization failed\n");
> >                 return PTR_ERR(data->regmap);
> >         }
> >         max30102_set_powermode(data, false);
> > --
> > 2.7.4
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

