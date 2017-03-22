Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48575 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753768AbdCVUdD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:33:03 -0400
Subject: Re: [PATCH] staging: ad7759: Replace mlock with driver private lock
To: Arushi Singhal <arushisinghal19971997@gmail.com>, lars@metafoo.de
References: <20170320160926.GA7088@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <28e4d9ae-9159-0ab7-1958-1ea9f996646e@kernel.org>
Date: Wed, 22 Mar 2017 20:33:00 +0000
MIME-Version: 1.0
In-Reply-To: <20170320160926.GA7088@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 16:09, Arushi Singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7759.c | 4 ++--
>  drivers/staging/iio/meter/ade7759.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 944ee3401029..1d1e0b33021f 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -381,7 +381,7 @@ static ssize_t ade7759_write_frequency(struct device *dev,
>  	if (!val)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->buf_lock);
>  
>  	t = 27900 / val;
>  	if (t > 0)
> @@ -402,7 +402,7 @@ static ssize_t ade7759_write_frequency(struct device *dev,
Deadlock as this call also take the buf_lock mutex..


>  	ret = ade7759_spi_write_reg_16(dev, ADE7759_MODE, reg);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->buf_lock);
>  
>  	return ret ? ret : len;
>  }
> diff --git a/drivers/staging/iio/meter/ade7759.h b/drivers/staging/iio/meter/ade7759.h
> index f0716d2fdf8e..4f69bb93cc45 100644
> --- a/drivers/staging/iio/meter/ade7759.h
> +++ b/drivers/staging/iio/meter/ade7759.h
> @@ -42,6 +42,7 @@
>   * @buf_lock:		mutex to protect tx and rx
>   * @tx:			transmit buffer
>   * @rx:			receive buffer
> + * @lock		protect sensor state
?
>   **/
>  struct ade7759_state {
>  	struct spi_device	*us;
> 

