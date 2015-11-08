Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43654 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbKHPNT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 10:13:19 -0500
Subject: Re: [PATCH] iio: light: apds9960: correct ->last_busy count
To: Matt Ranostay <mranostay@gmail.com>
References: <1446956488-8262-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563F668D.7090804@kernel.org>
Date: Sun, 8 Nov 2015 15:13:17 +0000
MIME-Version: 1.0
In-Reply-To: <1446956488-8262-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/15 04:21, Matt Ranostay wrote:
> Add missing pm_runtime_mark_last_busy to apds9960_set_power_state
> function.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Hi Matt,

Could you elaborate on what the result of this not being there is? 
My first thought is that this probably wants to go as a fix, but for
that I need details of what the effects of the 'bug' are.

Jonathan
> ---
>  drivers/iio/light/apds9960.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 7d269ef..f6a07dc 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -453,6 +453,7 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
>  			usleep_range(data->als_adc_int_us,
>  				     APDS9960_MAX_INT_TIME_IN_US);
>  	} else {
> +		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
>  	}
>  
> 

