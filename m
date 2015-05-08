Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52564 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbbEHSa1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:30:27 -0400
Message-ID: <554CD152.7080304@kernel.org>
Date: Fri, 08 May 2015 11:08:02 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Varka Bhadram <varkabhadram@gmail.com>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
CC: Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH iio] imu: inv_mpu6050: adds device tree bindings
References: <1429867387-10219-1-git-send-email-varkab@cdac.in>
In-Reply-To: <1429867387-10219-1-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/15 05:23, Varka Bhadram wrote:
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
Applied to the togreg branch of iio.git. Will be initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> new file mode 100644
> index 0000000..e4d8f1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -0,0 +1,17 @@
> +InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
> +
> +http://www.invensense.com/mems/gyro/mpu6050.html
> +
> +Required properties:
> + - compatible : should be "invensense,mpu6050"
> + - reg : the I2C address of the sensor
> + - interrupt-parent : should be the phandle for the interrupt controller
> + - interrupts : interrupt mapping for GPIO IRQ
> +
> +Example:
> +	mpu6050@68 {
> +		compatible = "invensense,mpu6050";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <18 1>;
> +	};
> 

