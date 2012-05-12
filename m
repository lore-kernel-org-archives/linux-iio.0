Return-Path: <jic23@kernel.org>
Message-ID: <4FAE2376.4020205@kernel.org>
Date: Sat, 12 May 2012 09:46:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 17/24] staging:iio:gyro: Use dev_to_iio_dev()
References: <1336741127-29552-1-git-send-email-lars@metafoo.de> <1336741127-29552-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-17-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/11/2012 01:58 PM, Lars-Peter Clausen wrote:
> Replace open-coded instances of getting a iio_dev struct from a device struct
> with dev_to_iio_dev().
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/gyro/adis16260_core.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index d7979cf..ec765f9 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -149,7 +149,7 @@ static ssize_t adis16260_read_frequency_available(struct device *dev,
>  						  struct device_attribute *attr,
>  						  char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct adis16260_state *st = iio_priv(indio_dev);
>  	if (spi_get_device_id(st->us)->driver_data)
>  		return sprintf(buf, "%s\n", "0.129 ~ 256");
> @@ -161,7 +161,7 @@ static ssize_t adis16260_read_frequency(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct adis16260_state *st = iio_priv(indio_dev);
>  	int ret, len = 0;
>  	u16 t;
> @@ -186,7 +186,7 @@ static ssize_t adis16260_write_frequency(struct device *dev,
>  		const char *buf,
>  		size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct adis16260_state *st = iio_priv(indio_dev);
>  	long val;
>  	int ret;
> @@ -237,7 +237,7 @@ static ssize_t adis16260_write_reset(struct device *dev,
>  		struct device_attribute *attr,
>  		const char *buf, size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	if (len < 1)
>  		return -EINVAL;
>  	switch (buf[0]) {
