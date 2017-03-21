Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33173 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbdCUQPu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 12:15:50 -0400
Received: by mail-pg0-f68.google.com with SMTP id 79so17279223pgf.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 09:15:49 -0700 (PDT)
Date: Tue, 21 Mar 2017 09:15:47 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Gargi Sharma <gs051095@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Subject: Re: [Outreachy kernel] [RESEND PATCH] staging: adis16203: Remove
 locking on raw reads of IIO_CHAN_INFO_CALIBBIAS
Message-ID: <20170321161547.GD1859@d830.WORKGROUP>
References: <1490112126-30265-1-git-send-email-gs051095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490112126-30265-1-git-send-email-gs051095@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 09:32:06PM +0530, Gargi Sharma wrote:
> adis16203_read_raw does not need lock for IIO_CHAN_INFO_CALIBBIAS
> since adis_read_reg_16 is already atomic and nothing else needs to be
> protected.
> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>

Just sent yesterday too!

> ---
>  drivers/staging/iio/accel/adis16203.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index 68189ad..14fe2d3 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -203,17 +203,14 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		bits = 14;
> -		mutex_lock(&indio_dev->mlock);
>  		addr = adis16203_addresses[chan->scan_index];
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
>  			return ret;
>  		}
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1490112126-30265-1-git-send-email-gs051095%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
