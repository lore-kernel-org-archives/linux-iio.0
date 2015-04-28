Return-Path: <varkabhadram@gmail.com>
Message-ID: <553EFEFA.5010708@gmail.com>
Date: Tue, 28 Apr 2015 09:01:06 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC: jic23@kernel.org, Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH iio] imu: inv_mpu6050: adds device tree bindings
References: <1429867387-10219-1-git-send-email-varkab@cdac.in>
In-Reply-To: <1429867387-10219-1-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/24/2015 02:53 PM, Varka Bhadram wrote:

> Signed-off-by: Varka Bhadram <varkab@cdac.in>
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

Ping..?

-- 
Varka Bhadram
