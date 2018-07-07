Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754290AbeGGRDW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Jul 2018 13:03:22 -0400
Date: Sat, 7 Jul 2018 18:03:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sca3000: Mark expected switch fall-through
Message-ID: <20180707180317.52cb8b39@archlinux>
In-Reply-To: <20180703193934.GA13572@embeddedor.com>
References: <20180703193934.GA13572@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 3 Jul 2018 14:39:34 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks like a bug to me not an unmarked fall through.

Should be return ret;

Do you want to do the patch?

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3000.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 4dceb75..209b52a 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -797,6 +797,7 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  		ret = sca3000_write_3db_freq(st, val);
>  		mutex_unlock(&st->lock);
> +		/* fall through */
>  	default:
>  		return -EINVAL;
>  	}

