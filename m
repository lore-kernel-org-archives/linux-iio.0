Return-Path: <jic23@kernel.org>
Message-ID: <4FAE1F10.80404@kernel.org>
Date: Sat, 12 May 2012 09:28:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/24] staging:iio:adis16203_read_ring_data: Pass IIO
 device directly
References: <1336741127-29552-1-git-send-email-lars@metafoo.de> <1336741127-29552-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/11/2012 01:58 PM, Lars-Peter Clausen wrote:
> When calling adis16203_read_ring_data we pass the device struct of embedded in
> the IIO device only to look up the IIO device from the device struct again right
> away. This patch changes the code to pass the IIO device directly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/accel/adis16203_ring.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
> index 2171f74..2a25d36 100644
> --- a/drivers/staging/iio/accel/adis16203_ring.c
> +++ b/drivers/staging/iio/accel/adis16203_ring.c
> @@ -12,13 +12,12 @@
>  
>  /**
>   * adis16203_read_ring_data() read data registers which will be placed into ring
> - * @dev: device associated with child of actual device (iio_dev or iio_trig)
> + * @indio_dev: The IIO device
>   * @rx: somewhere to pass back the value read
>   **/
> -static int adis16203_read_ring_data(struct device *dev, u8 *rx)
> +static int adis16203_read_ring_data(struct iio_dev *indio_dev, u8 *rx)
>  {
>  	struct spi_message msg;
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct adis16203_state *st = iio_priv(indio_dev);
>  	struct spi_transfer xfers[ADIS16203_OUTPUTS + 1];
>  	int ret;
> @@ -74,7 +73,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
>  	}
>  
>  	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
> -	    adis16203_read_ring_data(&indio_dev->dev, st->rx) >= 0)
> +	    adis16203_read_ring_data(indio_dev, st->rx) >= 0)
>  		for (; i < bitmap_weight(indio_dev->active_scan_mask,
>  					 indio_dev->masklength); i++)
>  			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
