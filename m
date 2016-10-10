Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48633 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbcJJUxx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 16:53:53 -0400
Subject: Re: [PATCH v2 5/8] staging: iio: isl29018: remove blank line for
 consistency
To: Brian Masney <masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
 <1476084002-29683-6-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <11d755ff-cf3f-b295-1ee1-9cd5a06fbc0e@kernel.org>
Date: Mon, 10 Oct 2016 21:53:52 +0100
MIME-Version: 1.0
In-Reply-To: <1476084002-29683-6-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 08:19, Brian Masney wrote:
> Remove blank line between MODULE_DEVICE_TABLE() and its corresponding
> structure for consistency with the other device table entries.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 6b6c761..917dd8b 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -821,7 +821,6 @@ static const struct i2c_device_id isl29018_id[] = {
>  	{"isl29035", isl29035},
>  	{}
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, isl29018_id);
>  
>  static const struct of_device_id isl29018_of_match[] = {
> 

