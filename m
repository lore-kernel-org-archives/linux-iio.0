Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40540 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbcKMM2R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:28:17 -0500
Subject: Re: [PATCH v4 20/26] staging: iio: tsl2583: add tsl2583 to list of
 supported devices in the header
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-21-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2507c13b-ffe9-7680-2511-1bc1db5d609d@kernel.org>
Date: Sun, 13 Nov 2016 12:28:13 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-21-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> The header only listed the tsl2580 and tsl2581 devices as supported by
> this driver. This patch adds the tsl2583 since it is also supported by
> this driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 3818ffa..806cb0a 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -1,6 +1,6 @@
>  /*
>   * Device driver for monitoring ambient light intensity (lux)
> - * within the TAOS tsl258x family of devices (tsl2580, tsl2581).
> + * within the TAOS tsl258x family of devices (tsl2580, tsl2581, tsl2583).
>   *
>   * Copyright (c) 2011, TAOS Corporation.
>   *
> 

