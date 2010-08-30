Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:44691 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab0H3MXn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 08:23:43 -0400
Message-ID: <4C7BA3EF.5010504@cam.ac.uk>
Date: Mon, 30 Aug 2010 13:28:31 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, "Song, Barry" <Barry.Song@analog.com>
Subject: Re: [PATCH 1/2] staging:iio rename ring attributes
References: <4C77D52A.6090606@cam.ac.uk> <1283165728-2231-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283165728-2231-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/30/10 11:55, Manuel Stahl wrote:
> bps -> bytes_per_datum
> ring_enable -> enable
Excellent.  Thanks for doing this.  At some point I'll do a cleanup
patch to do ring -> buffer wherever it appears and isn't guaranteed
to be a ring buffer.

Does need a follow up patch to deal with the Documentation for these
though.  Do you want to do it or shall I?  Simple spot of find an
replace I think...

Please send this on to Greg KH.

(cc'd Barry as a heads up...)
Sorry Analog guys, this is going to cause some more breakage
with your tree.  All easy fixes though + will encourage you to merge
drivers faster so it becomes our problem ;)
> 
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/accel/adis16209_ring.c |    2 +-
>  drivers/staging/iio/accel/adis16240_ring.c |    2 +-
>  drivers/staging/iio/accel/lis3l02dq_ring.c |    2 +-
>  drivers/staging/iio/accel/sca3000_ring.c   |   10 ++--
>  drivers/staging/iio/adc/max1363_ring.c     |    4 +-
>  drivers/staging/iio/gyro/adis16260_ring.c  |    2 +-
>  drivers/staging/iio/imu/adis16300_ring.c   |    2 +-
>  drivers/staging/iio/imu/adis16350_ring.c   |    2 +-
>  drivers/staging/iio/imu/adis16400_ring.c   |    2 +-
>  drivers/staging/iio/industrialio-ring.c    |    8 ++--
>  drivers/staging/iio/ring_generic.h         |   22 +++++-----
>  drivers/staging/iio/ring_sw.c              |   58 ++++++++++++++--------------
>  drivers/staging/iio/ring_sw.h              |   12 +++---
>  13 files changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
> index 25fde65..d40b95f 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -119,7 +119,7 @@ static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
>  	int i = 0;
>  	s16 *data;
>  	size_t datasize = st->indio_dev
> -		->ring->access.get_bpd(st->indio_dev->ring);
> +		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
> index cd69a2e..462d452 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -111,7 +111,7 @@ static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
>  	int i = 0;
>  	s16 *data;
>  	size_t datasize = st->indio_dev
> -		->ring->access.get_bpd(st->indio_dev->ring);
> +		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index a960a8f..4c1b36a 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -169,7 +169,7 @@ ssize_t lis3l02dq_read_accel_from_ring(struct device *dev,
>  	if (ret < 0)
>  		goto error_ret;
>  	if (ret) {
> -		data = kmalloc(dev_info->ring->access.get_bpd(dev_info->ring),
> +		data = kmalloc(dev_info->ring->access.get_bytes_per_datum(dev_info->ring),
>  			       GFP_KERNEL);
>  		if (data == NULL)
>  			return -ENOMEM;
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index 8e8c068..eff5b9a 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -100,7 +100,7 @@ static int sca3000_ring_get_length(struct iio_ring_buffer *r)
>  }
>  
>  /* only valid if resolution is kept at 11bits */
> -static int sca3000_ring_get_bpd(struct iio_ring_buffer *r)
> +static int sca3000_ring_get_bytes_per_datum(struct iio_ring_buffer *r)
>  {
>  	return 6;
>  }
> @@ -111,7 +111,7 @@ static void sca3000_ring_release(struct device *dev)
>  }
>  
>  static IIO_RING_ENABLE_ATTR;
> -static IIO_RING_BPS_ATTR;
> +static IIO_RING_BYTES_PER_DATUM_ATTR;
>  static IIO_RING_LENGTH_ATTR;
>  
>  /**
> @@ -218,8 +218,8 @@ static struct attribute_group sca3000_scan_el_group = {
>   */
>  static struct attribute *sca3000_ring_attributes[] = {
>  	&dev_attr_length.attr,
> -	&dev_attr_bps.attr,
> -	&dev_attr_ring_enable.attr,
> +	&dev_attr_bytes_per_datum.attr,
> +	&dev_attr_enable.attr,
>  	NULL,
>  };
>  
> @@ -272,7 +272,7 @@ int sca3000_configure_ring(struct iio_dev *indio_dev)
>  
>  	indio_dev->ring->access.rip_lots = &sca3000_rip_hw_rb;
>  	indio_dev->ring->access.get_length = &sca3000_ring_get_length;
> -	indio_dev->ring->access.get_bpd = &sca3000_ring_get_bpd;
> +	indio_dev->ring->access.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum;
>  
>  	return 0;
>  }
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index 786b17a..edac0ba 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -92,14 +92,14 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
>  	max1363_set_scan_mode(st);
>  
>  	numvals = hweight_long(st->current_mode->modemask);
> -	if (indio_dev->ring->access.set_bpd) {
> +	if (indio_dev->ring->access.set_bytes_per_datum) {
>  		if (st->chip_info->bits != 8)
>  			d_size = numvals*2 + sizeof(s64);
>  		else
>  			d_size = numvals + sizeof(s64);
>  		if (d_size % 8)
>  			d_size += 8 - (d_size % 8);
> -		indio_dev->ring->access.set_bpd(indio_dev->ring, d_size);
> +		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring, d_size);
>  	}
>  
>  	return 0;
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
> index 9ef7f90..055d5e8 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -114,7 +114,7 @@ static void adis16260_trigger_bh_to_ring(struct work_struct *work_s)
>  	int i = 0;
>  	s16 *data;
>  	size_t datasize = st->indio_dev
> -		->ring->access.get_bpd(st->indio_dev->ring);
> +		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
> index fc93160..854183c 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -138,7 +138,7 @@ static void adis16300_trigger_bh_to_ring(struct work_struct *work_s)
>  	int i = 0;
>  	s16 *data;
>  	size_t datasize = st->indio_dev
> -		->ring->access.get_bpd(st->indio_dev->ring);
> +		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
> index e053e9a..9620cbe 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -138,7 +138,7 @@ static void adis16350_trigger_bh_to_ring(struct work_struct *work_s)
>  	int i = 0;
>  	s16 *data;
>  	size_t datasize = st->indio_dev
> -		->ring->access.get_bpd(st->indio_dev->ring);
> +		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
> index 949db76..c8e2316 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -147,7 +147,7 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
>  	int i = 0;
>  	s16 *data;
>  	size_t datasize = st->indio_dev
> -		->ring->access.get_bpd(st->indio_dev->ring);
> +		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
> index 6ab578e..610c2b6 100644
> --- a/drivers/staging/iio/industrialio-ring.c
> +++ b/drivers/staging/iio/industrialio-ring.c
> @@ -338,20 +338,20 @@ EXPORT_SYMBOL(iio_read_ring_length);
>  }
>  EXPORT_SYMBOL(iio_write_ring_length);
>  
> -ssize_t iio_read_ring_bps(struct device *dev,
> +ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
>  			  struct device_attribute *attr,
>  			  char *buf)
>  {
>  	int len = 0;
>  	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
>  
> -	if (ring->access.get_bpd)
> +	if (ring->access.get_bytes_per_datum)
>  		len = sprintf(buf, "%d\n",
> -			      ring->access.get_bpd(ring));
> +			      ring->access.get_bytes_per_datum(ring));
>  
>  	return len;
>  }
> -EXPORT_SYMBOL(iio_read_ring_bps);
> +EXPORT_SYMBOL(iio_read_ring_bytes_per_datum);
>  
>  ssize_t iio_store_ring_enable(struct device *dev,
>  			      struct device_attribute *attr,
> diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
> index a872d39..ac017b1 100644
> --- a/drivers/staging/iio/ring_generic.h
> +++ b/drivers/staging/iio/ring_generic.h
> @@ -52,8 +52,8 @@ int iio_push_or_escallate_ring_event(struct iio_ring_buffer *ring_buf,
>   *			change.
>   * @request_update:	if a parameter change has been marked, update underlying
>   *			storage.
> - * @get_bpd:		get current bytes per datum
> - * @set_bpd:		set number of bytes per datum
> + * @get_bytes_per_datum:		get current bytes per datum
> + * @set_bytes_per_datum:		set number of bytes per datum
>   * @get_length:		get number of datums in ring
>   * @set_length:		set number of datums in ring
>   * @is_enabled:		query if ring is currently being used
> @@ -81,8 +81,8 @@ struct iio_ring_access_funcs {
>  	int (*mark_param_change)(struct iio_ring_buffer *ring);
>  	int (*request_update)(struct iio_ring_buffer *ring);
>  
> -	int (*get_bpd)(struct iio_ring_buffer *ring);
> -	int (*set_bpd)(struct iio_ring_buffer *ring, size_t bpd);
> +	int (*get_bytes_per_datum)(struct iio_ring_buffer *ring);
> +	int (*set_bytes_per_datum)(struct iio_ring_buffer *ring, size_t bpd);
>  	int (*get_length)(struct iio_ring_buffer *ring);
>  	int (*set_length)(struct iio_ring_buffer *ring, int length);
>  
> @@ -99,7 +99,7 @@ struct iio_ring_access_funcs {
>   * @id:			unique id number
>   * @access_id:		device id number
>   * @length:		[DEVICE] number of datums in ring
> - * @bpd:		[DEVICE] size of individual datum including timestamp
> + * @bytes_per_datum	[DEVICE] size of individual datum including timestamp
>   * @bpe:		[DEVICE] size of individual channel value
>   * @loopcount:		[INTERN] number of times the ring has looped
>   * @access_handler:	[INTERN] chrdev access handling
> @@ -121,7 +121,7 @@ struct iio_ring_buffer {
>  	int				id;
>  	int				access_id;
>  	int				length;
> -	int				bpd;
> +	int				bytes_per_datum;
>  	int				bpe;
>  	int				loopcount;
>  	struct iio_handler		access_handler;
> @@ -146,7 +146,7 @@ void iio_ring_buffer_init(struct iio_ring_buffer *ring,
>  static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
>  					    int bytes_per_datum, int length)
>  {
> -	ring->bpd = bytes_per_datum;
> +	ring->bytes_per_datum = bytes_per_datum;
>  	ring->length = length;
>  	ring->loopcount = 0;
>  }
> @@ -277,7 +277,7 @@ ssize_t iio_write_ring_length(struct device *dev,
>  			      struct device_attribute *attr,
>  			      const char *buf,
>  			      size_t len);
> -ssize_t iio_read_ring_bps(struct device *dev,
> +ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
>  			  struct device_attribute *attr,
>  			  char *buf);
>  ssize_t iio_store_ring_enable(struct device *dev,
> @@ -290,9 +290,9 @@ ssize_t iio_show_ring_enable(struct device *dev,
>  #define IIO_RING_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
>  					 iio_read_ring_length,		\
>  					 iio_write_ring_length)
> -#define IIO_RING_BPS_ATTR DEVICE_ATTR(bps, S_IRUGO | S_IWUSR,	\
> -				      iio_read_ring_bps, NULL)
> -#define IIO_RING_ENABLE_ATTR DEVICE_ATTR(ring_enable, S_IRUGO | S_IWUSR, \
> +#define IIO_RING_BYTES_PER_DATUM_ATTR DEVICE_ATTR(bytes_per_datum, S_IRUGO | S_IWUSR,	\
> +				      iio_read_ring_bytes_per_datum, NULL)
> +#define IIO_RING_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, \
>  					 iio_show_ring_enable,		\
>  					 iio_store_ring_enable)
>  #else /* CONFIG_IIO_RING_BUFFER */
> diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
> index e2f01c6..99efb6b 100644
> --- a/drivers/staging/iio/ring_sw.c
> +++ b/drivers/staging/iio/ring_sw.c
> @@ -21,7 +21,7 @@ static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_buffer *ring,
>  	if ((length == 0) || (bytes_per_datum == 0))
>  		return -EINVAL;
>  	__iio_update_ring_buffer(&ring->buf, bytes_per_datum, length);
> -	ring->data = kmalloc(length*ring->buf.bpd, GFP_ATOMIC);
> +	ring->data = kmalloc(length*ring->buf.bytes_per_datum, GFP_ATOMIC);
>  	ring->read_p = NULL;
>  	ring->write_p = NULL;
>  	ring->last_written_p = NULL;
> @@ -77,10 +77,10 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
>  		 * as long as the read pointer is valid before this
>  		 * passes it - guaranteed as set later in this function.
>  		 */
> -		ring->half_p = ring->data - ring->buf.length*ring->buf.bpd/2;
> +		ring->half_p = ring->data - ring->buf.length*ring->buf.bytes_per_datum/2;
>  	}
>  	/* Copy data to where ever the current write pointer says */
> -	memcpy(ring->write_p, data, ring->buf.bpd);
> +	memcpy(ring->write_p, data, ring->buf.bytes_per_datum);
>  	barrier();
>  	/* Update the pointer used to get most recent value.
>  	 * Always valid as either points to latest or second latest value.
> @@ -91,9 +91,9 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
>  	/* temp_ptr used to ensure we never have an invalid pointer
>  	 * it may be slightly lagging, but never invalid
>  	 */
> -	temp_ptr = ring->write_p + ring->buf.bpd;
> +	temp_ptr = ring->write_p + ring->buf.bytes_per_datum;
>  	/* End of ring, back to the beginning */
> -	if (temp_ptr == ring->data + ring->buf.length*ring->buf.bpd)
> +	if (temp_ptr == ring->data + ring->buf.length*ring->buf.bytes_per_datum)
>  		temp_ptr = ring->data;
>  	/* Update the write pointer
>  	 * always valid as long as this is the only function able to write.
> @@ -112,9 +112,9 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
>  	 */
>  	else if (ring->write_p == ring->read_p) {
>  		change_test_ptr = ring->read_p;
> -		temp_ptr = change_test_ptr + ring->buf.bpd;
> +		temp_ptr = change_test_ptr + ring->buf.bytes_per_datum;
>  		if (temp_ptr
> -		    == ring->data + ring->buf.length*ring->buf.bpd) {
> +		    == ring->data + ring->buf.length*ring->buf.bytes_per_datum) {
>  			temp_ptr = ring->data;
>  		}
>  		/* We are moving pointer on one because the ring is full.  Any
> @@ -135,8 +135,8 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
>  	/* There are definite 'issues' with this and chances of
>  	 * simultaneous read */
>  	/* Also need to use loop count to ensure this only happens once */
> -	ring->half_p += ring->buf.bpd;
> -	if (ring->half_p == ring->data + ring->buf.length*ring->buf.bpd)
> +	ring->half_p += ring->buf.bytes_per_datum;
> +	if (ring->half_p == ring->data + ring->buf.length*ring->buf.bytes_per_datum)
>  		ring->half_p = ring->data;
>  	if (ring->half_p == ring->read_p) {
>  		spin_lock(&ring->buf.shared_ev_pointer.lock);
> @@ -164,15 +164,15 @@ int iio_rip_sw_rb(struct iio_ring_buffer *r,
>  	 *  read something that is not a whole number of bpds.
>  	 * Return an error.
>  	 */
> -	if (count % ring->buf.bpd) {
> +	if (count % ring->buf.bytes_per_datum) {
>  		ret = -EINVAL;
>  		printk(KERN_INFO "Ring buffer read request not whole number of"
> -		       "samples: Request bytes %zd, Current bpd %d\n",
> -		       count, ring->buf.bpd);
> +		       "samples: Request bytes %zd, Current bytes per datum %d\n",
> +		       count, ring->buf.bytes_per_datum);
>  		goto error_ret;
>  	}
>  	/* Limit size to whole of ring buffer */
> -	bytes_to_rip = min((size_t)(ring->buf.bpd*ring->buf.length), count);
> +	bytes_to_rip = min((size_t)(ring->buf.bytes_per_datum*ring->buf.length), count);
>  
>  	*data = kmalloc(bytes_to_rip, GFP_KERNEL);
>  	if (*data == NULL) {
> @@ -214,7 +214,7 @@ int iio_rip_sw_rb(struct iio_ring_buffer *r,
>  	} else {
>  		/* going through 'end' of ring buffer */
>  		max_copied = ring->data
> -			+ ring->buf.length*ring->buf.bpd - initial_read_p;
> +			+ ring->buf.length*ring->buf.bytes_per_datum - initial_read_p;
>  		memcpy(*data, initial_read_p, max_copied);
>  		/* possible we are done if we align precisely with end */
>  		if (max_copied == bytes_to_rip)
> @@ -240,7 +240,7 @@ int iio_rip_sw_rb(struct iio_ring_buffer *r,
>  	if (initial_read_p <= current_read_p)
>  		*dead_offset = current_read_p - initial_read_p;
>  	else
> -		*dead_offset = ring->buf.length*ring->buf.bpd
> +		*dead_offset = ring->buf.length*ring->buf.bytes_per_datum
>  			- (initial_read_p - current_read_p);
>  
>  	/* possible issue if the initial write has been lapped or indeed
> @@ -293,7 +293,7 @@ again:
>  	/* Check there is anything here */
>  	if (last_written_p_copy == NULL)
>  		return -EAGAIN;
> -	memcpy(data, last_written_p_copy, ring->buf.bpd);
> +	memcpy(data, last_written_p_copy, ring->buf.bytes_per_datum);
>  
>  	if (unlikely(ring->last_written_p != last_written_p_copy))
>  		goto again;
> @@ -322,7 +322,7 @@ int iio_request_update_sw_rb(struct iio_ring_buffer *r)
>  		goto error_ret;
>  	}
>  	__iio_free_sw_ring_buffer(ring);
> -	ret = __iio_allocate_sw_ring_buffer(ring, ring->buf.bpd,
> +	ret = __iio_allocate_sw_ring_buffer(ring, ring->buf.bytes_per_datum,
>  					    ring->buf.length);
>  error_ret:
>  	spin_unlock(&ring->use_lock);
> @@ -330,23 +330,23 @@ error_ret:
>  }
>  EXPORT_SYMBOL(iio_request_update_sw_rb);
>  
> -int iio_get_bpd_sw_rb(struct iio_ring_buffer *r)
> +int iio_get_bytes_per_datum_sw_rb(struct iio_ring_buffer *r)
>  {
>  	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
> -	return ring->buf.bpd;
> +	return ring->buf.bytes_per_datum;
>  }
> -EXPORT_SYMBOL(iio_get_bpd_sw_rb);
> +EXPORT_SYMBOL(iio_get_bytes_per_datum_sw_rb);
>  
> -int iio_set_bpd_sw_rb(struct iio_ring_buffer *r, size_t bpd)
> +int iio_set_bytes_per_datum_sw_rb(struct iio_ring_buffer *r, size_t bpd)
>  {
> -	if (r->bpd != bpd) {
> -		r->bpd = bpd;
> +	if (r->bytes_per_datum != bpd) {
> +		r->bytes_per_datum = bpd;
>  		if (r->access.mark_param_change)
>  			r->access.mark_param_change(r);
>  	}
>  	return 0;
>  }
> -EXPORT_SYMBOL(iio_set_bpd_sw_rb);
> +EXPORT_SYMBOL(iio_set_bytes_per_datum_sw_rb);
>  
>  int iio_get_length_sw_rb(struct iio_ring_buffer *r)
>  {
> @@ -380,14 +380,14 @@ static void iio_sw_rb_release(struct device *dev)
>  }
>  
>  static IIO_RING_ENABLE_ATTR;
> -static IIO_RING_BPS_ATTR;
> +static IIO_RING_BYTES_PER_DATUM_ATTR;
>  static IIO_RING_LENGTH_ATTR;
>  
>  /* Standard set of ring buffer attributes */
>  static struct attribute *iio_ring_attributes[] = {
>  	&dev_attr_length.attr,
> -	&dev_attr_bps.attr,
> -	&dev_attr_ring_enable.attr,
> +	&dev_attr_bytes_per_datum.attr,
> +	&dev_attr_enable.attr,
>  	NULL,
>  };
>  
> @@ -451,7 +451,7 @@ int iio_sw_ring_preenable(struct iio_dev *indio_dev)
>  			size = sizeof(s64);
>  	else /* Data only */
>  		size = indio_dev->scan_count * indio_dev->ring->bpe;
> -	indio_dev->ring->access.set_bpd(indio_dev->ring, size);
> +	indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring, size);
>  
>  	return 0;
>  }
> @@ -464,7 +464,7 @@ void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
>  			work_trigger_to_ring);
>  	int len = 0;
>  	size_t datasize = st->indio_dev
> -		->ring->access.get_bpd(st->indio_dev->ring);
> +		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
>  	char *data = kmalloc(datasize, GFP_KERNEL);
>  
>  	if (data == NULL) {
> diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
> index 61f1ed6..ad03d83 100644
> --- a/drivers/staging/iio/ring_sw.h
> +++ b/drivers/staging/iio/ring_sw.h
> @@ -121,19 +121,19 @@ int iio_mark_update_needed_sw_rb(struct iio_ring_buffer *r);
>  
>  
>  /**
> - * iio_get_bpd_sw_rb() - get the datum size in bytes
> + * iio_get_bytes_per_datum_sw_rb() - get the datum size in bytes
>   * @r:		pointer to a software ring buffer created by an
>   *		iio_create_sw_rb call
>   **/
> -int iio_get_bpd_sw_rb(struct iio_ring_buffer *r);
> +int iio_get_bytes_per_datum_sw_rb(struct iio_ring_buffer *r);
>  
>  /**
> - * iio_set_bpd_sw_rb() - set the datum size in bytes
> + * iio_set_bytes_per_datum_sw_rb() - set the datum size in bytes
>   * @r:		pointer to a software ring buffer created by an
>   *		iio_create_sw_rb call
>   * @bpd:	bytes per datum value
>   **/
> -int iio_set_bpd_sw_rb(struct iio_ring_buffer *r, size_t bpd);
> +int iio_set_bytes_per_datum_sw_rb(struct iio_ring_buffer *r, size_t bpd);
>  
>  /**
>   * iio_get_length_sw_rb() - get how many datums the rb may contain
> @@ -166,8 +166,8 @@ static inline void iio_ring_sw_register_funcs(struct iio_ring_access_funcs *ra)
>  	ra->mark_param_change = &iio_mark_update_needed_sw_rb;
>  	ra->request_update = &iio_request_update_sw_rb;
>  
> -	ra->get_bpd = &iio_get_bpd_sw_rb;
> -	ra->set_bpd = &iio_set_bpd_sw_rb;
> +	ra->get_bytes_per_datum = &iio_get_bytes_per_datum_sw_rb;
> +	ra->set_bytes_per_datum = &iio_set_bytes_per_datum_sw_rb;
>  
>  	ra->get_length = &iio_get_length_sw_rb;
>  	ra->set_length = &iio_set_length_sw_rb;

