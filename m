Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaKPUVH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 15:21:07 -0500
Message-ID: <54690730.5070502@kernel.org>
Date: Sun, 16 Nov 2014 20:21:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 3/4] iio: gyro: bmg160: Send x, y and z motion separately
References: <1412998408-31870-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1412998408-31870-4-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998408-31870-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/14 04:33, Srinivas Pandruvada wrote:
> This chip is capable to identify motion across x, y and z axes. So
> send different events.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Taking the view this is an ABI 'fix' and applying it to the fixes-togreg branch
of iio.git

Thanks

Jonathan
> ---
>  drivers/iio/gyro/bmg160.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> index fa2e376..9f751d6 100644
> --- a/drivers/iio/gyro/bmg160.c
> +++ b/drivers/iio/gyro/bmg160.c
> @@ -85,6 +85,9 @@
>  
>  #define BMG160_REG_INT_STATUS_2	0x0B
>  #define BMG160_ANY_MOTION_MASK		0x07
> +#define BMG160_ANY_MOTION_BIT_X		BIT(0)
> +#define BMG160_ANY_MOTION_BIT_Y		BIT(1)
> +#define BMG160_ANY_MOTION_BIT_Z		BIT(2)
>  
>  #define BMG160_REG_TEMP		0x08
>  #define BMG160_TEMP_CENTER_VAL		23
> @@ -929,10 +932,24 @@ static irqreturn_t bmg160_event_handler(int irq, void *private)
>  	else
>  		dir = IIO_EV_DIR_FALLING;
>  
> -	if (ret & BMG160_ANY_MOTION_MASK)
> +	if (ret & BMG160_ANY_MOTION_BIT_X)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
>  							0,
> -							IIO_MOD_X_OR_Y_OR_Z,
> +							IIO_MOD_X,
> +							IIO_EV_TYPE_ROC,
> +							dir),
> +							data->timestamp);
> +	if (ret & BMG160_ANY_MOTION_BIT_Y)
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
> +							0,
> +							IIO_MOD_Y,
> +							IIO_EV_TYPE_ROC,
> +							dir),
> +							data->timestamp);
> +	if (ret & BMG160_ANY_MOTION_BIT_Z)
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
> +							0,
> +							IIO_MOD_Z,
>  							IIO_EV_TYPE_ROC,
>  							dir),
>  							data->timestamp);
> 

