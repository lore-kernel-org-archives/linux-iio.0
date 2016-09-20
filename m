Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42153 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbcITKIv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2016 06:08:51 -0400
Date: Tue, 20 Sep 2016 13:08:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 2/2] staging: iio: isl29018: fix alignment of function
 arguments
Message-ID: <20160920100835.GI13620@mwanda>
References: <1474364337-13949-1-git-send-email-masneyb@onstation.org>
 <1474364337-13949-2-git-send-email-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474364337-13949-2-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Sep 20, 2016 at 05:38:57AM -0400, Brian Masney wrote:
> Address warning from checkpatch:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/isl29018.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index ea4d7f1..4401451 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -607,8 +607,8 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
>  		return status;
>  	}
>  
> -	status = isl29018_set_integration_time(chip,
> -			isl29018_int_utimes[chip->type][chip->int_time]);
> +	status = isl29018_set_integration_time(
> +			chip, isl29018_int_utimes[chip->type][chip->int_time]);

Congrats on finding a hack to silence checkpatch but this doesn't really
improve the code at all...  It's ok to ignore checkpatch.pl.

regards,
dan carpenter

