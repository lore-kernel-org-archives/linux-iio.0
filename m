Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35916 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbcKLQi4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 11:38:56 -0500
Subject: Re: [PATCH v3 20/28] staging: iio: tsl2583: don't assume an unsigned
 int is 32 bits
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-21-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c8223c5c-4ff3-11cd-aea5-a1820a079188@kernel.org>
Date: Sat, 12 Nov 2016 16:38:53 +0000
MIME-Version: 1.0
In-Reply-To: <1478769964-7065-21-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/16 09:25, Brian Masney wrote:
> in_illuminance_lux_table_store assumes that an unsigned int is 32 bits.
> Replace this with sizeof(unsigned int).
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Preferred to use sizeof(value[0]) in case it changes type sometime in the future?
> ---
>  drivers/staging/iio/light/tsl2583.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 1b883b5..bcee31b 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -578,7 +578,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  
>  	/* Zero out the table */
>  	memset(tsl2583_device_lux, 0, sizeof(tsl2583_device_lux));
> -	memcpy(tsl2583_device_lux, &value[1], value[0] * 4);
> +	memcpy(tsl2583_device_lux, &value[1], value[0] * sizeof(unsigned int));
>  
>  	ret = len;
>  
> 

