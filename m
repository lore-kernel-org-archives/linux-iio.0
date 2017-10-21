Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932188AbdJURca (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:32:30 -0400
Date: Sat, 21 Oct 2017 18:32:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 02/13] staging: iio: tsl2x7x: remove unused
 tsl2x7x_parse_result structure
Message-ID: <20171021183225.052402d8@archlinux>
In-Reply-To: <20171019200632.25820-3-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:21 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The structure tsl2x7x_parse_result is not used so this patch removes its
> definition.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 2dd8c502fd7a..094ab76b5d60 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -142,11 +142,6 @@ enum {
>  	TSL2X7X_CHIP_SUSPENDED = 2
>  };
>  
> -struct tsl2x7x_parse_result {
> -	int integer;
> -	int fract;
> -};
> -
>  /* Per-device data */
>  struct tsl2x7x_als_info {
>  	u16 als_ch0;

