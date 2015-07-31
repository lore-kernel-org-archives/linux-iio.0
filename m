Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54106 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbbGaTXQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 31 Jul 2015 15:23:16 -0400
Message-ID: <1438370449.10028.2.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH 1/7] iio: bmg160: IIO_BUFFER and IIO_TRIGGERED_BUFFER
 are required
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date: Fri, 31 Jul 2015 12:20:49 -0700
In-Reply-To: <1438177569-18772-2-git-send-email-mpa@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
	 <1438177569-18772-2-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2015-07-29 at 15:46 +0200, Markus Pargmann wrote:
> This patch adds selects for IIO_BUFFER and IIO_TRIGGERED_BUFFER. Without
> IIO_BUFFER, the driver does not compile.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/iio/gyro/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index b3d0e94f72eb..8d2439345673 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -53,7 +53,8 @@ config ADXRS450
>  config BMG160
>  	tristate "BOSCH BMG160 Gyro Sensor"
>  	depends on I2C
> -	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
>  	  driver. This driver also supports BMI055 gyroscope.


