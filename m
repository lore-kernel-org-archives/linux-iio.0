Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48262 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3K3LIt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:08:49 -0500
Message-ID: <5299C740.7010406@kernel.org>
Date: Sat, 30 Nov 2013 11:08:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 06/15] iio:ad5791: Mark transfer buffers as __be32
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:41, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/iio/dac/ad5791.c:114:18: warning: incorrect type in assignment (different base types)
> 	drivers/iio/dac/ad5791.c:114:18:    expected unsigned int [unsigned] [usertype] d32
> 	drivers/iio/dac/ad5791.c:114:18:    got restricted __be32 [usertype] <noident>
> 	drivers/iio/dac/ad5791.c:142:21: warning: incorrect type in assignment (different base types)
> 	drivers/iio/dac/ad5791.c:142:21:    expected unsigned int [unsigned] [usertype] d32
> 	drivers/iio/dac/ad5791.c:142:21:    got restricted __be32 [usertype] <noident>
> 	drivers/iio/dac/ad5791.c:144:21: warning: incorrect type in assignment (different base types)
> 	drivers/iio/dac/ad5791.c:144:21:    expected unsigned int [unsigned] [usertype] d32
> 	drivers/iio/dac/ad5791.c:144:21:    got restricted __be32 [usertype] <noident>
> 	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
> 	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/dac/ad5791.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index d64acbd..1e7f4cd 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -107,7 +107,7 @@ enum ad5791_supported_device_ids {
>  static int ad5791_spi_write(struct spi_device *spi, u8 addr, u32 val)
>  {
>  	union {
> -		u32 d32;
> +		__be32 d32;
>  		u8 d8[4];
>  	} data;
>  
> @@ -121,7 +121,7 @@ static int ad5791_spi_write(struct spi_device *spi, u8 addr, u32 val)
>  static int ad5791_spi_read(struct spi_device *spi, u8 addr, u32 *val)
>  {
>  	union {
> -		u32 d32;
> +		__be32 d32;
>  		u8 d8[4];
>  	} data[3];
>  	int ret;
> 
