Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48151 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbcAARul (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jan 2016 12:50:41 -0500
Subject: Re: [PATCH 2/3] iio: Specify supported modes for buffers
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1432916062-15195-1-git-send-email-lars@metafoo.de>
 <1432916062-15195-3-git-send-email-lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5686BC6A.8080208@kernel.org>
Date: Fri, 1 Jan 2016 17:50:34 +0000
MIME-Version: 1.0
In-Reply-To: <1432916062-15195-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/05/15 17:14, Lars-Peter Clausen wrote:
> For each buffer type specify the supported device modes for this buffer.
> This allows us for devices which support multiple different operating modes
> to pick the correct operating mode based on the modes supported by the
> attached buffers.
> 
> It also prevents that buffers with conflicting modes are attached
> to a device at the same time or that a buffer with a non-supported mode is
> attached to a device (e.g. in-kernel callback buffer to a device only
> supporting hardware mode).
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

This email is more of a heads up than anything else.  We accidentally
broke the am335x driver doing this as it is specifying that it has
a hardware buffer whereas is should be a software buffer as the buffer
exposed to userspace is a software one (kfifo).

Hardware buffer should be reserved for those rare cases where we really
are talking directly to the hardware (and as such can't do some intermediate
stuff).  In this case we are reading from a fifo in the hardware but then
pushing it into the software buffer.

I'll send a patch shortly.

Jonathan
> ---
>  drivers/iio/buffer_cb.c                  |  2 ++
>  drivers/iio/industrialio-buffer.c        | 18 +++++++++++++++---
>  drivers/iio/kfifo_buf.c                  |  2 ++
>  drivers/staging/iio/accel/sca3000_ring.c |  2 ++
>  include/linux/iio/buffer.h               |  3 +++
>  5 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
> index eb46e72..1648e6e 100644
> --- a/drivers/iio/buffer_cb.c
> +++ b/drivers/iio/buffer_cb.c
> @@ -33,6 +33,8 @@ static void iio_buffer_cb_release(struct iio_buffer *buffer)
>  static const struct iio_buffer_access_funcs iio_cb_access = {
>  	.store_to = &iio_buffer_cb_store_to,
>  	.release = &iio_buffer_cb_release,
> +
> +	.modes = INDIO_BUFFER_SOFTWARE | INDIO_BUFFER_TRIGGERED,
>  };
>  
>  struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a72db00..4250e97 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -604,6 +604,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  	const unsigned long *scan_mask;
>  	struct iio_buffer *buffer;
>  	bool scan_timestamp;
> +	unsigned int modes;
>  
>  	memset(config, 0, sizeof(*config));
>  
> @@ -615,12 +616,23 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  		list_is_singular(&indio_dev->buffer_list))
>  			return 0;
>  
> +	modes = indio_dev->modes;
> +
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +		if (buffer == remove_buffer)
> +			continue;
> +		modes &= buffer->access->modes;
> +	}
> +
> +	if (insert_buffer)
> +		modes &= insert_buffer->access->modes;
> +
>  	/* Definitely possible for devices to support both of these. */
> -	if ((indio_dev->modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
> +	if ((modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
>  		config->mode = INDIO_BUFFER_TRIGGERED;
> -	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
> +	} else if (modes & INDIO_BUFFER_HARDWARE) {
>  		config->mode = INDIO_BUFFER_HARDWARE;
> -	} else if (indio_dev->modes & INDIO_BUFFER_SOFTWARE) {
> +	} else if (modes & INDIO_BUFFER_SOFTWARE) {
>  		config->mode = INDIO_BUFFER_SOFTWARE;
>  	} else {
>  		/* Can only occur on first buffer */
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index 847ca56..db15684 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -135,6 +135,8 @@ static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>  	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
>  	.set_length = &iio_set_length_kfifo,
>  	.release = &iio_kfifo_buffer_release,
> +
> +	.modes = INDIO_BUFFER_SOFTWARE | INDIO_BUFFER_TRIGGERED,
>  };
>  
>  struct iio_buffer *iio_kfifo_allocate(void)
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index 8589eade..23685e7 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -258,6 +258,8 @@ static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
>  	.read_first_n = &sca3000_read_first_n_hw_rb,
>  	.data_available = sca3000_ring_buf_data_available,
>  	.release = sca3000_ring_release,
> +
> +	.modes = INDIO_BUFFER_HARDWARE,
>  };
>  
>  int sca3000_configure_ring(struct iio_dev *indio_dev)
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index eb8622b..1600c55 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -29,6 +29,7 @@ struct iio_buffer;
>   * @set_length:		set number of datums in buffer
>   * @release:		called when the last reference to the buffer is dropped,
>   *			should free all resources allocated by the buffer.
> + * @modes:		Supported operating modes by this buffer type
>   *
>   * The purpose of this structure is to make the buffer element
>   * modular as event for a given driver, different usecases may require
> @@ -51,6 +52,8 @@ struct iio_buffer_access_funcs {
>  	int (*set_length)(struct iio_buffer *buffer, int length);
>  
>  	void (*release)(struct iio_buffer *buffer);
> +
> +	unsigned int modes;
>  };
>  
>  /**
> 

