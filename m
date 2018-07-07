Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932546AbeGGREk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Jul 2018 13:04:40 -0400
Date: Sat, 7 Jul 2018 18:04:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mma8452: Mark expected switch fall-through
Message-ID: <20180707180435.414b7a95@archlinux>
In-Reply-To: <20180703194436.GA15537@embeddedor.com>
References: <20180703194436.GA15537@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 3 Jul 2018 14:44:36 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used in this case: -Wimplicit-fallthrough=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index c149c9c..421a0a8 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1547,6 +1547,7 @@ static int mma8452_probe(struct i2c_client *client,
>  	case FXLS8471_DEVICE_ID:
>  		if (ret == data->chip_info->chip_id)
>  			break;
> +		/* else: fall through */
>  	default:
>  		return -ENODEV;
>  	}

