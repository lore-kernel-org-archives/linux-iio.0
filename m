Return-Path: <jic23@kernel.org>
Message-ID: <4ED7ECBF.1080903@kernel.org>
Date: Thu, 01 Dec 2011 21:08:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andreas Ruprecht <rupran@einserver.de>
CC: devel@linuxdriverproject.org, dan.carpenter@oracle.com,
 gregkh@suse.de, jic23@cam.ac.uk, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] Staging: iio/accel: Changed data type for val to
 unsigned long in write_frequency
References: <20111124205657.GL3258@mwanda> <1322432262-16533-1-git-send-email-rupran@einserver.de> <1322432262-16533-2-git-send-email-rupran@einserver.de>
In-Reply-To: <1322432262-16533-2-git-send-email-rupran@einserver.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/27/2011 10:17 PM, Andreas Ruprecht wrote:
> In lis3102dq_write_frequency() we used a long variable to store the
> value parsed from the char* buffer buf, as there only was a
> strict_strtol() function to parse values.
> Now we have got kstrto* which allows us to convert to the right data
> type in most cases.
> 
> In this particular function we want to write a frequency value, and it
> doesn't make sense to allow negative values here (as Dan Carpenter
> pointed out in a previous email).
> This means we can now parse the value into an unsigned long and get an
> error for invalid (e.g. negative) values.
Not that it matters, but seeing as it goes into a switch statement we
would have gotten an error on any negatives anyway.  Nice enough
cleanup and indeed more logical though!
> 
> Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/accel/lis3l02dq_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index 559545a..5566809 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -331,11 +331,11 @@ static ssize_t lis3l02dq_write_frequency(struct device *dev,
>  					 size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	long val;
> +	unsigned long val;
>  	int ret;
>  	u8 t;
>  
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  
