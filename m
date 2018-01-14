Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38114 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeANMCF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jan 2018 07:02:05 -0500
Date: Sun, 14 Jan 2018 12:02:01 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>
Subject: Re: [PATCH] iio: accel: use strlcpy() instead of strncpy()
Message-ID: <20180114120201.331b5983@archlinux>
In-Reply-To: <1515743138-94480-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1515743138-94480-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 12 Jan 2018 15:45:38 +0800
Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:

> From: Xiongfeng Wang <xiongfeng.wang@linaro.org>
> 
> gcc-8 reports
> 
> drivers/iio/accel/st_accel_i2c.c: In function 'st_accel_i2c_probe':
> ./include/linux/string.h:245:9: warning: '__builtin_strncpy' specified
> bound 20 equals destination size [-Wstringop-truncation]
> 
> The compiler require that the length of the dest string is greater than
> the length we want to copy to make sure the dest string is
> nul-terminated. We can just use strlcpy() to avoid this warning.
> 
> Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
Hmm. As this is just warning suppression I'm not taking it as a fix
but rather via the slow path.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Jonathan
> ---
>  drivers/iio/accel/st_accel_i2c.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 363429b..6bdec8c 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -159,9 +159,8 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
>  			return -ENODEV;
>  
> -		strncpy(client->name, st_accel_id_table[ret].name,
> +		strlcpy(client->name, st_accel_id_table[ret].name,
>  				sizeof(client->name));
> -		client->name[sizeof(client->name) - 1] = '\0';
>  	} else if (!id)
>  		return -ENODEV;
>  

