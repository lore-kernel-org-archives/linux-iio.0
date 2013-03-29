Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46614 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab3C2J23 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 05:28:29 -0400
Message-ID: <51555EBF.70308@kernel.org>
Date: Fri, 29 Mar 2013 09:28:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Shawn Guo <shawn.guo@linaro.org>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/13] iio: mxs-lradc: remove unneeded mach header inclusion
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org> <1364547350-30498-3-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1364547350-30498-3-git-send-email-shawn.guo@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/29/2013 08:55 AM, Shawn Guo wrote:
> Headers <mach/mxs.h> and <mach/common.h> are not used in the driver
> at all.  Removed the inclusions.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 55a459b..0eb5b4d 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -36,9 +36,6 @@
>  #include <linux/delay.h>
>  #include <linux/input.h>
>  
> -#include <mach/mxs.h>
> -#include <mach/common.h>
> -
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
> 
