Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40174 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab3ALKsc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 05:48:32 -0500
Message-ID: <50F13F7F.6080205@kernel.org>
Date: Sat, 12 Jan 2013 10:48:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:gyro: Remove stale Makefile entry
References: <1357901370-1170-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1357901370-1170-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/11/2013 10:49 AM, Lars-Peter Clausen wrote:
> Commit a301d425e ("staging:iio:gyro remove adis16251 driver as now supported by
> adis16260 driver") removed the adis16251, but left its Makefile entry intact.
> This patch removes the unused Makefile entry.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks,

Added to togreg branch of iio.git
> ---
>  drivers/staging/iio/gyro/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
> index 1303569..79bef4e 100644
> --- a/drivers/staging/iio/gyro/Makefile
> +++ b/drivers/staging/iio/gyro/Makefile
> @@ -14,8 +14,5 @@ obj-$(CONFIG_ADIS16130) += adis16130.o
>  adis16260-y             := adis16260_core.o
>  obj-$(CONFIG_ADIS16260) += adis16260.o
>  
> -adis16251-y             := adis16251_core.o
> -obj-$(CONFIG_ADIS16251) += adis16251.o
> -
>  adxrs450-y             := adxrs450_core.o
>  obj-$(CONFIG_ADXRS450) += adxrs450.o
> 
