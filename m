Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:10990
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751182AbeEPHvM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 May 2018 03:51:12 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: advertise max and min freqs
To: Martin Kelly <mkelly@xevo.com>, linux-iio@vger.kernel.org
References: <20180515215349.27482-1-mkelly@xevo.com>
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Message-ID: <379508e0-0e27-6df6-f29d-1f892745c606@invensense.com>
Date: Wed, 16 May 2018 09:51:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180515215349.27482-1-mkelly@xevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 15/05/2018 23:53, Martin Kelly wrote:
> CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Currently, we allow a minimum FIFO rate of 4 and a max of 1000, but we
> advertise down to only 10 and up to 1000. Expand the advertised range to
> reflect the full available range.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 43fba5f7532b..3f4862f09db3 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -799,7 +799,7 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
>   };
> 
>   /* constant IIO attribute */
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4 10 20 50 100 200 500 1000");
>   static IIO_CONST_ATTR(in_anglvel_scale_available,
>                                            "0.000133090 0.000266181 0.000532362 0.001064724");
>   static IIO_CONST_ATTR(in_accel_scale_available,
> --
> 2.11.0
> 

Hello,

in fact we advertise only frequencies that are supported by the low-pass 
filter. Filter bandwidths are: 5Hz, 10Hz, 20Hz, 42Hz (~50), 98Hz (~100), 
188Hz (~200), which are corresponding to a sampling rate of (x2): 10Hz, 
20Hz, ~50Hz, ~200Hz, ~400Hz. Only 500Hz is a little out of specs, since 
400Hz is not a possible frequency.

You can always set the frequency to any supported values, but you can 
suffer from aliasing.

I strongly suggest we just keep it like it is today. Better not 
advertise frequencies that are not correctly filtered.

JB
