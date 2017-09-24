Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbdIXORH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 10:17:07 -0400
Date: Sun, 24 Sep 2017 15:17:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshi Jain <himshijain.hj@gmail.com>
Cc: outreachy-kernel@googlegroups.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: ade7753:  replace mlock with driver
 private lock
Message-ID: <20170924151702.776d1ec6@archlinux>
In-Reply-To: <20170918065952.GA5386@himanshi-Inspiron-5558>
References: <20170918065952.GA5386@himanshi-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Sep 2017 12:29:52 +0530
Himanshi Jain <himshijain.hj@gmail.com> wrote:

> Replace driver usage of mlock with driver private lock to meet the new
> model where usage of iio_dev->mlock is being redefined as protecting
> operating mode changes(changes between BUFFER* and DIRECT modes).
> 
> Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>

A well presented patch making a sensible change.  My only thought here
is that ultimately we could cover bother the buffer protection and
the state protection with a single lock.

Hmm. The new lock (as was the old mlock code) is providing protection
to ensure we end up with consistent state when changing the
sampling frequency between the sampling frequency and the
bus clock speed (which has different maximum values depending
on the current sampling frequency). In similar cases we have
expanded the meaning on the buffer lock to fulfil both roles
- that could be done here as well, although you have to be careful
about deadlocks.

On reflection I think this patch is worthwhile applying even
if this new lock gets dropped again in some later rework of this
driver.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7753.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index ce26abdea..745c5a6 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -81,10 +81,12 @@
>   * @tx:         transmit buffer
>   * @rx:         receive buffer
>   * @buf_lock:       mutex to protect tx and rx
> + * @lock:	protect sensor data
>   **/
>  struct ade7753_state {
>  	struct spi_device   *us;
>  	struct mutex        buf_lock;
> +	struct mutex	    lock; /* protect sensor data */
>  	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>  	u8          rx[ADE7753_MAX_RX];
>  };
> @@ -483,7 +485,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>  	if (!val)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	t = 27900 / val;
>  	if (t > 0)
> @@ -504,7 +506,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>  	ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -580,6 +582,7 @@ static int ade7753_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	st->us = spi;
>  	mutex_init(&st->buf_lock);
> +	mutex_init(&st->lock);
>  
>  	indio_dev->name = spi->dev.driver->name;
>  	indio_dev->dev.parent = &spi->dev;

