Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50332 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbdC2VXD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 17:23:03 -0400
Subject: Re: [RFC] staging: iio: update locking method during frequency writes
To: Gargi Sharma <gs051095@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <1490471717-1413-1-git-send-email-gs051095@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cc87176d-4bcd-8681-e221-30ee22ba7100@kernel.org>
Date: Wed, 29 Mar 2017 22:23:00 +0100
MIME-Version: 1.0
In-Reply-To: <1490471717-1413-1-git-send-email-gs051095@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/03/17 19:55, Gargi Sharma wrote:
> The driver needs to insure atomicity during frequency
> changes of bus and device. The iiodev->mlock as used
> was not doing that. Replace it with the drivers existing
> buffer lock and execute spi_write directly.
> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
> ---
> ade7754_set_irq() has a similar read then write without any locking
> mechanism in place. Do we want to introduce something similar there?
Hmm. Tricky to construct a sequence where lack of locking would be a
problem. Right now it is definitely not possible to call it twice
concurrently.  If it became possible in future it would perhaps
need revisiting.


> ---
>  drivers/staging/iio/meter/ade7754.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index c8d2d4c..48339e9a 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -513,7 +513,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
>  	if (!val)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->buf_lock);
>  
>  	t = 26000 / val;
>  	if (t > 0)
> @@ -531,10 +531,13 @@ static ssize_t ade7754_write_frequency(struct device *dev,
>  	reg &= ~(3 << 3);
>  	reg |= t << 3;
>  
> -	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
> +	st->tx[0] = ADE7754_WRITE_REG(ADE7754_WAVMODE);
> +	st->tx[1] = reg;
> +
> +	ret = spi_write(st->us, st->tx, 2);
hmm. Approach is fairly sound, though might be marginally neater to define a
__ade7754_spi_write_reg_8 or similar with a comment saying it is the unlocked
version of the normally named function.  Use that in ade7754_spi_write_reg_8 and
here.

More importantly, buf_lock is now protecting rather more than before so the
comment should be updated when documenting the structure.
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->buf_lock);
>  
>  	return ret ? ret : len;
>  }
> 

