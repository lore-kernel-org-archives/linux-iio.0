Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44444 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbbFUPPS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 11:15:18 -0400
Message-ID: <5586D504.9050808@kernel.org>
Date: Sun, 21 Jun 2015 16:15:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 1/2] iio:adc:cc10001_adc: fix Kconfig dependency
References: <cover.1434844874.git.knaack.h@gmx.de> <9554701f1ada5bdee392c079e8c0de0e1faf45c9.1434844874.git.knaack.h@gmx.de>
In-Reply-To: <9554701f1ada5bdee392c079e8c0de0e1faf45c9.1434844874.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/15 11:15, Hartmut Knaack wrote:
> The Cosmic Circuits 10001 ADC driver depends on HAS_IOMEM, HAVE_CLK and
> REGULATOR together, not just any of these.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7c55658..eb0cd89 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -153,8 +153,7 @@ config DA9150_GPADC
>  
>  config CC10001_ADC
>  	tristate "Cosmic Circuits 10001 ADC driver"
> -	depends on HAVE_CLK || REGULATOR
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && HAVE_CLK && REGULATOR
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
