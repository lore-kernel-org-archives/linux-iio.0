Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdLJRTq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 12:19:46 -0500
Date: Sun, 10 Dec 2017 17:19:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Handle enumerated properties with gaps
Message-ID: <20171210171941.5740d639@archlinux>
In-Reply-To: <20171207094209.14748-1-lars@metafoo.de>
References: <20171207094209.14748-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  7 Dec 2017 10:42:09 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Some enums might have gaps or reserved values in the middle of their value
> range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
> meaning, but 2 is a reserved value and must not be used.
> 
> Add support for such enums to the IIO enum helper functions. A reserved
> value is marked by setting its entry in the items array to NULL rather
> than the normal descriptive string value.
> 
> Unfortunately that means we can no longer use __sysfs_match_string() since
> it treats a NULL entry as the array terminator. But the amount of
> boilerplate is manageable.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Open for suggestions on how to massage __sysfs_match_string() into handling
> this use-case.

In theory - that function should only use the null terminator in
the case of n == -1. Or so it's documentation implies...

However to make that actually the case, we would have
to be sure of causing no breakage which would be hard to do.
Mind you it's only used in a few places, so you could check them.
>From a quick scan over them it looks like you would fine to make
the change (the single non IIO user is clearly fine.)


> ---
>  drivers/iio/industrialio-core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2e8e36f9da61..e69bef13d005 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -446,8 +446,12 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
>  	if (!e->num_items)
>  		return 0;
>  
> -	for (i = 0; i < e->num_items; ++i)
> +	for (i = 0; i < e->num_items; ++i) {
> +		if (!e->items[i])
> +			continue;
> +
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
> +	}
>  
>  	/* replace last space with a newline */
>  	buf[len - 1] = '\n';
> @@ -468,7 +472,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
>  	i = e->get(indio_dev, chan);
>  	if (i < 0)
>  		return i;
> -	else if (i >= e->num_items)
> +	else if (i >= e->num_items || !e->items[i])
>  		return -EINVAL;
>  
>  	return snprintf(buf, PAGE_SIZE, "%s\n", e->items[i]);
> @@ -480,16 +484,21 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>  	size_t len)
>  {
>  	const struct iio_enum *e = (const struct iio_enum *)priv;
> +	unsigned int i;
>  	int ret;
>  
>  	if (!e->set)
>  		return -EINVAL;
>  
> -	ret = __sysfs_match_string(e->items, e->num_items, buf);
> -	if (ret < 0)
> -		return ret;
> +	for (i = 0; i < e->num_items; i++) {
> +		if (e->items[i] && sysfs_streq(buf, e->items[i]))
> +			break;
> +	}
> +
> +	if (i == e->num_items)
> +		return -EINVAL;
>  
> -	ret = e->set(indio_dev, chan, ret);
> +	ret = e->set(indio_dev, chan, i);
>  	return ret ? ret : len;
>  }
>  EXPORT_SYMBOL_GPL(iio_enum_write);

