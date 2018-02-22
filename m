Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36422 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbeBVJ1A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Feb 2018 04:27:00 -0500
Received: by mail-lf0-f65.google.com with SMTP id t79so6436710lfe.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Feb 2018 01:26:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222091453.GC9883@mwanda>
References: <20180222091453.GC9883@mwanda>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 22 Feb 2018 10:26:17 +0100
Message-ID: <CAKv63uuNqfc9=opZTUOpkdViHUREXKnGj1+u1HB71r0gpvySgQ@mail.gmail.com>
Subject: Re: [PATCH] iio temperature/mlx90632: silence a static checker warning
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

OK, makes sense.

Acked-by: Crt Mori <cmo@melexis.com>

On 22 February 2018 at 10:14, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This shouldn't affect runtime at all, but Smatch complains that we
> should check if mlx90632_read_ambient_raw() otherwise we
> "ambient_new_raw" can be uninitialized.
>
>     drivers/iio/temperature/mlx90632.c:509 mlx90632_calc_ambient_dsp105()
>     error: uninitialized symbol 'ambient_new_raw'.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index d695ab97d27f..9851311aa3fd 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -506,6 +506,8 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>
>         ret = mlx90632_read_ambient_raw(data->regmap, &ambient_new_raw,
>                                         &ambient_old_raw);
> +       if (ret < 0)
> +               return ret;
>         *val = mlx90632_calc_temp_ambient(ambient_new_raw, ambient_old_raw,
>                                           PT, PR, PG, PO, Gb);
>         return ret;
