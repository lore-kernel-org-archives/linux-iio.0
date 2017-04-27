Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38001 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdD0GXS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 02:23:18 -0400
Subject: Re: [PATCH] iio: proximity: as3935: move storm out of range check
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: linux-iio@vger.kernel.org
References: <20170427053000.31792-1-matt.ranostay@konsulko.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0cc57ef4-af54-a28a-b1b6-31fcd77b0c0f@kernel.org>
Date: Thu, 27 Apr 2017 07:23:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170427053000.31792-1-matt.ranostay@konsulko.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/17 06:30, Matt Ranostay wrote:
> Move out of storm check to apply to IIO_CHAN_INFO_RAW so the reported
> results are constant between the former and the IIO_CHAN_INFO_PROCESSED
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/as3935.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index ddf9bee89f77..aa0d0be1a608 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -176,13 +176,13 @@ static int as3935_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		if (m == IIO_CHAN_INFO_RAW)
> -			return IIO_VAL_INT;
> -
>  		/* storm out of range */
>  		if (*val == AS3935_DATA_MASK)
>  			return -EINVAL;
>  
> +		if (m == IIO_CHAN_INFO_RAW)
> +			return IIO_VAL_INT;
> +
>  		if (m == IIO_CHAN_INFO_PROCESSED)
>  			*val *= 1000;
>  		break;
> 

