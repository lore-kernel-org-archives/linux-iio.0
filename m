Return-Path: <lars@metafoo.de>
Message-ID: <4FFA9FCA.6070309@metafoo.de>
Date: Mon, 09 Jul 2012 11:09:30 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: iio_buffer_register: Use correct channel
 when calculating masklength
References: <1341824452-28803-1-git-send-email-lars@metafoo.de> <1341824452-28803-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1341824452-28803-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/09/2012 11:00 AM, Lars-Peter Clausen wrote:
> The channel set assigned to the iio device is not necessarily the same has the
> channel set passed to iio_buffer_register. So to avoid possible complications
> always work with the channel set pass to iio_buffer_register and ignore the
> channel set assigned to the iio device.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Oops, this one was not supposed to be in this series... please just ignore it.

> ---
> No changes since v1
> ---
>  drivers/iio/industrialio-buffer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 6e00042..e33a9dc 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -292,7 +292,7 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>  			if (channels[i].scan_index >
>  			    (int)indio_dev->masklength - 1)
>  				indio_dev->masklength
> -					= indio_dev->channels[i].scan_index + 1;
> +					= channels[i].scan_index + 1;
>  
>  			ret = iio_buffer_add_channel_sysfs(indio_dev,
>  							 &channels[i]);
