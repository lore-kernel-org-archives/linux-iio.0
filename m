Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44222 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbK2PXB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 10:23:01 -0500
Subject: Re: [PATCH] Staging: iio: frequency: use dev_get_platdata()
To: Nizam Haider <nizamhaider786@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org
References: <1448302036-11363-1-git-send-email-nizamhaider786@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Nizam Haider <nijamh@cdac.in>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565B1853.8020408@kernel.org>
Date: Sun, 29 Nov 2015 15:22:59 +0000
MIME-Version: 1.0
In-Reply-To: <1448302036-11363-1-git-send-email-nizamhaider786@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/11/15 18:07, Nizam Haider wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>
applied
> ---
>  drivers/staging/iio/frequency/ad9832.c | 2 +-
>  drivers/staging/iio/frequency/ad9834.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 2b65faa..18b27a1 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -201,7 +201,7 @@ static const struct iio_info ad9832_info = {
>  
>  static int ad9832_probe(struct spi_device *spi)
>  {
> -	struct ad9832_platform_data *pdata = spi->dev.platform_data;
> +	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct iio_dev *indio_dev;
>  	struct ad9832_state *st;
>  	struct regulator *reg;
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 6464f2c..6366216 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -318,7 +318,7 @@ static const struct iio_info ad9833_info = {
>  
>  static int ad9834_probe(struct spi_device *spi)
>  {
> -	struct ad9834_platform_data *pdata = spi->dev.platform_data;
> +	struct ad9834_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad9834_state *st;
>  	struct iio_dev *indio_dev;
>  	struct regulator *reg;
> 

