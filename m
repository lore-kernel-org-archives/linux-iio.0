Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61515 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbbG1N1W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2015 09:27:22 -0400
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH 1/7] iio:accel:stk8312: add triggered buffer dependency
Date: Tue, 28 Jul 2015 13:27:18 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4022186E7F@IRSMSX109.ger.corp.intel.com>
References: <cover.1437955135.git.knaack.h@gmx.de>
 <ab6ffe2a496adb1a1167e698e1c78ef7753d52ec.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <ab6ffe2a496adb1a1167e698e1c78ef7753d52ec.1437955135.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: Tuesday, July 28, 2015 1:49 AM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
> A
> Subject: [PATCH 1/7] iio:accel:stk8312: add triggered buffer dependency
> 
> Add the still missing dependencies for triggered buffer support.
> 
> Fixes: 	95c12bba51c37 ("iio: accel: Add buffer mode for Sensortek STK8312")
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

+1

Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

> ---
>  drivers/iio/accel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig index
> 00e7bcbdbe24..c99d8e242218 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -140,6 +140,8 @@ config MMA9553
>  config STK8312
>  	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to get support for the Sensortek STK8312 3-axis
>  	  accelerometer.
> --
> 2.4.6

