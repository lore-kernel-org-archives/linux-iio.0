Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48639 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbcJJUy0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 16:54:26 -0400
Subject: Re: [PATCH v2 6/8] staging: iio: isl29018: rename description in
 Kconfig for consistency
To: Brian Masney <masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
 <1476084002-29683-7-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c91d1c16-61f4-48a3-9d29-d209bb4386c4@kernel.org>
Date: Mon, 10 Oct 2016 21:54:24 +0100
MIME-Version: 1.0
In-Reply-To: <1476084002-29683-7-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 08:20, Brian Masney wrote:
> Rename description from "ISL 29018" to "Intersil 29018" in Kconfig for
> consistency with other drivers in mainline.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
> index ca8d6e6..5e4e77e 100644
> --- a/drivers/staging/iio/light/Kconfig
> +++ b/drivers/staging/iio/light/Kconfig
> @@ -4,7 +4,7 @@
>  menu "Light sensors"
>  
>  config SENSORS_ISL29018
> -	tristate "ISL 29018 light and proximity sensor"
> +	tristate "Intersil 29018 light and proximity sensor"
>  	depends on I2C
>  	select REGMAP_I2C
>  	default n
> 

