Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeHSTz2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:55:28 -0400
Date: Sun, 19 Aug 2018 17:43:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] iio: dac: mcp4725: avoid using CONFIG_PM_SLEEP
Message-ID: <20180819174320.29c8bc31@archlinux>
In-Reply-To: <20180811084725.6742-1-marcus.folkesson@gmail.com>
References: <20180811084725.6742-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 11 Aug 2018 10:47:25 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> This is already handled by SIMPLE_DEV_PM_OPS().
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.
> ---
> Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
> Mutt still read the mail correct though.

You have my sympathies ;) oh for all email servers and clients being well behaved.

Thanks,

Jonathan

> 
>  drivers/iio/dac/mcp4725.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 8b5aad4c32d9..6d71fd905e29 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -45,7 +45,7 @@ struct mcp4725_data {
>  	struct regulator *vref_reg;
>  };
>  
> -static int mcp4725_suspend(struct device *dev)
> +static int __maybe_unused mcp4725_suspend(struct device *dev)
>  {
>  	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
> @@ -58,7 +58,7 @@ static int mcp4725_suspend(struct device *dev)
>  	return i2c_master_send(data->client, outbuf, 2);
>  }
>  
> -static int mcp4725_resume(struct device *dev)
> +static int __maybe_unused mcp4725_resume(struct device *dev)
>  {
>  	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
> @@ -71,13 +71,7 @@ static int mcp4725_resume(struct device *dev)
>  
>  	return i2c_master_send(data->client, outbuf, 2);
>  }
> -
> -#ifdef CONFIG_PM_SLEEP
>  static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
> -#define MCP4725_PM_OPS (&mcp4725_pm_ops)
> -#else
> -#define MCP4725_PM_OPS NULL
> -#endif
>  
>  static ssize_t mcp4725_store_eeprom(struct device *dev,
>  	struct device_attribute *attr, const char *buf, size_t len)
> @@ -547,7 +541,7 @@ static struct i2c_driver mcp4725_driver = {
>  	.driver = {
>  		.name	= MCP4725_DRV_NAME,
>  		.of_match_table = of_match_ptr(mcp4725_of_match),
> -		.pm	= MCP4725_PM_OPS,
> +		.pm	= &mcp4725_pm_ops,
>  	},
>  	.probe		= mcp4725_probe,
>  	.remove		= mcp4725_remove,
