Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59281 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbcIXPVE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 11:21:04 -0400
Subject: Re: [PATCH] drivers: iio: light: Fix sparse warnings
To: Sandhya Bankar <bankarsandhya512@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <20160924121211.GA12546@localhost.localdomain>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9c0fb251-3d55-9da9-0f12-71e2c26231e4@kernel.org>
Date: Sat, 24 Sep 2016 16:21:01 +0100
MIME-Version: 1.0
In-Reply-To: <20160924121211.GA12546@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/16 13:12, Sandhya Bankar wrote:
> Fixing below warnings:
> 
> drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
This is really just papering over the problem.
A better solution would be to introduce a __be16 local variable to do
the initial read into.  Then put it in regval via that be16_to_cpu
call.

Jonathan
> ---
>  drivers/iio/light/max44000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index 6511b20..1ea9af9 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -214,7 +214,7 @@ static int max44000_read_alsval(struct max44000_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	regval = be16_to_cpu(regval);
> +	be16_to_cpus(&regval);
>  
>  	/*
>  	 * Overflow is explained on datasheet page 17.
> 

