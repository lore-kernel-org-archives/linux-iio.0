Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60563 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161289AbbBDSkn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Feb 2015 13:40:43 -0500
Message-ID: <54D24962.10402@kernel.org>
Date: Wed, 04 Feb 2015 16:31:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:adc:mcp3422 Fix incorrect scales table
References: <1423059266-18143-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1423059266-18143-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/02/15 14:14, Angelo Compagnucci wrote:
> This patch fixes uncorrect order of mcp3422_scales table, the values
> was erroneously transposed.
> It removes also an unused array and a wrong comment.
> 
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Applied to the fixes-togreg branch of iio.git.  Given timing this will
got to Greg after the merge windows closes.  

I'm travelling without my ssh key so this won't hit git.kernel.org until
at least Sunday.

(Mind you Manchester airport's wifi isn't working in the bar, so who knows
when the email will go out!)

> ---
>  drivers/iio/adc/mcp3422.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 5167225..b96c636 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -58,20 +58,11 @@
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	}
>  
> -/* LSB is in nV to eliminate floating point */
> -static const u32 rates_to_lsb[] = {1000000, 250000, 62500, 15625};
> -
> -/*
> - *  scales calculated as:
> - *  rates_to_lsb[sample_rate] / (1 << pga);
> - *  pga is 1 for 0, 2
> - */
> -
>  static const int mcp3422_scales[4][4] = {
> -	{ 1000000, 250000, 62500, 15625 },
> -	{ 500000 , 125000, 31250, 7812 },
> -	{ 250000 , 62500 , 15625, 3906 },
> -	{ 125000 , 31250 , 7812 , 1953 } };
> +	{ 1000000, 500000, 250000, 125000 },
> +	{ 250000 , 125000, 62500 , 31250  },
> +	{ 62500  , 31250 , 15625 , 7812   },
> +	{ 15625  , 7812  , 3906  , 1953   } };
>  
>  /* Constant msleep times for data acquisitions */
>  static const int mcp3422_read_times[4] = {
> 

