Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47389 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdDBJEL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 05:04:11 -0400
Subject: Re: [PATCH] staging: iio: meter: Replace mlock with driver private
 buf_lock
To: Arushi Singhal <arushisinghal19971997@gmail.com>, lars@metafoo.de
References: <20170331024702.GA18533@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3850b99e-dfb2-7b67-cb50-3879641df3ab@kernel.org>
Date: Sun, 2 Apr 2017 10:04:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170331024702.GA18533@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 03:47, Arushi Singhal wrote:
> The driver needs to insure atomicity during frequency
> changes of bus and device. The iiodev->mlock as used
> was not doing that. Replace it with the drivers existing
> buffer lock and execute spi_write directly.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Firstly please put the driver name in the title when a patch only
effects one driver.

Secondly, please see final version of Gargi Sharma's patch for
the ade7754.

As with that one, the basic principle is fine, but I didn't
like the V2 version which did the local copy of spi_write as
you have here.

Introduced an unlocked version of the ade7759_spi_write_reg_16
function and call it both from ade7759_spi_write_reg_16 and
directly here.

Puts the _WRITE_REG magic all in one place.

Otherwise, looks good!

Jonathan
> ---
>  drivers/staging/iio/meter/ade7759.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 0b65f1847510..a5ee4501d30a 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -429,7 +429,7 @@ static ssize_t ade7759_write_frequency(struct device *dev,
>  	if (!val)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->buf_lock);
>  
>  	t = 27900 / val;
>  	if (t > 0)
> @@ -447,10 +447,13 @@ static ssize_t ade7759_write_frequency(struct device *dev,
>  	reg &= ~(3 << 13);
>  	reg |= t << 13;
>  
> -	ret = ade7759_spi_write_reg_16(dev, ADE7759_MODE, reg);
> +	st->tx[0] = ADE7759_WRITE_REG(ADE7759_MODE);
> +	st->tx[1] = reg;
> +
> +	ret = spi_write(st->us, st->tx, 2);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->buf_lock);
>  
>  	return ret ? ret : len;
>  }
> 

