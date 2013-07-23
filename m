Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 23 Jul 2013 13:52:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/2] staging: iio: replace strict_strto*() with kstrto*()
Message-ID: <20130723105242.GP5585@mwanda>
References: <001d01ce878e$0e76b710$2b642530$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001d01ce878e$0e76b710$2b642530$@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 23, 2013 at 07:19:03PM +0900, Jingoo Han wrote:
> The usage of strict_strto*() is not preferred, because
> strict_strto*() is obsolete. Thus, kstrto*() should be
> used.

In olden times there was just strict_strtol() and strict_strtoul().
These days we have kstrtou8() and kstrtoint() and a bunch of others.
So when you do these patches you have to take more time to consider
what type we should be using and update the surrounding code.

I haven't reviewed all of these so please check everything again.

> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 6330af6..afe191a 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -326,7 +326,7 @@ static ssize_t ad5933_store_frequency(struct device *dev,
>  	long val;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoul(buf, 10, &val);

This bug is in the original code as well.  "val" is long but it
should be unsigned long.  Later we check that:

	if (val > AD5933_MAX_OUTPUT_FREQ_Hz) {

Forgetting that "val" could be a negative number.

> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index e5943e2..fbb230a 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -188,7 +188,7 @@ static ssize_t ade7753_write_8bit(struct device *dev,
>  	int ret;
>  	long val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtol(buf, 10, &val);

For these we should be using the new kstrtou8() functions.

>  	if (ret)
>  		goto error_ret;
>  	ret = ade7753_spi_write_reg_8(dev, this_attr->address, val);
> @@ -206,7 +206,7 @@ static ssize_t ade7753_write_16bit(struct device *dev,
>  	int ret;
>  	long val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtol(buf, 10, &val);

Same.

>  	if (ret)
>  		goto error_ret;
>  	ret = ade7753_spi_write_reg_16(dev, this_attr->address, val);
> @@ -418,7 +418,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>  	int ret;
>  	u16 reg, t;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtol(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  	if (val == 0)
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index 7b6503b..ea337c4 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -188,7 +188,7 @@ static ssize_t ade7754_write_8bit(struct device *dev,
>  	int ret;
>  	long val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtol(buf, 10, &val);

Same.

>  	if (ret)
>  		goto error_ret;
>  	ret = ade7754_spi_write_reg_8(dev, this_attr->address, val);
> @@ -206,7 +206,7 @@ static ssize_t ade7754_write_16bit(struct device *dev,
>  	int ret;
>  	long val;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtol(buf, 10, &val);

Same.

>  	if (ret)
>  		goto error_ret;
>  	ret = ade7754_spi_write_reg_16(dev, this_attr->address, val);
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -56,7 +56,7 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
>  	unsigned long val;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoul(buf, 10, &val);

For this one we should make "val" an int.

>  	if (ret)
>  		goto error_ret;
>  

regards,
dan carpenter
