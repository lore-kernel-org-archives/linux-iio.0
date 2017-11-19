Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbdKSOsz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 09:48:55 -0500
Date: Sun, 19 Nov 2017 14:48:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: core: Mark expected switch fall-through
Message-ID: <20171119144850.4d103283@archlinux>
In-Reply-To: <20171108180826.GA22852@embeddedor.com>
References: <20171108120245.Horde.X3xvu9MyIH2qhMzfKf1uUB2@gator4166.hostgator.com>
        <20171108180826.GA22852@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 8 Nov 2017 12:08:26 -0600
"Gustavo A. R. Silva" <garsilva@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1397962
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Applied to the togreg branch of iio.git and will be pushed out as
testing. 

Thanks,

Jonathan
> ---
> Changes in v2:
>  Fix subject line.
> 
>  drivers/iio/industrialio-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 9c4cfd1..2e8e36f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -588,6 +588,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  		return snprintf(buf, len, "%d", vals[0]);
>  	case IIO_VAL_INT_PLUS_MICRO_DB:
>  		scale_db = true;
> +		/* fall through */
>  	case IIO_VAL_INT_PLUS_MICRO:
>  		if (vals[1] < 0)
>  			return snprintf(buf, len, "-%d.%06u%s", abs(vals[0]),

