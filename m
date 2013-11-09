Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51814 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3KILPi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 06:15:38 -0500
Message-ID: <527E27A3.3080309@kernel.org>
Date: Sat, 09 Nov 2013 12:16:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] staging:iio: Fix hmc5843 Kconfig dependencies
References: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net> <1383008397-8721-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383008397-8721-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 00:59, Peter Meerwald wrote:
> trigger / buffer handling was introduced in changeset
> cb9b9a82 staging:iio:hmc5843: Add trigger handling
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/magnetometer/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
> index a3ea69e..34634da 100644
> --- a/drivers/staging/iio/magnetometer/Kconfig
> +++ b/drivers/staging/iio/magnetometer/Kconfig
> @@ -6,6 +6,8 @@ menu "Magnetometer sensors"
>  config SENSORS_HMC5843
>  	tristate "Honeywell HMC5843/5883/5883L 3-Axis Magnetometer"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here to add support for the Honeywell HMC5843, HMC5883 and
>  	  HMC5883L 3-Axis Magnetometer (digital compass).
> 
