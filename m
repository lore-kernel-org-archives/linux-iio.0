Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:52791 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755380AbbHQOvc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Aug 2015 10:51:32 -0400
Date: Mon, 17 Aug 2015 16:51:30 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Dan Carpenter <dan.carpenter@oracle.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch v2] iio: tsl4531: fix error handling in
 tsl4531_check_id()
In-Reply-To: <20150817143832.GC23820@mwanda>
Message-ID: <alpine.DEB.2.02.1508171650390.23302@pmeerw.net>
References: <20150817143832.GC23820@mwanda>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Aug 2015, Dan Carpenter wrote:

> tsl4531_check_id() returns 1 on "found", 0 on "not found" and negative
> if there is an error.  The bug here is that the error handling, treats
> errors as "found".
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Peter Meerwald <pmeerw@pmeerw.net>

> ---
> v2: slightly different fix
> 
> diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
> index 2697918..fca0cb0 100644
> --- a/drivers/iio/light/tsl4531.c
> +++ b/drivers/iio/light/tsl4531.c
> @@ -180,7 +180,10 @@ static int tsl4531_probe(struct i2c_client *client,
>  	data->client = client;
>  	mutex_init(&data->lock);
>  
> -	if (!tsl4531_check_id(client)) {
> +	ret = tsl4531_check_id(client);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0) {
>  		dev_err(&client->dev, "no TSL4531 sensor\n");
>  		return -ENODEV;
>  	}
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
