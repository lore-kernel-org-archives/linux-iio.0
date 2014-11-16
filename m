Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52087 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaKPUV0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 15:21:26 -0500
Message-ID: <54690745.7070805@kernel.org>
Date: Sun, 16 Nov 2014 20:21:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iio: gyro: bmg160: Fix iio_event_spec direction
References: <1412998408-31870-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1412998408-31870-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998408-31870-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/14 04:33, Srinivas Pandruvada wrote:
> Change event spec direction from
> IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING
> to
> IIO_EV_DIR_EITHER
> 
> Suggested-by: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/gyro/bmg160.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> index 9f751d6..d2fa526 100644
> --- a/drivers/iio/gyro/bmg160.c
> +++ b/drivers/iio/gyro/bmg160.c
> @@ -766,7 +766,7 @@ static const struct attribute_group bmg160_attrs_group = {
>  
>  static const struct iio_event_spec bmg160_event = {
>  		.type = IIO_EV_TYPE_ROC,
> -		.dir = IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING,
> +		.dir = IIO_EV_DIR_EITHER,
>  		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
>  				       BIT(IIO_EV_INFO_ENABLE)
>  };
> 

