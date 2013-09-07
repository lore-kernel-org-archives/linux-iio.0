Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58229 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3IGUHd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2013 16:07:33 -0400
Message-ID: <522B959D.3020204@kernel.org>
Date: Sat, 07 Sep 2013 22:07:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: Re: [PATCH 12/12] staging: iio: hmc5843: Fix a trivial typo
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org> <1378373397-22919-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-12-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/13 10:29, Sachin Kamat wrote:
> Add a missing closing brace.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Good spot.

Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index d2748c3..67c1ce7 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -730,6 +730,6 @@ static struct i2c_driver hmc5843_driver = {
>  };
>  module_i2c_driver(hmc5843_driver);
>  
> -MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com");
> +MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com>");
>  MODULE_DESCRIPTION("HMC5843/5883/5883L driver");
>  MODULE_LICENSE("GPL");
> 
