Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40466 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbcKMMVa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:21:30 -0500
Subject: Re: [PATCH v4 16/26] staging: iio: tsl2583: change
 tsl2583_als_calibrate() to return 0 on success
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-17-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <eb31f56e-9799-4307-4304-1e91cc536b5e@kernel.org>
Date: Sun, 13 Nov 2016 12:21:28 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-17-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> tsl2583_als_calibrate() returns the newly computed gain_trim if the
> calibration was successful. This function is only called by
> in_illuminance_calibrate_store() and the return value inside that
> sysfs attribute is only checked to see if an error was returned.
> This patch changes tsl2583_als_calibrate() to return 0 on success.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index bcdf095..fc58074 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -348,7 +348,7 @@ static int tsl2583_als_calibrate(struct iio_dev *indio_dev)
>  
>  	chip->als_settings.als_gain_trim = (int)gain_trim_val;
>  
> -	return (int)gain_trim_val;
> +	return 0;
>  }
>  
>  static int tsl2583_set_als_time(struct tsl2583_chip *chip)
> 

