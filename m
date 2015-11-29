Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44195 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbK2PU3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 10:20:29 -0500
Subject: Re: [PATCH] Staging: iio: adc: use dev_get_platdata()
To: Nizam Haider <nizamhaider786@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org
References: <1448299987-10163-1-git-send-email-nizamhaider786@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Nizam Haider <nijamh@cdac.in>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565B17BA.4000804@kernel.org>
Date: Sun, 29 Nov 2015 15:20:26 +0000
MIME-Version: 1.0
In-Reply-To: <1448299987-10163-1-git-send-email-nizamhaider786@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/11/15 17:33, Nizam Haider wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>
The 7780 platform data has gone away in the meantime.
Applied for the other 3.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c  | 2 +-
>  drivers/staging/iio/adc/ad7280a.c | 2 +-
>  drivers/staging/iio/adc/ad7780.c  | 2 +-
>  drivers/staging/iio/adc/ad7816.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index bb40f37..9221103 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -609,7 +609,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
>  
>  static int ad7192_probe(struct spi_device *spi)
>  {
> -	const struct ad7192_platform_data *pdata = spi->dev.platform_data;
> +	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret, voltage_uv = 0;
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 35acb1a..f45ebed 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -833,7 +833,7 @@ static const struct ad7280_platform_data ad7793_default_pdata = {
>  
>  static int ad7280_probe(struct spi_device *spi)
>  {
> -	const struct ad7280_platform_data *pdata = spi->dev.platform_data;
> +	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad7280_state *st;
>  	int ret;
>  	const unsigned short tACQ_ns[4] = {465, 1010, 1460, 1890};
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 3abc778..9baa703 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -163,7 +163,7 @@ static const struct iio_info ad7780_info = {
>  
>  static int ad7780_probe(struct spi_device *spi)
>  {
> -	struct ad7780_platform_data *pdata = spi->dev.platform_data;
> +	struct ad7780_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad7780_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret, voltage_uv = 0;
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index c8e1566..2226051 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -345,7 +345,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  {
>  	struct ad7816_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	unsigned short *pins = spi_dev->dev.platform_data;
> +	unsigned short *pins = dev_get_platdata(&spi_dev->dev);
>  	int ret = 0;
>  	int i;
>  
> 

