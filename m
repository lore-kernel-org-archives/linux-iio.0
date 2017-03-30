Return-Path: <SRS0=7/Tb=3H=gmail.com=robherring2@kernel.org>
Date: Thu, 30 Mar 2017 18:02:52 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Mark.Rutland@arm.com
Subject: Re: [PATCH 1/2] iio:imu:mpu6050 update i2c bindings to reflect
 i2c-gate and supported parts
Message-ID: <20170330230252.cxbdh3g744qwdtfh@rob-hp-laptop>
References: <20170326111100.2571-1-jic23@kernel.org>
 <20170326111100.2571-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170326111100.2571-2-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 26, 2017 at 12:10:59PM +0100, Jonathan Cameron wrote:
> These bindings are somewhat lagging the state of the driver.  The i2c-gate
> bindings are documented elsewhere, but it seems sensible to at least have
> an example and cross reference in here.  SPI bindings will need to be the
> subject of a future patch.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 23 ++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index a9fc11e43b45..e18e04f3c6f4 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -3,14 +3,17 @@ InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
>  http://www.invensense.com/mems/gyro/mpu6050.html
>  
>  Required properties:
> - - compatible : should be "invensense,mpu6050"
> + - compatible : should be "invensense,mpu6050", "invensense,mpu6500",
> +   "invensense,mpu9150" or "invensense,icm20608"

One per line please. With that,

Acked-by: Rob Herring <robh@kernel.org>
