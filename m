Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbdLJSV6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 13:21:58 -0500
Date: Sun, 10 Dec 2017 18:21:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <20171210182152.70ad8fbf@archlinux>
In-Reply-To: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 6 Dec 2017 17:52:34 +0000
Jeremy Cline <jeremy@jcline.org> wrote:

> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
> device. Check for a companion device and handle a second i2c_client
> if it is present.
> 
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
The requirement for this is still horrible, but you have done a nice
clean job on implementing it.

I'll let this sit for a few more days though before applying it.
Probably next weekend if we don't get any feedback before then.

Thanks,

Jonathan
> ---
> Changes in v2:
>   - Rather than exposing the bmc150_accel_data struct, use get and set
>     functions.
> 
>  drivers/iio/accel/bmc150-accel-core.c | 20 ++++++++++++++++++++
>  drivers/iio/accel/bmc150-accel-i2c.c  | 29 ++++++++++++++++++++++++++++-
>  drivers/iio/accel/bmc150-accel.h      |  2 ++
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 870f92ef61c2..7496c5121a8c 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -204,6 +204,7 @@ struct bmc150_accel_data {
>  	int ev_enable_state;
>  	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
>  	const struct bmc150_accel_chip_info *chip_info;
> +	struct i2c_client *second_device;
>  };
>  
>  static const struct {
> @@ -1659,6 +1660,25 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  }
>  EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
>  
> +struct i2c_client *bmc150_get_second_device(struct i2c_client *client)
> +{
> +	struct bmc150_accel_data *data = i2c_get_clientdata(client);
> +
> +	if (!data)
> +		return NULL;
> +
> +	return data->second_device;
> +}
> +EXPORT_SYMBOL_GPL(bmc150_get_second_device);
> +
> +void bmc150_set_second_device(struct i2c_client *client)
> +{
> +	struct bmc150_accel_data *data = i2c_get_clientdata(client);
> +	if (data)
> +		data->second_device = client;
> +}
> +EXPORT_SYMBOL_GPL(bmc150_set_second_device);
> +
>  int bmc150_accel_core_remove(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index f85014fbaa12..c7341df086e2 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -31,6 +31,10 @@
>  static int bmc150_accel_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
> +	int ret;
> +	struct acpi_device *adev;
> +	struct i2c_board_info board_info;
> +	struct i2c_client *second_dev;
>  	struct regmap *regmap;
>  	const char *name = NULL;
>  	bool block_supported =
> @@ -47,12 +51,35 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  	if (id)
>  		name = id->name;
>  
> -	return bmc150_accel_core_probe(&client->dev, regmap, client->irq, name,
> +	ret = bmc150_accel_core_probe(&client->dev, regmap, client->irq, name,
>  				       block_supported);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
> +	 * device, try instantiating a second i2c_client for an I2cSerialBusV2
> +	 * ACPI resource with index 1.
> +	 */
> +	adev = ACPI_COMPANION(&client->dev);
> +	if (adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
> +		memset(&board_info, 0, sizeof(board_info));
> +		strlcpy(board_info.type, "bma250e", I2C_NAME_SIZE);
> +		second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
> +		if (second_dev)
> +			bmc150_set_second_device(second_dev);
> +	}
> +
> +	return ret;
>  }
>  
>  static int bmc150_accel_remove(struct i2c_client *client)
>  {
> +	struct i2c_client *second_dev = bmc150_get_second_device(client);
> +
> +	if (second_dev)
> +		i2c_unregister_device(second_dev);
> +
>  	return bmc150_accel_core_remove(&client->dev);
>  }
>  
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index ae6118ae11b1..6e965a3ca322 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -16,6 +16,8 @@ enum {
>  int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  			    const char *name, bool block_supported);
>  int bmc150_accel_core_remove(struct device *dev);
> +struct i2c_client *bmc150_get_second_device(struct i2c_client *second_device);
> +void bmc150_set_second_device(struct i2c_client *second_device);
>  extern const struct dev_pm_ops bmc150_accel_pm_ops;
>  extern const struct regmap_config bmc150_regmap_conf;
>  

