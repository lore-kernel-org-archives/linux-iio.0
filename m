Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbeIPQzG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 12:55:06 -0400
Date: Sun, 16 Sep 2018 12:32:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] spi: add software implementation for SPI_CS_WORD
Message-ID: <20180916123222.67136773@archlinux>
In-Reply-To: <20180913003920.30600-3-david@lechnology.com>
References: <20180913003920.30600-1-david@lechnology.com>
        <20180913003920.30600-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 12 Sep 2018 19:39:18 -0500
David Lechner <david@lechnology.com> wrote:

> This adds a default software implementation for the SPI_CS_WORD flag for
> controllers that don't have such a feature.
> 
> The SPI_CS_WORD flag indicates that the CS line should be toggled
> between each word sent, not just between each transfer. The
> implementation works by using existing functions to split transfers into
> one-word-sized transfers and sets the cs_change bit for each of the
> new transfers.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
Looks good to me but I'm not that familiar with this code..

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/spi/spi.c | 31 +++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9da0bc5a036c..84518ed58872 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2783,8 +2783,10 @@ int spi_setup(struct spi_device *spi)
>  		return -EINVAL;
>  	/* help drivers fail *cleanly* when they need options
>  	 * that aren't supported with their current controller
> +	 * SPI_CS_WORD has a fallback software implementation,
> +	 * so it is ignored here.
>  	 */
> -	bad_bits = spi->mode & ~spi->controller->mode_bits;
> +	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
>  	ugly_bits = bad_bits &
>  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
>  	if (ugly_bits) {
> @@ -2838,6 +2840,33 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>  	if (list_empty(&message->transfers))
>  		return -EINVAL;
>  
> +	/* If an SPI controller does not support toggling the CS line on each
> +	 * transfer (indicated by the SPI_CS_WORD flag), we can emulate it by
> +	 * splitting transfers into one-word transfers and ensuring that
> +	 * cs_change is set for each transfer.
> +	 */
> +	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {
> +		size_t maxsize;
> +		int ret;
> +
> +		maxsize = (spi->bits_per_word + 7) / 8;
> +
> +		/* spi_split_transfers_maxsize() requires message->spi */
> +		message->spi = spi;
> +
> +		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
> +						  GFP_KERNEL);
> +		if (ret)
> +			return ret;
> +
> +		list_for_each_entry(xfer, &message->transfers, transfer_list) {
> +			/* don't change cs_change on the last entry in the list */
> +			if (list_is_last(&xfer->transfer_list, &message->transfers))
> +				break;
> +			xfer->cs_change = 1;
> +		}
> +	}
> +
>  	/* Half-duplex links include original MicroWire, and ones with
>  	 * only one data pin like SPI_3WIRE (switches direction) or where
>  	 * either MOSI or MISO is missing.  They can also be caused by
