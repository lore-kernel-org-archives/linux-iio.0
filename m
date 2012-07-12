Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45757 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728Ab2GLTYE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jul 2012 15:24:04 -0400
Message-ID: <4FFF2452.5050003@kernel.org>
Date: Thu, 12 Jul 2012 20:24:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: double unlock on error path
References: <20120711063443.GE11812@elgon.mountain>
In-Reply-To: <20120711063443.GE11812@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/11/2012 07:34 AM, Dan Carpenter wrote:
> We should be holding the mutex when we goto error_free_chans.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
merged to fixes-togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

and pull request sent.  Thanks.
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index e2aded0..b5afc2f 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -198,11 +198,12 @@ struct iio_channel *iio_channel_get_all(const char *name)
>  		iio_device_get(chans[mapind].indio_dev);
>  		mapind++;
>  	}
> -	mutex_unlock(&iio_map_list_lock);
>  	if (mapind == 0) {
>  		ret = -ENODEV;
>  		goto error_free_chans;
>  	}
> +	mutex_unlock(&iio_map_list_lock);
> +
>  	return chans;
>  
>  error_free_chans:
> 


