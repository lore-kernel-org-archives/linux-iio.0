Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38475 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcBVVtp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Feb 2016 16:49:45 -0500
Received: by mail-wm0-f45.google.com with SMTP id a4so182831758wme.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Feb 2016 13:49:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456177151-15881-2-git-send-email-matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
	<1456177151-15881-2-git-send-email-matt.ranostay@intel.com>
Date: Mon, 22 Feb 2016 23:49:44 +0200
Message-ID: <CAEnQRZBv4=UXVAzBn9rui2nyJ_UQdbqyUxDNchtZ9=mJ71Ympw@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: imu: mpu6050: use inv_mpu6050_sensor_show return code
From: Daniel Baluta <daniel.baluta@intel.com>
To: Matt Ranostay <matt.ranostay@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Adriana Reus <adriana.reus@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 22, 2016 at 11:39 PM, Matt Ranostay <matt.ranostay@intel.com> wrote:
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 225860016fed..4324328fd304 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -275,7 +275,7 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>                 case IIO_TEMP:
>                         /* wait for stablization */

While at it please also fix this type :D.

>                         msleep(INV_MPU6050_SENSOR_UP_TIME);
> -                       inv_mpu6050_sensor_show(st, st->reg->temperature,
> +                       ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
>                                                         IIO_MOD_X, val);
>                         break;
>                 default:
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
