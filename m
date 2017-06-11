Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbdFKLCt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 07:02:49 -0400
Date: Sun, 11 Jun 2017 12:02:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1] iio: adc: ad7791: Use sysfs_match_string() helper
Message-ID: <20170611120244.5e899136@kernel.org>
In-Reply-To: <20170609120810.22057-1-andriy.shevchenko@linux.intel.com>
References: <20170609120810.22057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  9 Jun 2017 15:08:10 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use sysfs_match_string() helper instead of open coded variant.
> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Looks obvious enough that I'm happy to apply without waiting
for Lars or Michael to have a moment.  It'll be in my testing
branch for at least a little while though if either of you
want to comment or add an Ack.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ad7791.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index 1817ebf5ad84..34e353c43ac8 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -272,11 +272,9 @@ static ssize_t ad7791_write_frequency(struct device *dev,
>  	struct ad7791_state *st = iio_priv(indio_dev);
>  	int i, ret;
>  
> -	for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++)
> -		if (sysfs_streq(ad7791_sample_freq_avail[i], buf))
> -			break;
> -	if (i == ARRAY_SIZE(ad7791_sample_freq_avail))
> -		return -EINVAL;
> +	i = sysfs_match_string(ad7791_sample_freq_avail, buf);
> +	if (i < 0)
> +		return i;
>  
>  	ret = iio_device_claim_direct_mode(indio_dev);
>  	if (ret)

