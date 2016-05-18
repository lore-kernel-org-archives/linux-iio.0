Return-Path: <robh@kernel.org>
Date: Wed, 18 May 2016 18:46:47 -0500
From: Rob Herring <robh@kernel.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <ggao@invensense.com>, Peter Rosin <peda@axentia.se>,
	linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [RFC v2 5/7] iio: inv_mpu6050: Add support for auxiliary I2C
 master
Message-ID: <20160518234647.GA12939@rob-hp-laptop>
References: <cover.1463582011.git.leonard.crestez@intel.com>
 <2aa92f6390bdb58362755ce9d61f3260f4d77e64.1463582011.git.leonard.crestez@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2aa92f6390bdb58362755ce9d61f3260f4d77e64.1463582011.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 18, 2016 at 06:00:52PM +0300, Crestez Dan Leonard wrote:
> The MPU has an auxiliary I2C bus for connecting external
> sensors. This bus has two operating modes:
> * bypasss: which connects the primary and auxiliary busses
> together. This is already supported via an i2c mux.
> * master: where the MPU acts as a master to any external
> connected sensors. This is implemented by this patch.
> 
> This I2C master mode also works when the MPU itself is connected via
> SPI.
> 
> I2C master supports up to 5 slaves. Slaves 0-3 have a common operating
> mode while slave 4 is different. This patch implements an i2c adapter
> using slave 4.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  66 +++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 258 ++++++++++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  36 +++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   8 -
>  4 files changed, 355 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index a9fc11e..778d076 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -1,16 +1,31 @@
>  InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
>  
> -http://www.invensense.com/mems/gyro/mpu6050.html
> -
>  Required properties:
> - - compatible : should be "invensense,mpu6050"
> - - reg : the I2C address of the sensor
> + - compatible : one of "invensense,mpu6000", "invensense,mpu6050",
> +	"invensense,mpu6000" or "invensense,mpu9150"
> + - reg : the I2C or SPI address of the sensor
>   - interrupt-parent : should be the phandle for the interrupt controller
>   - interrupts : interrupt mapping for GPIO IRQ
>  
>  Optional properties:
>   - mount-matrix: an optional 3x3 mounting rotation matrix
> + - invensense,i2c-aux-master: operate aux i2c in "master" mode (default is bypass).
> +
> +The MPU has an auxiliary i2c bus for additional sensors. Devices attached this
> +way can be described as for a regular linux i2c bus.
> +
> +It is possible to interact with aux devices in "bypass" or "master" mode. In
> +"bypass" mode the auxiliary SDA/SCL lines are connected directly to the main i2c
> +interface. In "master" mode access to aux devices is done by instructing the
> +MPU to read or write i2c bytes.
> +
> +In "bypass" mode aux devices are listed behind a "i2c@0" node with reg = <0>;
> +In "master" mode aux devices are listed behind a "i2c@1" node with reg = <1>;

What is meaning and purpose of 0 and 1? You know which mode based on 
invensense,i2c-aux-master.

I don't see the reason for this intermediate node. In bypass mode, the 
driver should register the child nodes with the parent node's bus. In 
master mode, the mpu driver should register itself as an i2c adapter and 
then probe its child nodes. Maybe I'm missing something from all the 
discussion.

> +The master and bypass modes are not supported at the same time. The
> +"invensense,i2c-aux-master" property must be set to activate master mode.
> +Bypass mode is generally faster but master mode also works when the MPU is
> +connected via SPI.

invensense,i2c-aux-master should only apply if the host interface is 
SPI. Bypass mode is faster, it there any reason to use master mode when 
the host is I2C? A slave address conflict is the only thing I can think 
of.

Rob
