Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44977 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753548AbdBKJtc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:49:32 -0500
Subject: Re: [PATCH 5/7] staging: iio: isl29028: add copyright
To: Brian Masney <masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
 <20170209015431.17380-6-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <697ba426-7a91-a7a5-25a2-28a8c4517e1a@kernel.org>
Date: Sat, 11 Feb 2017 09:49:30 +0000
MIME-Version: 1.0
In-Reply-To: <20170209015431.17380-6-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/17 01:54, Brian Masney wrote:
> Add Brian Masney's copyright to the header for the several rounds of
> staging cleanups that has been done to this driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Not that they'll do much with this one ;)

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index ddd604d..68b76b0 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -3,6 +3,7 @@
>   * ISL29028 is Concurrent Ambient Light and Proximity Sensor
>   *
>   * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2016-2017 Brian Masney <masneyb@onstation.org>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> 

