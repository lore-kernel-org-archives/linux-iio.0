Return-Path: <peda@axentia.se>
Subject: Re: [RFC 5/7] iio: inv_mpu6050: Add support for auxiliary I2C master
To: Crestez Dan Leonard <leonard.crestez@intel.com>, Jonathan Cameron
	<jic23@kernel.org>, <linux-iio@vger.kernel.org>
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <4aeaced7c1c8e222996df4c1b4b71e505ab256f7.1461953982.git.leonard.crestez@intel.com>
CC: <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Daniel Baluta <daniel.baluta@intel.com>, Ge Gao
	<GGao@invensense.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <de59c1ec-c757-2118-04cc-616c809e666f@axentia.se>
Date: Mon, 2 May 2016 17:31:45 +0200
MIME-Version: 1.0
In-Reply-To: <4aeaced7c1c8e222996df4c1b4b71e505ab256f7.1461953982.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-04-29 21:02, Crestez Dan Leonard wrote:
> The MPU has an auxiliary I2C bus for connecting external
> sensors. This bus has two operating modes:
> * pass-through, which connects the primary and auxiliary busses
> together. This is already supported via an i2c mux.
> * I2C master mode, where the mpu60x0 acts as a master to any external
> connected sensors. This is implemented by this patch.
> 
> This I2C master mode also works when the MPU itself is connected via
> SPI.
> 
> I2C master supports up to 5 slaves. Slaves 0-3 have a common operating
> mode while slave 4 is different. This patch implements an i2c adapter
> using slave 4 because it has a cleaner interface and it has an
> interrupt that signals when data from slave to master arrived.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  61 +++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 239 ++++++++++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  46 ++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   8 -
>  4 files changed, 341 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index a9fc11e..aaf12b4 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -1,16 +1,27 @@
>  InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
>  
> -http://www.invensense.com/mems/gyro/mpu6050.html
> -
>  Required properties:
> - - compatible : should be "invensense,mpu6050"
> - - reg : the I2C address of the sensor
> + - compatible : should be "invensense,mpuXXXX"
> + - reg : the I2C or SPI address of the sensor
>   - interrupt-parent : should be the phandle for the interrupt controller
>   - interrupts : interrupt mapping for GPIO IRQ
>  
>  Optional properties:
>   - mount-matrix: an optional 3x3 mounting rotation matrix
> + - inv,i2c-aux-master: operate aux i2c in "master mode" (default is mux).

I've looked a bit more into this, and I don't think you need
this property...

> +
> +Valid compatible strings:
> + - mpu6000
> + - mpu6050
> + - mpu6500
> + - mpu9150
> +
> +It is possible to attach auxiliary sensors to the MPU and have them be handled
> +by linux. Those auxiliary sensors are described as an i2c bus.
> +
> +Devices connected in "bypass" mode must be listed behind i2c@0 with the address 0
>  
> +Devices connected in "master" mode must be listed behind i2c@1 with the address 1

...and just condition the new stuff on the name i2c-master
instead. If there is no i2c-master child, then fall back
to the mux code. Does that work?

>  Example:
>  	mpu6050@68 {
> @@ -28,3 +39,45 @@ Example:
>  		               "0",                   /* y2 */
>  		               "0.984807753012208";   /* z2 */
>  	};
> +
> +Example describing mpu9150 (which includes an ak9875 on chip):
> +	mpu9150@68 {
> +		compatible = "invensense,mpu9150";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <18 1>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ak8975@0c {
> +				compatible = "ak,ak8975";
> +				reg = <0x0c>;
> +			};
> +		};
> +	};
> +
> +Example describing a mpu6500 via SPI with an hmc5883l on auxiliary i2c:
> +	mpu6500@0 {
> +		compatible = "inv,mpu6500";
> +		reg = <0x0>;
> +		spi-max-frequency = <1000000>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <31 1>;
> +
> +		inv,i2c-aux-master

If you keep the below as i2c@1, including the @, I think you also need
	#address-cells = <1>;
	#size-cells = <0>;

As always, I'm not a device tree expert, but I'd be glad to lose
these extra lines and change i2c@1 into i2c-master.

> +		i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hmc5883l@1e {
> +				compatible = "honeywell,hmc5883l";
> +				reg = <0x1e>;
> +			};
> +		};
> +	};

*snip*

Cheers,
Peter
