Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752371AbeDOPbH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:31:07 -0400
Date: Sun, 15 Apr 2018 16:31:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] staging: iio: ad7746: Add remove()
Message-ID: <20180415163101.6ab15cbc@archlinux>
In-Reply-To: <1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:46 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> This allows the driver to be probed and removed as a module powering it
> down on remove().
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index c29a221..05506bf9 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -775,6 +775,31 @@ static int ad7746_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static int ad7746_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> +	unsigned char regval;
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	regval = chip->config | AD7746_CONF_MODE_PWRDN;
> +	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
As this is a one off operation, perhaps it would be better to factor
it out to a utility function then use devm_add_action_or_reset in
the probe?

Also, I am nervous about this change as there doesn't seem to be
path in probe by which this is deliberately reversed?
It seems to be 'accidentally' handled by the read_raw write to the
CFG register.

The data sheet doesn't really mention much about this register
at all.  It may have special requirements to exit from power down - I have
no idea, but if it is costless, why do we bother with idle mode?

Perhaps Michael can confirm if this is safe to do or not.


> +
> +	mutex_unlock(&chip->lock);
> +
> +	if (ret < 0) {
> +		dev_warn(&client->dev, "Could NOT Power Down!\n");
> +		goto out;
> +	}
> +
> +	iio_device_unregister(indio_dev);
You can't safely do this against the devm_iio_device_register.

> +
> +out:
> +	return ret;
> +}
> +
>  static const struct i2c_device_id ad7746_id[] = {
>  	{ "ad7745", 7745 },
>  	{ "ad7746", 7746 },
> @@ -799,6 +824,7 @@ static struct i2c_driver ad7746_driver = {
>  		.of_match_table = of_match_ptr(ad7746_of_match),
>  	},
>  	.probe = ad7746_probe,
> +	.remove = ad7746_remove,
>  	.id_table = ad7746_id,
>  };
>  module_i2c_driver(ad7746_driver);

