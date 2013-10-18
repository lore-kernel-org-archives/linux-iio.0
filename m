Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49014 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270Ab3JRSFn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2013 14:05:43 -0400
Message-ID: <526186AD.2030109@kernel.org>
Date: Fri, 18 Oct 2013 20:06:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: mcp3422: Include linux/of.h header
References: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/13 13:04, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly to
> avoid build breakage in the future.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
All 4 applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/adc/mcp3422.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index bc93f53..1294832 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/sysfs.h>
> +#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> 
