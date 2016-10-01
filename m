Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44646 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbcJANzU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 09:55:20 -0400
Subject: Re: [PATCH v3 4/5] staging: iio: isl29018: change isl29018_read_raw()
 to only have one exit point
To: Brian Masney <masneyb@onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
 <1474935620-13151-4-git-send-email-masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <11ef3887-93eb-3775-1282-3968b85e0550@kernel.org>
Date: Sat, 1 Oct 2016 14:55:18 +0100
MIME-Version: 1.0
In-Reply-To: <1474935620-13151-4-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/09/16 01:20, Brian Masney wrote:
> When the chip is in a suspended state, isl29018_read_raw() will return
> -EBUSY. Change the function so that it only has a single exit point.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 990c6e5..3a4d79d 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -390,8 +390,8 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&chip->lock);
>  	if (chip->suspended) {
> -		mutex_unlock(&chip->lock);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto read_done;
>  	}
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -438,6 +438,8 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
>  	default:
>  		break;
>  	}
> +
> +read_done:
>  	mutex_unlock(&chip->lock);
>  	return ret;
>  }
> 

