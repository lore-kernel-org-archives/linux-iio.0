Return-Path: <jic23@kernel.org>
Message-ID: <4FAE238B.3090201@kernel.org>
Date: Sat, 12 May 2012 09:47:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/24] staging:iio:impedance-analyzer: Use dev_to_iio_dev()
References: <1336741127-29552-1-git-send-email-lars@metafoo.de> <1336741127-29552-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-18-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/11/2012 01:58 PM, Lars-Peter Clausen wrote:
> Replace open-coded instances of getting a iio_dev struct from a device struct
> with dev_to_iio_dev().
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 359a794..a8e51bc 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -291,7 +291,7 @@ static ssize_t ad5933_show_frequency(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret;
> @@ -320,7 +320,7 @@ static ssize_t ad5933_store_frequency(struct device *dev,
>  					 const char *buf,
>  					 size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	long val;
> @@ -354,7 +354,7 @@ static ssize_t ad5933_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret = 0, len = 0;
> @@ -397,7 +397,7 @@ static ssize_t ad5933_store(struct device *dev,
>  					 const char *buf,
>  					 size_t len)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	long val;
