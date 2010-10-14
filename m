Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 13 Oct 2010 23:16:06 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, drivers@analog.com,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-iio@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>,
	matthias <mensch0815@googlemail.com>,
	spi-devel-general@lists.sourceforge.net, kernel@avr32linux.org
Subject: Re: [Patch] atmel_spi.c - let transfers through if not changing
 bits_per_word
Message-ID: <20101014051606.GA2248@angua.secretlab.ca>
References: <4CB5D566.2040301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CB5D566.2040301@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 13, 2010 at 05:51:02PM +0200, Matthias Brugger wrote:
> - bits_per_word option in spi_transfer are allowed if it does not change
> the csr register.
> 
> This is necessary for the driver in
> drivers/staging/iio/adis16260_core.c, as it uses this option.
> 
> Signed-off-by: Matthias Brugger <mensch0815@gmail.com>

Applied, thanks.

However, the patch is line-wrap damaged and I needed to fix it up by
hand.  Please check your email client configuration.

g.

> ---
>  drivers/spi/atmel_spi.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
> index c4e0442..5c03a5b 100644
> --- a/drivers/spi/atmel_spi.c
> +++ b/drivers/spi/atmel_spi.c
> @@ -654,6 +654,8 @@ static int atmel_spi_transfer(struct spi_device
> *spi, struct spi_message *msg)
>  	struct spi_transfer	*xfer;
>  	unsigned long		flags;
>  	struct device		*controller = spi->master->dev.parent;
> +	u8			bits;
> +	struct atmel_spi_device	*asd;
> 
>  	as = spi_master_get_devdata(spi->master);
> 
> @@ -672,8 +674,18 @@ static int atmel_spi_transfer(struct spi_device
> *spi, struct spi_message *msg)
>  			return -EINVAL;
>  		}
> 
> +		if (xfer->bits_per_word) {
> +			asd = spi->controller_state;
> +			bits = (asd->csr >> 4) & 0xf;
> +			if (bits != xfer->bits_per_word - 8) {
> +				dev_dbg(&spi->dev, "you can't yet change "
> +					 "bit_per_word in transfers\n");
> +				return -ENOPROTOOPT;
> +			}
> +		}
> +
>  		/* FIXME implement these protocol options!! */
> -		if (xfer->bits_per_word || xfer->speed_hz) {
> +		if (xfer->speed_hz) {
>  			dev_dbg(&spi->dev, "no protocol options yet\n");
>  			return -ENOPROTOOPT;
>  		}
> -- 
> 1.5.6.5
