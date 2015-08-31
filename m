Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38023 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbHaPam (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 11:30:42 -0400
Subject: Re: [patch v3] iio: tsl4531: fix error handling in tsl4531_check_id()
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20150818091633.GC3965@mwanda>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dan Murphy <dmurphy@ti.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E4731F.4070507@kernel.org>
Date: Mon, 31 Aug 2015 16:30:39 +0100
MIME-Version: 1.0
In-Reply-To: <20150818091633.GC3965@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/08/15 10:16, Dan Carpenter wrote:
> The tsl4531_check_id() function returned 1 on "found" and 0 on "not
> found" and negative error codes on failure.  This was non-standard and
> bug prone.  The caller treated all non-zero values including error codes
> as "found".
> 
> This patch fixes it by changing the tsl4531_check_id() to return zero on
> success or a negative error code, and updates the caller.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied to the fixes-togreg branch of iio.git.

Given it's just a slightly different approach to the v2 that
Peter acked, I pulled that ack in here as well.

Thanks,

Jonathan
> ---
> v3: slightly different fix again
> v2: different fix
> 
> diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
> index 2697918..cf94ec7 100644
> --- a/drivers/iio/light/tsl4531.c
> +++ b/drivers/iio/light/tsl4531.c
> @@ -158,9 +158,9 @@ static int tsl4531_check_id(struct i2c_client *client)
>  	case TSL45313_ID:
>  	case TSL45315_ID:
>  	case TSL45317_ID:
> -		return 1;
> -	default:
>  		return 0;
> +	default:
> +		return -ENODEV;
>  	}
>  }
>  
> @@ -180,9 +180,10 @@ static int tsl4531_probe(struct i2c_client *client,
>  	data->client = client;
>  	mutex_init(&data->lock);
>  
> -	if (!tsl4531_check_id(client)) {
> +	ret = tsl4531_check_id(client);
> +	if (ret) {
>  		dev_err(&client->dev, "no TSL4531 sensor\n");
> -		return -ENODEV;
> +		return ret;
>  	}
>  
>  	ret = i2c_smbus_write_byte_data(data->client, TSL4531_CONTROL,
> 

