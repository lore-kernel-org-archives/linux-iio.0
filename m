Return-Path: <jic23@kernel.org>
Message-ID: <4FF32D85.1040503@kernel.org>
Date: Tue, 03 Jul 2012 18:36:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: iio_buffer_register: Use correct channel when calculating
 masklength
References: <1341233576-9082-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1341233576-9082-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/02/2012 01:52 PM, Lars-Peter Clausen wrote:
> The channel set assigned to the iio device is not necessarily the same has the
> channel set passed to iio_buffer_register. So to avoid possible complications
> always work with the channel set pass to iio_buffer_register and ignore the
> channel set assigned to the iio device.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
merged to fixes. Thanks
> ---
>  drivers/iio/industrialio-buffer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index bb88377..d074051 100644
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
> 
