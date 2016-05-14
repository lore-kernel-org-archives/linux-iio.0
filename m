Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35592 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbcENQ6O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 12:58:14 -0400
Subject: Re: [PATCH] iio: potentiometer: tpl0102: remove unneeded i2c check
 functionality test
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1463028468-13880-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <06678591-2f64-de15-ef86-1f530c7f498c@kernel.org>
Date: Sat, 14 May 2016 17:58:13 +0100
MIME-Version: 1.0
In-Reply-To: <1463028468-13880-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/05/16 05:47, Matt Ranostay wrote:
> Actually I2C_FUNC_SMBUS_WORD_DATA isn't need for this device, and regmap
> handles all single byte reads transparently.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git.  If you need it quicker I'm happy to push
this trivial patch as a fix but only if is preventing known hardware from working
(i.e. we have users complaining)

thanks

Jonathan

> ---
>  drivers/iio/potentiometer/tpl0102.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
> index 5c304d4..7b6b545 100644
> --- a/drivers/iio/potentiometer/tpl0102.c
> +++ b/drivers/iio/potentiometer/tpl0102.c
> @@ -116,10 +116,6 @@ static int tpl0102_probe(struct i2c_client *client,
>  	struct tpl0102_data *data;
>  	struct iio_dev *indio_dev;
>  
> -	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_WORD_DATA))
> -		return -EOPNOTSUPP;
> -
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> 

