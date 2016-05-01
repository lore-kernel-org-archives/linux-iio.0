Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48862 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbcEAV0b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:26:31 -0400
Subject: Re: [PATCH] iio: light: bh1780: return after write
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1461844961-28558-1-git-send-email-linus.walleij@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5fed5120-ed2c-60ab-704b-8a832ff91c23@kernel.org>
Date: Sun, 1 May 2016 20:42:06 +0100
MIME-Version: 1.0
In-Reply-To: <1461844961-28558-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/04/16 13:02, Linus Walleij wrote:
> When writing a value using direct reg access from debugfs
> we need to return and not fall through to reading the
> value, lest we'll dereference a NULL pointer.
> 
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
This is another one I'll have to pick up when I can create a fixes branch for
post the merge window.

Poke me if I forget it.

Jonathan
> ---
>  drivers/iio/light/bh1780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
> index 72b364e4aa72..f83595334ff1 100644
> --- a/drivers/iio/light/bh1780.c
> +++ b/drivers/iio/light/bh1780.c
> @@ -84,7 +84,7 @@ static int bh1780_debugfs_reg_access(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	if (!readval)
> -		bh1780_write(bh1780, (u8)reg, (u8)writeval);
> +		return bh1780_write(bh1780, (u8)reg, (u8)writeval);
>  
>  	ret = bh1780_read(bh1780, (u8)reg);
>  	if (ret < 0)
> 

