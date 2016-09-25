Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36224 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934881AbcIYO0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 10:26:14 -0400
Subject: Re: [PATCH 1/3] staging: iio: isl29018: remove unused variable and
 defines
To: Brian Masney <masneyb@onstation.org>, gregkh@linuxfoundation.org
References: <1474803667-21776-1-git-send-email-masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5c9abd6e-0e95-e89e-c0ef-99db8d5e7b75@kernel.org>
Date: Sun, 25 Sep 2016 15:26:11 +0100
MIME-Version: 1.0
In-Reply-To: <1474803667-21776-1-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/16 12:41, Brian Masney wrote:
> Removes unused variable and associated #defines that was found using
> make W=1.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. Must have gotten left over from some refactoring that generates
these strings on the fly.

Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 76d9f74..ad282f1 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -66,16 +66,6 @@
>  #define ISL29035_BOUT_SHIFT		0x07
>  #define ISL29035_BOUT_MASK		(0x01 << ISL29035_BOUT_SHIFT)
>  
> -#define ISL29018_INT_TIME_AVAIL		"0.090000 0.005630 0.000351 0.000021"
> -#define ISL29023_INT_TIME_AVAIL		"0.090000 0.005600 0.000352 0.000022"
> -#define ISL29035_INT_TIME_AVAIL		"0.105000 0.006500 0.000410 0.000025"
> -
> -static const char * const int_time_avail[] = {
> -	ISL29018_INT_TIME_AVAIL,
> -	ISL29023_INT_TIME_AVAIL,
> -	ISL29035_INT_TIME_AVAIL,
> -};
> -
>  enum isl29018_int_time {
>  	ISL29018_INT_TIME_16,
>  	ISL29018_INT_TIME_12,
> 

