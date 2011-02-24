Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:57662 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1BXTzY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2011 14:55:24 -0500
Message-ID: <4D66B7CC.3060604@cam.ac.uk>
Date: Thu, 24 Feb 2011 19:55:56 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: ADC: AD799x: Update timestamp handling
References: <1298574577-8373-1-git-send-email-michael.hennerich@analog.com> <1298574577-8373-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1298574577-8373-4-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/24/11 19:09, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add timestamp attributes.
> Revise timestamp handling accordingly.
> Preset timestamp generation.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Thanks for doing these so fast.
> ---
>  drivers/staging/iio/adc/ad799x.h      |    1 +
>  drivers/staging/iio/adc/ad799x_core.c |   12 +++++++++
>  drivers/staging/iio/adc/ad799x_ring.c |   43 ++++++++++++--------------------
>  3 files changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
> index 81a20d5..a421362 100644
> --- a/drivers/staging/iio/adc/ad799x.h
> +++ b/drivers/staging/iio/adc/ad799x.h
> @@ -116,6 +116,7 @@ struct ad799x_state {
>  	struct work_struct		poll_work;
>  	struct work_struct		work_thresh;
>  	atomic_t			protect_ring;
> +	size_t				d_size;
>  	struct iio_trigger		*trig;
>  	struct regulator		*reg;
>  	s64				last_timestamp;
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index 89ccf37..e50841b 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -123,6 +123,9 @@ static AD799X_SCAN_EL(5);
>  static AD799X_SCAN_EL(6);
>  static AD799X_SCAN_EL(7);
>  
> +static IIO_SCAN_EL_TIMESTAMP(8);
> +static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64)
> +
>  static ssize_t ad799x_show_type(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
> @@ -471,6 +474,9 @@ static struct attribute *ad7991_5_9_3_4_scan_el_attrs[] = {
>  	&iio_const_attr_in2_index.dev_attr.attr,
>  	&iio_scan_el_in3.dev_attr.attr,
>  	&iio_const_attr_in3_index.dev_attr.attr,
> +	&iio_const_attr_timestamp_index.dev_attr.attr,
> +	&iio_scan_el_timestamp.dev_attr.attr,
> +	&iio_const_attr_timestamp_type.dev_attr.attr,
>  	&iio_dev_attr_in_type.dev_attr.attr,
>  	NULL,
>  };
> @@ -497,6 +503,9 @@ static struct attribute *ad7992_scan_el_attrs[] = {
>  	&iio_const_attr_in0_index.dev_attr.attr,
>  	&iio_scan_el_in1.dev_attr.attr,
>  	&iio_const_attr_in1_index.dev_attr.attr,
> +	&iio_const_attr_timestamp_index.dev_attr.attr,
> +	&iio_scan_el_timestamp.dev_attr.attr,
> +	&iio_const_attr_timestamp_type.dev_attr.attr,
>  	&iio_dev_attr_in_type.dev_attr.attr,
>  	NULL,
>  };
> @@ -541,6 +550,9 @@ static struct attribute *ad7997_8_scan_el_attrs[] = {
>  	&iio_const_attr_in6_index.dev_attr.attr,
>  	&iio_scan_el_in7.dev_attr.attr,
>  	&iio_const_attr_in7_index.dev_attr.attr,
> +	&iio_const_attr_timestamp_index.dev_attr.attr,
> +	&iio_scan_el_timestamp.dev_attr.attr,
> +	&iio_const_attr_timestamp_type.dev_attr.attr,
>  	&iio_dev_attr_in_type.dev_attr.attr,
>  	NULL,
>  };
> diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
> index 975cdcb..56abc39 100644
> --- a/drivers/staging/iio/adc/ad799x_ring.c
> +++ b/drivers/staging/iio/adc/ad799x_ring.c
> @@ -73,8 +73,6 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
>  {
>  	struct iio_ring_buffer *ring = indio_dev->ring;
>  	struct ad799x_state *st = indio_dev->dev_data;
> -	size_t d_size;
> -	unsigned long numvals;
>  
>  	/*
>  	 * Need to figure out the current mode based upon the requested
> @@ -84,15 +82,19 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
>  	if (st->id == ad7997 || st->id == ad7998)
>  		ad799x_set_scan_mode(st, ring->scan_mask);
>  
> -	numvals = ring->scan_count;
> +	st->d_size = ring->scan_count * 2;
>  
> -	if (ring->access.set_bytes_per_datum) {
> -		d_size = numvals*2 + sizeof(s64);
> -		if (d_size % 8)
> -			d_size += 8 - (d_size % 8);
> -		ring->access.set_bytes_per_datum(ring, d_size);
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
> @@ -130,29 +132,13 @@ static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
>  	s64 time_ns;
>  	__u8 *rxbuf;
>  	int b_sent;
> -	size_t d_size;
>  	u8 cmd;
>  
> -	unsigned long numvals = ring->scan_count;
> -
> -	/* Ensure the timestamp is 8 byte aligned */
> -	d_size = numvals*2 + sizeof(s64);
> -
> -	if (d_size % sizeof(s64))
> -		d_size += sizeof(s64) - (d_size % sizeof(s64));
> -
>  	/* Ensure only one copy of this function running at a time */
>  	if (atomic_inc_return(&st->protect_ring) > 1)
>  		return;
>  
> -	/* Monitor mode prevents reading. Whilst not currently implemented
> -	 * might as well have this test in here in the meantime as it does
> -	 * no harm.
> -	 */
> -	if (numvals == 0)
> -		return;
> -
> -	rxbuf = kmalloc(d_size,	GFP_KERNEL);
> +	rxbuf = kmalloc(st->d_size, GFP_KERNEL);
>  	if (rxbuf == NULL)
>  		return;
>  
> @@ -177,13 +163,15 @@ static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
>  	}
>  
>  	b_sent = i2c_smbus_read_i2c_block_data(st->client,
> -			cmd, numvals*2, rxbuf);
> +			cmd, ring->scan_count * 2, rxbuf);
>  	if (b_sent < 0)
>  		goto done;
>  
>  	time_ns = iio_get_time_ns();
>  
> -	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
> +	if (ring->scan_timestamp)
> +		memcpy(rxbuf + st->d_size - sizeof(s64),
> +			&time_ns, sizeof(time_ns));
>  
>  	ring->access.store_to(&ring_sw->buf, rxbuf, time_ns);
>  done:
> @@ -213,6 +201,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  	indio_dev->ring->preenable = &ad799x_ring_preenable;
>  	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
>  	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
> +	indio_dev->ring->scan_timestamp = true;
>  
>  	INIT_WORK(&st->poll_work, &ad799x_poll_bh_to_ring);
>  

