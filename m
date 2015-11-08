Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43858 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbbKHPpg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 10:45:36 -0500
Subject: Re: [PATCH 2/2] iio: imu: check sscanf return value
To: Ioana Ciornei <ciorneiioana@gmail.com>, linux-iio@vger.kernel.org
References: <1446382725-11765-1-git-send-email-ciorneiioana@gmail.com>
 <1446382725-11765-2-git-send-email-ciorneiioana@gmail.com>
Cc: outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563F6E1F.7070205@kernel.org>
Date: Sun, 8 Nov 2015 15:45:35 +0000
MIME-Version: 1.0
In-Reply-To: <1446382725-11765-2-git-send-email-ciorneiioana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/11/15 12:58, Ioana Ciornei wrote:
> This patch fixes the following checkpatch warning:
> WARNING: unchecked sscanf return value
> 
> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
Applied to the togreg branch of stating - initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
> based on linux-iio testing branch
> 
>  drivers/iio/imu/adis16400_core.c | 6 +++++-
>  drivers/iio/imu/adis16480.c      | 4 +++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index abc4c50..72bcc24 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -288,7 +288,11 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
>  		if (ret)
>  			goto err_ret;
>  
> -		sscanf(indio_dev->name, "adis%u\n", &device_id);
> +		ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
> +		if (ret != 1) {
> +			ret = -EINVAL;
> +			goto err_ret;
> +		}
>  
>  		if (prod_id != device_id)
>  			dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index b94bfd3..16d4304 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -765,7 +765,9 @@ static int adis16480_initial_setup(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	sscanf(indio_dev->name, "adis%u\n", &device_id);
> +	ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
> +	if (ret != 1)
> +		return -EINVAL;
>  
>  	if (prod_id != device_id)
>  		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
> 

