Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50284 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932689AbdC2VQj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 17:16:39 -0400
Subject: Re: [RFC] staging: iio: ad7759: Replace mlock with driver private
 buf_lock
To: Arushi Singhal <arushisinghal19971997@gmail.com>, lars@metafoo.de
References: <20170328173721.GA12157@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4fd5df27-288b-f544-8860-4516ef52888f@kernel.org>
Date: Wed, 29 Mar 2017 22:16:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170328173721.GA12157@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/17 18:37, Arushi Singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a buf_lock in the devices global data.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Rule 1 of an RFC.  Explain why it is an RFC rather than simply a
patch.  What needs comment here in particular?

One thing that needs doing is a documentation update to reflect
the additional elements buf_lock is now protecting.

I think the use is sensible and can't otherwise see any issue with
this patch.

Thanks,

Jonathan
> ---

>  drivers/staging/iio/meter/ade7759.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 0b65f1847510..514a4f6bb8f9 100644
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
> +	st->tx[0] = ADE7754_WRITE_REG(ADE7754_WAVMODE);
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

