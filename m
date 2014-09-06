Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:57569 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbaIFMYD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 6 Sep 2014 08:24:03 -0400
Message-ID: <540AFCCA.7050104@gmx.de>
Date: Sat, 06 Sep 2014 14:23:38 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-kernel@vger.kernel.org, Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH] iio: magn: ak8975: fix unnecessary casting between char*
 and const char*
References: <1409655865-28912-1-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1409655865-28912-1-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Irina Tirdea schrieb:
> Use const char* instead of casting const char* to char*.
>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  drivers/iio/magnetometer/ak8975.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index a235792..61edc66 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -477,7 +477,7 @@ static const struct acpi_device_id ak_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
>  
> -static char *ak8975_match_acpi_device(struct device *dev,
> +static const char *ak8975_match_acpi_device(struct device *dev,
>  				enum asahi_compass_chipset *chipset)
This second line should also be indented properly, it will exactly fit 80 characters.
>  {
>  	const struct acpi_device_id *id;
> @@ -487,7 +487,7 @@ static char *ak8975_match_acpi_device(struct device *dev,
>  		return NULL;
>  	*chipset = (int)id->driver_data;
>  
> -	return (char *)dev_name(dev);
> +	return dev_name(dev);
>  }
>  
>  static int ak8975_probe(struct i2c_client *client,
> @@ -497,7 +497,7 @@ static int ak8975_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int eoc_gpio;
>  	int err;
> -	char *name = NULL;
> +	const char *name = NULL;
>  
>  	/* Grab and set up the supplied GPIO. */
>  	if (client->dev.platform_data)
> @@ -539,7 +539,7 @@ static int ak8975_probe(struct i2c_client *client,
>  	if (id) {
>  		data->chipset =
>  			(enum asahi_compass_chipset)(id->driver_data);
> -		name = (char *) id->name;
> +		name = id->name;
>  	} else if (ACPI_HANDLE(&client->dev))
>  		name = ak8975_match_acpi_device(&client->dev, &data->chipset);
>  	else

