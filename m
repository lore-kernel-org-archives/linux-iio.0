Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757797AbbEWLEX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 07:04:23 -0400
Message-ID: <55605EB4.5060603@kernel.org>
Date: Sat, 23 May 2015 12:04:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: light: Updated Vishay Capella cm32181 ambient
 light sensor driver.
References: <1432268380-7302-1-git-send-email-ktsai@capellamicro.com> <1432268380-7302-3-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1432268380-7302-3-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/15 05:19, Kevin Tsai wrote:
> - Added Power Management support.
> - Added driver remove routine.
> 
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
This one is fine other than the patch title.
You could split it but as the two changes don't interfere and are
kind of related, this one is fine as a single patch.
> ---
>  drivers/iio/light/cm32181.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 6b11145..9bc3e1f 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -370,11 +370,51 @@ static int cm32181_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static int cm32181_remove(struct i2c_client *client)
> +{
> +	i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> +		CM32181_CMD_ALS_DISABLE);
> +
> +	return 0;
> +}
> +
>  static const struct i2c_device_id cm32181_id[] = {
>  	{ "cm32181", 0 },
>  	{ }
>  };
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int cm32181_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct cm32181_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	ret = i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> +					CM32181_CMD_ALS_DISABLE);
> +
> +	return ret;
> +}
> +
> +static int cm32181_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct cm32181_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	chip->conf_regs[CM32181_REG_ADDR_CMD] &= ~CM32181_CMD_ALS_DISABLE;
> +	ret = i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> +				chip->conf_regs[CM32181_REG_ADDR_CMD]);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops cm32181_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cm32181_suspend, cm32181_resume)};
> +#endif
> +
>  MODULE_DEVICE_TABLE(i2c, cm32181_id);
>  
>  static const struct of_device_id cm32181_of_match[] = {
> @@ -387,9 +427,13 @@ static struct i2c_driver cm32181_driver = {
>  		.name	= "cm32181",
>  		.of_match_table = of_match_ptr(cm32181_of_match),
>  		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM_SLEEP
> +		.pm     = &cm32181_pm_ops,
> +#endif
>  	},
>  	.id_table	= cm32181_id,
>  	.probe		= cm32181_probe,
> +	.remove		= cm32181_remove,
>  };
>  
>  module_i2c_driver(cm32181_driver);
> 

