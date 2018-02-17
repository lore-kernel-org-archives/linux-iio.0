Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbeBQQ4Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Feb 2018 11:56:16 -0500
Date: Sat, 17 Feb 2018 16:56:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, ppmeerw@pmeerw.net,
        linux-iio@vger.kernel.org,
        Stefan Windfeldt-Prytz <stefanw@axis.com>
Subject: Re: [PATCHv3] iio: buffer: check if a buffer has been set up when
 poll is called
Message-ID: <20180217165611.24c7f92c@archlinux>
In-Reply-To: <1518703373-23687-1-git-send-email-stefan.windfeldt@axis.com>
References: <1518703373-23687-1-git-send-email-stefan.windfeldt@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Feb 2018 15:02:53 +0100
Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com> wrote:

> If no iio buffer has been set up and poll is called return 0.
> Without this check there will be a null pointer dereference when
> calling poll on a iio driver without an iio buffer.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Added consequences of missing the check
> 
> drivers/iio/industrialio-buffer.c | 2 +-
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

