Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56881 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbcCTLFN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 07:05:13 -0400
Subject: Re: [PATCH] iio: light: tsl2563: Remove flush_scheduled_work
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20160317135510.GA4831@amitoj-Inspiron-3542>
Cc: tj@kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56EE83E7.3090407@kernel.org>
Date: Sun, 20 Mar 2016 11:05:11 +0000
MIME-Version: 1.0
In-Reply-To: <20160317135510.GA4831@amitoj-Inspiron-3542>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/16 13:55, Amitoj Kaur Chawla wrote:
> flush_scheduled_work is scheduled for deprecation.
> Replace cancel_delayed_work and flush_scheduled_work with
> cancel_delayed_work_sync instead to ensure there is no pending or
> running work item.
> 
> Since there is only one work item, chip->poweroff_work, there are 
> no further dependencies of flush_scheduled_work().
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/light/tsl2563.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index 12731d6..57b108c 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -806,8 +806,7 @@ static int tsl2563_probe(struct i2c_client *client,
>  	return 0;
>  
>  fail:
> -	cancel_delayed_work(&chip->poweroff_work);
> -	flush_scheduled_work();
> +	cancel_delayed_work_sync(&chip->poweroff_work);
>  	return err;
>  }
>  
> 

