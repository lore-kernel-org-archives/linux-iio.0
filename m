Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:36836 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0H3Mxh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 08:53:37 -0400
Message-ID: <4C7BAAF1.7050501@cam.ac.uk>
Date: Mon, 30 Aug 2010 13:58:25 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, "Song, Barry" <Barry.Song@analog.com>
Subject: Re: [PATCH 2/2] staging:iio move scan_elements into ring buffer
References: <4C77D52A.6090606@cam.ac.uk> <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/30/10 11:55, Manuel Stahl wrote:
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

On more complex patches like this, could you verify which devices
you have tested against? Given the nature of that patch it
probably doesn't matter that much, but it's nice to save people
from wondering if they need to test on devices you have already
tried it with.

This one certainly turned out to be more complex that I was
anticipating! Mostly movement of code so easy enough to
review.

In one place as commented you made a change that obscured exactly
which bits your patch was changing. (see below).  I have nothing
against what you did, but would rather not have seen it in this
patch as it obscures what you are doing and that is never a good
idea! (in lis3l02dq_configure_ring).

There is also a movement of available_scan_masks in the iio_dev
structure that is unexplained.  It doesn't matter in the slightest
but is an odd thing to do without reason.

Neither of the above matter, they are just things I picked up
on whilst reviewing.

Thanks for doing this!

More than happy to add

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Please forward to Greg KH (assuming no one shouts - might be worth
holding this one for a day or so given it effects a lot of drivers)

Again, sorry to the Analog guys, this one is going to thoroughly break
you tree when it hits it.  Still better now than later when it effects
even more drivers.

Note this also needs a patch updating the documentation.


