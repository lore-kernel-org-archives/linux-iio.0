Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:33741 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1BXTyF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2011 14:54:05 -0500
Message-ID: <4D66B77C.4030606@cam.ac.uk>
Date: Thu, 24 Feb 2011 19:54:36 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: ADC: AD7887: Update timestamp handling
References: <1298574577-8373-1-git-send-email-michael.hennerich@analog.com> <1298574577-8373-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1298574577-8373-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/24/11 19:09, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add timestamp attributes.
> Revise timestamp handling accordingly.
> Preset timestamp generation.
Could group these patches as a series with the explanation of why these are
needed in a cover letter.  Would provide explanation to Greg for what
otherwise just looks like adding functionality.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad7887.h      |    1 +
>  drivers/staging/iio/adc/ad7887_ring.c |   36 +++++++++++++++++++-------------
>  2 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
> index 8c2a218..439c802 100644
> --- a/drivers/staging/iio/adc/ad7887.h
> +++ b/drivers/staging/iio/adc/ad7887.h
> @@ -63,6 +63,7 @@ struct ad7887_state {
>  	struct regulator		*reg;
>  	struct work_struct		poll_work;
>  	atomic_t			protect_ring;
> +	size_t				d_size;
>  	u16				int_vref_mv;
>  	bool				en_dual;
>  	struct spi_transfer		xfer[4];
> diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
> index 6b9cb1f..2d7fe65 100644
> --- a/drivers/staging/iio/adc/ad7887_ring.c
> +++ b/drivers/staging/iio/adc/ad7887_ring.c
> @@ -27,6 +27,8 @@
>  
>  static IIO_SCAN_EL_C(in0, 0, 0, NULL);
>  static IIO_SCAN_EL_C(in1, 1, 0, NULL);
> +static IIO_SCAN_EL_TIMESTAMP(2);
> +static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
>  
>  static ssize_t ad7887_show_type(struct device *dev,
>  				struct device_attribute *attr,
> @@ -47,6 +49,9 @@ static struct attribute *ad7887_scan_el_attrs[] = {
>  	&iio_const_attr_in0_index.dev_attr.attr,
>  	&iio_scan_el_in1.dev_attr.attr,
>  	&iio_const_attr_in1_index.dev_attr.attr,
> +	&iio_const_attr_timestamp_index.dev_attr.attr,
> +	&iio_scan_el_timestamp.dev_attr.attr,
> +	&iio_const_attr_timestamp_type.dev_attr.attr,
>  	&iio_dev_attr_in_type.dev_attr.attr,
>  	NULL,
>  };
> @@ -118,16 +123,20 @@ static int ad7887_ring_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7887_state *st = indio_dev->dev_data;
>  	struct iio_ring_buffer *ring = indio_dev->ring;
> -	size_t d_size;
>  
> -	if (indio_dev->ring->access.set_bytes_per_datum) {
> -		d_size = st->chip_info->storagebits / 8 + sizeof(s64);
> -		if (d_size % 8)
> -			d_size += 8 - (d_size % 8);
> -		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
> -							    d_size);
> +	st->d_size = ring->scan_count * st->chip_info->storagebits / 8;
> +
> +	if (ring->scan_timestamp) {
> +		st->d_size += sizeof(s64);
> +
> +		if (st->d_size % sizeof(s64))
> +			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
>  	}
>  
> +	if (indio_dev->ring->access.set_bytes_per_datum)
> +		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
> +							    st->d_size);
> +
>  	switch (ring->scan_mask) {
>  	case (1 << 0):
>  		st->ring_msg = &st->msg[AD7887_CH0];
> @@ -186,20 +195,14 @@ static void ad7887_poll_bh_to_ring(struct work_struct *work_s)
>  	s64 time_ns;
>  	__u8 *buf;
>  	int b_sent;
> -	size_t d_size;
>  
>  	unsigned int bytes = ring->scan_count * st->chip_info->storagebits / 8;
>  
> -	/* Ensure the timestamp is 8 byte aligned */
> -	d_size = bytes + sizeof(s64);
> -	if (d_size % sizeof(s64))
> -		d_size += sizeof(s64) - (d_size % sizeof(s64));
> -
>  	/* Ensure only one copy of this function running at a time */
>  	if (atomic_inc_return(&st->protect_ring) > 1)
>  		return;
>  
> -	buf = kzalloc(d_size, GFP_KERNEL);
> +	buf = kzalloc(st->d_size, GFP_KERNEL);
>  	if (buf == NULL)
>  		return;
>  
> @@ -210,7 +213,9 @@ static void ad7887_poll_bh_to_ring(struct work_struct *work_s)
>  	time_ns = iio_get_time_ns();
>  
>  	memcpy(buf, st->data, bytes);
> -	memcpy(buf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
> +	if (ring->scan_timestamp)
> +		memcpy(buf + st->d_size - sizeof(s64),
> +			&time_ns, sizeof(time_ns));
>  
>  	indio_dev->ring->access.store_to(&sw_ring->buf, buf, time_ns);
>  done:
> @@ -241,6 +246,7 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
>  	indio_dev->ring->postdisable = &ad7887_ring_postdisable;
>  	indio_dev->ring->scan_el_attrs = &ad7887_scan_el_group;
> +	indio_dev->ring->scan_timestamp = true;
>  
>  	INIT_WORK(&st->poll_work, &ad7887_poll_bh_to_ring);
>  

