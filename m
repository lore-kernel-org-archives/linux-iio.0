Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33278 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcADLiV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 06:38:21 -0500
Subject: Re: [PATCH 1/2] iio: add IIO_TRIGGER dependency to STK8BA50
To: Vegard Nossum <vegard.nossum@oracle.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1451739880-14178-1-git-send-email-vegard.nossum@oracle.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568A59AC.6020608@kernel.org>
Date: Mon, 4 Jan 2016 11:38:20 +0000
MIME-Version: 1.0
In-Reply-To: <1451739880-14178-1-git-send-email-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/16 13:04, Vegard Nossum wrote:
> Ran into this on UML:
> 
> drivers/iio/accel/stk8ba50.c: In function ‘stk8ba50_data_rdy_trigger_set_state’:
> drivers/iio/accel/stk8ba50.c:163:9: error: implicit declaration of function ‘iio_trigger_get_drvdata’ [-Werror=implicit-function-declaration]
> 
> iio_trigger_get_drvdata() is defined only when IIO_TRIGGER is selected.
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 969428d..16cc5c6 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -173,6 +173,7 @@ config STK8312
>  config STK8BA50
>  	tristate "Sensortek STK8BA50 3-Axis Accelerometer Driver"
>  	depends on I2C
> +	depends on IIO_TRIGGER
>  	help
>  	  Say yes here to get support for the Sensortek STK8BA50 3-axis
>  	  accelerometer.
> 

