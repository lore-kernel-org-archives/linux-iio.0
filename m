Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51795 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3KILPV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 06:15:21 -0500
Message-ID: <527E2793.70405@kernel.org>
Date: Sat, 09 Nov 2013 12:16:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: Fix tcs3472 Kconfig dependencies
References: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net> <1383008397-8721-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383008397-8721-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 00:59, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/light/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 5e60be4..f0035db 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -81,6 +81,8 @@ config SENSORS_LM3533
>  config TCS3472
>  	tristate "TAOS TCS3472 color light-to-digital converter"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	 If you say yes here you get support for the TAOS TCS3472
>  	 family of color light-to-digital converters with IR filter.
> 
