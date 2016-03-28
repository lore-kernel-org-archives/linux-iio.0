Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44632 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbcC1KGj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 06:06:39 -0400
Subject: Re: [PATCH 1/1] iio: remove gpio interrupt probing from drivers that
 use a single interrupt
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org
References: <1458810309-24356-1-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F9022C.8010005@kernel.org>
Date: Mon, 28 Mar 2016 11:06:36 +0100
MIME-Version: 1.0
In-Reply-To: <1458810309-24356-1-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/16 09:05, Irina Tirdea wrote:
> Commit 845c877009cf014b ("i2c / ACPI: Assign IRQ for devices that have
> GpioInt automatically") automatically assigns the first ACPI GPIO
> interrupt in client->irq, so we can remove the probing code from
> drivers that use only one interrupt.
> 
> Commit 0f0796509c07c1c7 ("iio: remove gpio interrupt probing from drivers
> that use a single interrupt") removes gpio interrupt probing from most
> drivers. This patch cleans the remaining ones.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Applied to the togreg branch of iio.git, initially pushed out as testing
for the autobuilders to play with it.

Thanks.  Good to get the last? of these cleaned up.

Jonathan
> ---
>  drivers/iio/accel/mxc4005.c    | 29 -----------------------------
>  drivers/iio/gyro/bmg160_core.c | 28 ----------------------------
>  2 files changed, 57 deletions(-)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index e72e218..c23f47a 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -17,7 +17,6 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/acpi.h>
> -#include <linux/gpio/consumer.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
> @@ -380,31 +379,6 @@ static const struct iio_trigger_ops mxc4005_trigger_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> -static int mxc4005_gpio_probe(struct i2c_client *client,
> -			      struct mxc4005_data *data)
> -{
> -	struct device *dev;
> -	struct gpio_desc *gpio;
> -	int ret;
> -
> -	if (!client)
> -		return -EINVAL;
> -
> -	dev = &client->dev;
> -
> -	gpio = devm_gpiod_get_index(dev, "mxc4005_int", 0, GPIOD_IN);
> -	if (IS_ERR(gpio)) {
> -		dev_err(dev, "failed to get acpi gpio index\n");
> -		return PTR_ERR(gpio);
> -	}
> -
> -	ret = gpiod_to_irq(gpio);
> -
> -	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
> -
> -	return ret;
> -}
> -
>  static int mxc4005_chip_init(struct mxc4005_data *data)
>  {
>  	int ret;
> @@ -470,9 +444,6 @@ static int mxc4005_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	if (client->irq < 0)
> -		client->irq = mxc4005_gpio_probe(client, data);
> -
>  	if (client->irq > 0) {
>  		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
>  							   "%s-dev%d",
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index bbce3b0..822767c 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -17,7 +17,6 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> -#include <linux/gpio/consumer.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/iio/iio.h>
> @@ -31,7 +30,6 @@
>  #include "bmg160.h"
>  
>  #define BMG160_IRQ_NAME		"bmg160_event"
> -#define BMG160_GPIO_NAME		"gpio_int"
>  
>  #define BMG160_REG_CHIP_ID		0x00
>  #define BMG160_CHIP_ID_VAL		0x0F
> @@ -955,29 +953,6 @@ static const struct iio_buffer_setup_ops bmg160_buffer_setup_ops = {
>  	.postdisable = bmg160_buffer_postdisable,
>  };
>  
> -static int bmg160_gpio_probe(struct bmg160_data *data)
> -
> -{
> -	struct device *dev;
> -	struct gpio_desc *gpio;
> -
> -	dev = data->dev;
> -
> -	/* data ready gpio interrupt pin */
> -	gpio = devm_gpiod_get_index(dev, BMG160_GPIO_NAME, 0, GPIOD_IN);
> -	if (IS_ERR(gpio)) {
> -		dev_err(dev, "acpi gpio get index failed\n");
> -		return PTR_ERR(gpio);
> -	}
> -
> -	data->irq = gpiod_to_irq(gpio);
> -
> -	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio),
> -		data->irq);
> -
> -	return 0;
> -}
> -
>  static const char *bmg160_match_acpi_device(struct device *dev)
>  {
>  	const struct acpi_device_id *id;
> @@ -1022,9 +997,6 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bmg160_info;
>  
> -	if (data->irq <= 0)
> -		bmg160_gpio_probe(data);
> -
>  	if (data->irq > 0) {
>  		ret = devm_request_threaded_irq(dev,
>  						data->irq,
> 

