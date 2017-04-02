Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47173 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdDBImB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:42:01 -0400
Subject: Re: [PATCH 3/3] staging: iio: light: Remove useless type conversion
To: simran singhal <singhalsimran0@gmail.com>
References: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
 <1490972930-15476-4-git-send-email-singhalsimran0@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <06fde090-96a6-8a28-3553-d6446dd9b58d@kernel.org>
Date: Sun, 2 Apr 2017 09:41:59 +0100
MIME-Version: 1.0
In-Reply-To: <1490972930-15476-4-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 16:08, simran singhal wrote:
> Some type conversions like casting a pointer to a pointer of same type,
> casting to the original type using addressof(&) operator etc. are not
> needed. Therefore, remove them. Done using coccinelle:
> 
> @@
> type t;
> t *p;
> t a;
> @@
> (
> - (t)(a)
> + a
> |
> - (t *)(p)
> + p
> |
> - (t *)(&a)
> + &a
> )
> 
Description is largely irrelevant.  Please tailor it to the patch.
Also if only effecting one driver, the title should include the name of
the driver.
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index ea15bc1..0490c1d 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -624,7 +624,7 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  	dev_info(&chip->client->dev,
>  		 "%s als_calibrate completed\n", chip->client->name);
>  
> -	return (int)gain_trim_val;
> +	return gain_trim_val;
>  }
>  
>  static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
> 

