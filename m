Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46790 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933464AbaHYUpB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 16:45:01 -0400
Message-ID: <53FBA04B.1030103@kernel.org>
Date: Mon, 25 Aug 2014 21:44:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH v1 6/8] iio: gyro: itg3200: Fix indio_dev->trig assignment
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1408740516-31261-7-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-7-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/14 21:48, Srinivas Pandruvada wrote:
> This can result in wrong reference count for trigger device, call
> iio_trigger_get to increment reference.
> Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
> with Jonathan.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
>  drivers/iio/gyro/itg3200_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> index e3b3c50..eef50e9 100644
> --- a/drivers/iio/gyro/itg3200_buffer.c
> +++ b/drivers/iio/gyro/itg3200_buffer.c
> @@ -132,7 +132,7 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
>  		goto error_free_irq;
>  
>  	/* select default trigger */
> -	indio_dev->trig = st->trig;
> +	indio_dev->trig = iio_trigger_get(st->trig);
>  
>  	return 0;
>  
> 
