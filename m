Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48135 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3K3LDa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:03:30 -0500
Message-ID: <5299C600.1060706@kernel.org>
Date: Sat, 30 Nov 2013 11:03:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/15] iio:ad5504: Mark transfer buffers as __be16
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:41, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/iio/dac/ad5504.c:71:19: warning: incorrect type in initializer (different base types)
> 	drivers/iio/dac/ad5504.c:71:19:    expected unsigned short [unsigned] [usertype] tmp
> 	drivers/iio/dac/ad5504.c:71:19:    got restricted __be16 [usertype] <noident>
> 	drivers/iio/dac/ad5504.c:80:19: warning: incorrect type in initializer (different base types)
> 	drivers/iio/dac/ad5504.c:80:19:    expected unsigned short [unsigned] [usertype] tmp
> 	drivers/iio/dac/ad5504.c:80:19:    got restricted __be16 [usertype] <noident>
> 	drivers/iio/dac/ad5504.c:93:16: warning: cast to restricted __be16
> 	drivers/iio/dac/ad5504.c:93:16: warning: cast to restricted __be16
> 	drivers/iio/dac/ad5504.c:93:16: warning: cast to restricted __be16
> 	drivers/iio/dac/ad5504.c:93:16: warning: cast to restricted __be16
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/dac/ad5504.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index c0957a9..6cd0dd6 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -68,7 +68,7 @@ enum ad5504_supported_device_ids {
>  
>  static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
>  {
> -	u16 tmp = cpu_to_be16(AD5504_CMD_WRITE |
> +	__be16 tmp = cpu_to_be16(AD5504_CMD_WRITE |
>  			      AD5504_ADDR(addr) |
>  			      (val & AD5504_RES_MASK));
>  
> @@ -77,8 +77,8 @@ static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
>  
>  static int ad5504_spi_read(struct spi_device *spi, u8 addr)
>  {
> -	u16 tmp = cpu_to_be16(AD5504_CMD_READ | AD5504_ADDR(addr));
> -	u16 val;
> +	__be16 tmp = cpu_to_be16(AD5504_CMD_READ | AD5504_ADDR(addr));
> +	__be16 val;
>  	int ret;
>  	struct spi_transfer	t = {
>  			.tx_buf		= &tmp,
> 
