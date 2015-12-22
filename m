Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48537 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596AbbLVSBX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2015 13:01:23 -0500
Subject: Re: [PATCH v2 1/3] iio: light: us5182d: Fix enable status
 inconcistency
To: Adriana Reus <adriana.reus@intel.com>
References: <1450095887-13122-1-git-send-email-adriana.reus@intel.com>
 <1450095887-13122-2-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56798FF2.9020502@kernel.org>
Date: Tue, 22 Dec 2015 18:01:22 +0000
MIME-Version: 1.0
In-Reply-To: <1450095887-13122-2-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/12/15 12:24, Adriana Reus wrote:
> When setting als only or proximity only modes make sure that we mark the
> other component as disabled. This fix is in preparation of adding event
> support because that will make it possible to switch between one-shot and
> continuous modes and not tracking these correctly may cause faulty
> behaviour (e.g wrongfully considering px enabled and not setting an
> appropriate mode in the chip).
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Chattier commit message, no other changes
> 
>  drivers/iio/light/us5182d.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 256c4bc..f24b687 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -238,8 +238,12 @@ static int us5182d_als_enable(struct us5182d_data *data)
>  	int ret;
>  	u8 mode;
>  
> -	if (data->power_mode == US5182D_ONESHOT)
> -		return us5182d_set_opmode(data, US5182D_ALS_ONLY);
> +	if (data->power_mode == US5182D_ONESHOT) {
> +		ret = us5182d_set_opmode(data, US5182D_ALS_ONLY);
> +		if (ret < 0)
> +			return ret;
> +		data->px_enabled = false;
> +	}
>  
>  	if (data->als_enabled)
>  		return 0;
> @@ -260,8 +264,12 @@ static int us5182d_px_enable(struct us5182d_data *data)
>  	int ret;
>  	u8 mode;
>  
> -	if (data->power_mode == US5182D_ONESHOT)
> -		return us5182d_set_opmode(data, US5182D_PX_ONLY);
> +	if (data->power_mode == US5182D_ONESHOT) {
> +		ret = us5182d_set_opmode(data, US5182D_PX_ONLY);
> +		if (ret < 0)
> +			return ret;
> +		data->als_enabled = false;
> +	}
>  
>  	if (data->px_enabled)
>  		return 0;
> 

