Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752004AbeCXNeb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:34:31 -0400
Date: Sat, 24 Mar 2018 13:34:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 03/11] staging: iio: tsl2x7x: no need to clear interrupt
 flag when getting lux
Message-ID: <20180324133426.6d0053f7@archlinux>
In-Reply-To: <20180321102912.5130-4-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:04 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_get_lux() does not need to clear the interrupt flag when
> querying the ALS. The interrupt flag is cleared in
> tsl2x7x_event_handler(). This patches removes the unnecessary code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 59921850a226..9c929e273135 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -387,10 +387,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		buf[i] = ret;
>  	}
>  
> -	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_ALS_INT_CLR);
> -	if (ret < 0)
> -		goto out_unlock;
> -
>  	/* extract ALS/lux data */
>  	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
>  	ch1 = le16_to_cpup((const __le16 *)&buf[2]);

