Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52122 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaKPUZY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 15:25:24 -0500
Message-ID: <54690832.1010306@kernel.org>
Date: Sun, 16 Nov 2014 20:25:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iio: accel: bmc150: Fix iio_event_spec direction
References: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1412998534-31971-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998534-31971-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/14 04:35, Srinivas Pandruvada wrote:
> Change event spec direction from
> IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING
> to
> IIO_EV_DIR_EITHER
> 
> Suggested-by: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

> ---
>  drivers/iio/accel/bmc150-accel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 969cb21..513bd6d 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -853,7 +853,7 @@ static const struct attribute_group bmc150_accel_attrs_group = {
>  
>  static const struct iio_event_spec bmc150_accel_event = {
>  		.type = IIO_EV_TYPE_ROC,
> -		.dir = IIO_EV_DIR_RISING | IIO_EV_DIR_FALLING,
> +		.dir = IIO_EV_DIR_EITHER,
>  		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>  				 BIT(IIO_EV_INFO_ENABLE) |
>  				 BIT(IIO_EV_INFO_PERIOD)
> 

