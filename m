Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51779 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3KILOx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 06:14:53 -0500
Message-ID: <527E2776.8050203@kernel.org>
Date: Sat, 09 Nov 2013 12:15:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: Fix mag3110 Kconfig dependencies
References: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net> <1383008397-8721-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383008397-8721-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 00:59, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/iio/magnetometer/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 0cf0963..d86d226 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -19,6 +19,8 @@ config AK8975
>  config MAG3110
>  	tristate "Freescale MAG3110 3-Axis Magnetometer"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the Freescale MAG3110 3-Axis
>  	  magnetometer.
> 
