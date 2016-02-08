Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Sun, 7 Feb 2016 20:31:05 -0600
From: Michael Welling <mwelling@ieee.org>
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	lucas.de.marchi@gmail.com
Subject: Re: [PATCH v2 0/4] iio: imu: inv_mpu6050: Split driver into core and
 I2C/SPI functionality
Message-ID: <20160208023105.GA12090@deathstar>
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 04, 2016 at 11:20:24AM +0200, Adriana Reus wrote:
> This series splits this driver into general and I2C/SPI specific functionality.
> The first patch is a fix for a bug in the interrupt pin configuration.
> The second patch changes all the I2C specific calls into regmap calls.
> The third patch separated the remaining I2C specific part into a different component.
> Finally the fourth patch adds SPI support for the MPU6000 chip.
> 
> No changes since v1 for the first two patches.
> Small changes since v1 to the last two patches
> 
> Adriana Reus (4):
>   iio: imu: inv-mpu6050: Fix interrupt pin configuration
>   iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
>   iio: imu: inv_mpu6050: Separate driver into core and i2c
>     functionality.
>   iio: imu: inv_mpu6050: Add SPI support for MPU6000
> 
>  drivers/iio/imu/inv_mpu6050/Kconfig           |  21 ++-
>  drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  14 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 253 +++++---------------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 207 +++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  17 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  35 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  87 +++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
>  9 files changed, 412 insertions(+), 240 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>

Got the following when compiling for a non ACPI target.

/home/michael/projects/linux/linux-git/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c:205:5: error: conflicting types for 'inv_mpu_acpi_create_mux_client'
 int inv_mpu_acpi_create_mux_client(struct inv_mpu6050_state *st)
     ^
In file included from /home/michael/projects/linux/linux-git/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c:203:0:
/home/michael/projects/linux/linux-git/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h:261:5: note: previous declaration of 'inv_mpu_acpi_create_mux_client' was here
 int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
     ^
/home/michael/projects/linux/linux-git/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c:210:6: error: conflicting types for 'inv_mpu_acpi_delete_mux_client'
 void inv_mpu_acpi_delete_mux_client(struct inv_mpu6050_state *st)
      ^
In file included from /home/michael/projects/linux/linux-git/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c:203:0:
/home/michael/projects/linux/linux-git/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h:262:6: note: previous declaration of 'inv_mpu_acpi_delete_mux_client' was here
 void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);

Seems a few function definitions on the other side of the ifdef were missed.
 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
