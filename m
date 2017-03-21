Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34290 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757145AbdCURcz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 13:32:55 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so23023691pfb.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 10:32:55 -0700 (PDT)
Date: Tue, 21 Mar 2017 10:24:38 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Gargi Sharma <gs051095@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Subject: Re: [Outreachy kernel] [PATCH] staging: ade7754: Replace mlock with
 buf_lock and refactor code
Message-ID: <20170321172438.GC2793@d830.WORKGROUP>
References: <1489995561-6988-1-git-send-email-gs051095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489995561-6988-1-git-send-email-gs051095@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 20, 2017 at 01:09:21PM +0530, Gargi Sharma wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes. Replace it with buf_lock in the devices global data.
> 
> As buf_lock already protects operations in ade7754_write_frequency,
> there isn't a need to acquire the lock inside ade7754_spi_write_reg_8
> when writing to the register.

Hi Gargi,

Looks like something went wrong in your patch below.  It doesn't do what
you say it'll do...Instead of removing the lock from _write_reg_8()
it inserts a bunch of code.  Anyway, it seems that w_rite_reg_8() is used
in multiple places, so removing that lock doesn't appear to be an
option.

See below...

alisons

> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7754.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index 024463a..eb03469 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -29,6 +29,15 @@ static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7754_state *st = iio_priv(indio_dev);
>  
> +	if (reg_address == ADE7754_WAVMODE) {
> +		st->tx[0] = ADE7754_WRITE_REG(reg_address);
> +		st->tx[1] = val;
> +
> +		ret = spi_write(st->us, st->tx, 2);
> +
> +		return ret;
> +	}
> +
What's this?

>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7754_WRITE_REG(reg_address);
>  	st->tx[1] = val;
> @@ -430,7 +439,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
>  	if (!val)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->buf_lock);
>  
>  	t = 26000 / val;
>  	if (t > 0)
> @@ -451,7 +460,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
>  	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->buf_lock);
>  
>  	return ret ? ret : len;
>  }
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1489995561-6988-1-git-send-email-gs051095%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
