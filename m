Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:58144 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbaKDVm1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Nov 2014 16:42:27 -0500
Message-ID: <54594840.3050302@gmx.de>
Date: Tue, 04 Nov 2014 22:42:24 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: George McCollister <george.mccollister@gmail.com>,
	mranostay@gmail.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: as3935: allocate correct iio_device size
References: <1414770263-13146-1-git-send-email-george.mccollister@gmail.com>
In-Reply-To: <1414770263-13146-1-git-send-email-george.mccollister@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

George McCollister schrieb am 31.10.2014 16:44:
> Signed-off-by: George McCollister <george.mccollister@gmail.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/proximity/as3935.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 5e780ef..8349cc0 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -330,7 +330,7 @@ static int as3935_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> 

