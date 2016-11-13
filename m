Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40566 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbcKMM3k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:29:40 -0500
Subject: Re: [PATCH v4 23/26] staging: iio: tsl2583: remove unnecessary memset
 call
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-24-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6ca76ab8-17b8-9944-82d0-1517b7db91b3@kernel.org>
Date: Sun, 13 Nov 2016 12:29:38 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-24-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> The entries in the lux table (als_device_lux) can be updated via sysfs
> through the function in_illuminance_lux_table_store(). The last row in
> the table must be terminated with values that are zero. The sysfs code
> already ensures that the last row is all zeros. The call to memset to
> clear out the table is not needed so this patch removes the unnecessary
> call.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 9db191f..712f753 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -591,9 +591,6 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  		goto done;
>  	}
>  
> -	/* Zero out the table */
> -	memset(chip->als_settings.als_device_lux, 0,
> -	       sizeof(chip->als_settings.als_device_lux));
>  	memcpy(chip->als_settings.als_device_lux, &value[1],
>  	       value[0] * sizeof(value[1]));
>  
> 

