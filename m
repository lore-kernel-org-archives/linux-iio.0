Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33289 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbcFQBEb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2016 21:04:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id r201so957656wme.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2016 18:04:30 -0700 (PDT)
Message-ID: <57634C9D.7090705@gmail.com>
Date: Fri, 17 Jun 2016 03:04:29 +0200
From: Marek Vasut <marek.vasut@gmail.com>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: Re: [PATCH] iio: proximity: as3935: remove redundant zeroing of tune_cap
References: <1466041622-1236-1-git-send-email-mranostay@gmail.com>
In-Reply-To: <1466041622-1236-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/16/2016 03:47 AM, Matt Ranostay wrote:

Commit message explaining what the patch does and why this patch is
needed is missing.

> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/proximity/as3935.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 9aa2ce551ba8..692e9cda8ae0 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -346,7 +346,6 @@ static int as3935_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  	st->spi = spi;
> -	st->tune_cap = 0;
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	mutex_init(&st->lock);
> 


-- 
Best regards,
Marek Vasut
