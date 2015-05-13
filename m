Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34456 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbbEMRkx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 13:40:53 -0400
Message-ID: <55538CA3.2050806@kernel.org>
Date: Wed, 13 May 2015 18:40:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio:temp:mlx90614 trivial drop of unnecessary ret return
 from write_raw.
References: <1430562902-28068-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1430562902-28068-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/15 11:35, Jonathan Cameron wrote:
> This is mostly part of an effort to clean out our current warnings
> and make the autobuilder build reports more useful.
> 
> Still a worthwhile if trivial cleanup!
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git - pushed out as testing.

Jonathan
> ---
>  drivers/iio/temperature/mlx90614.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index b2d3b56f1260..cb2e8ad8bfdc 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -254,9 +254,7 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&data->lock);
>  		mlx90614_power_put(data);
>  
> -		if (ret < 0)
> -			return ret;
> -		return 0;
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> 

