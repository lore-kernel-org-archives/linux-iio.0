Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43532 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab3BBKHk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 05:07:40 -0500
Message-ID: <510CE56B.9090902@kernel.org>
Date: Sat, 02 Feb 2013 10:07:39 +0000
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
Subject: Re: [PATCH 06/11] iio/adc: (max1363) Remove duplicate code
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-7-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 09:43 PM, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Applied to togreg branch of iio.git
> ---
>  drivers/iio/adc/max1363.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index ca8bbc1..2c773b4 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1572,8 +1572,6 @@ static int max1363_probe(struct i2c_client *client,
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  	indio_dev->info = st->chip_info->info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channels;
> -	indio_dev->num_channels = st->chip_info->num_channels;
>  	ret = max1363_initial_setup(st);
>  	if (ret < 0)
>  		goto error_free_available_scan_masks;
> 
