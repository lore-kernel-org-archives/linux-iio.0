Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbeAUMvl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jan 2018 07:51:41 -0500
Date: Sun, 21 Jan 2018 12:51:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: ade7758: Replace mlock with buf_lock
Message-ID: <20180121125136.5a386ec8@archlinux>
In-Reply-To: <1516463088-2514-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1516463088-2514-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 20 Jan 2018 21:14:48 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> iio_dev->mlock is to be used only by the IIO core for protecting
> device mode changes between INDIO_DIRECT and INDIO_BUFFER.
> 
> This patch replaces the use of mlock with the already established
> buf_lock mutex.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

You can't do it this simply as it will cause deadlock due to nested
locking of the buf_lock.

To share the lock you will need to provide unlocked versions of
the read and write functions and use those if the lock has already been
taken.

Jonathan

> ---
>  drivers/staging/iio/meter/ade7758_core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index 7b7ffe5..1a866cc 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -523,12 +523,13 @@ static int ade7758_read_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	int ret;
> +	struct ade7758_state *st = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->buf_lock);
>  		ret = ade7758_read_samp_freq(&indio_dev->dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->buf_lock);
>  		return ret;
>  	default:
>  		return -EINVAL;
> @@ -542,14 +543,15 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	int ret;
> +	struct ade7758_state *st = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->buf_lock);
>  		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->buf_lock);
>  		return ret;
>  	default:
>  		return -EINVAL;

