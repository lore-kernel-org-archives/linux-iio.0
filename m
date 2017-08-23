Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:43274 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbdHWGlo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Aug 2017 02:41:44 -0400
Date: Wed, 23 Aug 2017 08:41:43 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix missing break in switch
In-Reply-To: <20170822191324.GA15477@embeddedgus>
Message-ID: <alpine.DEB.2.20.1708230841050.6913@vps.pmeerw.net>
References: <20170822191324.GA15477@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Add missing break statement to prevent the code for case
> IIO_CHAN_INFO_CALIBBIAS falling through to the default case.
> 
> Also, add a break to the default case for the switch within
> case IIO_CHAN_INFO_CALIBBIAS.

fix seems to be cosmetic only...

> Addresses-Coverity-ID: 1357377
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> This issue was reported by Coverity and it was tested by compilation only.
> Please, verify if this is an actual bug.
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 44830bc..6d2268a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -542,7 +542,9 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			result = -EINVAL;
> +			break;
>  		}
> +		break;
>  	default:
>  		result = -EINVAL;
>  		break;
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
