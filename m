Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:52159 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752994AbeEUPKD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2018 11:10:03 -0400
Subject: Re: [PATCH] iio: amplifiers: ad8366: move channel init before
 iio_device_register()
To: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com
References: <20180521064005.17637-1-alexandru.ardelean@analog.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3522029f-ab8d-b368-6f7e-ee33cb6ed999@metafoo.de>
Date: Mon, 21 May 2018 17:10:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180521064005.17637-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Patch looks good, but remember to put the maintainer and reviewers on the
recipient list. Otherwise there is a risk that the patch gets lost.

On 05/21/2018 08:40 AM, Alexandru Ardelean wrote:
> Otherwise a race condition can occur, where userspace can start operations
> before the channels have been properly initialized.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/amplifiers/ad8366.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 43667866321e..0138337aedd1 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -161,12 +161,14 @@ static int ad8366_probe(struct spi_device *spi)
>  	indio_dev->channels = ad8366_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
>  
> +	ret = ad8366_write(indio_dev, 0 , 0);
> +	if (ret < 0)
> +		goto error_disable_reg;
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ad8366_write(indio_dev, 0, 0);
> -
>  	return 0;
>  
>  error_disable_reg:
> 

