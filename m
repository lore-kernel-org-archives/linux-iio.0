Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37550 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbaKHMlS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Nov 2014 07:41:18 -0500
Message-ID: <545E0F6C.3050904@kernel.org>
Date: Sat, 08 Nov 2014 12:41:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v4] iio:kxcjk-1013: Add support for SMO8500 device
References: <1415225352.7630.23.camel@hadess.net>
In-Reply-To: <1415225352.7630.23.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/11/14 22:09, Bastien Nocera wrote:
> The Onda v975w tablet contains an accelerometer that's advertised over
> ACPI as SMO8500. This device is however a KXCJ9 accelerometer as
> can be seen in the Windows driver's INF file, and from the etching on
> the chipset ("KXCJ9 41566 0414").
> 
> This patch also removes the attempt to get the IRQ for the "data ready"
> signal, as it does not seem to be supported by this device on this
> platform.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
> 
> Changes from v1:
> - Rebase after driver changes
> - Stop checking for IRQ when not supported
> 
> Changes from v2:
> - Fixed the space before the opening bracket
> - Added Sob line
> - Add version to the patch subject line ;)
> 
> Changes from v3:
> - SMO8500 is a KXCJ9, so define it as such
> 
>  drivers/iio/accel/kxcjk-1013.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index a23e58c..570a237 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -108,6 +108,7 @@ struct kxcjk1013_data {
>  	bool motion_trigger_on;
>  	int64_t timestamp;
>  	enum kx_chipset chipset;
> +	bool is_smo8500_device;
>  };
>  
>  enum kxcjk1013_axis {
> @@ -1129,12 +1130,15 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
>  }
>  
>  static const char *kxcjk1013_match_acpi_device(struct device *dev,
> -					       enum kx_chipset *chipset)
> +					       enum kx_chipset *chipset,
> +					       bool *is_smo8500_device)
>  {
>  	const struct acpi_device_id *id;
>  	id = acpi_match_device(dev->driver->acpi_match_table, dev);
>  	if (!id)
>  		return NULL;
> +	if (strcmp(id->id, "SMO8500") == 0)
> +		*is_smo8500_device = true;
>  	*chipset = (enum kx_chipset)id->driver_data;
>  
>  	return dev_name(dev);
> @@ -1149,6 +1153,8 @@ static int kxcjk1013_gpio_probe(struct i2c_client *client,
>  
>  	if (!client)
>  		return -EINVAL;
> +	if (data->is_smo8500_device)
> +		return -ENOTSUPP;
>  
>  	dev = &client->dev;
>  
> @@ -1198,7 +1204,8 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  		name = id->name;
>  	} else if (ACPI_HANDLE(&client->dev)) {
>  		name = kxcjk1013_match_acpi_device(&client->dev,
> -						   &data->chipset);
> +						   &data->chipset,
> +						   &data->is_smo8500_device);
>  	} else
>  		return -ENODEV;
>  
> @@ -1397,6 +1404,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
>  	{"KXCJ1013", KXCJK1013},
>  	{"KXCJ1008", KXCJ91008},
>  	{"KXTJ1009", KXTJ21009},
> +	{"SMO8500",  KXCJ91008},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
> @@ -1405,6 +1413,7 @@ static const struct i2c_device_id kxcjk1013_id[] = {
>  	{"kxcjk1013", KXCJK1013},
>  	{"kxcj91008", KXCJ91008},
>  	{"kxtj21009", KXTJ21009},
> +	{"SMO8500",   KXCJ91008},
>  	{}
>  };
>  
> 

