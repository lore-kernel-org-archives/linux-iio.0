Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42798 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3EFQo6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 12:44:58 -0400
Message-ID: <5187DE08.6020002@kernel.org>
Date: Mon, 06 May 2013 17:44:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, achew@nvidia.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 1/2] iio: ak8975: Add support for gpios DT property
References: <1366123040-17917-1-git-send-email-j.anaszewski@samsung.com> <1366123040-17917-2-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1366123040-17917-2-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/16/2013 03:37 PM, Jacek Anaszewski wrote:
> Add support for parsing 'gpios' property when initializing
> from oftree.
> This patch adds also the binding documentation file.
> 
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Andrew Chew <achew@nvidia.com>
One issue here.

The driver has moved out of staging, yet your are documenting it's bindings
as if it hasn't.  Please just move the docs and resend the series.

Also, there is a bonus blank line at the end of the bindings file. Please remove.

Jonathan
> ---
>  .../bindings/staging/iio/magnetometer/ak8975.txt   |   19 +++++++++++++++++++
>  drivers/iio/magnetometer/ak8975.c                  |    5 ++++-
>  2 files changed, 23 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/staging/iio/magnetometer/ak8975.txt
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/staging/iio/magnetometer/ak8975.txt
> new file mode 100644
> index 0000000..d085d90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/iio/magnetometer/ak8975.txt
> @@ -0,0 +1,19 @@
> +* AsahiKASEI AK8975 device driver
> +
> +Required properties:
> +
> +  - compatible : should be "asahi-kasei,ak8975"
> +  - reg : the I2C address of the magnetometer
> +
> +Optional properties:
> +
> +  - gpios : should be device tree identifier of magnetometer DRDY pin
> +
> +Example:
> +
> +ak8975@0C {
> +        compatible = "asahi-kasei,ak8975";
> +        reg = <0x0C>;
> +        gpios = <&gpj0 7 0>;
> +};
> +
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index af6c320..eb17eca 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -29,6 +29,7 @@
>  #include <linux/delay.h>
>  
>  #include <linux/gpio.h>
> +#include <linux/of_gpio.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -384,7 +385,9 @@ static int ak8975_probe(struct i2c_client *client,
>  	int err;
>  
>  	/* Grab and set up the supplied GPIO. */
> -	if (client->dev.platform_data == NULL)
> +	if (client->dev.of_node)
> +		eoc_gpio = of_get_gpio(client->dev.of_node, 0);
> +	else if (client->dev.platform_data == NULL)
>  		eoc_gpio = -1;
>  	else
>  		eoc_gpio = *(int *)(client->dev.platform_data);
> 
