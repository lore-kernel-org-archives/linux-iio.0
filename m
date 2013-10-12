Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46323 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab3JLKAZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:00:25 -0400
Message-ID: <52592BE7.8080108@kernel.org>
Date: Sat, 12 Oct 2013 12:00:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/5] iio: Add reference counting for buffers
References: <1380884822-17035-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1380884822-17035-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/13 12:06, Lars-Peter Clausen wrote:
> Since the buffer is accessed by userspace we can not just free the buffers
> memory once we are done with it in kernel space. There might still be open file
> descriptors and userspace still might be accessing the buffer. This patch adds
> support for reference counting to the IIO buffers. When a buffer is created and
> initialized its initial reference count is set to 1. Instead of freeing the
> memory of the buffer the buffer's _free() function will drop that reference
> again. But only after the last reference to the buffer has been dropped the
> buffer the buffer's memory will be freed. The IIO device will take a reference
> to its primary buffer. The patch adds a small helper function for this called
> iio_device_attach_buffer() which will get a reference to the buffer and assign
> the buffer to the IIO device. This function must be used instead of assigning
> the buffer to the device by hand. The reference is only dropped once the IIO
> device is freed and we can be sure that there are no more open file handles. A
> reference to a buffer will also be taken whenever the buffer is active to avoid
> the buffer being freed while data is still being send to it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Lars, you have forgotten to cc GregKH given he raised the issues you have fixed.
I've added him now.  As far as I can see you have addressed all the points
raised and the code is a little bit nicer as a result (and more consistent!)

Applied to the togreg branch of iio.git.

Thanks for fixing this little mess that I made ;)

