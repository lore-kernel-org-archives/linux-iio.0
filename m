Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:51643 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbcIGSNe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Sep 2016 14:13:34 -0400
Subject: Re: [PATCH v1 1/2] iio:buffer: properly handle polling of
 unregistered device
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1473269007.git.gregor.boirie@parrot.com>
 <76209c68a95ae086878c35713e2ac6c2a3776f69.1473269007.git.gregor.boirie@parrot.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <aeee1e9c-4f0b-3435-a96d-478e256ebdf4@metafoo.de>
Date: Wed, 7 Sep 2016 20:13:28 +0200
MIME-Version: 1.0
In-Reply-To: <76209c68a95ae086878c35713e2ac6c2a3776f69.1473269007.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/2016 07:26 PM, Gregor Boirie wrote:
> Using iio_device_unregister() on a device currently in use may stall
> userspace process polling for data availability (poll syscall).
> 
> If device has vanished before running the iio_buffer_fileops poll hook, the
> latter will return empty poll event mask. Process will be stalled waiting
> for events that will never come (if no timeout specified).
> 
> This patch ensures iio_buffer_poll() returns POLLERR if device has just
> been unregistered in order to properly notify userspace process something
> wrong happened (such as removable device unplugged).
> 
> Fixes: 1bdc029390 ("iio: industrialio-buffer: Fix iio_buffer_poll return value")
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>

Hi,

Thanks for the patch. I agree with the solution, I don't quite agree with
the description. In my opinion the current behavior is not necessarily a
bug. Obviously there won't be a wakeup when the device has been removed
since no new data will be generated. But there are other scenarios where
this can happen as well (e.g. broken hardware). An application should be
prepared to handle this and if it is interactive for example allow the user
to interrupt the capture process.

Nevertheless adding support for returning an error on poll() when the device
has been removed is a good idea.

> ---
>  drivers/iio/industrialio-buffer.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 90462fc..b15b3386 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -162,13 +162,20 @@ unsigned int iio_buffer_poll(struct file *filp,
>  {
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
> +	bool rdy;
>  
>  	if (!indio_dev->info)
> -		return 0;
> +		return POLLERR;

I've had a look at what other subsystems do and input returns POLLERR |
POLLHUP. Maybe we should mirror this.

>  
>  	poll_wait(filp, &rb->pollq, wait);
> -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> +	rdy = iio_buffer_ready(indio_dev, rb, rb->watermark, 0);
> +
> +	if (!indio_dev->info)
> +		return POLLERR;

Why check indio_dev->info twice though? I think we should check it only once
after the poll_wait() call. If the device is unregistered we wake the pollq.
So adding it there should make sure that the poll() callback is called again
if the device is unregistered after the check.

> +
> +	if (rdy)
>  		return POLLIN | POLLRDNORM;
> +
>  	return 0;
>  }
>  
> 

