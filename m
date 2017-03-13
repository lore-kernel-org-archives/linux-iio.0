Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:57505 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdCMLkG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 07:40:06 -0400
Subject: Re: [PATCH 2/2] staging: iio: adis16240: Modify existing comment.
To: Varsha Rao <rvarsha016@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org
References: <cover.1489395260.git.rvarsha016@gmail.com>
 <58c66533.42d5620a.3e22a.3a06@mx.google.com>
Cc: outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5a05de57-4d0d-f066-1966-f39865e126ce@metafoo.de>
Date: Mon, 13 Mar 2017 12:39:11 +0100
MIME-Version: 1.0
In-Reply-To: <58c66533.42d5620a.3e22a.3a06@mx.google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/13/2017 10:23 AM, Varsha Rao wrote:
> Modify the existing comment to reflect the changes from mlock to
> txrx_lock.
> 
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16240.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index c182b2d..aa3030c 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -231,7 +231,7 @@ static ssize_t adis16240_read_12bit_signed(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct adis *st = iio_priv(indio_dev);
>  
> -	/* Take the iio_dev status lock */
> +	/* Take adis txrx_lock to protect sensor state */

This should be part of the patch that changes the lock.

>  	mutex_lock(&st->txrx_lock);
>  	ret =  adis16240_spi_read_signed(dev, attr, buf, 12);
>  	mutex_unlock(&st->txrx_lock);
> 

