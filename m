Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57740 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756590AbdEGWqB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:46:01 -0400
Subject: Re: [PATCH 1/2] staging: iio: tsl2x7x: rename driver for consistency
 with other IIO light drivers
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
References: <20170505003823.12133-1-masneyb@onstation.org>
 <20170505003823.12133-2-masneyb@onstation.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b68a3d06-429d-f6e7-4e29-0b801cdf3f8f@kernel.org>
Date: Sun, 7 May 2017 13:10:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170505003823.12133-2-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 01:38, Brian Masney wrote:
> This patch renames the tsl2x7x_core.c file to tsl2x7x.c so that the
> naming convention is consistent with other IIO light drivers outside
> of staging.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/Makefile                      | 2 +-
>  drivers/staging/iio/light/{tsl2x7x_core.c => tsl2x7x.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/staging/iio/light/{tsl2x7x_core.c => tsl2x7x.c} (100%)
> 
> diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
> index 10286c3..ab8dc3a 100644
> --- a/drivers/staging/iio/light/Makefile
> +++ b/drivers/staging/iio/light/Makefile
> @@ -2,4 +2,4 @@
>  # Makefile for industrial I/O Light sensors
>  #
>  
> -obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
> +obj-$(CONFIG_TSL2x7x)	+= tsl2x7x.o
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x.c
> similarity index 100%
> rename from drivers/staging/iio/light/tsl2x7x_core.c
> rename to drivers/staging/iio/light/tsl2x7x.c
> 