> ---
>  drivers/staging/iio/accel/adis16209_ring.c |   41 ++++++------
>  drivers/staging/iio/accel/adis16240_ring.c |   33 +++++-----
>  drivers/staging/iio/accel/lis3l02dq_ring.c |   62 +++++++++--------
>  drivers/staging/iio/accel/sca3000_ring.c   |    2 +-
>  drivers/staging/iio/adc/max1363_core.c     |    1 -
>  drivers/staging/iio/adc/max1363_ring.c     |   18 +++--
>  drivers/staging/iio/gyro/adis16260_ring.c  |   31 ++++-----
>  drivers/staging/iio/iio.h                  |  102 +---------------------------
>  drivers/staging/iio/imu/adis16300_ring.c   |   43 ++++++------
>  drivers/staging/iio/imu/adis16350_ring.c   |   47 ++++++-------
>  drivers/staging/iio/imu/adis16400_ring.c   |   49 +++++++-------
>  drivers/staging/iio/industrialio-core.c    |   12 ---
>  drivers/staging/iio/industrialio-ring.c    |   28 ++++++--
>  drivers/staging/iio/ring_generic.h         |  100 +++++++++++++++++++++++++++
>  drivers/staging/iio/ring_sw.c              |   25 ++++---
>  15 files changed, 298 insertions(+), 296 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
> index d40b95f..120bf91 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -115,11 +115,11 @@ static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
>  	struct adis16209_state *st
>  		= container_of(work_s, struct adis16209_state,
>  			       work_trigger_to_ring);
> +	struct iio_ring_buffer *ring = st->indio_dev->ring;
>  
>  	int i = 0;
>  	s16 *data;
> -	size_t datasize = st->indio_dev
> -		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
> +	size_t datasize = ring->access.get_bytes_per_datum(ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> @@ -127,19 +127,19 @@ static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
>  		return;
>  	}
>  
> -	if (st->indio_dev->scan_count)
> +	if (ring->scan_count)
>  		if (adis16209_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
> -			for (; i < st->indio_dev->scan_count; i++)
> +			for (; i < ring->scan_count; i++)
>  				data[i] = be16_to_cpup(
>  					(__be16 *)&(st->rx[i*2]));
>  
>  	/* Guaranteed to be aligned with 8 byte boundary */
> -	if (st->indio_dev->scan_timestamp)
> +	if (ring->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>  
> -	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> -					    (u8 *)data,
> -					    st->last_timestamp);
> +	ring->access.store_to(ring,
> +			      (u8 *)data,
> +			      st->last_timestamp);
>  
>  	iio_trigger_notify_done(st->indio_dev->trig);
>  	kfree(data);
> @@ -159,19 +159,6 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
>  	struct adis16209_state *st = indio_dev->dev_data;
>  	struct iio_ring_buffer *ring;
>  	INIT_WORK(&st->work_trigger_to_ring, adis16209_trigger_bh_to_ring);
> -	/* Set default scan mode */
> -
> -	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_rot.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_aux_adc.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_incli_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_incli_y.number);
> -	indio_dev->scan_timestamp = true;
> -
> -	indio_dev->scan_el_attrs = &adis16209_scan_el_group;
>  
>  	ring = iio_sw_rb_allocate(indio_dev);
>  	if (!ring) {
> @@ -182,11 +169,23 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
>  	/* Effectively select the ring buffer implementation */
>  	iio_ring_sw_register_funcs(&ring->access);
>  	ring->bpe = 2;
> +	ring->scan_el_attrs = &adis16209_scan_el_group;
> +	ring->scan_timestamp = true;
>  	ring->preenable = &iio_sw_ring_preenable;
>  	ring->postenable = &iio_triggered_ring_postenable;
>  	ring->predisable = &iio_triggered_ring_predisable;
>  	ring->owner = THIS_MODULE;
>  
> +	/* Set default scan mode */
> +	iio_scan_mask_set(ring, iio_scan_el_supply.number);
> +	iio_scan_mask_set(ring, iio_scan_el_rot.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_temp.number);
> +	iio_scan_mask_set(ring, iio_scan_el_aux_adc.number);
> +	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
> +
>  	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16209_poll_func_th);
>  	if (ret)
>  		goto error_iio_sw_rb_free;
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
> index 462d452..581d0e5 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -107,11 +107,11 @@ static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
>  	struct adis16240_state *st
>  		= container_of(work_s, struct adis16240_state,
>  				work_trigger_to_ring);
> +	struct iio_ring_buffer *ring = st->indio_dev->ring;
>  
>  	int i = 0;
>  	s16 *data;
> -	size_t datasize = st->indio_dev
> -		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
> +	size_t datasize = ring->access.get_bytes_per_datum(ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> @@ -119,17 +119,17 @@ static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
>  		return;
>  	}
>  
> -	if (st->indio_dev->scan_count)
> +	if (ring->scan_count)
>  		if (adis16240_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
> -			for (; i < st->indio_dev->scan_count; i++)
> +			for (; i < ring->scan_count; i++)
>  				data[i] = be16_to_cpup(
>  					(__be16 *)&(st->rx[i*2]));
>  
>  	/* Guaranteed to be aligned with 8 byte boundary */
> -	if (st->indio_dev->scan_timestamp)
> +	if (ring->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>  
> -	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> +	ring->access.store_to(ring,
>  			(u8 *)data,
>  			st->last_timestamp);
>  
> @@ -151,17 +151,6 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
>  	struct adis16240_state *st = indio_dev->dev_data;
>  	struct iio_ring_buffer *ring;
>  	INIT_WORK(&st->work_trigger_to_ring, adis16240_trigger_bh_to_ring);
> -	/* Set default scan mode */
> -
> -	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_aux_adc.number);
> -	indio_dev->scan_timestamp = true;
> -
> -	indio_dev->scan_el_attrs = &adis16240_scan_el_group;
>  
>  	ring = iio_sw_rb_allocate(indio_dev);
>  	if (!ring) {
> @@ -172,11 +161,21 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
>  	/* Effectively select the ring buffer implementation */
>  	iio_ring_sw_register_funcs(&ring->access);
>  	ring->bpe = 2;
> +	ring->scan_el_attrs = &adis16240_scan_el_group;
> +	ring->scan_timestamp = true;
>  	ring->preenable = &iio_sw_ring_preenable;
>  	ring->postenable = &iio_triggered_ring_postenable;
>  	ring->predisable = &iio_triggered_ring_predisable;
>  	ring->owner = THIS_MODULE;
>  
> +	/* Set default scan mode */
> +	iio_scan_mask_set(ring, iio_scan_el_supply.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
> +	iio_scan_mask_set(ring, iio_scan_el_temp.number);
> +	iio_scan_mask_set(ring, iio_scan_el_aux_adc.number);
> +
>  	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16240_poll_func_th);
>  	if (ret)
>  		goto error_iio_sw_rb_free;
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index 4c1b36a..a68a381 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -150,38 +150,40 @@ ssize_t lis3l02dq_read_accel_from_ring(struct device *dev,
>  	int ret, len = 0, i = 0;
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct iio_ring_buffer *ring = dev_info->ring;
> +	struct attribute_group *scan_el_attrs = ring->scan_el_attrs;
>  	s16 *data;
>  
> -	while (dev_info->scan_el_attrs->attrs[i]) {
> +	while (scan_el_attrs->attrs[i]) {
>  		el = to_iio_scan_el((struct device_attribute *)
> -				    (dev_info->scan_el_attrs->attrs[i]));
> +				    (scan_el_attrs->attrs[i]));
>  		/* label is in fact the address */
>  		if (el->label == this_attr->address)
>  			break;
>  		i++;
>  	}
> -	if (!dev_info->scan_el_attrs->attrs[i]) {
> +	if (!scan_el_attrs->attrs[i]) {
>  		ret = -EINVAL;
>  		goto error_ret;
>  	}
>  	/* If this element is in the scan mask */
> -	ret = iio_scan_mask_query(dev_info, el->number);
> +	ret = iio_scan_mask_query(ring, el->number);
>  	if (ret < 0)
>  		goto error_ret;
>  	if (ret) {
> -		data = kmalloc(dev_info->ring->access.get_bytes_per_datum(dev_info->ring),
> +		data = kmalloc(ring->access.get_bytes_per_datum(ring),
>  			       GFP_KERNEL);
>  		if (data == NULL)
>  			return -ENOMEM;
> -		ret = dev_info->ring->access.read_last(dev_info->ring,
> -						      (u8 *)data);
> +		ret = ring->access.read_last(ring,
> +					(u8 *)data);
>  		if (ret)
>  			goto error_free_data;
>  	} else {
>  		ret = -EINVAL;
>  		goto error_ret;
>  	}
> -	len = iio_scan_mask_count_to_right(dev_info, el->number);
> +	len = iio_scan_mask_count_to_right(ring, el->number);
>  	if (len < 0) {
>  		ret = len;
>  		goto error_free_data;
> @@ -211,11 +213,12 @@ static const u8 read_all_tx_array[] = {
>   **/
>  static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
>  {
> +	struct iio_ring_buffer *ring = st->help.indio_dev->ring;
>  	struct spi_transfer *xfers;
>  	struct spi_message msg;
>  	int ret, i, j = 0;
>  
> -	xfers = kzalloc((st->help.indio_dev->scan_count) * 2
> +	xfers = kzalloc((ring->scan_count) * 2
>  			* sizeof(*xfers), GFP_KERNEL);
>  	if (!xfers)
>  		return -ENOMEM;
> @@ -223,7 +226,7 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
>  	mutex_lock(&st->buf_lock);
>  
>  	for (i = 0; i < ARRAY_SIZE(read_all_tx_array)/4; i++) {
> -		if (st->help.indio_dev->scan_mask & (1 << i)) {
> +		if (ring->scan_mask & (1 << i)) {
>  			/* lower byte */
>  			xfers[j].tx_buf = st->tx + 2*j;
>  			st->tx[2*j] = read_all_tx_array[i*4];
> @@ -251,7 +254,7 @@ static int lis3l02dq_read_all(struct lis3l02dq_state *st, u8 *rx_array)
>  	 * values in alternate bytes
>  	 */
>  	spi_message_init(&msg);
> -	for (j = 0; j < st->help.indio_dev->scan_count * 2; j++)
> +	for (j = 0; j < ring->scan_count * 2; j++)
>  		spi_message_add_tail(&xfers[j], &msg);
>  
>  	ret = spi_sync(st->us, &msg);
> @@ -279,13 +282,13 @@ static int lis3l02dq_get_ring_element(struct iio_sw_ring_helper_state *h,
>  	u8 *rx_array ;
>  	s16 *data = (s16 *)buf;
>  
> -	rx_array = kzalloc(4 * (h->indio_dev->scan_count), GFP_KERNEL);
> +	rx_array = kzalloc(4 * (h->indio_dev->ring->scan_count), GFP_KERNEL);
>  	if (rx_array == NULL)
>  		return -ENOMEM;
>  	ret = lis3l02dq_read_all(lis3l02dq_h_to_s(h), rx_array);
>  	if (ret < 0)
>  		return ret;
> -	for (i = 0; i < h->indio_dev->scan_count; i++)
> +	for (i = 0; i < h->indio_dev->ring->scan_count; i++)
>  		data[i] = combine_8_to_16(rx_array[i*4+1],
>  					rx_array[i*4+3]);
>  	kfree(rx_array);
> @@ -479,28 +482,29 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
>  {
>  	int ret;
>  	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
> -
> +	struct iio_ring_buffer *ring;
>  	INIT_WORK(&h->work_trigger_to_ring, lis3l02dq_trigger_bh_to_ring);
> -	/* Set default scan mode */
>  	h->get_ring_element = &lis3l02dq_get_ring_element;
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
> -	indio_dev->scan_timestamp = true;
> -
> -	indio_dev->scan_el_attrs = &lis3l02dq_scan_el_group;
>  
> -	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
> -	if (!indio_dev->ring)
Personally I'd have done this directly into indio_dev->ring
as it would have reduced the lines changed count and kept
your changes more apparent.  Still doesn't really matter and
not worth respining the patch.
> +	ring = iio_sw_rb_allocate(indio_dev);
> +	if (!ring)
>  		return -ENOMEM;
>  
> +	indio_dev->ring = ring;
>  	/* Effectively select the ring buffer implementation */
> -	iio_ring_sw_register_funcs(&indio_dev->ring->access);
> -	indio_dev->ring->bpe = 2;
> -	indio_dev->ring->preenable = &iio_sw_ring_preenable;
> -	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
> -	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
> -	indio_dev->ring->owner = THIS_MODULE;
> +	iio_ring_sw_register_funcs(&ring->access);
> +	ring->bpe = 2;
> +	ring->scan_el_attrs = &lis3l02dq_scan_el_group;
> +	ring->scan_timestamp = true;
> +	ring->preenable = &iio_sw_ring_preenable;
> +	ring->postenable = &iio_triggered_ring_postenable;
> +	ring->predisable = &iio_triggered_ring_predisable;
> +	ring->owner = THIS_MODULE;
> +
> +	/* Set default scan mode */
> +	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
>  
>  	ret = iio_alloc_pollfunc(indio_dev, NULL, &lis3l02dq_poll_func_th);
>  	if (ret)
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index eff5b9a..6d19d15 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -264,12 +264,12 @@ static inline void sca3000_rb_free(struct iio_ring_buffer *r)
>  
>  int sca3000_configure_ring(struct iio_dev *indio_dev)
>  {
> -	indio_dev->scan_el_attrs = &sca3000_scan_el_group;
>  	indio_dev->ring = sca3000_rb_allocate(indio_dev);
>  	if (indio_dev->ring == NULL)
>  		return -ENOMEM;
>  	indio_dev->modes |= INDIO_RING_HARDWARE_BUFFER;
>  
> +	indio_dev->ring->scan_el_attrs = &sca3000_scan_el_group;
>  	indio_dev->ring->access.rip_lots = &sca3000_rip_hw_rb;
>  	indio_dev->ring->access.get_length = &sca3000_ring_get_length;
>  	indio_dev->ring->access.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum;
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index 6435e50..1dc428f 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -1631,7 +1631,6 @@ static int __devinit max1363_probe(struct i2c_client *client,
>  	st->indio_dev->attrs = st->chip_info->dev_attrs;
>  
>  	/* Todo: this shouldn't be here. */
> -	st->indio_dev->scan_el_attrs = st->chip_info->scan_attrs;
>  	st->indio_dev->dev_data = (void *)(st);
>  	st->indio_dev->driver_module = THIS_MODULE;
>  	st->indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index edac0ba..1d6ce54 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -30,6 +30,7 @@
>  /* Todo: test this */
>  int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
>  {
> +	struct iio_ring_buffer *ring = st->indio_dev->ring;
>  	unsigned long numvals;
>  	int count = 0, ret;
>  	u8 *ring_data;
> @@ -44,8 +45,7 @@ int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> -	ret = st->indio_dev->ring->access.read_last(st->indio_dev->ring,
> -						ring_data);
> +	ret = ring->access.read_last(ring, ring_data);
>  	if (ret)
>  		goto error_free_ring_data;
>  	/* Need a count of channels prior to this one */
> @@ -77,6 +77,7 @@ error_ret:
>  static int max1363_ring_preenable(struct iio_dev *indio_dev)
>  {
>  	struct max1363_state *st = indio_dev->dev_data;
> +	struct iio_ring_buffer *ring = indio_dev->ring;
>  	size_t d_size;
>  	unsigned long numvals;
>  
> @@ -84,7 +85,7 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
>  	 * Need to figure out the current mode based upon the requested
>  	 * scan mask in iio_dev
>  	 */
> -	st->current_mode = max1363_match_mode(st->indio_dev->scan_mask,
> +	st->current_mode = max1363_match_mode(ring->scan_mask,
>  					st->chip_info);
>  	if (!st->current_mode)
>  		return -EINVAL;
> @@ -92,14 +93,14 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
>  	max1363_set_scan_mode(st);
>  
>  	numvals = hweight_long(st->current_mode->modemask);
> -	if (indio_dev->ring->access.set_bytes_per_datum) {
> +	if (ring->access.set_bytes_per_datum) {
>  		if (st->chip_info->bits != 8)
>  			d_size = numvals*2 + sizeof(s64);
>  		else
>  			d_size = numvals + sizeof(s64);
>  		if (d_size % 8)
>  			d_size += 8 - (d_size % 8);
> -		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring, d_size);
> +		ring->access.set_bytes_per_datum(ring, d_size);
>  	}
>  
>  	return 0;
> @@ -135,7 +136,7 @@ static void max1363_poll_bh_to_ring(struct work_struct *work_s)
>  	struct max1363_state *st = container_of(work_s, struct max1363_state,
>  						  poll_work);
>  	struct iio_dev *indio_dev = st->indio_dev;
> -	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(indio_dev->ring);
> +	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
>  	s64 time_ns;
>  	__u8 *rxbuf;
>  	int b_sent;
> @@ -175,7 +176,7 @@ static void max1363_poll_bh_to_ring(struct work_struct *work_s)
>  
>  	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
>  
> -	indio_dev->ring->access.store_to(&ring->buf, rxbuf, time_ns);
> +	indio_dev->ring->access.store_to(&sw_ring->buf, rxbuf, time_ns);
>  done:
>  	kfree(rxbuf);
>  	atomic_dec(&st->protect_ring);
> @@ -193,12 +194,13 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  		goto error_ret;
>  	}
>  	/* Effectively select the ring buffer implementation */
> -	iio_ring_sw_register_funcs(&st->indio_dev->ring->access);
> +	iio_ring_sw_register_funcs(&indio_dev->ring->access);
>  	ret = iio_alloc_pollfunc(indio_dev, NULL, &max1363_poll_func_th);
>  	if (ret)
>  		goto error_deallocate_sw_rb;
>  
>  	/* Ring buffer functions - here trigger setup related */
> +	indio_dev->ring->scan_el_attrs = st->chip_info->scan_attrs;
>  	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
>  	indio_dev->ring->preenable = &max1363_ring_preenable;
>  	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
> index 055d5e8..0334860 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -110,11 +110,11 @@ static void adis16260_trigger_bh_to_ring(struct work_struct *work_s)
>  	struct adis16260_state *st
>  		= container_of(work_s, struct adis16260_state,
>  				work_trigger_to_ring);
> +	struct iio_ring_buffer *ring = st->indio_dev->ring;
>  
>  	int i = 0;
>  	s16 *data;
> -	size_t datasize = st->indio_dev
> -		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
> +	size_t datasize = ring->access.get_bytes_per_datum(ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> @@ -122,17 +122,17 @@ static void adis16260_trigger_bh_to_ring(struct work_struct *work_s)
>  		return;
>  	}
>  
> -	if (st->indio_dev->scan_count)
> +	if (ring->scan_count)
>  		if (adis16260_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
> -			for (; i < st->indio_dev->scan_count; i++)
> +			for (; i < ring->scan_count; i++)
>  				data[i] = be16_to_cpup(
>  					(__be16 *)&(st->rx[i*2]));
>  
>  	/* Guaranteed to be aligned with 8 byte boundary */
> -	if (st->indio_dev->scan_timestamp)
> +	if (ring->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>  
> -	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> +	ring->access.store_to(ring,
>  			(u8 *)data,
>  			st->last_timestamp);
>  
> @@ -154,16 +154,6 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
>  	struct adis16260_state *st = indio_dev->dev_data;
>  	struct iio_ring_buffer *ring;
>  	INIT_WORK(&st->work_trigger_to_ring, adis16260_trigger_bh_to_ring);
> -	/* Set default scan mode */
> -
> -	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_gyro.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_aux_adc.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_angl.number);
> -	indio_dev->scan_timestamp = true;
> -
> -	indio_dev->scan_el_attrs = &adis16260_scan_el_group;
>  
>  	ring = iio_sw_rb_allocate(indio_dev);
>  	if (!ring) {
> @@ -174,11 +164,20 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
>  	/* Effectively select the ring buffer implementation */
>  	iio_ring_sw_register_funcs(&ring->access);
>  	ring->bpe = 2;
> +	ring->scan_el_attrs = &adis16260_scan_el_group;
> +	ring->scan_timestamp = true;
>  	ring->preenable = &iio_sw_ring_preenable;
>  	ring->postenable = &iio_triggered_ring_postenable;
>  	ring->predisable = &iio_triggered_ring_predisable;
>  	ring->owner = THIS_MODULE;
>  
> +	/* Set default scan mode */
> +	iio_scan_mask_set(ring, iio_scan_el_supply.number);
> +	iio_scan_mask_set(ring, iio_scan_el_gyro.number);
> +	iio_scan_mask_set(ring, iio_scan_el_aux_adc.number);
> +	iio_scan_mask_set(ring, iio_scan_el_temp.number);
> +	iio_scan_mask_set(ring, iio_scan_el_angl.number);
> +
>  	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16260_poll_func_th);
>  	if (ret)
>  		goto error_iio_sw_rb_free;
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 9d0ca12..3a4e8c3 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -87,15 +87,10 @@ void iio_remove_event_from_list(struct iio_event_handler_list *el,
>   * @event_attrs:	[DRIVER] event control attributes
>   * @event_conf_attrs:	[DRIVER] event configuration attributes
>   * @event_interfaces:	[INTERN] event chrdevs associated with interrupt lines
> + * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
>   * @ring:		[DRIVER] any ring buffer present
>   * @mlock:		[INTERN] lock used to prevent simultaneous device state
>   *			changes
> - * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
> - *			control method is used
> - * @scan_count:	[INTERN] the number of elements in the current scan mode
> - * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
> - * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
> - * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
>   * @trig:		[INTERN] current device trigger (ring buffer modes)
>   * @pollfunc:		[DRIVER] function run on trigger being recieved
>   **/
> @@ -115,107 +110,14 @@ struct iio_dev {
>  
>  	struct iio_event_interface	*event_interfaces;
>  
Why move this element?
> +	u32				*available_scan_masks;
>  	struct iio_ring_buffer		*ring;
>  	struct mutex			mlock;
>  
> -	struct attribute_group		*scan_el_attrs;
> -	int				scan_count;
> -
> -	u32				scan_mask;
> -	u32				*available_scan_masks;
> -	bool				scan_timestamp;
>  	struct iio_trigger		*trig;
>  	struct iio_poll_func		*pollfunc;
>  };
>  
> -/*
> - * These are mainly provided to allow for a change of implementation if a device
> - * has a large number of scan elements
> - */
> -#define IIO_MAX_SCAN_LENGTH 31
> -
> -/* note 0 used as error indicator as it doesn't make sense. */
> -static inline u32 iio_scan_mask_match(u32 *av_masks, u32 mask)
> -{
> -	while (*av_masks) {
> -		if (!(~*av_masks & mask))
> -			return *av_masks;
> -		av_masks++;
> -	}
> -	return 0;
> -}
> -
> -static inline int iio_scan_mask_query(struct iio_dev *dev_info, int bit)
> -{
> -	u32 mask;
> -
> -	if (bit > IIO_MAX_SCAN_LENGTH)
> -		return -EINVAL;
> -
> -	if (!dev_info->scan_mask)
> -		return 0;
> -
> -	if (dev_info->available_scan_masks)
> -		mask = iio_scan_mask_match(dev_info->available_scan_masks,
> -					dev_info->scan_mask);
> -	else
> -		mask = dev_info->scan_mask;
> -
> -	if (!mask)
> -		return -EINVAL;
> -
> -	return !!(mask & (1 << bit));
> -};
> -
> -static inline int iio_scan_mask_set(struct iio_dev *dev_info, int bit)
> -{
> -	u32 mask;
> -	u32 trialmask = dev_info->scan_mask | (1 << bit);
> -
> -	if (bit > IIO_MAX_SCAN_LENGTH)
> -		return -EINVAL;
> -	if (dev_info->available_scan_masks) {
> -		mask = iio_scan_mask_match(dev_info->available_scan_masks,
> -					trialmask);
> -		if (!mask)
> -			return -EINVAL;
> -	}
> -	dev_info->scan_mask = trialmask;
> -	dev_info->scan_count++;
> -
> -	return 0;
> -};
> -
> -static inline int iio_scan_mask_clear(struct iio_dev *dev_info, int bit)
> -{
> -	if (bit > IIO_MAX_SCAN_LENGTH)
> -		return -EINVAL;
> -	dev_info->scan_mask &= ~(1 << bit);
> -	dev_info->scan_count--;
> -	return 0;
> -};
> -
> -/**
> - * iio_scan_mask_count_to_right() - how many scan elements occur before here
> - * @dev_info: the iio_device whose scan mode we are querying
> - * @bit: which number scan element is this
> - **/
> -static inline int iio_scan_mask_count_to_right(struct iio_dev *dev_info,
> -						int bit)
> -{
> -	int count = 0;
> -	int mask = (1 << bit);
> -	if (bit > IIO_MAX_SCAN_LENGTH)
> -		return -EINVAL;
> -	while (mask) {
> -		mask >>= 1;
> -		if (mask & dev_info->scan_mask)
> -			count++;
> -	}
> -
> -	return count;
> -}
> -
>  /**
>   * iio_device_register() - register a device with the IIO subsystem
>   * @dev_info:		Device structure filled by the device driver
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
> index 854183c..742cad6 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -134,11 +134,11 @@ static void adis16300_trigger_bh_to_ring(struct work_struct *work_s)
>  	struct adis16300_state *st
>  		= container_of(work_s, struct adis16300_state,
>  			       work_trigger_to_ring);
> +	struct iio_ring_buffer *ring = st->indio_dev->ring;
>  
>  	int i = 0;
>  	s16 *data;
> -	size_t datasize = st->indio_dev
> -		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
> +	size_t datasize = ring->access.get_bytes_per_datum(ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> @@ -146,19 +146,19 @@ static void adis16300_trigger_bh_to_ring(struct work_struct *work_s)
>  		return;
>  	}
>  
> -	if (st->indio_dev->scan_count)
> +	if (ring->scan_count)
>  		if (adis16300_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
> -			for (; i < st->indio_dev->scan_count; i++)
> +			for (; i < ring->scan_count; i++)
>  				data[i] = be16_to_cpup(
>  					(__be16 *)&(st->rx[i*2]));
>  
>  	/* Guaranteed to be aligned with 8 byte boundary */
> -	if (st->indio_dev->scan_timestamp)
> +	if (ring->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>  
> -	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> -					    (u8 *)data,
> -					    st->last_timestamp);
> +	ring->access.store_to(ring,
> +			(u8 *)data,
> +			st->last_timestamp);
>  
>  	iio_trigger_notify_done(st->indio_dev->trig);
>  	kfree(data);
> @@ -178,20 +178,6 @@ int adis16300_configure_ring(struct iio_dev *indio_dev)
>  	struct adis16300_state *st = indio_dev->dev_data;
>  	struct iio_ring_buffer *ring;
>  	INIT_WORK(&st->work_trigger_to_ring, adis16300_trigger_bh_to_ring);
> -	/* Set default scan mode */
> -
> -	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_adc_0.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_incli_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_incli_y.number);
> -	indio_dev->scan_timestamp = true;
> -
> -	indio_dev->scan_el_attrs = &adis16300_scan_el_group;
>  
>  	ring = iio_sw_rb_allocate(indio_dev);
>  	if (!ring) {
> @@ -202,11 +188,24 @@ int adis16300_configure_ring(struct iio_dev *indio_dev)
>  	/* Effectively select the ring buffer implementation */
>  	iio_ring_sw_register_funcs(&ring->access);
>  	ring->bpe = 2;
> +	ring->scan_el_attrs = &adis16300_scan_el_group;
> +	ring->scan_timestamp = true;
>  	ring->preenable = &iio_sw_ring_preenable;
>  	ring->postenable = &iio_triggered_ring_postenable;
>  	ring->predisable = &iio_triggered_ring_predisable;
>  	ring->owner = THIS_MODULE;
>  
> +	/* Set default scan mode */
> +	iio_scan_mask_set(ring, iio_scan_el_supply.number);
> +	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
> +	iio_scan_mask_set(ring, iio_scan_el_temp.number);
> +	iio_scan_mask_set(ring, iio_scan_el_adc_0.number);
> +	iio_scan_mask_set(ring, iio_scan_el_incli_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_incli_y.number);
> +
>  	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16300_poll_func_th);
>  	if (ret)
>  		goto error_iio_sw_rb_free;
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
> index 9620cbe..a0b80e4 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -134,11 +134,11 @@ static void adis16350_trigger_bh_to_ring(struct work_struct *work_s)
>  	struct adis16350_state *st
>  		= container_of(work_s, struct adis16350_state,
>  			       work_trigger_to_ring);
> +	struct iio_ring_buffer *ring = st->indio_dev->ring;
>  
>  	int i = 0;
>  	s16 *data;
> -	size_t datasize = st->indio_dev
> -		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
> +	size_t datasize = ring->access.get_bytes_per_datum(ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> @@ -146,19 +146,19 @@ static void adis16350_trigger_bh_to_ring(struct work_struct *work_s)
>  		return;
>  	}
>  
> -	if (st->indio_dev->scan_count)
> +	if (ring->scan_count)
>  		if (adis16350_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
> -			for (; i < st->indio_dev->scan_count; i++)
> +			for (; i < ring->scan_count; i++)
>  				data[i] = be16_to_cpup(
>  					(__be16 *)&(st->rx[i*2]));
>  
>  	/* Guaranteed to be aligned with 8 byte boundary */
> -	if (st->indio_dev->scan_timestamp)
> +	if (ring->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>  
> -	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> -					    (u8 *)data,
> -					    st->last_timestamp);
> +	ring->access.store_to(ring,
> +			(u8 *)data,
> +			st->last_timestamp);
>  
>  	iio_trigger_notify_done(st->indio_dev->trig);
>  	kfree(data);
> @@ -178,22 +178,6 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
>  	struct adis16350_state *st = indio_dev->dev_data;
>  	struct iio_ring_buffer *ring;
>  	INIT_WORK(&st->work_trigger_to_ring, adis16350_trigger_bh_to_ring);
> -	/* Set default scan mode */
> -
> -	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_z.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_temp_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_temp_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_temp_z.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_adc_0.number);
> -	indio_dev->scan_timestamp = true;
> -
> -	indio_dev->scan_el_attrs = &adis16350_scan_el_group;
>  
>  	ring = iio_sw_rb_allocate(indio_dev);
>  	if (!ring) {
> @@ -204,11 +188,26 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
>  	/* Effectively select the ring buffer implementation */
>  	iio_ring_sw_register_funcs(&ring->access);
>  	ring->bpe = 2;
> +	ring->scan_el_attrs = &adis16350_scan_el_group;
> +	ring->scan_timestamp = true;
>  	ring->preenable = &iio_sw_ring_preenable;
>  	ring->postenable = &iio_triggered_ring_postenable;
>  	ring->predisable = &iio_triggered_ring_predisable;
>  	ring->owner = THIS_MODULE;
>  
> +	/* Set default scan mode */
> +	iio_scan_mask_set(ring, iio_scan_el_supply.number);
> +	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_gyro_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_gyro_z.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
> +	iio_scan_mask_set(ring, iio_scan_el_temp_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_temp_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_temp_z.number);
> +	iio_scan_mask_set(ring, iio_scan_el_adc_0.number);
> +
>  	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16350_poll_func_th);
>  	if (ret)
>  		goto error_iio_sw_rb_free;
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
> index c8e2316..667f77b 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -143,11 +143,11 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
>  	struct adis16400_state *st
>  		= container_of(work_s, struct adis16400_state,
>  			       work_trigger_to_ring);
> +	struct iio_ring_buffer *ring = st->indio_dev->ring;
>  
>  	int i = 0;
>  	s16 *data;
> -	size_t datasize = st->indio_dev
> -		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
> +	size_t datasize = ring->access.get_bytes_per_datum(ring);
>  
>  	data = kmalloc(datasize , GFP_KERNEL);
>  	if (data == NULL) {
> @@ -155,19 +155,19 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
>  		return;
>  	}
>  
> -	if (st->indio_dev->scan_count)
> +	if (ring->scan_count)
>  		if (adis16400_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
> -			for (; i < st->indio_dev->scan_count; i++)
> +			for (; i < ring->scan_count; i++)
>  				data[i]	= be16_to_cpup(
>  					(__be16 *)&(st->rx[i*2]));
>  
>  	/* Guaranteed to be aligned with 8 byte boundary */
> -	if (st->indio_dev->scan_timestamp)
> +	if (ring->scan_timestamp)
>  		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>  
> -	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> -					    (u8 *)data,
> -					    st->last_timestamp);
> +	ring->access.store_to(ring,
> +			(u8 *) data,
> +			st->last_timestamp);
>  
>  	iio_trigger_notify_done(st->indio_dev->trig);
>  	kfree(data);
> @@ -187,23 +187,6 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
>  	struct adis16400_state *st = indio_dev->dev_data;
>  	struct iio_ring_buffer *ring;
>  	INIT_WORK(&st->work_trigger_to_ring, adis16400_trigger_bh_to_ring);
> -	/* Set default scan mode */
> -
> -	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_gyro_z.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_magn_x.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_magn_y.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_magn_z.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
> -	iio_scan_mask_set(indio_dev, iio_scan_el_adc_0.number);
> -	indio_dev->scan_timestamp = true;
> -
> -	indio_dev->scan_el_attrs = &adis16400_scan_el_group;
>  
>  	ring = iio_sw_rb_allocate(indio_dev);
>  	if (!ring) {
> @@ -214,11 +197,27 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
>  	/* Effectively select the ring buffer implementation */
>  	iio_ring_sw_register_funcs(&ring->access);
>  	ring->bpe = 2;
> +	ring->scan_el_attrs = &adis16400_scan_el_group;
> +	ring->scan_timestamp = true;
>  	ring->preenable = &iio_sw_ring_preenable;
>  	ring->postenable = &iio_triggered_ring_postenable;
>  	ring->predisable = &iio_triggered_ring_predisable;
>  	ring->owner = THIS_MODULE;
>  
> +	/* Set default scan mode */
> +	iio_scan_mask_set(ring, iio_scan_el_supply.number);
> +	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_gyro_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_gyro_z.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
> +	iio_scan_mask_set(ring, iio_scan_el_magn_x.number);
> +	iio_scan_mask_set(ring, iio_scan_el_magn_y.number);
> +	iio_scan_mask_set(ring, iio_scan_el_magn_z.number);
> +	iio_scan_mask_set(ring, iio_scan_el_temp.number);
> +	iio_scan_mask_set(ring, iio_scan_el_adc_0.number);
> +
>  	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16400_poll_func_th);
>  	if (ret)
>  		goto error_iio_sw_rb_free;
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index dd4d87a..5c0e56a 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -507,24 +507,12 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
>  		goto error_ret;
>  	}
>  
> -	if (dev_info->scan_el_attrs) {
> -		ret = sysfs_create_group(&dev_info->dev.kobj,
> -					 dev_info->scan_el_attrs);
> -		if (ret)
> -			dev_err(&dev_info->dev,
> -				"Failed to add sysfs scan els\n");
> -	}
> -
>  error_ret:
>  	return ret;
>  }
>  
>  static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
>  {
> -	if (dev_info->scan_el_attrs)
> -		sysfs_remove_group(&dev_info->dev.kobj,
> -				   dev_info->scan_el_attrs);
> -
>  	sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
>  }
>  
> diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
> index 610c2b6..148ca5c 100644
> --- a/drivers/staging/iio/industrialio-ring.c
> +++ b/drivers/staging/iio/industrialio-ring.c
> @@ -279,6 +279,16 @@ int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
>  	if (ret)
>  		goto error_free_ring_buffer_event_chrdev;
>  
> +	if (ring->scan_el_attrs) {
> +		ret = sysfs_create_group(&ring->dev.kobj,
> +					 ring->scan_el_attrs);
> +		if (ret) {
> +			dev_err(&ring->dev,
> +				"Failed to add sysfs scan elements\n");
> +			goto error_free_ring_buffer_event_chrdev;
> +		}
> +	}
> +
>  	return ret;
>  error_free_ring_buffer_event_chrdev:
>  	__iio_free_ring_buffer_event_chrdev(ring);
> @@ -291,6 +301,10 @@ EXPORT_SYMBOL(iio_ring_buffer_register);
>  
>  void iio_ring_buffer_unregister(struct iio_ring_buffer *ring)
>  {
> +	if (ring->scan_el_attrs)
> +		sysfs_remove_group(&ring->dev.kobj,
> +				   ring->scan_el_attrs);
> +
>  	__iio_free_ring_buffer_access_chrdev(ring);
>  	__iio_free_ring_buffer_event_chrdev(ring);
>  	device_del(&ring->dev);
> @@ -468,7 +482,7 @@ ssize_t iio_scan_el_show(struct device *dev,
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct iio_scan_el *this_el = to_iio_scan_el(attr);
>  
> -	ret = iio_scan_mask_query(indio_dev, this_el->number);
> +	ret = iio_scan_mask_query(indio_dev->ring, this_el->number);
>  	if (ret < 0)
>  		return ret;
>  	return sprintf(buf, "%d\n", ret);
> @@ -491,19 +505,17 @@ ssize_t iio_scan_el_store(struct device *dev,
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> -	ret = iio_scan_mask_query(indio_dev, this_el->number);
> +	ret = iio_scan_mask_query(indio_dev->ring, this_el->number);
>  	if (ret < 0)
>  		goto error_ret;
>  	if (!state && ret) {
> -		ret = iio_scan_mask_clear(indio_dev, this_el->number);
> +		ret = iio_scan_mask_clear(indio_dev->ring, this_el->number);
>  		if (ret)
>  			goto error_ret;
> -		indio_dev->scan_count--;
>  	} else if (state && !ret) {
> -		ret = iio_scan_mask_set(indio_dev, this_el->number);
> +		ret = iio_scan_mask_set(indio_dev->ring, this_el->number);
>  		if (ret)
>  			goto error_ret;
> -		indio_dev->scan_count++;
>  	}
>  	if (this_el->set_state)
>  		ret = this_el->set_state(this_el, indio_dev, state);
> @@ -520,7 +532,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev,
>  			    char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	return sprintf(buf, "%d\n", indio_dev->scan_timestamp);
> +	return sprintf(buf, "%d\n", indio_dev->ring->scan_timestamp);
>  }
>  EXPORT_SYMBOL(iio_scan_el_ts_show);
>  
> @@ -538,7 +550,7 @@ ssize_t iio_scan_el_ts_store(struct device *dev,
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> -	indio_dev->scan_timestamp = state;
> +	indio_dev->ring->scan_timestamp = state;
>  error_ret:
>  	mutex_unlock(&indio_dev->mlock);
>  
> diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
> index ac017b1..6124353 100644
> --- a/drivers/staging/iio/ring_generic.h
> +++ b/drivers/staging/iio/ring_generic.h
> @@ -102,6 +102,11 @@ struct iio_ring_access_funcs {
>   * @bytes_per_datum	[DEVICE] size of individual datum including timestamp
>   * @bpe:		[DEVICE] size of individual channel value
>   * @loopcount:		[INTERN] number of times the ring has looped
> + * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
> + *			control method is used
> + * @scan_count:	[INTERN] the number of elements in the current scan mode
> + * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
> + * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
>   * @access_handler:	[INTERN] chrdev access handling
>   * @ev_int:		[INTERN] chrdev interface for the event chrdev
>   * @shared_ev_pointer:	[INTERN] the shared event pointer to allow escalation of
> @@ -124,6 +129,10 @@ struct iio_ring_buffer {
>  	int				bytes_per_datum;
>  	int				bpe;
>  	int				loopcount;
> +	struct attribute_group		*scan_el_attrs;
> +	int				scan_count;
> +	u32				scan_mask;
> +	bool				scan_timestamp;
>  	struct iio_handler		access_handler;
>  	struct iio_event_interface	ev_int;
>  	struct iio_shared_ev_pointer	shared_ev_pointer;
> @@ -258,6 +267,97 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
>  				   iio_scan_el_ts_store),	\
>  	}
>  
> +/*
> + * These are mainly provided to allow for a change of implementation if a device
> + * has a large number of scan elements
> + */
> +#define IIO_MAX_SCAN_LENGTH 31
> +
> +/* note 0 used as error indicator as it doesn't make sense. */
> +static inline u32 iio_scan_mask_match(u32 *av_masks, u32 mask)
> +{
> +	while (*av_masks) {
> +		if (!(~*av_masks & mask))
> +			return *av_masks;
> +		av_masks++;
> +	}
> +	return 0;
> +}
> +
> +static inline int iio_scan_mask_query(struct iio_ring_buffer *ring, int bit)
> +{
> +	struct iio_dev *dev_info = ring->indio_dev;
> +	u32 mask;
> +
> +	if (bit > IIO_MAX_SCAN_LENGTH)
> +		return -EINVAL;
> +
> +	if (!ring->scan_mask)
> +		return 0;
> +
> +	if (dev_info->available_scan_masks)
> +		mask = iio_scan_mask_match(dev_info->available_scan_masks,
> +					ring->scan_mask);
> +	else
> +		mask = ring->scan_mask;
> +
> +	if (!mask)
> +		return -EINVAL;
> +
> +	return !!(mask & (1 << bit));
> +};
> +
> +static inline int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit)
> +{
> +	struct iio_dev *dev_info = ring->indio_dev;
> +	u32 mask;
> +	u32 trialmask = ring->scan_mask | (1 << bit);
> +
> +	if (bit > IIO_MAX_SCAN_LENGTH)
> +		return -EINVAL;
> +	if (dev_info->available_scan_masks) {
> +		mask = iio_scan_mask_match(dev_info->available_scan_masks,
> +					trialmask);
> +		if (!mask)
> +			return -EINVAL;
> +	}
> +	ring->scan_mask = trialmask;
> +	ring->scan_count++;
> +
> +	return 0;
> +};
> +
> +static inline int iio_scan_mask_clear(struct iio_ring_buffer *ring, int bit)
> +{
> +	if (bit > IIO_MAX_SCAN_LENGTH)
> +		return -EINVAL;
> +	ring->scan_mask &= ~(1 << bit);
> +	ring->scan_count--;
> +	return 0;
> +};
> +
> +/**
> + * iio_scan_mask_count_to_right() - how many scan elements occur before here
> + * @dev_info: the iio_device whose scan mode we are querying
> + * @bit: which number scan element is this
> + **/
> +static inline int iio_scan_mask_count_to_right(struct iio_ring_buffer *ring,
> +						int bit)
> +{
> +	int count = 0;
> +	int mask = (1 << bit);
> +	if (bit > IIO_MAX_SCAN_LENGTH)
> +		return -EINVAL;
> +	while (mask) {
> +		mask >>= 1;
> +		if (mask & ring->scan_mask)
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
> +
>  static inline void iio_put_ring_buffer(struct iio_ring_buffer *ring)
>  {
>  	put_device(&ring->dev);
> diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
> index 99efb6b..52624ac 100644
> --- a/drivers/staging/iio/ring_sw.c
> +++ b/drivers/staging/iio/ring_sw.c
> @@ -435,23 +435,24 @@ EXPORT_SYMBOL(iio_sw_rb_free);
>  
>  int iio_sw_ring_preenable(struct iio_dev *indio_dev)
>  {
> +	struct iio_ring_buffer *ring = indio_dev->ring;
>  	size_t size;
>  	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>  	/* Check if there are any scan elements enabled, if not fail*/
> -	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
> +	if (!(ring->scan_count || ring->scan_timestamp))
>  		return -EINVAL;
> -	if (indio_dev->scan_timestamp)
> -		if (indio_dev->scan_count)
> +	if (ring->scan_timestamp)
> +		if (ring->scan_count)
>  			/* Timestamp (aligned to s64) and data */
> -			size = (((indio_dev->scan_count * indio_dev->ring->bpe)
> +			size = (((ring->scan_count * ring->bpe)
>  					+ sizeof(s64) - 1)
>  				& ~(sizeof(s64) - 1))
>  				+ sizeof(s64);
>  		else /* Timestamp only  */
>  			size = sizeof(s64);
>  	else /* Data only */
> -		size = indio_dev->scan_count * indio_dev->ring->bpe;
> -	indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring, size);
> +		size = ring->scan_count * ring->bpe;
> +	ring->access.set_bytes_per_datum(ring, size);
>  
>  	return 0;
>  }
> @@ -462,9 +463,9 @@ void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
>  	struct iio_sw_ring_helper_state *st
>  		= container_of(work_s, struct iio_sw_ring_helper_state,
>  			work_trigger_to_ring);
> +	struct iio_ring_buffer *ring = st->indio_dev->ring;
>  	int len = 0;
> -	size_t datasize = st->indio_dev
> -		->ring->access.get_bytes_per_datum(st->indio_dev->ring);
> +	size_t datasize = ring->access.get_bytes_per_datum(ring);
>  	char *data = kmalloc(datasize, GFP_KERNEL);
>  
>  	if (data == NULL) {
> @@ -473,16 +474,16 @@ void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
>  		return;
>  	}
>  
> -	if (st->indio_dev->scan_count)
> +	if (ring->scan_count)
>  		len = st->get_ring_element(st, data);
>  
>  	  /* Guaranteed to be aligned with 8 byte boundary */
> -	if (st->indio_dev->scan_timestamp)
> +	if (ring->scan_timestamp)
>  		*(s64 *)(((phys_addr_t)data + len
>  				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
>  			= st->last_timestamp;
> -	  st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> -					(u8 *)data,
> +	ring->access.store_to(ring,
> +			(u8 *)data,
>  			st->last_timestamp);
>  
>  	iio_trigger_notify_done(st->indio_dev->trig);

