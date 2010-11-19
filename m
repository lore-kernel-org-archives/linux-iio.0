Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51604 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab0KSOFV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2010 09:05:21 -0500
Message-ID: <4CE685A7.5080909@cam.ac.uk>
Date: Fri, 19 Nov 2010 14:11:51 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 3/3] staging: iio: dac: Use spi_device_id
References: <1290170090-31015-1-git-send-email-michael.hennerich@analog.com> <1290170090-31015-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1290170090-31015-3-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/19/10 12:34, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
Nice clean up.
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/ad5624r_spi.c |   25 +++++++++----------------
>  1 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
> index 17588b4..b7c1661 100644
> --- a/drivers/staging/iio/dac/ad5624r_spi.c
> +++ b/drivers/staging/iio/dac/ad5624r_spi.c
> @@ -209,13 +209,8 @@ static const struct attribute_group ad5624r_attribute_group = {
>  
>  static int __devinit ad5624r_probe(struct spi_device *spi)
>  {
> -
>  	struct ad5624r_state *st;
>  	int ret = 0;
> -	char *chip_name = spi->dev.platform_data;
> -
> -	if (!chip_name)
> -		return -ENODEV;
>  
>  	st = kzalloc(sizeof(*st), GFP_KERNEL);
>  	if (st == NULL) {
> @@ -224,17 +219,7 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
>  	}
>  	spi_set_drvdata(spi, st);
>  
> -	if (strcmp(chip_name, "ad5624r") == 0)
> -		st->data_len = 12;
> -	else if (strcmp(chip_name, "ad5644r") == 0)
> -		st->data_len = 14;
> -	else if (strcmp(chip_name, "ad5664r") == 0)
> -		st->data_len = 16;
> -	else {
> -		dev_err(&spi->dev, "not supported chip type\n");
> -		ret = -EINVAL;
> -		goto error_ret;
> -	}
> +	st->data_len = spi_get_device_id(spi)->driver_data;
>  
>  	st->us = spi;
>  	st->indio_dev = iio_allocate_device();
> @@ -278,6 +263,13 @@ static int __devexit ad5624r_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct spi_device_id ad5624r_id[] = {
> +	{"ad5624r", 12},
> +	{"ad5644r", 14},
> +	{"ad5664r", 16},
> +	{}
> +};
> +
>  static struct spi_driver ad5624r_driver = {
>  	.driver = {
>  		.name = "ad5624r",
> @@ -285,6 +277,7 @@ static struct spi_driver ad5624r_driver = {
>  	},
>  	.probe = ad5624r_probe,
>  	.remove = __devexit_p(ad5624r_remove),
> +	.id_table = ad5624r_id,
>  };
>  
>  static __init int ad5624r_spi_init(void)

