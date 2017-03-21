Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40883 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933294AbdCUTpu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 15:45:50 -0400
Subject: Re: [PATCH] staging: ade7754: Replace mlock with buf_lock and
 refactor code
To: Gargi Sharma <gs051095@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <1489995561-6988-1-git-send-email-gs051095@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <087b03c7-9480-67b8-4c95-4248a1381500@kernel.org>
Date: Tue, 21 Mar 2017 19:45:47 +0000
MIME-Version: 1.0
In-Reply-To: <1489995561-6988-1-git-send-email-gs051095@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 07:39, Gargi Sharma wrote:
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
> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
Question inline.
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
This block doesn't fit with the description.  What's going on here?
> +
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
> 

