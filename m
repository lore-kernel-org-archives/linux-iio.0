Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:47216 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdLFMK5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Dec 2017 07:10:57 -0500
Subject: Re: [PATCH v2] iio: buffer: Expose data available
To: mfornero@gmail.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        Matt Fornero <matt.fornero@mathworks.com>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
 <1512507416-21856-1-git-send-email-mfornero@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e4f1d159-d0b2-ce1b-4468-fc6f1b9e0601@metafoo.de>
Date: Wed, 6 Dec 2017 13:10:53 +0100
MIME-Version: 1.0
In-Reply-To: <1512507416-21856-1-git-send-email-mfornero@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/05/2017 09:56 PM, mfornero@gmail.com wrote:
> From: Matt Fornero <matt.fornero@mathworks.com>
> 
> Add a sysfs attribute that exposes buffer data available to userspace.
> This attribute can be checked at runtime to determine the overall buffer
> fill level (across all allocated buffers).
> 
> Signed-off-by: Matt Fornero <matt.fornero@mathworks.com>

Looks sensible to me. I think we need an update to the ABI documentation as
well for this in Documentation/ABI/testing/sysfs-bus-iio

> ---
> v1 -> v2:
>  - Use iio_buffer_data_available() for all buffers instead
>    of only DMA buffers
> 
>  drivers/iio/industrialio-buffer.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index d80f830..e7bdfa3 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1121,6 +1121,18 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
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
> +	return sprintf(buf, "%llu\n", (unsigned long long)bytes);

Since this is the kernel we shouldn't need those MSVC workarounds ;)
"%zu" should work

> +}
[..]
