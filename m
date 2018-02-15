Return-Path: <SRS0=oxLK=FJ=metafoo.de=lars@kernel.org>
Subject: Re: [PATCHv2] iio: buffer: check if a buffer has been set up when
 poll is called
To: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>, jic23@kernel.org
Cc: knaack.h@gmx.de, ppmeerw@pmeerw.net, linux-iio@vger.kernel.org,
 Stefan Windfeldt-Prytz <stefanw@axis.com>
References: <1518679721-17415-1-git-send-email-stefan.windfeldt@axis.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <acd87ba1-6b8f-ce64-ef5a-5d1e6eb8fa77@metafoo.de>
Date: Thu, 15 Feb 2018 08:33:39 +0100
MIME-Version: 1.0
In-Reply-To: <1518679721-17415-1-git-send-email-stefan.windfeldt@axis.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 02/15/2018 08:28 AM, Stefan Windfeldt-Prytz wrote:
> If no iio buffer has been set up and poll is called return 0.
> 

This is a pretty bad bug, thanks for fixing this.

The commit message should include a section about the consequences of
missing check.

It looks like the issue goes back all the way to the beginning and the fix
needs to be backported to all stable releases.

> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
> ---
> Changes in v2:
> - Removed Change-Id
> 
>  drivers/iio/industrialio-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 79abf70..cd5bfe3 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -175,7 +175,7 @@ __poll_t iio_buffer_poll(struct file *filp,
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
>  
> -	if (!indio_dev->info)
> +	if (!indio_dev->info || rb == NULL)
>  		return 0;
>  
>  	poll_wait(filp, &rb->pollq, wait);
> 
