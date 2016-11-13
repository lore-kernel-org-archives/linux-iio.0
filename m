Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40418 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933588AbcKMMSg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:18:36 -0500
Subject: Re: [PATCH v4 13/26] staging: iio: tsl2583: fix multiline comment
 syntax
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-14-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c07b488b-3530-b4b1-5fc1-abf894f90a99@kernel.org>
Date: Sun, 13 Nov 2016 12:17:48 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-14-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> The definition of the tsl2583_device_lux struct has a series of single
> line comments. There are two other cases where the multiline comments
> did not have an initial blank line. Change these comments to use the
> proper multiline syntax.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 8303753..52a39a6 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -93,9 +93,11 @@ struct tsl2583_lux {
>  	unsigned int ch1;
>  };
>  
> -/* This structure is intentionally large to accommodate updates via sysfs. */
> -/* Sized to 11 = max 10 segments + 1 termination segment */
> -/* Assumption is one and only one type of glass used  */
> +/*
> + * This structure is intentionally large to accommodate updates via sysfs.
> + * Sized to 11 = max 10 segments + 1 termination segment. Assumption is that
> + * one and only one type of glass used.
> + */
>  static struct tsl2583_lux tsl2583_device_lux[11] = {
>  	{  9830,  8520, 15729 },
>  	{ 12452, 10807, 23344 },
> @@ -261,7 +263,8 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
>  		lux = (lux + (chip->als_time_scale >> 1)) /
>  			chip->als_time_scale;
>  
> -	/* Adjust for active gain scale.
> +	/*
> +	 * Adjust for active gain scale.
>  	 * The tsl2583_device_lux tables above have a factor of 8192 built in,
>  	 * so we need to shift right.
>  	 * User-specified gain provides a multiplier.
> @@ -553,7 +556,8 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  
>  	get_options(buf, ARRAY_SIZE(value), value);
>  
> -	/* We now have an array of ints starting at value[1], and
> +	/*
> +	 * We now have an array of ints starting at value[1], and
>  	 * enumerated by value[0].
>  	 * We expect each group of three ints is one table entry,
>  	 * and the last table entry is all 0.
> 

