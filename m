Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60723 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278AbaCOQ1G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Mar 2014 12:27:06 -0400
Message-ID: <53247F95.7050706@kernel.org>
Date: Sat, 15 Mar 2014 16:28:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Neil Brown <neilb@suse.de>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio:gyro:itg3200 - drop unreachable return ret. Highlighted
 by smatch
References: <1393711683-2287-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1393711683-2287-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/14 22:08, Jonathan Cameron wrote:
> CHECK   drivers/iio/gyro/itg3200_core.c
> drivers/iio/gyro/itg3200_core.c:114 itg3200_read_raw() info: ignoring unreachable code.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
Applied to the togreg branch of iio.git as clearly no one cares.
> ---
>   drivers/iio/gyro/itg3200_core.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> index 4d3f3b9..8295e31 100644
> --- a/drivers/iio/gyro/itg3200_core.c
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -110,8 +110,6 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
>   	default:
>   		return -EINVAL;
>   	}
> -
> -	return ret;
>   }
>
>   static ssize_t itg3200_read_frequency(struct device *dev,
>

