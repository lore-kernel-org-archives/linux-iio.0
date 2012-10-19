Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58532 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab2JSRpT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 13:45:19 -0400
Message-ID: <50819FBD.9000403@kernel.org>
Date: Fri, 19 Oct 2012 19:45:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andreas Larsson <andreas@gaisler.com>
CC: linux-iio@vger.kernel.org, software@gaisler.com
Subject: Re: [PATCH] iio: Remove duplicates for light/ in Kconfig and Makefile
References: <1350462995-18347-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1350462995-18347-1-git-send-email-andreas@gaisler.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/17/2012 09:36 AM, Andreas Larsson wrote:
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Thanks, added to fixes-togreg branch of iio.git tree.
> ---
>  drivers/iio/Kconfig  |    1 -
>  drivers/iio/Makefile |    1 -
>  2 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 6e3f143..fc937ac 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -60,9 +60,8 @@ source "drivers/iio/amplifiers/Kconfig"
>  source "drivers/iio/light/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
>  source "drivers/iio/dac/Kconfig"
>  source "drivers/iio/common/Kconfig"
>  source "drivers/iio/gyro/Kconfig"
> -source "drivers/iio/light/Kconfig"
>  source "drivers/iio/magnetometer/Kconfig"
>  
>  endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index f7fa3c0..761f2b6 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -16,7 +16,6 @@ obj-y += amplifiers/
>  obj-y += light/
>  obj-y += frequency/
>  obj-y += dac/
>  obj-y += common/
>  obj-y += gyro/
> -obj-y += light/
>  obj-y += magnetometer/
> 
