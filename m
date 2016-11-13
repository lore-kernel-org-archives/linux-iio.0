Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40608 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933747AbcKMMg1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:36:27 -0500
Subject: Re: [PATCH v4 25/26] staging: iio: tsl2583: add copyright and
 MODULE_AUTHOR
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-26-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a5a147f7-4207-db73-6bf3-4ddd53412706@kernel.org>
Date: Sun, 13 Nov 2016 12:35:32 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-26-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> Add Brian Masney's copyright to the header and to the MODULE_AUTHOR
> for all of the staging cleanups that has been done to this driver.
> 
> The original MODULE_AUTHOR() did not have a space between his name and
> email address. This patch also adds the missing space.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index b787952..ca26444 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -3,6 +3,7 @@
>   * within the TAOS tsl258x family of devices (tsl2580, tsl2581, tsl2583).
>   *
>   * Copyright (c) 2011, TAOS Corporation.
> + * Copyright (c) 2016 Brian Masney <masneyb@onstation.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -906,6 +907,7 @@ static struct i2c_driver tsl2583_driver = {
>  };
>  module_i2c_driver(tsl2583_driver);
>  
> -MODULE_AUTHOR("J. August Brenner<jbrenner@taosinc.com>");
> +MODULE_AUTHOR("J. August Brenner <jbrenner@taosinc.com>");
> +MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
>  MODULE_DESCRIPTION("TAOS tsl2583 ambient light sensor driver");
>  MODULE_LICENSE("GPL");
> 

