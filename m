Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49682 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753890Ab1LMA4O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 19:56:14 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F234F20535
	for <linux-iio@vger.kernel.org>; Mon, 12 Dec 2011 19:56:13 -0500 (EST)
Date: Mon, 12 Dec 2011 16:45:06 -0800
From: Greg KH <greg@kroah.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access
 ops
Message-ID: <20111213004506.GA11553@kroah.com>
References: <1323684526-11134-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323684526-11134-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 12, 2011 at 11:08:46AM +0100, Lars-Peter Clausen wrote:
> Add some convenience wrapper functions around the buffer access operations. This
> makes the resulting code both a bit easier to read and to write.

Yeah, but why are you abstracting this away?


> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/buffer.h              |   68 +++++++++++++++++++++++++++++
>  drivers/staging/iio/industrialio-buffer.c |   63 +++++++++++---------------
>  2 files changed, 95 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
> index 44593b2..46e0867 100644
> --- a/drivers/staging/iio/buffer.h
> +++ b/drivers/staging/iio/buffer.h
> @@ -194,6 +194,74 @@ ssize_t iio_buffer_show_enable(struct device *dev,
>  
>  int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
>  
> +static inline void buffer_mark_in_use(struct iio_buffer *buffer)
> +{
> +	if (buffer->access->mark_in_use)

Why would this check ever fail?

> +		buffer->access->mark_in_use(buffer);
> +}
> +
> +static inline void buffer_unmark_in_use(struct iio_buffer *buffer)
> +{
> +	if (buffer->access->unmark_in_use)

Same for this one?

> +		buffer->access->unmark_in_use(buffer);
> +}
> +
> +static inline int buffer_store_to(struct iio_buffer *buffer, u8 *data,
> +	s64 timestamp)
> +{
> +	return buffer->access->store_to(buffer, data, timestamp);

WHy didn't you check this one here?

> +}
> +
> +static inline int buffer_read_first_n(struct iio_buffer *buffer, size_t n,
> +	char __user *buf)
> +{
> +	return buffer->access->read_first_n(buffer, n, buf);
> +}
> +
> +static inline int buffer_mark_param_change(struct iio_buffer *buffer)
> +{
> +	if (buffer->access->mark_param_change)
> +		return buffer->access->mark_param_change(buffer);
> +
> +	return 0;

Why 0?  Not an error?

> +}
> +
> +static inline int buffer_request_update(struct iio_buffer *buffer)
> +{
> +	if (buffer->access->request_update)
> +		return buffer->access->request_update(buffer);
> +
> +	return 0;
> +}
> +
> +static inline int buffer_get_bytes_per_datum(struct iio_buffer *buffer)
> +{
> +	return buffer->access->get_bytes_per_datum(buffer);
> +}
> +
> +static inline int buffer_set_bytes_per_datum(struct iio_buffer *buffer,
> +	size_t bpd)
> +{
> +	return buffer->access->set_bytes_per_datum(buffer, bpd);
> +}
> +
> +static inline int buffer_get_length(struct iio_buffer *buffer)
> +{
> +	if (buffer->access->get_length)
> +		return buffer->access->get_length(buffer);
> +
> +	return -ENOSYS;

Here you return an error, but why ENOSYS?

Consistancy is key, and you don't have it here at all.  Or if you do, I
sure don't understand it...

Are you trying to keep people from touching the access field of the
buffer directly?  If so, that's great, but you don't prevent that here.

Perhaps you need to reduce the levels of indirection and work on making
an easier buffer object to work with?  If you have to have these types
of "helper" functions, just to keep the levels of pointers you have to
type, perhaps that's not really a good data structure in the first place
to be using?



> +}
> +
> +static inline int buffer_set_length(struct iio_buffer *buffer,
> +	int length)
> +{
> +	if (buffer->access->set_length)
> +		return buffer->access->set_length(buffer, length);
> +
> +	return -ENOSYS;
> +}
> +
>  #else /* CONFIG_IIO_BUFFER */
>  
>  static inline int iio_buffer_register(struct iio_dev *indio_dev,
> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
> index a03a574..8472570 100644
> --- a/drivers/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio-buffer.c
> @@ -43,9 +43,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
>  
> -	if (!rb || !rb->access->read_first_n)
> +	if (!rb)
>  		return -EINVAL;
> -	return rb->access->read_first_n(rb, n, buf);
> +	return buffer_read_first_n(rb, n, buf);

Oops, you just crashed if there wasn't a read_first_n() function here.

See consistancy just tripped you up :)

Sorry, I don't want to take this patch as-is.

greg k-h
