Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46585 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbcEUQsK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2016 12:48:10 -0400
Subject: Re: [patch v2] iio: humidity: am2315: Remove a stray unlock
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
References: <20160517080256.GC11011@mwanda>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <158f3365-e2c4-49a0-6bd4-25b198ae1e09@kernel.org>
Date: Sat, 21 May 2016 17:48:05 +0100
MIME-Version: 1.0
In-Reply-To: <20160517080256.GC11011@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/05/16 09:02, Dan Carpenter wrote:
> We haven't taken the lock yet so we don't need to unlock here.
> 
> Fixes: 0d96d5ead3f7 ('iio: humidity: Add triggered buffer support for AM2315')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git

Thanks,

Jonathan
> ---
> v2: update subject
> 
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index 3be6d20..1153591 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -165,10 +165,8 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
>  	struct am2315_sensor_data sensor_data;
>  
>  	ret = am2315_read_data(data, &sensor_data);
> -	if (ret < 0) {
> -		mutex_unlock(&data->lock);
> +	if (ret < 0)
>  		goto err;
> -	}
>  
>  	mutex_lock(&data->lock);
>  	if (*(indio_dev->active_scan_mask) == AM2315_ALL_CHANNEL_MASK) {
> 

