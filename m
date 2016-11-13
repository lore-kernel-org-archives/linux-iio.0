Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40485 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbcKMMXl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:23:41 -0500
Subject: Re: [PATCH v4 18/26] staging: iio: tsl2583: don't assume an unsigned
 int is 32 bits
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-19-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ab1a1c0e-b602-822b-79f1-6d71496ac137@kernel.org>
Date: Sun, 13 Nov 2016 12:23:40 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-19-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> in_illuminance_lux_table_store assumes that an unsigned int is 32 bits.
> Replace this with sizeof(value[1]).
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index fe9d777..78967dc 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -582,7 +582,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  
>  	/* Zero out the table */
>  	memset(tsl2583_device_lux, 0, sizeof(tsl2583_device_lux));
> -	memcpy(tsl2583_device_lux, &value[1], value[0] * 4);
> +	memcpy(tsl2583_device_lux, &value[1], value[0] * sizeof(value[1]));
>  
>  	ret = len;
>  
> 

