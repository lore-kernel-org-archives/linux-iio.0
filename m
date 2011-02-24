Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54724 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab1BXTv0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2011 14:51:26 -0500
Message-ID: <4D66B6DE.1080002@cam.ac.uk>
Date: Thu, 24 Feb 2011 19:51:58 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: ADC: AD7476: Update timestamp handling
References: <1298574577-8373-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1298574577-8373-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/24/11 19:09, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add timestamp attributes.
> Revise timestamp handling accordingly.
> Preset timestamp generation.

As an aside:

An alternative would be to define an always on version of IIO_SCAN_EL_TIMESTAMP.
That would lead to smaller changes.  This way means we can turn it off though, which
on simple devices like this one means a big saving in 'ring_buffer' usage.

Patch is good, thanks. Technically this fixes a bug (by conforming to the abi)
as you pointed out the other day so could go to stable. Up to you...
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad7476.h      |    1 +
>  drivers/staging/iio/adc/ad7476_ring.c |   37 +++++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
> index b51b49e..f917e9c 100644
> --- a/drivers/staging/iio/adc/ad7476.h
> +++ b/drivers/staging/iio/adc/ad7476.h
> @@ -33,6 +33,7 @@ struct ad7476_state {
>  	struct regulator		*reg;
>  	struct work_struct		poll_work;
>  	atomic_t			protect_ring;
> +	size_t				d_size;
>  	u16				int_vref_mv;
>  	struct spi_transfer		xfer;
>  	struct spi_message		msg;
> diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
> index 85de142..1d654c8 100644
> --- a/drivers/staging/iio/adc/ad7476_ring.c
> +++ b/drivers/staging/iio/adc/ad7476_ring.c
> @@ -26,6 +26,8 @@
>  #include "ad7476.h"
>  
>  static IIO_SCAN_EL_C(in0, 0, 0, NULL);
> +static IIO_SCAN_EL_TIMESTAMP(1);
> +static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
>  
>  static ssize_t ad7476_show_type(struct device *dev,
>  				struct device_attribute *attr,
> @@ -44,6 +46,9 @@ static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad7476_show_type, NULL, 0);
>  static struct attribute *ad7476_scan_el_attrs[] = {
>  	&iio_scan_el_in0.dev_attr.attr,
>  	&iio_const_attr_in0_index.dev_attr.attr,
> +	&iio_const_attr_timestamp_index.dev_attr.attr,
> +	&iio_scan_el_timestamp.dev_attr.attr,
> +	&iio_const_attr_timestamp_type.dev_attr.attr,
>  	&iio_dev_attr_in_type.dev_attr.attr,
>  	NULL,
>  };
> @@ -86,16 +91,21 @@ error_ret:
>  static int ad7476_ring_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7476_state *st = indio_dev->dev_data;
> -	size_t d_size;
> +	struct iio_ring_buffer *ring = indio_dev->ring;
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
>  	return 0;
>  }
>  
> @@ -131,18 +141,12 @@ static void ad7476_poll_bh_to_ring(struct work_struct *work_s)
>  	s64 time_ns;
>  	__u8 *rxbuf;
>  	int b_sent;
> -	size_t d_size;
> -
> -	/* Ensure the timestamp is 8 byte aligned */
> -	d_size = st->chip_info->storagebits / 8 + sizeof(s64);
> -	if (d_size % sizeof(s64))
> -		d_size += sizeof(s64) - (d_size % sizeof(s64));
>  
>  	/* Ensure only one copy of this function running at a time */
>  	if (atomic_inc_return(&st->protect_ring) > 1)
>  		return;
>  
> -	rxbuf = kzalloc(d_size,	GFP_KERNEL);
> +	rxbuf = kzalloc(st->d_size, GFP_KERNEL);
>  	if (rxbuf == NULL)
>  		return;
>  
> @@ -152,7 +156,9 @@ static void ad7476_poll_bh_to_ring(struct work_struct *work_s)
>  
>  	time_ns = iio_get_time_ns();
>  
> -	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
> +	if (indio_dev->ring->scan_timestamp)
> +		memcpy(rxbuf + st->d_size - sizeof(s64),
> +			&time_ns, sizeof(time_ns));
>  
>  	indio_dev->ring->access.store_to(&sw_ring->buf, rxbuf, time_ns);
>  done:
> @@ -182,6 +188,7 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
>  	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
>  	indio_dev->ring->scan_el_attrs = &ad7476_scan_el_group;
> +	indio_dev->ring->scan_timestamp = true;
>  
>  	INIT_WORK(&st->poll_work, &ad7476_poll_bh_to_ring);
>  

