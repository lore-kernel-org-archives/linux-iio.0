Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47419 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbbHOOfj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 10:35:39 -0400
Subject: Re: [patch] iio: tsl4531: fix error handling in tsl4531_check_id()
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <20150813202027.GA4385@mwanda>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF4E38.70506@kernel.org>
Date: Sat, 15 Aug 2015 15:35:36 +0100
MIME-Version: 1.0
In-Reply-To: <20150813202027.GA4385@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/08/15 21:21, Dan Carpenter wrote:
> The caller expect us to return zero if the ID doesn't match.  Negative
> error codes are treated as success.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Whilst this does indeed fix the issue, I think I'd prefer changing the call
site to deal with the error properly. Could return -ENODEV directly
from the function to make the code cleaner.  Not quite the minimal fix
but only slightly worse and avoids reworking it again to pass the
error up correctly as it should do (after the fix is in place).

Jonathan
> 
> diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
> index 2697918..730fd2b 100644
> --- a/drivers/iio/light/tsl4531.c
> +++ b/drivers/iio/light/tsl4531.c
> @@ -151,7 +151,7 @@ static int tsl4531_check_id(struct i2c_client *client)
>  {
>  	int ret = i2c_smbus_read_byte_data(client, TSL4531_ID);
>  	if (ret < 0)
> -		return ret;
> +		return 0;
>  
>  	switch (ret >> TSL4531_ID_SHIFT) {
>  	case TSL45311_ID:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

