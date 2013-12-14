Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46450 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab3LNLRc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Dec 2013 06:17:32 -0500
Message-ID: <52AC3E47.4010007@kernel.org>
Date: Sat, 14 Dec 2013 11:17:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: cm36651: Changed return value of read function
References: <52A5284D.4080906@samsung.com>
In-Reply-To: <52A5284D.4080906@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/09/13 02:17, Beomho Seo wrote:
> Hello,
> 
> I have fixed cm36651 driver.
> Some return value of callback have been changed to IIO_VAL_INT.
> If not IIO_VAL_INT, driver will print wrong value(*_read_int_time) or not print(*_read_prox_thresh).
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Applied to the fixes-togreg branch of iio.git

This is going to cause a merge conflict with the reworking of the event
handling in the togreg branch, but the solution is simple so shouldn't
cause any problems (hopefully I'll remember to metion it when I send
the pull requests!)
> ---
>  drivers/iio/light/cm36651.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 21df571..0206eab 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -387,7 +387,7 @@ static int cm36651_read_int_time(struct cm36651_data *cm36651,
>  		return -EINVAL;
>  	}
> 
> -	return IIO_VAL_INT_PLUS_MICRO;
> +	return IIO_VAL_INT;
>  }
> 
>  static int cm36651_write_int_time(struct cm36651_data *cm36651,
> @@ -494,7 +494,7 @@ static int cm36651_read_prox_thresh(struct iio_dev *indio_dev,
> 
>  	*val = cm36651->ps_ctrl_regs[CM36651_PS_THD];
> 
> -	return 0;
> +	return IIO_VAL_INT;
>  }
> 
>  static int cm36651_write_prox_thresh(struct iio_dev *indio_dev,
> 