Jonathan
> 
> ---
> Changes since v1:
> 	* Uninline iio_buffer_get()/iio_buffer_put()
> 	* Let iio_buffer_get()/iio_buffer_put() accept NULL pointers
> 	* Let iio_buffer_get() return the same buffer that was passed into it
> ---
>  drivers/iio/buffer_cb.c                         | 21 +++++---
>  drivers/iio/industrialio-buffer.c               | 66 +++++++++++++++++++++++--
>  drivers/iio/industrialio-core.c                 |  3 ++
>  drivers/iio/industrialio-triggered-buffer.c     |  7 ++-
>  drivers/iio/kfifo_buf.c                         |  8 ++-
>  drivers/staging/iio/accel/lis3l02dq_ring.c      |  2 +-
>  drivers/staging/iio/accel/sca3000_ring.c        | 13 +++--
>  drivers/staging/iio/iio_simple_dummy_buffer.c   |  2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c |  8 ++-
>  drivers/staging/iio/meter/ade7758_ring.c        |  7 ++-
>  include/linux/iio/buffer.h                      | 28 +++++++++++
>  11 files changed, 141 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
> index 841fec1..2d9c6f8 100644
> --- a/drivers/iio/buffer_cb.c
> +++ b/drivers/iio/buffer_cb.c
> @@ -12,17 +12,27 @@ struct iio_cb_buffer {
>  	struct iio_channel *channels;
>  };
>  
> -static int iio_buffer_cb_store_to(struct iio_buffer *buffer, const void *data)
> +static struct iio_cb_buffer *buffer_to_cb_buffer(struct iio_buffer *buffer)
>  {
> -	struct iio_cb_buffer *cb_buff = container_of(buffer,
> -						     struct iio_cb_buffer,
> -						     buffer);
> +	return container_of(buffer, struct iio_cb_buffer, buffer);
> +}
>  
> +static int iio_buffer_cb_store_to(struct iio_buffer *buffer, const void *data)
> +{
> +	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
>  	return cb_buff->cb(data, cb_buff->private);
>  }
>  
> +static void iio_buffer_cb_release(struct iio_buffer *buffer)
> +{
> +	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
> +	kfree(cb_buff->buffer.scan_mask);
> +	kfree(cb_buff);
> +}
> +
>  static const struct iio_buffer_access_funcs iio_cb_access = {
>  	.store_to = &iio_buffer_cb_store_to,
> +	.release = &iio_buffer_cb_release,
>  };
>  
>  struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
> @@ -104,9 +114,8 @@ EXPORT_SYMBOL_GPL(iio_channel_stop_all_cb);
>  
>  void iio_channel_release_all_cb(struct iio_cb_buffer *cb_buff)
>  {
> -	kfree(cb_buff->buffer.scan_mask);
>  	iio_channel_release_all(cb_buff->channels);
> -	kfree(cb_buff);
> +	iio_buffer_put(&cb_buff->buffer);
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_release_all_cb);
>  
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e9f389b..36c39dc 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -74,6 +74,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
>  	INIT_LIST_HEAD(&buffer->demux_list);
>  	INIT_LIST_HEAD(&buffer->buffer_list);
>  	init_waitqueue_head(&buffer->pollq);
> +	kref_init(&buffer->ref);
>  }
>  EXPORT_SYMBOL(iio_buffer_init);
>  
> @@ -454,6 +455,19 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>  	return bytes;
>  }
>  
> +static void iio_buffer_activate(struct iio_dev *indio_dev,
> +	struct iio_buffer *buffer)
> +{
> +	iio_buffer_get(buffer);
> +	list_add(&buffer->buffer_list, &indio_dev->buffer_list);
> +}
> +
> +static void iio_buffer_deactivate(struct iio_buffer *buffer)
> +{
> +	list_del_init(&buffer->buffer_list);
> +	iio_buffer_put(buffer);
> +}
> +
>  void iio_disable_all_buffers(struct iio_dev *indio_dev)
>  {
>  	struct iio_buffer *buffer, *_buffer;
> @@ -466,7 +480,7 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
>  
>  	list_for_each_entry_safe(buffer, _buffer,
>  			&indio_dev->buffer_list, buffer_list)
> -		list_del_init(&buffer->buffer_list);
> +		iio_buffer_deactivate(buffer);
>  
>  	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  	if (indio_dev->setup_ops->postdisable)
> @@ -503,9 +517,9 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  		indio_dev->active_scan_mask = NULL;
>  
>  	if (remove_buffer)
> -		list_del_init(&remove_buffer->buffer_list);
> +		iio_buffer_deactivate(remove_buffer);
>  	if (insert_buffer)
> -		list_add(&insert_buffer->buffer_list, &indio_dev->buffer_list);
> +		iio_buffer_activate(indio_dev, insert_buffer);
>  
>  	/* If no buffers in list, we are done */
>  	if (list_empty(&indio_dev->buffer_list)) {
> @@ -540,7 +554,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  			 * Roll back.
>  			 * Note can only occur when adding a buffer.
>  			 */
> -			list_del_init(&insert_buffer->buffer_list);
> +			iio_buffer_deactivate(insert_buffer);
>  			if (old_mask) {
>  				indio_dev->active_scan_mask = old_mask;
>  				success = -EINVAL;
> @@ -631,7 +645,7 @@ error_run_postdisable:
>  error_remove_inserted:
>  
>  	if (insert_buffer)
> -		list_del_init(&insert_buffer->buffer_list);
> +		iio_buffer_deactivate(insert_buffer);
>  	indio_dev->active_scan_mask = old_mask;
>  	kfree(compound_mask);
>  error_ret:
> @@ -952,3 +966,45 @@ error_clear_mux_table:
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iio_update_demux);
> +
> +/**
> + * iio_buffer_release() - Free a buffer's resources
> + * @ref: Pointer to the kref embedded in the iio_buffer struct
> + *
> + * This function is called when the last reference to the buffer has been
> + * dropped. It will typically free all resources allocated by the buffer. Do not
> + * call this function manually, always use iio_buffer_put() when done using a
> + * buffer.
> + */
> +static void iio_buffer_release(struct kref *ref)
> +{
> +	struct iio_buffer *buffer = container_of(ref, struct iio_buffer, ref);
> +
> +	buffer->access->release(buffer);
> +}
> +
> +/**
> + * iio_buffer_get() - Grab a reference to the buffer
> + * @buffer: The buffer to grab a reference for, may be NULL
> + *
> + * Returns the pointer to the buffer that was passed into the function.
> + */
> +struct iio_buffer *iio_buffer_get(struct iio_buffer *buffer)
> +{
> +	if (buffer)
> +		kref_get(&buffer->ref);
> +
> +	return buffer;
> +}
> +EXPORT_SYMBOL_GPL(iio_buffer_get);
> +
> +/**
> + * iio_buffer_put() - Release the reference to the buffer
> + * @buffer: The buffer to release the reference for, may be NULL
> + */
> +void iio_buffer_put(struct iio_buffer *buffer)
> +{
> +	if (buffer)
> +		kref_put(&buffer->ref, iio_buffer_release);
> +}
> +EXPORT_SYMBOL_GPL(iio_buffer_put);
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 863aa01..0dfaf9e 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -28,6 +28,7 @@
>  #include "iio_core_trigger.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>
>  
>  /* IDA to assign each registered device a unique id */
>  static DEFINE_IDA(iio_ida);
> @@ -896,6 +897,8 @@ static void iio_dev_release(struct device *device)
>  	iio_device_unregister_sysfs(indio_dev);
>  	iio_device_unregister_debugfs(indio_dev);
>  
> +	iio_buffer_put(indio_dev->buffer);
> +
>  	ida_simple_remove(&iio_ida, indio_dev->id);
>  	kfree(indio_dev);
>  }
> diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
> index 46c619b..c1cb1f9 100644
> --- a/drivers/iio/industrialio-triggered-buffer.c
> +++ b/drivers/iio/industrialio-triggered-buffer.c
> @@ -47,14 +47,17 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
>  	irqreturn_t (*pollfunc_th)(int irq, void *p),
>  	const struct iio_buffer_setup_ops *setup_ops)
>  {
> +	struct iio_buffer *buffer;
>  	int ret;
>  
> -	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
> -	if (!indio_dev->buffer) {
> +	buffer = iio_kfifo_allocate(indio_dev);
> +	if (!buffer) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
>  
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
>  	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
>  						 pollfunc_th,
>  						 IRQF_ONESHOT,
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index 538d461..b4ac55a 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -130,6 +130,11 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
>  	return copied;
>  }
>  
> +static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
> +{
> +	kfree(iio_to_kfifo(buffer));
> +}
> +
>  static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>  	.store_to = &iio_store_to_kfifo,
>  	.read_first_n = &iio_read_first_n_kfifo,
> @@ -138,6 +143,7 @@ static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>  	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
>  	.get_length = &iio_get_length_kfifo,
>  	.set_length = &iio_set_length_kfifo,
> +	.release = &iio_kfifo_buffer_release,
>  };
>  
>  struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
> @@ -158,7 +164,7 @@ EXPORT_SYMBOL(iio_kfifo_allocate);
>  
>  void iio_kfifo_free(struct iio_buffer *r)
>  {
> -	kfree(iio_to_kfifo(r));
> +	iio_buffer_put(r);
>  }
>  EXPORT_SYMBOL(iio_kfifo_free);
>  
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index aae86dd..99b233f 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -397,7 +397,7 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return -ENOMEM;
>  
> -	indio_dev->buffer = buffer;
> +	iio_device_attach_buffer(indio_dev, buffer);
>  
>  	buffer->scan_timestamp = true;
>  	indio_dev->setup_ops = &lis3l02dq_buffer_setup_ops;
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index 0f2ee33..4a27beb 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -265,7 +265,7 @@ static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
>  	return buf;
>  }
>  
> -static inline void sca3000_rb_free(struct iio_buffer *r)
> +static void sca3000_ring_release(struct iio_buffer *r)
>  {
>  	kfree(iio_to_hw_buf(r));
>  }
> @@ -274,23 +274,28 @@ static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
>  	.read_first_n = &sca3000_read_first_n_hw_rb,
>  	.get_length = &sca3000_ring_get_length,
>  	.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum,
> +	.release = sca3000_ring_release,
>  };
>  
>  int sca3000_configure_ring(struct iio_dev *indio_dev)
>  {
> -	indio_dev->buffer = sca3000_rb_allocate(indio_dev);
> -	if (indio_dev->buffer == NULL)
> +	struct iio_buffer *buffer;
> +
> +	buffer = sca3000_rb_allocate(indio_dev);
> +	if (buffer == NULL)
>  		return -ENOMEM;
>  	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
>  
>  	indio_dev->buffer->access = &sca3000_ring_access_funcs;
>  
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
>  	return 0;
>  }
>  
>  void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
>  {
> -	sca3000_rb_free(indio_dev->buffer);
> +	iio_buffer_put(indio_dev->buffer);
>  }
>  
>  static inline
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index 09c93ac..2612e87 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -135,7 +135,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
>  		goto error_ret;
>  	}
>  
> -	indio_dev->buffer = buffer;
> +	iio_device_attach_buffer(indio_dev, buffer);
>  
>  	/* Enable timestamps by default */
>  	buffer->scan_timestamp = true;
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 712f3c2..f570115 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -630,10 +630,14 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
>  
>  static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  {
> -	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
> -	if (!indio_dev->buffer)
> +	struct iio_buffer *buffer;
> +
> +	buffer = iio_kfifo_allocate(indio_dev);
> +	if (buffer)
>  		return -ENOMEM;
>  
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
>  	/* Ring buffer functions - here trigger setup related */
>  	indio_dev->setup_ops = &ad5933_ring_setup_ops;
>  
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> index 4080995..7a448ff 100644
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ b/drivers/staging/iio/meter/ade7758_ring.c
> @@ -121,14 +121,17 @@ void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
>  int ade7758_configure_ring(struct iio_dev *indio_dev)
>  {
>  	struct ade7758_state *st = iio_priv(indio_dev);
> +	struct iio_buffer *buffer;
>  	int ret = 0;
>  
> -	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
> -	if (!indio_dev->buffer) {
> +	buffer = iio_kfifo_allocate(indio_dev);
> +	if (!buffer) {
>  		ret = -ENOMEM;
>  		return ret;
>  	}
>  
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
>  	indio_dev->setup_ops = &ade7758_ring_setup_ops;
>  
>  	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index a1124bd..6e428d9 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -11,6 +11,7 @@
>  #define _IIO_BUFFER_GENERIC_H_
>  #include <linux/sysfs.h>
>  #include <linux/iio/iio.h>
> +#include <linux/kref.h>
>  
>  #ifdef CONFIG_IIO_BUFFER
>  
> @@ -26,6 +27,8 @@ struct iio_buffer;
>   * @set_bytes_per_datum:set number of bytes per datum
>   * @get_length:		get number of datums in buffer
>   * @set_length:		set number of datums in buffer
> + * @release:		called when the last reference to the buffer is dropped,
> + *			should free all resources allocated by the buffer.
>   *
>   * The purpose of this structure is to make the buffer element
>   * modular as event for a given driver, different usecases may require
> @@ -47,6 +50,8 @@ struct iio_buffer_access_funcs {
>  	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
>  	int (*get_length)(struct iio_buffer *buffer);
>  	int (*set_length)(struct iio_buffer *buffer, int length);
> +
> +	void (*release)(struct iio_buffer *buffer);
>  };
>  
>  /**
> @@ -67,6 +72,7 @@ struct iio_buffer_access_funcs {
>   * @demux_list:		[INTERN] list of operations required to demux the scan.
>   * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
>   * @buffer_list:	[INTERN] entry in the devices list of current buffers.
> + * @ref:		[INTERN] reference count of the buffer.
>   */
>  struct iio_buffer {
>  	int					length;
> @@ -83,6 +89,7 @@ struct iio_buffer {
>  	struct list_head			demux_list;
>  	void					*demux_bounce;
>  	struct list_head			buffer_list;
> +	struct kref				ref;
>  };
>  
>  /**
> @@ -204,6 +211,24 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
>  bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>  	const unsigned long *mask);
>  
> +struct iio_buffer *iio_buffer_get(struct iio_buffer *buffer);
> +void iio_buffer_put(struct iio_buffer *buffer);
> +
> +/**
> + * iio_device_attach_buffer - Attach a buffer to a IIO device
> + * @indio_dev: The device the buffer should be attached to
> + * @buffer: The buffer to attach to the device
> + *
> + * This function attaches a buffer to a IIO device. The buffer stays attached to
> + * the device until the device is freed. The function should only be called at
> + * most once per device.
> + */
> +static inline void iio_device_attach_buffer(struct iio_dev *indio_dev,
> +	struct iio_buffer *buffer)
> +{
> +	indio_dev->buffer = iio_buffer_get(buffer);
> +}
> +
>  #else /* CONFIG_IIO_BUFFER */
>  
>  static inline int iio_buffer_register(struct iio_dev *indio_dev,
> @@ -216,6 +241,9 @@ static inline int iio_buffer_register(struct iio_dev *indio_dev,
>  static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
>  {}
>  
> +static inline void iio_buffer_get(struct iio_buffer *buffer) {}
> +static inline void iio_buffer_put(struct iio_buffer *buffer) {}
> +
>  #endif /* CONFIG_IIO_BUFFER */
>  
>  #endif /* _IIO_BUFFER_GENERIC_H_ */
> 
