Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37122 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbEBSyW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2015 14:54:22 -0400
Received: by widdi4 with SMTP id di4so75024779wid.0
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2015 11:54:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430564705-31119-1-git-send-email-jic23@kernel.org>
References: <1430564705-31119-1-git-send-email-jic23@kernel.org>
Date: Sat, 2 May 2015 21:54:21 +0300
Message-ID: <CAEnQRZAHSqssqmqSWSm4NYB5854um28MjsFPoBC5DkrJRySVzA@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:light: Add some missing brackets to make sure
 code works as intended. Note this is not a bug due to the fact the region
 cannot be reached without the sanity check passing. The autobuilder reported
 it as missaligned code which is kind of true as well.
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This looks good to me. Anyhow, we need a newline somewhere in the
commit subject.

On Sat, May 2, 2015 at 2:05 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Cc: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> ---
>  drivers/staging/iio/light/isl29018.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 08ca9a4172e3..e646c5d24004 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -369,12 +369,13 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
>                 }
>                 break;
>         case IIO_CHAN_INFO_INT_TIME:
> -               if (chan->type == IIO_LIGHT)
> +               if (chan->type == IIO_LIGHT) {
>                         if (val != 0) {
>                                 mutex_unlock(&chip->lock);
>                                 return -EINVAL;
>                         }
>                         ret = isl29018_set_integration_time(chip, val2);
> +               }
>                 break;
>         case IIO_CHAN_INFO_SCALE:
>                 if (chan->type == IIO_LIGHT)
> --
> 2.3.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
