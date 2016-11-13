Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40558 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbcKMM3R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:29:17 -0500
Subject: Re: [PATCH v4 22/26] staging: iio: tsl2583: remove comment for
 tsl2583_probe()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-23-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dc47b704-3027-ca26-e570-ab0c47af2451@kernel.org>
Date: Sun, 13 Nov 2016 12:29:15 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-23-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> The comment for tsl2583_probe() does not provide any useful value.
> This patch removes the comment.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied 
> ---
>  drivers/staging/iio/light/tsl2583.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 727ed49..9db191f 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -782,10 +782,6 @@ static const struct iio_info tsl2583_info = {
>  	.write_raw = tsl2583_write_raw,
>  };
>  
> -/*
> - * Client probe function - When a valid device is found, the driver's device
> - * data structure is updated, and initialization completes successfully.
> - */
>  static int tsl2583_probe(struct i2c_client *clientp,
>  			 const struct i2c_device_id *idp)
>  {
> 

