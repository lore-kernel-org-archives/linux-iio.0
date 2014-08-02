Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46434 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaHBL4M (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Aug 2014 07:56:12 -0400
Message-ID: <53DCD1D7.9000206@kernel.org>
Date: Sat, 02 Aug 2014 12:56:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Teodora Baluta <teodora.baluta@intel.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] staging: iio: ad7816: fix sparse warning cast to
 restricted __be16
References: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com> <1406546313-23031-2-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406546313-23031-2-git-send-email-teodora.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/07/14 12:18, Teodora Baluta wrote:
> Fix following sparse endianness problems:
> 
>   CHECK   drivers/staging/iio/adc/ad7816.c
> drivers/staging/iio/adc/ad7816.c:93:17: warning: cast to restricted
> __be16
> drivers/staging/iio/adc/ad7816.c:93:17: warning: cast to restricted
> __be16
> drivers/staging/iio/adc/ad7816.c:93:17: warning: cast to restricted
> __be16
> drivers/staging/iio/adc/ad7816.c:93:17: warning: cast to restricted
> __be16
> 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
Hi Teodora,

There's actually a nastier problem hiding in here.  SPI requires that
the buffers passed to spi_read are in their own cache lines.
Here they are on the stack and hence this is unlikely to be true.
Cc'd Lars for info.

Also, in cases like this I'd prefer to introduce a local __be16 to
hold the value whilst it is big endian, rather than using it for both
big endian and cpu endian in different places in the code.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7816.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 158d770..6686eac 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -90,7 +90,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  		return ret;
>  	}
>  
> -	*data = be16_to_cpu(*data);
> +	be16_to_cpus(data);
>  
>  	return ret;
>  }
> 
