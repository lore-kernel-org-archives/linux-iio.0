Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41970 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932937AbcKHUqk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 15:46:40 -0500
Subject: Re: [PATCH v2 22/23] staging: iio: tsl2583: updated copyright and
 MODULE_AUTHOR
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
 <1478600208-21153-23-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4649728f-04d9-42d7-c485-f442c13b345a@kernel.org>
Date: Tue, 8 Nov 2016 20:35:57 +0000
MIME-Version: 1.0
In-Reply-To: <1478600208-21153-23-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/16 10:16, Brian Masney wrote:
> Added Brian Masney's copyright to the header and to the MODULE_AUTHOR
> for all of the staging cleanups that has been done to this driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/tsl2583.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 013e7f6..5cb4ae3 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -3,6 +3,7 @@
>   * within the TAOS tsl258x family of devices (tsl2580, tsl2581).
>   *
>   * Copyright (c) 2011, TAOS Corporation.
> + * Copyright (c) 2016 Brian Masney <masneyb@onstation.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -910,6 +911,6 @@ static struct i2c_driver tsl2583_driver = {
>  };
>  module_i2c_driver(tsl2583_driver);
>  
> -MODULE_AUTHOR("J. August Brenner<jbrenner@taosinc.com>");
> +MODULE_AUTHOR("J. August Brenner <jbrenner@taosinc.com> and Brian Masney <masneyb@onstation.org>");
IIRC preferred method is multiple MODULE_AUTHOR statements.

>  MODULE_DESCRIPTION("TAOS tsl2583 ambient light sensor driver");
>  MODULE_LICENSE("GPL");
> 

