Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752168AbdFMSNY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Jun 2017 14:13:24 -0400
Date: Sun, 11 Jun 2017 11:52:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1] iio: core: Use __sysfs_match_string() helper
Message-ID: <20170611115245.6215189e@kernel.org>
In-Reply-To: <20170609120816.22106-1-andriy.shevchenko@linux.intel.com>
References: <20170609120816.22106-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  9 Jun 2017 15:08:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use __sysfs_match_string() helper instead of open coded variant.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A nice little tidy up.  I'd missed that function being added.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with.

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4a1de59d153a..15c86a8cd704 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -478,21 +478,16 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>  	size_t len)
>  {
>  	const struct iio_enum *e = (const struct iio_enum *)priv;
> -	unsigned int i;
>  	int ret;
>  
>  	if (!e->set)
>  		return -EINVAL;
>  
> -	for (i = 0; i < e->num_items; i++) {
> -		if (sysfs_streq(buf, e->items[i]))
> -			break;
> -	}
> -
> -	if (i == e->num_items)
> -		return -EINVAL;
> +	ret = __sysfs_match_string(e->items, e->num_items, buf);
> +	if (ret < 0)
> +		return ret;
>  
> -	ret = e->set(indio_dev, chan, i);
> +	ret = e->set(indio_dev, chan, ret);
>  	return ret ? ret : len;
>  }
>  EXPORT_SYMBOL_GPL(iio_enum_write);

