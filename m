Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59185 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab3H1Srf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Aug 2013 14:47:35 -0400
Message-ID: <521E53D6.8010805@kernel.org>
Date: Wed, 28 Aug 2013 20:47:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	Balaji T K <balajitk@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [patch] iio: adc: twl6030-gpadc: returning success instead of
 error
References: <20130827011902.GC17061@elgon.mountain>
In-Reply-To: <20130827011902.GC17061@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/27/13 02:19, Dan Carpenter wrote:
> I've moved the goto down a line after we set the error code.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Sorry, I was being slow, but Wei Youngjun has already posted a fix for this one.
Just applied to the togreg branch of iio.git

Thanks

Jonathan
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index a558516..0ea96c0 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -537,8 +537,8 @@ static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
>  		ret = -ETIMEDOUT;
>  		goto err;
>  	} else if (timeout < 0) {
> -		goto err;
>  		ret = -EINTR;
> +		goto err;
>  	}
>  
>  	switch (mask) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
