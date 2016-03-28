Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44445 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbcC1Jjk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 05:39:40 -0400
Subject: Re: [PATCH] iio: potentiometer: mcp4531: use pointer to access model
 parameters
To: Slawomir Stepien <sst@poczta.fm>, peda@axentia.se
References: <20160324160601.GA7819@x220>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8FBD9.6030805@kernel.org>
Date: Mon, 28 Mar 2016 10:39:37 +0100
MIME-Version: 1.0
In-Reply-To: <20160324160601.GA7819@x220>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/16 16:06, Slawomir Stepien wrote:
> Use const pointer to element from model configuration array rather then array
> index, as it will not change anyway.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.  Thanks for cleaning this up.

Jonathan
> ---
>  drivers/iio/potentiometer/mcp4531.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> index a3f6687..385f568 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -79,7 +79,7 @@ static const struct mcp4531_cfg mcp4531_cfg[] = {
>  
>  struct mcp4531_data {
>  	struct i2c_client *client;
> -	unsigned long devid;
> +	const struct mcp4531_cfg *cfg;
>  };
>  
>  #define MCP4531_CHANNEL(ch) {					\
> @@ -113,8 +113,8 @@ static int mcp4531_read_raw(struct iio_dev *indio_dev,
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 1000 * mcp4531_cfg[data->devid].kohms;
> -		*val2 = mcp4531_cfg[data->devid].max_pos;
> +		*val = 1000 * data->cfg->kohms;
> +		*val2 = data->cfg->max_pos;
>  		return IIO_VAL_FRACTIONAL;
>  	}
>  
> @@ -130,7 +130,7 @@ static int mcp4531_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > mcp4531_cfg[data->devid].max_pos || val < 0)
> +		if (val > data->cfg->max_pos || val < 0)
>  			return -EINVAL;
>  		break;
>  	default:
> @@ -152,7 +152,6 @@ static int mcp4531_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct device *dev = &client->dev;
> -	unsigned long devid = id->driver_data;
>  	struct mcp4531_data *data;
>  	struct iio_dev *indio_dev;
>  
> @@ -168,12 +167,12 @@ static int mcp4531_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> -	data->devid = devid;
> +	data->cfg = &mcp4531_cfg[id->driver_data];
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->info = &mcp4531_info;
>  	indio_dev->channels = mcp4531_channels;
> -	indio_dev->num_channels = mcp4531_cfg[devid].wipers;
> +	indio_dev->num_channels = data->cfg->wipers;
>  	indio_dev->name = client->name;
>  
>  	return devm_iio_device_register(dev, indio_dev);
> 

