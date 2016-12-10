Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48598 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbcLJRgh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 12:36:37 -0500
Subject: Re: [PATCH] iio: adc: max1027: allocate DMA-safe buffer
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Sandhya Bankar <bankarsandhya512@gmail.com>
References: <20161209102435.30638-1-marcus.folkesson@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <915bf030-49c3-5d56-73c2-9c3da3f1a02e@kernel.org>
Date: Sat, 10 Dec 2016 17:36:34 +0000
MIME-Version: 1.0
In-Reply-To: <20161209102435.30638-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/12/16 10:24, Marcus Folkesson wrote:
> The buffer needs to be DMA-safe when used with spi_read()
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Please read the documentation in include/linux/gfp.h about GFP_DMA.

Specifically:
220  * GFP_DMA exists for historical reasons and should be avoided where possible.
221  *   The flags indicates that the caller requires that the lowest zone be
222  *   used (ZONE_DMA or 16M on x86-64). Ideally, this would be removed but
223  *   it would require careful auditing as some users really require it and
224  *   others use the flag to avoid lowmem reserves in ZONE_DMA and treat the
225  *   lowest zone as a type of emergency reserve.

Seems unlikely this applies!  This caught me by surprise as I didn't even know
that flag existed - hence I went digging.

Jonathan
> ---
>  drivers/iio/adc/max1027.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 712fbd2b1f16..ff1f1f15a873 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -435,7 +435,7 @@ static int max1027_probe(struct spi_device *spi)
>  
>  	st->buffer = devm_kmalloc(&indio_dev->dev,
>  				  indio_dev->num_channels * 2,
> -				  GFP_KERNEL);
> +				  GFP_KERNEL | GFP_DMA);
>  	if (st->buffer == NULL) {
>  		dev_err(&indio_dev->dev, "Can't allocate buffer\n");
>  		return -ENOMEM;
> 

