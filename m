Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49075 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3K3MEW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 07:04:22 -0500
Message-ID: <5299D444.30801@kernel.org>
Date: Sat, 30 Nov 2013 12:04:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Shawn Guo <shawn.guo@linaro.org>
CC: Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>
Subject: Re: [RFC PATCH 1/3] iio: accel: Add device tree probing for STMicro
 accelerometers
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com> <1384876234-1211-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1384876234-1211-2-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/19/13 15:50, Maxime Ripard wrote:
> Add the compatibles supported by the st_sensors library. This uses kind
> of a hack, since the st_sensors core will actively check at probe time
> that the device name matches the one reported when using old style i2c
> probing, and that this name will be different with device tree.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Note that this is unnecessary give core i2c matching, until we have some
more elements in the binding.  I'd certainly expect the interrupts
on the relevant devices to be in the binding...
> ---
>  .../devicetree/bindings/iio/accel/st_accel_i2c.txt | 22 +++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c                   | 33 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/st_accel_i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/st_accel_i2c.txt b/Documentation/devicetree/bindings/iio/accel/st_accel_i2c.txt
> new file mode 100644
> index 000000000000..4a1efdf1775f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/st_accel_i2c.txt
> @@ -0,0 +1,22 @@
> +* ST Micro accelerometer sensors 
> +
> +Required properties:
> +  - compatible : should be either:
> +	* "st,lis3dh"
> +	* "st,lis331dlh"
> +	* "st,lsm303dl-accel"
> +	* "st,lsm303dlh-accel"
> +	* "st,lsm303dlhc-accel"
> +	* "st,lsm303dlm-accel"
> +	* "st,lsm330-accel"
> +	* "st,lsm330d-accel"
> +	* "st,lsm330dl-accel"
> +	* "st,lsm330dlc-accel"
> +  - reg : the I2C address of the sensor
> +
> +Example:
> +
> +accel: accel@19 {
> +	compatible = "st,lsm330dlc-accel";
> +	reg = <0x19>;
> +};
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index d7bedbdfc81d..de2bf76378d8 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -13,11 +13,27 @@
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_i2c.h>
>  #include "st_accel.h"
>  
> +static const struct of_device_id st_accel_of_table[] = {
> +	{ .compatible = "st,lis3dh", .data = LIS3DH_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lis331dlh", .data = LIS331DLH_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lsm303dl-accel", .data = LSM303DL_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lsm303dlh-accel", .data = LSM303DLH_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lsm303dlhc-accel", .data = LSM303DLHC_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lsm303dlm-accel", .data = LSM303DLM_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lsm330-accel", .data = LSM330_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lsm330d-accel", .data = LSM330D_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lsm330dl-accel", .data = LSM330DL_ACCEL_DEV_NAME },
> +	{ .compatible = "st,lsm330dlc-accel", .data = LSM330DLC_ACCEL_DEV_NAME },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, st_accel_of_table);
> +
>  static int st_accel_i2c_probe(struct i2c_client *client,
>  						const struct i2c_device_id *id)
>  {
> @@ -34,6 +50,22 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  
>  	st_sensors_i2c_configure(indio_dev, client, adata);
>  
> +	/*
> +	 * If we are probed through DT, st_sensors_i2c_configure will
> +	 * fill the indio_dev->name string with the client->name,
> +	 * which is the compatible without the vendor prefix.  Since
> +	 * compatibles separators are usually "-", and that the
> +	 * convention in this driver is using "_", we obviously have a
> +	 * problem when the st-sensors core checks that the two
> +	 * strings matches. We need to set again the indio_dev->name
> +	 * string to the real value used by the core later on.
> +	 */
> +	if (client->dev.of_node) {
> +		const struct of_device_id *device;
> +		device = of_match_device(st_accel_of_table, &client->dev);
> +		indio_dev->name = device->data;
> +	}
> +
>  	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
>  	if (err < 0)
>  		return err;
> @@ -67,6 +99,7 @@ static struct i2c_driver st_accel_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "st-accel-i2c",
> +		.of_match_table = of_match_ptr(st_accel_of_table),
>  	},
>  	.probe = st_accel_i2c_probe,
>  	.remove = st_accel_i2c_remove,
> 
