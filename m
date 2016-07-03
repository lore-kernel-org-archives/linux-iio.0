Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57496 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbcGCKlz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 06:41:55 -0400
Subject: Re: [PATCH v3 2/2] iio: adc: max1363: Add device tree binding
To: Florian Vaussard <florian.vaussard@gmail.com>,
	devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467272586-28761-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1467272586-28761-3-git-send-email-florian.vaussard@heig-vd.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aceae589-9b7c-b818-63c1-4e9f25dec913@kernel.org>
Date: Sun, 3 Jul 2016 11:41:47 +0100
MIME-Version: 1.0
In-Reply-To: <1467272586-28761-3-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/16 08:43, Florian Vaussard wrote:
> This patch adds the necessary device tree binding to allow DT probing of
> currently supported parts.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
Applied.  Thanks.

Jonathan
> ---
>  drivers/iio/adc/max1363.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index b5d28c0..c3e4c3c 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -25,6 +25,8 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -1516,6 +1518,56 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_OF
> +
> +#define MAX1363_COMPATIBLE(of_compatible, cfg) {		\
> +			.compatible = of_compatible,		\
> +			.data = &max1363_chip_info_tbl[cfg],	\
> +}
> +
> +static const struct of_device_id max1363_of_match[] = {
> +	MAX1363_COMPATIBLE("maxim,max1361", max1361),
> +	MAX1363_COMPATIBLE("maxim,max1362", max1362),
> +	MAX1363_COMPATIBLE("maxim,max1363", max1363),
> +	MAX1363_COMPATIBLE("maxim,max1364", max1364),
> +	MAX1363_COMPATIBLE("maxim,max1036", max1036),
> +	MAX1363_COMPATIBLE("maxim,max1037", max1037),
> +	MAX1363_COMPATIBLE("maxim,max1038", max1038),
> +	MAX1363_COMPATIBLE("maxim,max1039", max1039),
> +	MAX1363_COMPATIBLE("maxim,max1136", max1136),
> +	MAX1363_COMPATIBLE("maxim,max1137", max1137),
> +	MAX1363_COMPATIBLE("maxim,max1138", max1138),
> +	MAX1363_COMPATIBLE("maxim,max1139", max1139),
> +	MAX1363_COMPATIBLE("maxim,max1236", max1236),
> +	MAX1363_COMPATIBLE("maxim,max1237", max1237),
> +	MAX1363_COMPATIBLE("maxim,max1238", max1238),
> +	MAX1363_COMPATIBLE("maxim,max1239", max1239),
> +	MAX1363_COMPATIBLE("maxim,max11600", max11600),
> +	MAX1363_COMPATIBLE("maxim,max11601", max11601),
> +	MAX1363_COMPATIBLE("maxim,max11602", max11602),
> +	MAX1363_COMPATIBLE("maxim,max11603", max11603),
> +	MAX1363_COMPATIBLE("maxim,max11604", max11604),
> +	MAX1363_COMPATIBLE("maxim,max11605", max11605),
> +	MAX1363_COMPATIBLE("maxim,max11606", max11606),
> +	MAX1363_COMPATIBLE("maxim,max11607", max11607),
> +	MAX1363_COMPATIBLE("maxim,max11608", max11608),
> +	MAX1363_COMPATIBLE("maxim,max11609", max11609),
> +	MAX1363_COMPATIBLE("maxim,max11610", max11610),
> +	MAX1363_COMPATIBLE("maxim,max11611", max11611),
> +	MAX1363_COMPATIBLE("maxim,max11612", max11612),
> +	MAX1363_COMPATIBLE("maxim,max11613", max11613),
> +	MAX1363_COMPATIBLE("maxim,max11614", max11614),
> +	MAX1363_COMPATIBLE("maxim,max11615", max11615),
> +	MAX1363_COMPATIBLE("maxim,max11616", max11616),
> +	MAX1363_COMPATIBLE("maxim,max11617", max11617),
> +	MAX1363_COMPATIBLE("maxim,max11644", max11644),
> +	MAX1363_COMPATIBLE("maxim,max11645", max11645),
> +	MAX1363_COMPATIBLE("maxim,max11646", max11646),
> +	MAX1363_COMPATIBLE("maxim,max11647", max11647),
> +	{ /* sentinel */ }
> +};
> +#endif
> +
>  static int max1363_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1523,6 +1575,7 @@ static int max1363_probe(struct i2c_client *client,
>  	struct max1363_state *st;
>  	struct iio_dev *indio_dev;
>  	struct regulator *vref;
> +	const struct of_device_id *match;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev,
>  					  sizeof(struct max1363_state));
> @@ -1549,7 +1602,12 @@ static int max1363_probe(struct i2c_client *client,
>  	/* this is only used for device removal purposes */
>  	i2c_set_clientdata(client, indio_dev);
>  
> -	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
> +	match = of_match_device(of_match_ptr(max1363_of_match),
> +				&client->dev);
> +	if (match)
> +		st->chip_info = of_device_get_match_data(&client->dev);
> +	else
> +		st->chip_info = &max1363_chip_info_tbl[id->driver_data];
>  	st->client = client;
>  
>  	st->vref_uv = st->chip_info->int_vref_mv * 1000;
> @@ -1692,6 +1750,7 @@ MODULE_DEVICE_TABLE(i2c, max1363_id);
>  static struct i2c_driver max1363_driver = {
>  	.driver = {
>  		.name = "max1363",
> +		.of_match_table = of_match_ptr(max1363_of_match),
>  	},
>  	.probe = max1363_probe,
>  	.remove = max1363_remove,
> 

