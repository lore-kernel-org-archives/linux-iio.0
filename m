Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43512 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab3BBKG0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 05:06:26 -0500
Message-ID: <510CE520.7010308@kernel.org>
Date: Sat, 02 Feb 2013 10:06:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 05/11] iio/adc: (max1363) Provide OF node information
 to iio device
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-6-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 09:43 PM, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to togreg branch of iio.git

A previous merge seems to have gone wrong in this driver and some
removed functions have reappeared. I'll post a patch for that in a few mins.

> ---
>  drivers/iio/adc/max1363.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 03b25b3..ca8bbc1 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1538,6 +1538,7 @@ static int max1363_probe(struct i2c_client *client,
>  		goto error_out;
>  	}
>  
> +	indio_dev->dev.of_node = client->dev.of_node;
>  	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
>  	if (ret < 0)
>  		goto error_free_device;
> 
