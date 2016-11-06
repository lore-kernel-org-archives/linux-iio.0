Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55536 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbcKFLsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 06:48:41 -0500
Subject: Re: [PATCH 3/9] staging: iio: tsl2583: fixed ordering of comments
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
 <1478177780-28699-4-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <702bfb8e-25dc-258c-6e69-0c2af7ddf64d@kernel.org>
Date: Sun, 6 Nov 2016 11:48:39 +0000
MIME-Version: 1.0
In-Reply-To: <1478177780-28699-4-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 12:56, Brian Masney wrote:
> in taos_defaults()
> 
> The comments in taos_defaults() appear after the line of code
> that they apply to. This patch moves the comments so that they appear
> before the code. Some of the comments were updated to be more
> informative.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Nice tidying up.

Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2583.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 388440b..709f446 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -143,16 +143,23 @@ static const struct gainadj gainadj[] = {
>   */
>  static void taos_defaults(struct tsl2583_chip *chip)
>  {
> -	/* Operational parameters */
> +	/*
> +	 * The integration time must be a multiple of 50ms and within the
> +	 * range [50, 600] ms.
> +	 */
>  	chip->taos_settings.als_time = 100;
> -	/* must be a multiple of 50mS */
> +
> +	/*
> +	 * This is an index into the gainadj table. Assume clear glass as the
> +	 * default.
> +	 */
>  	chip->taos_settings.als_gain = 0;
> -	/* this is actually an index into the gain table */
> -	/* assume clear glass as default */
> +
> +	/* Default gain trim to account for aperture effects */
>  	chip->taos_settings.als_gain_trim = 1000;
> -	/* default gain trim to account for aperture effects */
> -	chip->taos_settings.als_cal_target = 130;
> +
>  	/* Known external ALS reading used for calibration */
> +	chip->taos_settings.als_cal_target = 130;
>  }
>  
>  /*
> 

