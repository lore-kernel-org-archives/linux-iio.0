Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39504 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeC3KEM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Mar 2018 06:04:12 -0400
Date: Fri, 30 Mar 2018 11:04:09 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: imu: inv_mpu6050: clean double declaration of
 set_power_itg
Message-ID: <20180330110409.1a5235a9@archlinux>
In-Reply-To: <CY4PR1201MB0184FA5F5A0E0F5902E86879C4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB0184FA5F5A0E0F5902E86879C4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Mar 2018 14:01:20 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Given this one stands on it's own, I've applied it to the togreg
branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 0657941..c3d6225 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -298,5 +298,4 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
>  int inv_mpu_core_remove(struct device *dev);
> -int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  extern const struct dev_pm_ops inv_mpu_pmops;

