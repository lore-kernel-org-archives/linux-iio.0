Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46769 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873AbaHYUni (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 16:43:38 -0400
Message-ID: <53FB9FF8.6050506@kernel.org>
Date: Mon, 25 Aug 2014 21:43:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH v1 5/8] iio: st_sensors: Fix indio_dev->trig assignment
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1408740516-31261-6-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-6-git-send-email-srinivas.pandruvada@linux.intel.com>
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
Applied to the fixes-togreg branch of iio.git.
> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 8fc3a97..8d8ca6f 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -49,7 +49,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
>  		goto iio_trigger_register_error;
>  	}
> -	indio_dev->trig = sdata->trig;
> +	indio_dev->trig = iio_trigger_get(sdata->trig);
>  
>  	return 0;
>  
> 
