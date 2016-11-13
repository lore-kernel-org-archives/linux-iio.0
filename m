Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40471 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbcKMMW2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:22:28 -0500
Subject: Re: [PATCH v4 17/26] staging: iio: tsl2583: remove unnecessary
 parentheses
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-18-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1ffdb5cc-5211-92f1-87c9-015b175b2ee5@kernel.org>
Date: Sun, 13 Nov 2016 12:22:26 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-18-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> in_illuminance_lux_table_store() contains some unnecessary parentheses.
> This patch removes them since they provide no value.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index fc58074..fe9d777 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -574,7 +574,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  			__func__, TSL2583_MAX_LUX_INTS);
>  		goto done;
>  	}
> -	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
> +	if ((value[n - 2] | value[n - 1] | value[n]) != 0) {
>  		dev_err(dev, "%s: The last 3 entries in the lux table must be zeros.\n",
>  			__func__);
>  		goto done;
> @@ -582,7 +582,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  
>  	/* Zero out the table */
>  	memset(tsl2583_device_lux, 0, sizeof(tsl2583_device_lux));
> -	memcpy(tsl2583_device_lux, &value[1], (value[0] * 4));
> +	memcpy(tsl2583_device_lux, &value[1], value[0] * 4);
>  
>  	ret = len;
>  
> 

