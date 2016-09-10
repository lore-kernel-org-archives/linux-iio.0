Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58586 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754753AbcIJPoE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 11:44:04 -0400
Subject: Re: [PATCH v2 1/1] iio:buffer: let poll report an error for
 unregistered devices
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1473430265.git.gregor.boirie@parrot.com>
 <579ce80942853be7eb6e6320727df0d4ffbd0903.1473430265.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7f729816-f82c-7ad1-8505-6df24a619131@kernel.org>
Date: Sat, 10 Sep 2016 16:44:02 +0100
MIME-Version: 1.0
In-Reply-To: <579ce80942853be7eb6e6320727df0d4ffbd0903.1473430265.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/09/16 15:20, Gregor Boirie wrote:
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
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Looks good to me.

Lars, as you were involved in the discussions of v1 could you
take a quick look.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 90462fc..aad5159 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -155,6 +155,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>   *		a wait queue
>   *
>   * Return: (POLLIN | POLLRDNORM) if data is available for reading
> + *	   POLLERR if device was unregistered in our back
>   *	   or 0 for other cases
>   */
>  unsigned int iio_buffer_poll(struct file *filp,
> @@ -162,13 +163,20 @@ unsigned int iio_buffer_poll(struct file *filp,
>  {
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
> +	bool rdy;
>  
>  	if (!indio_dev->info)
> -		return 0;
> +		return POLLERR;
>  
>  	poll_wait(filp, &rb->pollq, wait);
> -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> +	rdy = iio_buffer_ready(indio_dev, rb, rb->watermark, 0);
> +
> +	if (!indio_dev->info)
> +		return POLLERR;
> +
> +	if (rdy)
>  		return POLLIN | POLLRDNORM;
> +
>  	return 0;
>  }
>  
> 

