Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-159.synserver.de ([212.40.185.159]:1062 "EHLO
	smtp-out-145.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755579AbbCRLzY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2015 07:55:24 -0400
Message-ID: <550967B5.7000100@metafoo.de>
Date: Wed, 18 Mar 2015 12:55:33 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v5 2/3] iio: add support for hardware fifo
References: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com> <1425491773-28499-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1425491773-28499-3-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/2015 06:56 PM, Octavian Purdila wrote:
>[...]
>   Documentation/ABI/testing/sysfs-bus-iio | 25 ++++++++++++
>   drivers/iio/industrialio-buffer.c       | 69 +++++++++++++++++++++++++++------
>   include/linux/iio/iio.h                 | 26 +++++++++++++
>   3 files changed, 108 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 1283ca7..143ddf2d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1264,3 +1264,28 @@ Description:
>   		allows the application to block on poll with a timeout and read
>   		the available samples after the timeout expires and thus have a
>   		maximum delay guarantee.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark
> +KernelVersion: 3.21
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +	       Read-only entry that contains a single integer specifying the
> +	       current level for the hardware fifo watermark level. If this
> +	       value is negative it means that the device does not support a
> +	       hardware fifo. If this value is 0 it means that the hardware fifo
> +	       is currently disabled.
> +	       If this value is strictly positive it signals that the hardware
> +	       fifo of the device is active and that samples are stored in an
> +	       internal hardware buffer. When the level of the hardware fifo
> +	       reaches the watermark level the device will flush its internal
> +	       buffer to the device buffer. Because of this a trigger is not
> +	       needed to use the device in buffer mode.
> +	       The hardware watermark level is set by the driver based on the
> +	       value set by the user in buffer/watermark but taking into account
> +	       the limitations of the hardware (e.g. most hardware buffers are
> +	       limited to 32-64 samples).
> +	       Because the sematics of triggers and hardware fifo may be

semantics

> +	       different (e.g. the hadware fifo may record samples according to
> +	       the sample rate while an any-motion trigger generates samples
> +	       based on the set rate of change) setting a trigger may disable
> +	       the hardware fifo.

I still don't understand why the hardware fifo level is something the 
userspace application needs to set. And how would the application decide 
which level it wants?

[...]
>   int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 80d8550..1b1cd7d 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -338,6 +338,29 @@ struct iio_dev;
>    *			provide a custom of_xlate function that reads the
>    *			*args* and returns the appropriate index in registered
>    *			IIO channels array.
> + * @hwfifo_set_watermark: function pointer to set the current hardware fifo
> + *			watermark level. It receives the desired watermark as a
> + *			hint and the device driver may adjust it to take into
> + *			account hardware limitations. Setting the watermark to a
> + *			strictly positive value should enable the hardware fifo
> + *			if not already enabled. When the hardware fifo is
> + *			enabled and its level reaches the watermark level the
> + *			device must flush the samples stored in the hardware
> + *			fifo to the device buffer. Setting the watermark to 0
> + *			should disable the hardware fifo. The device driver must
> + *			disable the hardware fifo when a trigger with different
> + *			sampling semantic (then the hardware fifo) is set
> + *			(e.g. when setting an any-motion trigger to a device
> + *			that has its hardware fifo sample based on the set
> + *			sample frequency).
> + * @hwfifo_get_watermark: function pointer to obtain the current hardware fifo
> + *			watermark level
> + * @hwfifo_flush:	function pointer to flush the samples stored in the

This might just be me, but I associate flushing a FIFO with discarding the 
data. Our previous discussions make a lot more sense now :)

> + *			hardware fifo to the device buffer. The driver should
> + *			not flush more then count samples. The function must
> + *			return the number of samples flushed, 0 if no samples
> + *			were flushed or a negative integer if no samples were
> + *			flushed and there was an error.
>    **/
>   struct iio_info {
>   	struct module			*driver_module;
> @@ -399,6 +422,9 @@ struct iio_info {
>   				  unsigned *readval);
>   	int (*of_xlate)(struct iio_dev *indio_dev,
>   			const struct of_phandle_args *iiospec);
> +	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned val);
> +	int (*hwfifo_get_watermark)(struct iio_dev *indio_dev);
> +	int (*hwfifo_flush)(struct iio_dev *indio_dev, unsigned count);
>   };
>
>   /**
>

