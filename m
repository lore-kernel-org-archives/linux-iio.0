Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbeG3Upm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Jul 2018 16:45:42 -0400
Date: Mon, 30 Jul 2018 20:09:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: fix test for val being not zero or not one.
Message-ID: <20180730200914.7becfa32@archlinux>
In-Reply-To: <20180730125918.7100-1-colin.king@canonical.com>
References: <20180730125918.7100-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 30 Jul 2018 13:59:18 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The current check on val always results in true and so the
> call to sii1133_update_adcsens never gets called. Fix this check
> so it returns with -EINVAL only when val is not zero and not one.
> 
> Detected by CoverityScan, CID#1472099 ("Logically dead code")
> 
> Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks!,

Applied to the fixes-togreg branch of iio.git. Will send upstream after
the merge window closes now.

Jonathan

> ---
>  drivers/iio/light/si1133.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index d3fbeb3bc463..5ac22c46da1f 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -838,7 +838,7 @@ static int si1133_write_raw(struct iio_dev *iio_dev,
>  		switch (chan->type) {
>  		case IIO_INTENSITY:
>  		case IIO_UVINDEX:
> -			if (val != 0 || val != 1)
> +			if (val != 0 && val != 1)
>  				return -EINVAL;
>  
>  			return si1133_update_adcsens(data,

