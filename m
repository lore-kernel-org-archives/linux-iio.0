Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdLJQVS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 11:21:18 -0500
Date: Sun, 10 Dec 2017 16:21:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: mfornero@gmail.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Matt Fornero <matt.fornero@mathworks.com>
Subject: Re: [PATCH v3] iio: buffer: Expose data available
Message-ID: <20171210162114.7928d9ed@archlinux>
In-Reply-To: <1512589410-9087-1-git-send-email-mfornero@gmail.com>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
        <1512589410-9087-1-git-send-email-mfornero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed,  6 Dec 2017 14:43:30 -0500
mfornero@gmail.com wrote:

> From: Matt Fornero <matt.fornero@mathworks.com>
> 
> Add a sysfs attribute that exposes buffer data available to userspace.
> This attribute can be checked at runtime to determine the overall buffer
> fill level (across all allocated buffers).

There are a few odd cases where we don't actually know the right answer
to this case, but we can 'estimate it'.  The classic would be a hardware
fifo like the sca3000 where (IIRC) you don't have the ability to query the
fill level of the buffer, but only whether it is empty.  You also have
watershed interrupts that let you know there is 'at least' this much in the
buffer.  Currently we route that one through a software kfifo anyway so
it doesn't matter here  - just thought I'd mention it ;)

Anyhow, looks fine to me.  The description including output buffers
 is good future proofing but that code isn't yet upstream.

I don't have an issue with having it in the description though!

Applied to the togreg branch of iio.git and pushed out as testing.
Lars, if you would like to add a tag let me know as I won't be pushing this
out in non rebasing form until at least next weekend.  Obviously I can
also back it out of change things if you have comments that require it
as well!

Thanks,

Jonathan

> 
> Signed-off-by: Matt Fornero <matt.fornero@mathworks.com>
> ---
> v2 -> v3:
>  - Use %zu for sprintf instead of %llu
>  - Add documentation
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>  drivers/iio/industrialio-buffer.c       | 15 +++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a478740..9cc0ea1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1413,6 +1413,16 @@ Description:
>  		the available samples after the timeout expires and thus have a
>  		maximum delay guarantee.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/buffer/data_available
> +KernelVersion: 4.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read-only value indicating the bytes of data available in the
> +		buffer. In the case of an output buffer, this indicates the
> +		amount of empty space available to write data to. In the case of
> +		an input buffer, this indicates the amount of data available for
> +		reading.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_enabled
>  KernelVersion: 4.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index d2b4651..eda2a0f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1198,6 +1198,18 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> +static ssize_t iio_dma_show_data_available(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	size_t bytes;
> +
> +	bytes = iio_buffer_data_available(indio_dev->buffer);
> +
> +	return sprintf(buf, "%zu\n", bytes);
> +}
> +
>  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
>  		   iio_buffer_write_length);
>  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> @@ -1208,11 +1220,14 @@ static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
>  		   iio_buffer_show_watermark, iio_buffer_store_watermark);
>  static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
>  	S_IRUGO, iio_buffer_show_watermark, NULL);
> +static DEVICE_ATTR(data_available, S_IRUGO,
> +		iio_dma_show_data_available, NULL);
>  
>  static struct attribute *iio_buffer_attrs[] = {
>  	&dev_attr_length.attr,
>  	&dev_attr_enable.attr,
>  	&dev_attr_watermark.attr,
> +	&dev_attr_data_available.attr,
>  };
>  
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)

