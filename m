Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61059 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab2HUNR6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Aug 2012 09:17:58 -0400
Received: by ggdk6 with SMTP id k6so5774213ggd.19
        for <linux-iio@vger.kernel.org>; Tue, 21 Aug 2012 06:17:57 -0700 (PDT)
References: <502E10A4.1080800@metafoo.de> <1345490581-30375-1-git-send-email-jeff.dagenais@gmail.com> <1345490581-30375-2-git-send-email-jeff.dagenais@gmail.com>
In-Reply-To: <1345490581-30375-2-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <43BFC719-E115-4E4A-B2C0-71A8ADDE8A81@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	device-drivers-devel@blackfin.uclinux.org
From: =?iso-8859-1?Q?Jean-Fran=E7ois_Dagenais?= <jeff.dagenais@gmail.com>
Subject: Re: [PATCH] iio:ad5446: Add support for I2C based DACs
Date: Tue, 21 Aug 2012 09:17:54 -0400
To: =?iso-8859-1?Q?Jean-Fran=E7ois_Dagenais?= <jeff.dagenais@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

Since this has not been integrated anywhere yet...

Got my brain back after a good night sleep, and something caught my attention
this morning. See below...

On 2012-08-20, at 3:23 PM, Jean-François Dagenais wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> This patch adds support for I2C based single channel DACs to the ad5446
> driver. Specifically AD5602, AD5612 and AD5622.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jean-François Dagenais <jeff.dagenais@gmail.com>
> ---
> drivers/iio/dac/Kconfig  |   9 +-
> drivers/iio/dac/ad5446.c | 362 ++++++++++++++++++++++++++++++++---------------
> drivers/iio/dac/ad5446.h |   5 +-
> 3 files changed, 256 insertions(+), 120 deletions(-)
...
> @@ -375,18 +381,144 @@ static const struct spi_device_id ad5446_id[] = {
> 	{"ad5662", ID_AD5662},
> 	{}
> };
> -MODULE_DEVICE_TABLE(spi, ad5446_id);
> +MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
> +
> +static int __devinit ad5446_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> 
> -static struct spi_driver ad5446_driver = {
> +	return ad5446_probe(&spi->dev, id->name,
> +		&ad5446_spi_chip_info[id->driver_data]);
> +}
> +
> +static int __devexit ad5446_spi_remove(struct spi_device *spi)
> +{
> +	return ad5446_remove(&spi->dev);
> +}
> +
> +static struct spi_driver ad5446_spi_driver = {
> 	.driver = {
> 		.name	= "ad5446",
> 		.owner	= THIS_MODULE,
> 	},
> -	.probe		= ad5446_probe,
> -	.remove		= __devexit_p(ad5446_remove),
> -	.id_table	= ad5446_id,
> +	.probe		= ad5446_spi_probe,
> +	.remove		= __devexit_p(ad5446_spi_remove),
> +	.id_table	= ad5446_spi_ids,
> +};
> +
> +static int __init ad5446_spi_register_driver(void)
> +{
> +	return spi_register_driver(&ad5446_spi_driver);
> +}
> +
> +static void ad5446_spi_unregister_driver(void)
> +{
> +	spi_unregister_driver(&ad5446_spi_driver);
> +}
> +
> +#else
> +
> +static inline int ad5446_spi_register_driver(void) { return 0; }
> +static inline void ad5446_spi_unregister_driver(void) { }
> +
> +#endif
> +
> +#if IS_ENABLED(CONFIG_I2C)
> +
> +static int ad5622_write(struct ad5446_state *st, unsigned val)
> +{
> +	struct i2c_client *client = to_i2c_client(st->dev);
> +	__be16 data = cpu_to_be16(val);
> +
> +	return i2c_master_send(client, (char *)&data, sizeof(data));
> +}
> +
> +static const struct ad5446_chip_info ad5446_i2c_chip_info[] = {
> +	[ID_AD5602] = {
> +		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
> +		.write = ad5622_write,
> +	},
> +	[ID_AD5612] = {
> +		.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
> +		.write = ad5622_write,
> +	},
> +	[ID_AD5622] = {
> +		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
> +		.write = ad5622_write,
> +	},
> +};

This array is uselessly long, see the ID_AD5xyz enum in the .h

> +
> +static int __devinit ad5446_i2c_probe(struct i2c_client *i2c,
> +	const struct i2c_device_id *id)
> +{
> +	return ad5446_probe(&i2c->dev, id->name,
> +		&ad5446_i2c_chip_info[id->driver_data]);
> +}
...
> diff --git a/drivers/iio/dac/ad5446.h b/drivers/iio/dac/ad5446.h
> index 2934269..aedd7a5 100644
> --- a/drivers/iio/dac/ad5446.h
> +++ b/drivers/iio/dac/ad5446.h
> @@ -38,7 +38,7 @@
>  */
> 
> struct ad5446_state {
> -	struct spi_device		*spi;
> +	struct device		*dev;
> 	const struct ad5446_chip_info	*chip_info;
> 	struct regulator		*reg;
> 	unsigned short			vref_mv;
> @@ -86,6 +86,9 @@ enum ad5446_supported_device_ids {
> 	ID_AD5660_2500,
> 	ID_AD5660_1250,
> 	ID_AD5662,


Here we should split the SPI and I2C enums so I2C chips ID, which are exclusive
to each drivers we register (SPI and I2C), start back at value 0. Or at the very
least, with explicit comments, force the enum back to 0.


> +	ID_AD5602,
> +	ID_AD5612,
> +	ID_AD5622,
> };
> 
> #endif /* IIO_DAC_AD5446_H_ */
> -- 
> 1.7.11.3
> 

I will test this, and if I get no feedback, I will submit a V2 accordingly.

/jfd