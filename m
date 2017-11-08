Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:58026 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbdKHR70 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Nov 2017 12:59:26 -0500
Date: Wed, 8 Nov 2017 18:59:25 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io: core: mark expected switch fall-through
In-Reply-To: <20171108173621.GA20008@embeddedor.com>
Message-ID: <alpine.DEB.2.20.1711081856310.656@vps.pmeerw.net>
References: <20171108173621.GA20008@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

please fix the subject line, should be 
iio: core: Mark...

thx, p.
 
> Addresses-Coverity-ID: 1397962
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
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
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
