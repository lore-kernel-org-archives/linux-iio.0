Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932776AbeGHLFf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Jul 2018 07:05:35 -0400
Date: Sun, 8 Jul 2018 12:05:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sca3000: Fix missing return in switch
Message-ID: <20180708120530.0de30fcc@archlinux>
In-Reply-To: <20180707174401.GA11730@embeddedor.com>
References: <20180707174401.GA11730@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 7 Jul 2018 12:44:01 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> The IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY case is missing a
> return and will fall through to the default case and errorenously
> return -EINVAL.
> 
> Fix this by adding in missing *return ret*.
> 
> Fixes: 626f971b5b07 ("staging:iio:accel:sca3000 Add write support to the low pass filter control")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, Applied to the fixes-togreg branch of iio.git, marked for stable.

Jonathan
> ---
>  drivers/iio/accel/sca3000.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 4dceb75..4964561 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -797,6 +797,7 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  		ret = sca3000_write_3db_freq(st, val);
>  		mutex_unlock(&st->lock);
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}

