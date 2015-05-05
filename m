Return-Path: <lars@metafoo.de>
Message-ID: <5548FE07.7040404@metafoo.de>
Date: Tue, 05 May 2015 19:29:43 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Michael Welling <mwelling@ieee.org>, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, san@rosetechnology.dk,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mcp320x: Fix occasional incorrect readings
References: <1430843395-19446-1-git-send-email-mwelling@ieee.org>
In-Reply-To: <1430843395-19446-1-git-send-email-mwelling@ieee.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/05/2015 06:29 PM, Michael Welling wrote:
> Without the cacheline alignment, the readings will occasionally incorrectly
> return 0.
>
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> ---
>   drivers/iio/adc/mcp320x.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index efbfd12..46b98cf 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -60,7 +60,7 @@ struct mcp320x {
>   	struct spi_message msg;
>   	struct spi_transfer transfer[2];
>
> -	u8 tx_buf;
> +	u8 tx_buf ____cacheline_aligned;
>   	u8 rx_buf[2];

The buffers should probably be moved at the end, e.g. reg will still be on 
the same cacheline.

>
>   	struct regulator *reg;
