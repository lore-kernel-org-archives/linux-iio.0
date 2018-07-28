Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbeG1LCQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Jul 2018 07:02:16 -0400
Date: Sat, 28 Jul 2018 10:36:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: ad9523: Fix return value for ad952x_store()
Message-ID: <20180728103622.7c16b732@archlinux>
In-Reply-To: <20180727064245.7954-1-alexandru.ardelean@analog.com>
References: <20180727064245.7954-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 27 Jul 2018 09:42:45 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> A sysfs write callback function needs to either return the number of
> consumed characters or an error.
> 
> The ad952x_store() function currently returns 0 if the input value was "0",
> this will signal that no characters have been consumed and the function
> will be called repeatedly in a loop indefinitely. Fix this by returning
> number of supplied characters to indicate that the whole input string has
> been consumed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Should have had a fixes tag - admittedly this one is easy as it's been
there from the start, but none the less it is good practice to put
one for any fix.

Fixes: cd1678f96329 ("iio: frequency: New driver for AD9523 SPI Low Jitter Clock Generator")

I have added that an marked this for stable.  It won't go anywhere until after
the coming merge window now though.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/ad9523.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 37504739c277..059b2fda8cbd 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -518,7 +518,7 @@ static ssize_t ad9523_store(struct device *dev,
>  		return ret;
>  
>  	if (!state)
> -		return 0;
> +		return len;
>  
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {

