Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44633 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbcJANx1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 09:53:27 -0400
Subject: Re: [PATCH v3 3/5] staging: iio: isl29018: fixed race condition in
 in_illuminance_scale_available_show()
To: Brian Masney <masneyb@onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
 <1474935620-13151-3-git-send-email-masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5a81b7a7-e031-0f1e-9676-b81a00f00191@kernel.org>
Date: Sat, 1 Oct 2016 14:53:23 +0100
MIME-Version: 1.0
In-Reply-To: <1474935620-13151-3-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/09/16 01:20, Brian Masney wrote:
> in_illuminance_scale_available_show() references the
> isl29018_chip->int_time variable in three places inside a for loop.
> The value of the int_time variable can be updated by the
> isl29018_set_integration_time() function, which is called by the
> isl29018_write_raw() function. isl29018_write_raw() locks a
> mutex specific to this driver when the integration time variable is
> updated.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This one I can get more enthusiastic about.  Nice catch.
I thought about sending this for stable, but as the effect
is minor probably not worth it.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 19f282c..990c6e5 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -277,10 +277,12 @@ static ssize_t in_illuminance_scale_available_show
>  	unsigned int i;
>  	int len = 0;
>  
> +	mutex_lock(&chip->lock);
>  	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i)
>  		len += sprintf(buf + len, "%d.%06d ",
>  			       isl29018_scales[chip->int_time][i].scale,
>  			       isl29018_scales[chip->int_time][i].uscale);
> +	mutex_unlock(&chip->lock);
>  
>  	buf[len - 1] = '\n';
>  
> 

