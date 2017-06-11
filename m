Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbdFKMpx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 08:45:53 -0400
Date: Sun, 11 Jun 2017 13:45:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] iio: imu: inv_mpu6050: replace sprintf with
 scnprintf
Message-ID: <20170611134548.72e0d499@kernel.org>
In-Reply-To: <BLUPR12MB065777243F5CD0574B4B19B1C4C80@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB065777243F5CD0574B4B19B1C4C80@BLUPR12MB0657.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 7 Jun 2017 13:42:26 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 37fb18f..64af12c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -684,7 +684,8 @@ static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
>  	case ATTR_ACCL_MATRIX:
>  		m = st->plat_data.orientation;
>  
> -		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
> +		return scnprintf(buf, PAGE_SIZE,
> +			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
>  			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
>  	default:
>  		return -EINVAL;

