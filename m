Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57789 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab3JAOkc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 10:40:32 -0400
Message-ID: <524AED0A.6030707@kernel.org>
Date: Tue, 01 Oct 2013 16:40:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lukasz Czerwinski <l.czerwinski@samsung.com>, jic23@cam.ac.uk
CC: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2 PATCH 02/14] iio: st_accel: Add dt bindings
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com> <1380299538-22047-3-git-send-email-l.czerwinski@samsung.com>
In-Reply-To: <1380299538-22047-3-git-send-email-l.czerwinski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/13 17:32, Lukasz Czerwinski wrote:
> Add OF support for the st_accel.
> 
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

The dev name changes result in an ABI change.  This was
being discussed deep in a thread related to Lee's patches
but I don't think has yet been resolved.

The issue is that they are exposed to userspace via sysfs
by both the i2c subsystem and IIO.

My gut feeling is we are stuck with the underscores but no one has
definitively come down and said we are find to leave them be
and break with DT conventions.

We can't even play games with having different naming in the device
tree and exposed to usespace because there are already DT files
using the implicit i2c bindings.

Otherwise this all looks fine to me.
> ---
>  drivers/iio/accel/st_accel.h      |   19 +++++++++----------
>  drivers/iio/accel/st_accel_core.c |   10 ++++------
>  drivers/iio/accel/st_accel_i2c.c  |   19 ++++++++++++++++++-
>  drivers/iio/accel/st_accel_spi.c  |   19 ++++++++++++++++++-
>  4 files changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index c387763..08a0eb7 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -14,16 +14,16 @@ 
>  #include <linux/types.h>
>  #include <linux/iio/common/st_sensors.h>
>  
> -#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
> +#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc-accel"
>  #define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
> -#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
> -#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
> -#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
> +#define LSM330D_ACCEL_DEV_NAME		"lsm330d-accel"
> +#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl-accel"
> +#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc-accel"
>  #define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
> -#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
> -#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
> -#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
> -#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
> +#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl-accel"
> +#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh-accel"
> +#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm-accel"
> +#define LSM330_ACCEL_DEV_NAME		"lsm330-accel"
>  
>  /**
>  * struct st_sensors_platform_data - default accel platform data
> @@ -33,8 +33,7 @@ static const struct st_sensors_platform_data default_accel_pdata = {
>  	.drdy_int_pin = 1,
>  };
>  
> -int st_accel_common_probe(struct iio_dev *indio_dev,
> -					struct st_sensors_platform_data *pdata);
> +int st_accel_common_probe(struct iio_dev *indio_dev);
>  void st_accel_common_remove(struct iio_dev *indio_dev);
>  
>  #ifdef CONFIG_IIO_BUFFER
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 38caedc..57e63bf 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -449,8 +449,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>  
> -int st_accel_common_probe(struct iio_dev *indio_dev,
> -				struct st_sensors_platform_data *plat_data)
> +int st_accel_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	int irq = adata->get_irq_data_ready(indio_dev);
> @@ -473,11 +472,10 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
>  						&adata->sensor->fs.fs_avl[0];
>  	adata->odr = adata->sensor->odr.odr_avl[0].hz;
>  
> -	if (!plat_data)
> -		plat_data =
> -			(struct st_sensors_platform_data *)&default_accel_pdata;
> +	if (!adata->dev->platform_data && !adata->dev->of_node)
> +		adata->drdy_int_pin = default_accel_pdata.drdy_int_pin;
>  
> -	err = st_sensors_init_sensor(indio_dev, plat_data);
> +	err = st_sensors_init_sensor(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index d7bedbd..6c27ad44 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -34,7 +34,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  
>  	st_sensors_i2c_configure(indio_dev, client, adata);
>  
> -	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
> +	err = st_accel_common_probe(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> @@ -63,10 +63,27 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id st_accel_dt_match[] = {
> +	{ .compatible = "st,lsm330dlhc_accel" },
> +	{ .compatible = "st,lis3dh" },
> +	{ .compatible = "st,lsm330d-accel" },
> +	{ .compatible = "st,lsm330dl-accel" },
> +	{ .compatible = "st,lsm330dlc-accel" },
> +	{ .compatible = "st,lsm331dlh" },
> +	{ .compatible = "st,lsm303dl-accel" },
> +	{ .compatible = "st,lsm303dlh-accel" },
> +	{ .compatible = "st,lsm303dlm-accel" },
> +	{ .compatible = "st,lsm330-accel" },
> +	{ }
> +};
> +#endif
> +
>  static struct i2c_driver st_accel_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "st-accel-i2c",
> +		.of_match_table = of_match_ptr(st_accel_dt_match),
>  	},
>  	.probe = st_accel_i2c_probe,
>  	.remove = st_accel_i2c_remove,
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 1956396..e66548e 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -33,7 +33,7 @@ static int st_accel_spi_probe(struct spi_device *spi)
>  
>  	st_sensors_spi_configure(indio_dev, spi, adata);
>  
> -	err = st_accel_common_probe(indio_dev, spi->dev.platform_data);
> +	err = st_accel_common_probe(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> @@ -62,10 +62,27 @@ static const struct spi_device_id st_accel_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, st_accel_id_table);
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id st_accel_dt_match[] = {
> +	{ .compatible = "st,lsm330dlhc-accel" },
> +	{ .compatible = "st,lis3dh" },
> +	{ .compatible = "st,lsm330d-accel" },
> +	{ .compatible = "st,lsm330dl-accel" },
> +	{ .compatible = "st,lsm330dlc-accel" },
> +	{ .compatible = "st,lsm331dlh" },
> +	{ .compatible = "st,lsm303dl-accel" },
> +	{ .compatible = "st,lsm303dlh-accel" },
> +	{ .compatible = "st,lsm303dlm-accel" },
> +	{ .compatible = "st,lsm330-accel" },
> +	{ }
> +};
> +#endif
> +
>  static struct spi_driver st_accel_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "st-accel-spi",
> +		.of_match_table = of_match_ptr(st_accel_dt_match),
>  	},
>  	.probe = st_accel_spi_probe,
>  	.remove = st_accel_spi_remove,
> 
