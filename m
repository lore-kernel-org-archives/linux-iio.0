Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeJIDnk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Oct 2018 23:43:40 -0400
Date: Mon, 8 Oct 2018 21:30:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20181008213004.033e2b29@archlinux>
In-Reply-To: <20181008172332.GA29816@embeddedor.com>
References: <20181008172332.GA29816@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 8 Oct 2018 19:23:32 +0200
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1397962 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Hi,

I'll be honest I'm lost on what the intent of this code actually is...

Gwendal - why do we have a loop with this odd switch statement
in it.  Superficially I think we might as well drop the switch
and pull those assignments out of the loop.   However, perhaps
I'm missing something!

Thanks,

Jonathan

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 063e89e..d609654 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  		switch (i) {
>  		case X:
>  			ec_accel_channels[X].scan_index = Y;
> +			/* fall through */
>  		case Y:
>  			ec_accel_channels[Y].scan_index = X;
> +			/* fall through */
>  		case Z:
>  			ec_accel_channels[Z].scan_index = Z;
>  		}
