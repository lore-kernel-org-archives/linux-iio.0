Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45748 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbHBSap (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:30:45 -0400
Subject: Re: [PATCH 1/7] iio: bmg160: IIO_BUFFER and IIO_TRIGGERED_BUFFER are
 required
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Markus Pargmann <mpa@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
 <1438177569-18772-2-git-send-email-mpa@pengutronix.de>
 <1438370449.10028.2.camel@spandruv-DESK3.jf.intel.com>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE61D3.6000100@kernel.org>
Date: Sun, 2 Aug 2015 19:30:43 +0100
MIME-Version: 1.0
In-Reply-To: <1438370449.10028.2.camel@spandruv-DESK3.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/07/15 20:20, Srinivas Pandruvada wrote:
> On Wed, 2015-07-29 at 15:46 +0200, Markus Pargmann wrote:
>> This patch adds selects for IIO_BUFFER and IIO_TRIGGERED_BUFFER. Without
>> IIO_BUFFER, the driver does not compile.
>>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
>> ---
>>  drivers/iio/gyro/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
>> index b3d0e94f72eb..8d2439345673 100644
>> --- a/drivers/iio/gyro/Kconfig
>> +++ b/drivers/iio/gyro/Kconfig
>> @@ -53,7 +53,8 @@ config ADXRS450
>>  config BMG160
>>  	tristate "BOSCH BMG160 Gyro Sensor"
>>  	depends on I2C
>> -	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
>>  	  driver. This driver also supports BMI055 gyroscope.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

