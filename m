Return-Path: <jic23@kernel.org>
Message-ID: <4FCF1613.2000002@kernel.org>
Date: Wed, 06 Jun 2012 09:34:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: iio_enum_available_read: Prevent possible buffer
 overflow
References: <1338913452-26786-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1338913452-26786-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/5/2012 5:24 PM, Lars-Peter Clausen wrote:
> Use scnprint instead of snprintf, because snprintf returns the number of bytes
> that would have been written to the buffer if there was enough space, and as a
> result writing to buf[len-1] might cause a access beyond the buffers limits.
>
> Reported-by: Dan Carpenter<dan.carpenter@oracle.com>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/iio/industrialio-core.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 56a3c0b..cf9ecd0 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -300,7 +300,7 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
>   		return 0;
>
>   	for (i = 0; i<  e->num_items; ++i)
> -		len += snprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
>
>   	/* replace last space with a newline */
>   	buf[len - 1] = '\n';
