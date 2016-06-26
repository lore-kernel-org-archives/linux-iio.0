Return-Path: <peda@axentia.se>
Subject: Re: [PATCH v2 3/4] iio: potentiometer: mcp4531: Add device tree
 binding
To: Florian Vaussard <florian.vaussard@gmail.com>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut
 Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1466972567-9580-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466972567-9580-4-git-send-email-florian.vaussard@heig-vd.ch>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Slawomir Stepien <sst@poczta.fm>, Joachim
 Eastwood <manabian@gmail.com>, Matt Ranostay <mranostay@gmail.com>, Cristina
 Moraru <cristina.moraru09@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Florian Vaussard
	<florian.vaussard@heig-vd.ch>
From: Peter Rosin <peda@axentia.se>
Message-ID: <68f532da-766d-d1f6-5528-f69b80fb41b6@axentia.se>
Date: Mon, 27 Jun 2016 00:12:49 +0200
MIME-Version: 1.0
In-Reply-To: <1466972567-9580-4-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

Hi Florian,

On 2016-06-26 22:22, Florian Vaussard wrote:
> This patch adds the necessary device tree binding to allow DT probing of
> currently supported parts.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> ---
>  drivers/iio/potentiometer/mcp4531.c | 273 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 272 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> index 2251173..bf7b853 100644
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
> @@ -188,12 +190,275 @@ static const struct iio_info mcp4531_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id mcp4531_of_match[] = {
> +	{
> +		.compatible = "microchip,mcp4531-502",
> +		.data = &mcp4531_cfg[MCP453x_502]
> +	},

All this vertical whitespace makes this unreadable. I'd be
happier with either ignoring the 80 char rule, or skipping
the leading tab. I.e.

	{ .compatible = "microchip,mcp4531-502", .data = &mcp4531_cfg[MCP453x_502] },
	{ .compatible = "microchip,mcp4531-103", .data = &mcp4531_cfg[MCP453x_103] },
	{ .compatible = "microchip,mcp4531-503", .data = &mcp4531_cfg[MCP453x_503] },
	...

or

{ .compatible = "microchip,mcp4531-502", .data = &mcp4531_cfg[MCP453x_502] },
{ .compatible = "microchip,mcp4531-103", .data = &mcp4531_cfg[MCP453x_103] },
{ .compatible = "microchip,mcp4531-503", .data = &mcp4531_cfg[MCP453x_503] },
...

Or perhaps using a macro?

#define MCP4531_COMPATIBLE(of_compatible, cfg) {	\
		.compatible = of_compatible,		\
		.data = &mcp4531_cfg[cfg],		\
}

and then

	MCP4531_COMPATIBLE("microchip,mcp4531-502", MCP453x_502),
	MCP4531_COMPATIBLE("microchip,mcp4531-103", MCP453x_103),
	MCP4531_COMPATIBLE("microchip,mcp4531-503", MCP453x_503),
	...

Pick any of those, and you have my ack. Maybe Jonathan has an opinion
on which is best?

End of bikeshed...

Cheers,
Peter

> +	{
> +		.compatible = "microchip,mcp4531-103",
> +		.data = &mcp4531_cfg[MCP453x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4531-503",
> +		.data = &mcp4531_cfg[MCP453x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4531-104",
> +		.data = &mcp4531_cfg[MCP453x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4532-502",
> +		.data = &mcp4531_cfg[MCP453x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4532-103",
> +		.data = &mcp4531_cfg[MCP453x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4532-503",
> +		.data = &mcp4531_cfg[MCP453x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4532-104",
> +		.data = &mcp4531_cfg[MCP453x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4541-502",
> +		.data = &mcp4531_cfg[MCP454x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4541-103",
> +		.data = &mcp4531_cfg[MCP454x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4541-503",
> +		.data = &mcp4531_cfg[MCP454x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4541-104",
> +		.data = &mcp4531_cfg[MCP454x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4542-502",
> +		.data = &mcp4531_cfg[MCP454x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4542-103",
> +		.data = &mcp4531_cfg[MCP454x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4542-503",
> +		.data = &mcp4531_cfg[MCP454x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4542-104",
> +		.data = &mcp4531_cfg[MCP454x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4551-502",
> +		.data = &mcp4531_cfg[MCP455x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4551-103",
> +		.data = &mcp4531_cfg[MCP455x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4551-503",
> +		.data = &mcp4531_cfg[MCP455x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4551-104",
> +		.data = &mcp4531_cfg[MCP455x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4552-502",
> +		.data = &mcp4531_cfg[MCP455x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4552-103",
> +		.data = &mcp4531_cfg[MCP455x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4552-503",
> +		.data = &mcp4531_cfg[MCP455x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4552-104",
> +		.data = &mcp4531_cfg[MCP455x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4561-502",
> +		.data = &mcp4531_cfg[MCP456x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4561-103",
> +		.data = &mcp4531_cfg[MCP456x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4561-503",
> +		.data = &mcp4531_cfg[MCP456x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4561-104",
> +		.data = &mcp4531_cfg[MCP456x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4562-502",
> +		.data = &mcp4531_cfg[MCP456x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4562-103",
> +		.data = &mcp4531_cfg[MCP456x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4562-503",
> +		.data = &mcp4531_cfg[MCP456x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4562-104",
> +		.data = &mcp4531_cfg[MCP456x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4631-502",
> +		.data = &mcp4531_cfg[MCP463x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4631-103",
> +		.data = &mcp4531_cfg[MCP463x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4631-503",
> +		.data = &mcp4531_cfg[MCP463x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4631-104",
> +		.data = &mcp4531_cfg[MCP463x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4632-502",
> +		.data = &mcp4531_cfg[MCP463x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4632-103",
> +		.data = &mcp4531_cfg[MCP463x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4632-503",
> +		.data = &mcp4531_cfg[MCP463x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4632-104",
> +		.data = &mcp4531_cfg[MCP463x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4641-502",
> +		.data = &mcp4531_cfg[MCP464x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4641-103",
> +		.data = &mcp4531_cfg[MCP464x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4641-503",
> +		.data = &mcp4531_cfg[MCP464x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4641-104",
> +		.data = &mcp4531_cfg[MCP464x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4642-502",
> +		.data = &mcp4531_cfg[MCP464x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4642-103",
> +		.data = &mcp4531_cfg[MCP464x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4642-503",
> +		.data = &mcp4531_cfg[MCP464x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4642-104",
> +		.data = &mcp4531_cfg[MCP464x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4651-502",
> +		.data = &mcp4531_cfg[MCP465x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4651-103",
> +		.data = &mcp4531_cfg[MCP465x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4651-503",
> +		.data = &mcp4531_cfg[MCP465x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4651-104",
> +		.data = &mcp4531_cfg[MCP465x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4652-502",
> +		.data = &mcp4531_cfg[MCP465x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4652-103",
> +		.data = &mcp4531_cfg[MCP465x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4652-503",
> +		.data = &mcp4531_cfg[MCP465x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4652-104",
> +		.data = &mcp4531_cfg[MCP465x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4661-502",
> +		.data = &mcp4531_cfg[MCP466x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4661-103",
> +		.data = &mcp4531_cfg[MCP466x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4661-503",
> +		.data = &mcp4531_cfg[MCP466x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4661-104",
> +		.data = &mcp4531_cfg[MCP466x_104]
> +	},
> +	{
> +		.compatible = "microchip,mcp4662-502",
> +		.data = &mcp4531_cfg[MCP466x_502]
> +	},
> +	{
> +		.compatible = "microchip,mcp4662-103",
> +		.data = &mcp4531_cfg[MCP466x_103]
> +	},
> +	{
> +		.compatible = "microchip,mcp4662-503",
> +		.data = &mcp4531_cfg[MCP466x_503]
> +	},
> +	{
> +		.compatible = "microchip,mcp4662-104",
> +		.data = &mcp4531_cfg[MCP466x_104]
> +	},
> +	{ /* sentinel */ }
> +};
> +#endif
> +
>  static int mcp4531_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct device *dev = &client->dev;
>  	struct mcp4531_data *data;
>  	struct iio_dev *indio_dev;
> +	const struct of_device_id *match;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_WORD_DATA)) {
> @@ -207,7 +472,12 @@ static int mcp4531_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> -	data->cfg = &mcp4531_cfg[id->driver_data];
> +
> +	match = of_match_device(of_match_ptr(mcp4531_of_match), dev);
> +	if (match)
> +		data->cfg = of_device_get_match_data(dev);
> +	else
> +		data->cfg = &mcp4531_cfg[id->driver_data];
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->info = &mcp4531_info;
> @@ -290,6 +560,7 @@ MODULE_DEVICE_TABLE(i2c, mcp4531_id);
>  static struct i2c_driver mcp4531_driver = {
>  	.driver = {
>  		.name	= "mcp4531",
> +		.of_match_table = of_match_ptr(mcp4531_of_match),
>  	},
>  	.probe		= mcp4531_probe,
>  	.id_table	= mcp4531_id,
> 
