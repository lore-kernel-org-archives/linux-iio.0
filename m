Return-Path: <SRS0=7/Tb=3H=gmail.com=robherring2@kernel.org>
Date: Thu, 30 Mar 2017 18:18:46 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Mark.Rutland@arm.com
Subject: Re: [PATCH 2/2] iio:imu:mpu6050 add explicit mpu9250 support
Message-ID: <20170330231846.j45psrzast3pjc5b@rob-hp-laptop>
References: <20170326111100.2571-1-jic23@kernel.org>
 <20170326111100.2571-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170326111100.2571-3-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 26, 2017 at 12:11:00PM +0100, Jonathan Cameron wrote:
> The mpu9250 is a SIP containing an mpu6500 and an ak8975.  If this was all
> there was too it there would be no need for explicit handling in the driver.
> Arguably the bindings would also only reflect the presence of an mpu6500 with
> the ak8975 hanging off it, as the kernel doesn't care that they are in one
> package.
> 
> However, the WHOAMI value changes as well so best to add explicit support.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                | 6 ++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c                 | 5 +++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h                 | 2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c                 | 1 +
>  5 files changed, 15 insertions(+), 1 deletion(-)

Same one per line comment, but

Acked-by: Rob Herring <robh@kernel.org>
