Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db3on0126.outbound.protection.outlook.com ([157.55.234.126]:19456
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753007AbcFUILN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Jun 2016 04:11:13 -0400
Subject: Re: [PATCH 3/3] iio: potentiometer: mcp4531: Add device tree binding
To: Florian Vaussard <florian.vaussard@gmail.com>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"Hartmut Knaack" <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492137-32683-4-git-send-email-florian.vaussard@heig-vd.ch>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	"Joachim Eastwood" <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	"Cristina Moraru" <cristina.moraru09@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Peter Rosin <peda@axentia.se>
Message-ID: <bf4dbd64-aac8-aba3-ec5c-4cd4d0e848f6@axentia.se>
Date: Tue, 21 Jun 2016 09:51:52 +0200
MIME-Version: 1.0
In-Reply-To: <1466492137-32683-4-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-06-21 08:55, Florian Vaussard wrote:
> This patch adds the necessary device tree binding to allow DT probing of
> currently supported parts.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> ---
>  drivers/iio/potentiometer/mcp4531.c | 83 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> index 2251173..41a1e46 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -31,6 +31,8 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/iio/iio.h>
>  
> @@ -188,12 +190,84 @@ static const struct iio_info mcp4531_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id mcp45xx_of_match[] = {

Should be named mcp4531_of_match, also the casting to void and
then back to an integer type is ugly. Would it work to store a
pointer directly into the mcp4531_cfg array instead? I.e.

	{ .compatible = "microchip,mcp4531-502", .data = &mcp4531_cfg[MCP453x_502] },
etc

and then adjust accordingly in mcp4531_probe()?

That is, if you need this patch at all, see my reply to 2/3...

Cheers,
Peter

> +	{ .compatible = "microchip,mcp4531-502", .data = (void *)MCP453x_502 },
> +	{ .compatible = "microchip,mcp4531-103", .data = (void *)MCP453x_103 },
> +	{ .compatible = "microchip,mcp4531-503", .data = (void *)MCP453x_503 },
> +	{ .compatible = "microchip,mcp4531-104", .data = (void *)MCP453x_104 },
> +	{ .compatible = "microchip,mcp4532-502", .data = (void *)MCP453x_502 },
> +	{ .compatible = "microchip,mcp4532-103", .data = (void *)MCP453x_103 },
> +	{ .compatible = "microchip,mcp4532-503", .data = (void *)MCP453x_503 },
> +	{ .compatible = "microchip,mcp4532-104", .data = (void *)MCP453x_104 },
> +	{ .compatible = "microchip,mcp4541-502", .data = (void *)MCP454x_502 },
> +	{ .compatible = "microchip,mcp4541-103", .data = (void *)MCP454x_103 },
> +	{ .compatible = "microchip,mcp4541-503", .data = (void *)MCP454x_503 },
> +	{ .compatible = "microchip,mcp4541-104", .data = (void *)MCP454x_104 },
> +	{ .compatible = "microchip,mcp4542-502", .data = (void *)MCP454x_502 },
> +	{ .compatible = "microchip,mcp4542-103", .data = (void *)MCP454x_103 },
> +	{ .compatible = "microchip,mcp4542-503", .data = (void *)MCP454x_503 },
> +	{ .compatible = "microchip,mcp4542-104", .data = (void *)MCP454x_104 },
> +	{ .compatible = "microchip,mcp4551-502", .data = (void *)MCP455x_502 },
> +	{ .compatible = "microchip,mcp4551-103", .data = (void *)MCP455x_103 },
> +	{ .compatible = "microchip,mcp4551-503", .data = (void *)MCP455x_503 },
> +	{ .compatible = "microchip,mcp4551-104", .data = (void *)MCP455x_104 },
> +	{ .compatible = "microchip,mcp4552-502", .data = (void *)MCP455x_502 },
> +	{ .compatible = "microchip,mcp4552-103", .data = (void *)MCP455x_103 },
> +	{ .compatible = "microchip,mcp4552-503", .data = (void *)MCP455x_503 },
> +	{ .compatible = "microchip,mcp4552-104", .data = (void *)MCP455x_104 },
> +	{ .compatible = "microchip,mcp4561-502", .data = (void *)MCP456x_502 },
> +	{ .compatible = "microchip,mcp4561-103", .data = (void *)MCP456x_103 },
> +	{ .compatible = "microchip,mcp4561-503", .data = (void *)MCP456x_503 },
> +	{ .compatible = "microchip,mcp4561-104", .data = (void *)MCP456x_104 },
> +	{ .compatible = "microchip,mcp4562-502", .data = (void *)MCP456x_502 },
> +	{ .compatible = "microchip,mcp4562-103", .data = (void *)MCP456x_103 },
> +	{ .compatible = "microchip,mcp4562-503", .data = (void *)MCP456x_503 },
> +	{ .compatible = "microchip,mcp4562-104", .data = (void *)MCP456x_104 },
> +	{ .compatible = "microchip,mcp4631-502", .data = (void *)MCP463x_502 },
> +	{ .compatible = "microchip,mcp4631-103", .data = (void *)MCP463x_103 },
> +	{ .compatible = "microchip,mcp4631-503", .data = (void *)MCP463x_503 },
> +	{ .compatible = "microchip,mcp4631-104", .data = (void *)MCP463x_104 },
> +	{ .compatible = "microchip,mcp4632-502", .data = (void *)MCP463x_502 },
> +	{ .compatible = "microchip,mcp4632-103", .data = (void *)MCP463x_103 },
> +	{ .compatible = "microchip,mcp4632-503", .data = (void *)MCP463x_503 },
> +	{ .compatible = "microchip,mcp4632-104", .data = (void *)MCP463x_104 },
> +	{ .compatible = "microchip,mcp4641-502", .data = (void *)MCP464x_502 },
> +	{ .compatible = "microchip,mcp4641-103", .data = (void *)MCP464x_103 },
> +	{ .compatible = "microchip,mcp4641-503", .data = (void *)MCP464x_503 },
> +	{ .compatible = "microchip,mcp4641-104", .data = (void *)MCP464x_104 },
> +	{ .compatible = "microchip,mcp4642-502", .data = (void *)MCP464x_502 },
> +	{ .compatible = "microchip,mcp4642-103", .data = (void *)MCP464x_103 },
> +	{ .compatible = "microchip,mcp4642-503", .data = (void *)MCP464x_503 },
> +	{ .compatible = "microchip,mcp4642-104", .data = (void *)MCP464x_104 },
> +	{ .compatible = "microchip,mcp4651-502", .data = (void *)MCP465x_502 },
> +	{ .compatible = "microchip,mcp4651-103", .data = (void *)MCP465x_103 },
> +	{ .compatible = "microchip,mcp4651-503", .data = (void *)MCP465x_503 },
> +	{ .compatible = "microchip,mcp4651-104", .data = (void *)MCP465x_104 },
> +	{ .compatible = "microchip,mcp4652-502", .data = (void *)MCP465x_502 },
> +	{ .compatible = "microchip,mcp4652-103", .data = (void *)MCP465x_103 },
> +	{ .compatible = "microchip,mcp4652-503", .data = (void *)MCP465x_503 },
> +	{ .compatible = "microchip,mcp4652-104", .data = (void *)MCP465x_104 },
> +	{ .compatible = "microchip,mcp4661-502", .data = (void *)MCP466x_502 },
> +	{ .compatible = "microchip,mcp4661-103", .data = (void *)MCP466x_103 },
> +	{ .compatible = "microchip,mcp4661-503", .data = (void *)MCP466x_503 },
> +	{ .compatible = "microchip,mcp4661-104", .data = (void *)MCP466x_104 },
> +	{ .compatible = "microchip,mcp4662-502", .data = (void *)MCP466x_502 },
> +	{ .compatible = "microchip,mcp4662-103", .data = (void *)MCP466x_103 },
> +	{ .compatible = "microchip,mcp4662-503", .data = (void *)MCP466x_503 },
> +	{ .compatible = "microchip,mcp4662-104", .data = (void *)MCP466x_104 },
> +	{ /*sentinel*/ }
> +};
> +#endif
> +
>  static int mcp4531_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct device *dev = &client->dev;
> +	unsigned long devid;
>  	struct mcp4531_data *data;
>  	struct iio_dev *indio_dev;
> +	const struct of_device_id *match;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_WORD_DATA)) {
> @@ -201,13 +275,19 @@ static int mcp4531_probe(struct i2c_client *client,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	match = of_match_device(of_match_ptr(mcp45xx_of_match), dev);
> +	if (match)
> +		devid = (int)of_device_get_match_data(dev);
> +	else
> +		devid = id->driver_data;
> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> -	data->cfg = &mcp4531_cfg[id->driver_data];
> +	data->cfg = &mcp4531_cfg[devid];
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->info = &mcp4531_info;
> @@ -290,6 +370,7 @@ MODULE_DEVICE_TABLE(i2c, mcp4531_id);
>  static struct i2c_driver mcp4531_driver = {
>  	.driver = {
>  		.name	= "mcp4531",
> +		.of_match_table = of_match_ptr(mcp45xx_of_match),
>  	},
>  	.probe		= mcp4531_probe,
>  	.id_table	= mcp4531_id,
> 

