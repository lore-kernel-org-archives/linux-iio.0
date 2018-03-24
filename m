Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeCXNqR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:46:17 -0400
Date: Sat, 24 Mar 2018 13:46:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 11/11] staging: iio: tsl2x7x: add copyright
Message-ID: <20180324134611.271b173f@archlinux>
In-Reply-To: <20180321102912.5130-12-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-12-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:12 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Add Brian Masney's copyright and to the list of module authors for all
> of the staging cleanups. This patch also update's Jon Brenner's current
> work email address since AMS now owns TAOS.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing.
Likely these will be going upstream after the coming merge window.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 5f78664d2b0e..77a81d75af4f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -3,6 +3,7 @@
>   * and proximity detection (prox) within the TAOS TSL2X7X family of devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
> + * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -1744,6 +1745,7 @@ static struct i2c_driver tsl2x7x_driver = {
>  
>  module_i2c_driver(tsl2x7x_driver);
>  
> -MODULE_AUTHOR("J. August Brenner<jbrenner@taosinc.com>");
> +MODULE_AUTHOR("J. August Brenner <Jon.Brenner@ams.com>");
> +MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
>  MODULE_DESCRIPTION("TAOS tsl2x7x ambient and proximity light sensor driver");
>  MODULE_LICENSE("GPL");

