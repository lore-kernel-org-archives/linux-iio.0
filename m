Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37500 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbdDHOrN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 10:47:13 -0400
Subject: Re: [PATCH v2 1/7] iio: light: rpr0521 disable sensor -bugfix
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <19d68038-5af3-2728-cbc9-8df28b3b26d9@kernel.org>
Date: Sat, 8 Apr 2017 15:47:11 +0100
MIME-Version: 1.0
In-Reply-To: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/17 13:07, Mikko Koivunen wrote:
> Sensor was marked enabled on each call even if the call was for disabling
> sensor.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
What effect does this have on device operation?
What I'm looking for is info on whether this wants to go to stable as
it will cause the device not to work, or whether it is wasting power etc.

Also useful to add a fixes tag as that makes it easy for stable maintainers
to filter incoming patches for relevance to their trees.

Will be looking for Acks from Daniel on all of these as he wrote the original
and is still active.

Jonathan
> ---
> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> 
>  drivers/iio/light/rpr0521.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 7de0f39..c15529b 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -197,8 +197,10 @@ static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
>  	if (ret < 0)
>  		return ret;
>  
> -	data->als_dev_en = true;
> -
> +	if (status & RPR0521_MODE_ALS_MASK)
> +		data->als_dev_en = true;
> +	else
> +		data->als_dev_en = false;
>  	return 0;
>  }
>  
> @@ -212,7 +214,10 @@ static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
>  	if (ret < 0)
>  		return ret;
>  
> -	data->pxs_dev_en = true;
> +	if (status & RPR0521_MODE_PXS_MASK)
> +		data->pxs_dev_en = true;
> +	else
> +		data->pxs_dev_en = false;
>  
>  	return 0;
>  }
> 

