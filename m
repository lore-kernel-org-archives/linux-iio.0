Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbeBXNfw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Feb 2018 08:35:52 -0500
Date: Sat, 24 Feb 2018 13:35:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio temperature/mlx90632: silence a static checker
 warning
Message-ID: <20180224133547.6f5d3384@archlinux>
In-Reply-To: <CAKv63uuNqfc9=opZTUOpkdViHUREXKnGj1+u1HB71r0gpvySgQ@mail.gmail.com>
References: <20180222091453.GC9883@mwanda>
        <CAKv63uuNqfc9=opZTUOpkdViHUREXKnGj1+u1HB71r0gpvySgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 22 Feb 2018 10:26:17 +0100
Crt Mori <cmo@melexis.com> wrote:

> OK, makes sense.
> 
> Acked-by: Crt Mori <cmo@melexis.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> On 22 February 2018 at 10:14, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > This shouldn't affect runtime at all, but Smatch complains that we
> > should check if mlx90632_read_ambient_raw() otherwise we
> > "ambient_new_raw" can be uninitialized.
> >
> >     drivers/iio/temperature/mlx90632.c:509 mlx90632_calc_ambient_dsp105()
> >     error: uninitialized symbol 'ambient_new_raw'.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index d695ab97d27f..9851311aa3fd 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -506,6 +506,8 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
> >
> >         ret = mlx90632_read_ambient_raw(data->regmap, &ambient_new_raw,
> >                                         &ambient_old_raw);
> > +       if (ret < 0)
> > +               return ret;
> >         *val = mlx90632_calc_temp_ambient(ambient_new_raw, ambient_old_raw,
> >                                           PT, PR, PG, PO, Gb);
> >         return ret;  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

