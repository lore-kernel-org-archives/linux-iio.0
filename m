Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Thu, 11 Feb 2016 12:00:20 -0600
From: Michael Welling <mwelling@ieee.org>
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	lars@metafoo.de, daniel.baluta@intel.com, lucas.de.marchi@gmail.com,
	adi.reus@gmail.com, cmo@melexis.com
Subject: Re: [PATCH v5 3/4] iio: imu: inv_mpu6050: Separate driver into core
 and i2c functionality.
Message-ID: <20160211180019.GA15330@deathstar>
References: <1455185128-4717-1-git-send-email-adriana.reus@intel.com>
 <1455185128-4717-4-git-send-email-adriana.reus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455185128-4717-4-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 11, 2016 at 12:05:27PM +0200, Adriana Reus wrote:
> +MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
> +
> +static struct i2c_driver inv_mpu_driver = {
> +	.probe		=	inv_mpu_probe,
> +	.remove		=	inv_mpu_remove,
> +	.id_table	=	inv_mpu_id,
> +	.driver = {
> +		.acpi_match_table = ACPI_PTR(inv_acpi_match),
> +		.name	=	"inv-mpu6050 i2c driver",

I just noticed this but spaces in this name leads to spaces in the sysfs entry
which could be potentially confusing.

root@dragonboard-410c:/sys/bus/i2c/drivers# ls
ads1015                 cs2000-cp               inv-mpu6050 i2c driver
ak4613-codec            dummy                   pca9685-pwm
root@dragonboard-410c:/sys/bus/i2c/drivers# ls -l
drwxr-xr-x    2 root     root             0 Feb  5 05:37 ads1015
drwxr-xr-x    2 root     root             0 Feb  5 05:37 ak4613-codec
drwxr-xr-x    2 root     root             0 Feb  5 05:37 cs2000-cp
drwxr-xr-x    2 root     root             0 Feb  5 05:37 dummy
drwxr-xr-x    2 root     root             0 Feb  5 05:37 inv-mpu6050 i2c driver
drwxr-xr-x    2 root     root             0 Feb  5 05:37 pca9685-pwm

Same goes for the SPI driver.

root@dragonboard-410c:/sys/bus/spi/drivers# ls
inv-mpu6000 spi driver  mmc_spi                 spidev
root@dragonboard-410c:/sys/bus/spi/drivers# ls -l
drwxr-xr-x    2 root     root             0 Feb  5 05:43 inv-mpu6000 spi driver
drwxr-xr-x    2 root     root             0 Feb  5 05:43 mmc_spi
drwxr-xr-x    2 root     root             0 Feb  5 05:43 spidev

Not sure if it is worth a revision but letting you know.
