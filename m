Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56215 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab2FILQ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jun 2012 07:16:56 -0400
Message-ID: <4FD33EC3.3010505@kernel.org>
Date: Sat, 09 Jun 2012 13:17:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio: Add support for multiple buffers
References: <1338406594-14550-1-git-send-email-jic23@kernel.org> <1338406594-14550-2-git-send-email-jic23@kernel.org> <4FD216B2.7080504@metafoo.de>
In-Reply-To: <4FD216B2.7080504@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/08/2012 04:13 PM, Lars-Peter Clausen wrote:
> On 05/30/2012 09:36 PM, Jonathan Cameron wrote:
>> Route all buffer writes through the demux.
>> Addition or removal of a buffer results in tear down and
>> setup of all the buffers for a given device.
>>
>=20
> My test platform is currently broken in staging-next, so just some co=
mments
> based on code review for now.
Annoying when that happens!

Thanks for taking a look.  This codes now been sitting around
long enough that I'm not entirely sure what some of it does myself...
>=20
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/iio/industrialio-buffer.c               |  335 ++++++++++++=
+++--------
>>  drivers/iio/industrialio-core.c                 |    1 +
>>  drivers/staging/iio/accel/adis16201_ring.c      |    4 +-
>>  drivers/staging/iio/accel/adis16203_ring.c      |    6 +-
>>  drivers/staging/iio/accel/adis16204_ring.c      |    3 +-
>>  drivers/staging/iio/accel/adis16209_ring.c      |    3 +-
>>  drivers/staging/iio/accel/adis16240_ring.c      |    4 +-
>>  drivers/staging/iio/accel/lis3l02dq_ring.c      |    3 +-
>>  drivers/staging/iio/adc/ad7192.c                |    3 +-
>>  drivers/staging/iio/adc/ad7298_ring.c           |    5 +-
>>  drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
>>  drivers/staging/iio/adc/ad7606_ring.c           |    3 +-
>>  drivers/staging/iio/adc/ad7793.c                |    3 +-
>>  drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
>>  drivers/staging/iio/adc/ad799x_ring.c           |    3 +-
>>  drivers/staging/iio/adc/max1363_ring.c          |    2 +-
>>  drivers/staging/iio/gyro/adis16260_ring.c       |    3 +-
>>  drivers/staging/iio/iio_simple_dummy_buffer.c   |    5 +-
>>  drivers/staging/iio/impedance-analyzer/ad5933.c |    3 +-
>>  drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
>>  drivers/staging/iio/meter/ade7758_ring.c        |    3 +-
>>  include/linux/iio/buffer.h                      |   24 +-
>>  include/linux/iio/iio.h                         |    2 +
>=20
> The at91_adc driver is not handled by this patch
good point. oops.  Darn these new drivers ;)
>=20
>>  23 files changed, 267 insertions(+), 157 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industr=
ialio-buffer.c
>> index ac185b8..b04b543 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -31,6 +31,16 @@ static const char * const iio_endian_prefix[] =3D=
 {
>>  	[IIO_LE] =3D "le",
>>  };
>> =20
>> +static bool iio_buffer_is_primary_active(struct iio_dev *indio_dev)
>> +{
>> +	struct list_head *p;
>> +
>> +	list_for_each(p, &indio_dev->buffer_list)
>> +		if (p =3D=3D &indio_dev->buffer->buffer_list)
>> +			return true;
>=20
> More or less the same code is used below. I think it makes sense to h=
ave a
> generic iio_buffer_is_active(indio_dev, buffer)
Good point.
>=20
>> +	return false;
>> +}
>=20
>> [...]
>> @@ -534,31 +453,186 @@ static int iio_compute_scan_bytes(struct iio_=
dev *indio_dev, const long *mask,
>>  	return bytes;
>>  }
>> =20
>> -int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>> +int iio_update_buffers(struct iio_dev *indio_dev,
>> +		       struct iio_buffer *insert_buffer,
>> +		       struct iio_buffer *remove_buffer)
>>  {
>> -	struct iio_buffer *buffer =3D indio_dev->buffer;
>> -	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> +	int ret;
>=20
> drivers/iio/industrialio-buffer.c: In function =91iio_update_buffers=92=
:
> drivers/iio/industrialio-buffer.c:460: warning: =91ret=92 may be used
> uninitialized in this function
>=20
> I think there a missing 'return 0', before the error handling. Right =
now the
> code always sets active_scan_mask to NULL.
The setting to NULL definitely isn't right, but we do still need to
free the compoundmask.  I'll fix that up.
>=20
>=20
>> +	struct iio_buffer *buffer;
>> +	unsigned long *compound_mask;
>> =20
>> -	/* How much space will the demuxed element take? */
>> -	indio_dev->scan_bytes =3D
>> -		iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
>> -				       buffer->scan_timestamp);
>> -	buffer->access->set_bytes_per_datum(buffer, indio_dev->scan_bytes)=
;
>> +	/* Wind down existing buffers - iff there are any */
>> +	if (!list_empty(&indio_dev->buffer_list)) {
>> +		if (indio_dev->setup_ops->predisable) {
>> +			ret =3D indio_dev->setup_ops->predisable(indio_dev);
>> +			if (ret)
>> +				goto error_ret;
>> +		}
>> +		indio_dev->currentmode =3D INDIO_DIRECT_MODE;
>> +		if (indio_dev->setup_ops->postdisable) {
>> +			ret =3D indio_dev->setup_ops->postdisable(indio_dev);
>> +			if (ret)
>> +				goto error_ret;
>> +		}
>> +	}
>> +	if (!indio_dev->available_scan_masks)
>> +		kfree(indio_dev->active_scan_mask);
>=20
> If the code errors out before reassigning active_scan_mask we'll leav=
e a
> dangling pointer to the old scan mask, which will cause access after =
free or
> a double free.
good point this needs to be set to NULL.
>=20
>> +
>> +	if (insert_buffer)
>> +		list_add(&insert_buffer->buffer_list, &indio_dev->buffer_list);
>> +	if (remove_buffer)
>> +		list_del(&remove_buffer->buffer_list);
>=20
> I'd do the remove before the insert, makes this more robust, if the f=
unction
> is ever going to be called with both set to the same buffer.
Tempting as it is to take the view we should crash hard if anyone does
that you are right of course ;)
>=20
>> +
>> +	/* If no buffers in list, we are done */
>> +	if (list_empty(&indio_dev->buffer_list))
>> +		return 0;
>> =20
>>  	/* What scan mask do we actually have ?*/
>> +	compound_mask =3D kzalloc(BITS_TO_LONGS(indio_dev->masklength)
>> +				*sizeof(long), GFP_KERNEL);
>> +	if (compound_mask =3D=3D NULL)
>> +		return -ENOMEM;
>> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) =
{
>> +		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
>> +			  indio_dev->masklength);
>> +		indio_dev->scan_timestamp |=3D buffer->scan_timestamp;
>> +	}
>>  	if (indio_dev->available_scan_masks)
>>  		indio_dev->active_scan_mask =3D
>>  			iio_scan_mask_match(indio_dev->available_scan_masks,
>>  					    indio_dev->masklength,
>> -					    buffer->scan_mask);
>> +					    compound_mask);
>=20
> active_scan_mask may be NULL if the device isn't able to handle the c=
ompound
> mask.
>=20
> Btw. if it is not possible to add the new buffer to the list, e.g. be=
cause
> the compound scan mask is not supported, do we to do a rollback to th=
e
> previous working configuration? I think this might be a better option=
,
> rather than leaving things broken.
hmm.. Indeed, that is a good idea...  Adds a bit of complexity, but not
too bad.
>=20
>>  	else
>> -		indio_dev->active_scan_mask =3D buffer->scan_mask;
>> +		indio_dev->active_scan_mask =3D compound_mask;
>> +
>>  	iio_update_demux(indio_dev);
>> =20
>> -	if (indio_dev->info->update_scan_mode)
>> -		return indio_dev->info
>> +	/* Wind up again */
>> +	if (indio_dev->setup_ops->preenable) {
>> +		ret =3D indio_dev->setup_ops->preenable(indio_dev);
>> +		if (ret) {
>> +			printk(KERN_ERR
>> +			       "Buffer not started:"
>> +			       "buffer preenable failed\n");
>> +			goto error_free_compound_mask;
>> +		}
>> +	}
>> +	indio_dev->scan_bytes =3D
>> +		iio_compute_scan_bytes(indio_dev,
>> +				       indio_dev->active_scan_mask,
>> +				       indio_dev->scan_timestamp);
>> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
>> +		if (buffer->access->request_update) {
>> +			ret =3D buffer->access->request_update(buffer);
>> +			if (ret) {
>> +				printk(KERN_INFO
>> +				       "Buffer not started:"
>> +				       "buffer parameter update failed\n");
>> +				goto error_ret;
>> +			}
>> +		}
>> +	if (indio_dev->info->update_scan_mode) {
>> +		ret =3D indio_dev->info
>>  			->update_scan_mode(indio_dev,
>>  					   indio_dev->active_scan_mask);
>> +		if (ret < 0)
>> +			goto error_free_compound_mask;
>> +	}
>> +	/* Definitely possible for devices to support both of these.*/
>> +	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
>> +		if (!indio_dev->trig) {
>> +			printk(KERN_INFO "Buffer not started: no trigger\n");
>> +			ret =3D -EINVAL;
>> +			goto error_free_compound_mask;
>> +		}
>> +		indio_dev->currentmode =3D INDIO_BUFFER_TRIGGERED;
>> +	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
>> +		indio_dev->currentmode =3D INDIO_BUFFER_HARDWARE;
>> +	} else { /* should never be reached */
>> +		ret =3D -EINVAL;
>> +		goto error_free_compound_mask;
>> +	}
>> +
>> +	if (indio_dev->setup_ops->postenable) {
>> +		ret =3D indio_dev->setup_ops->postenable(indio_dev);
>> +		if (ret) {
>> +			printk(KERN_INFO
>> +			       "Buffer not started: postenable failed\n");
>> +			indio_dev->currentmode =3D INDIO_DIRECT_MODE;
>> +			if (indio_dev->setup_ops->postdisable)
>> +				indio_dev->setup_ops->postdisable(indio_dev);
>> +			goto error_free_compound_mask;
>> +		}
>> +	}
>> +error_free_compound_mask:
>> +	indio_dev->active_scan_mask =3D NULL;
>> +	kfree(compound_mask);
>> +error_ret:
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_update_buffers);
>> +
>> +ssize_t iio_buffer_store_enable(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf,
>> +				size_t len)
>> +{
>> +	int ret;
>> +	bool requested_state;
>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> +	struct iio_buffer *pbuf =3D indio_dev->buffer;
>> +	struct list_head *p;
>> +	bool inlist =3D false;
>> +
>> +	ret =3D strtobool(buf, &requested_state);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	mutex_lock(&indio_dev->mlock);
>> +
>> +	/* Find out if it is in the list */
>> +	list_for_each(p, &indio_dev->buffer_list)
>> +		if (p =3D=3D &pbuf->buffer_list) {
>> +			inlist =3D true;
>> +			break;
>> +		}
>> +	/* Already enabled */
>> +	if (inlist && requested_state)
>> +		goto done;
>> +	/* Already disabled */
>> +	if (!inlist && !requested_state)
>> +		goto done;
>=20
>         if (inlist =3D=3D requested_state)
> 		goto done;
>=20
>> +
>> +	if (requested_state)
>> +		ret =3D iio_update_buffers(indio_dev,
>> +					 indio_dev->buffer, NULL);
>> +	else
>> +		ret =3D iio_update_buffers(indio_dev,
>> +					 NULL, indio_dev->buffer);
>> +
>> +	if (ret < 0)
>> +		goto done;
>> +done:
>> +	mutex_unlock(&indio_dev->mlock);
>> +	return (ret < 0) ? ret : len;
>> +}
>> +EXPORT_SYMBOL(iio_buffer_store_enable);
>> +
> [...]
>> @@ -567,7 +641,11 @@ EXPORT_SYMBOL(iio_sw_buffer_preenable);
>>   * iio_scan_mask_set() - set particular bit in the scan mask
>>   * @buffer: the buffer whose scan mask we are interested in
>>   * @bit: the bit to be set.
>> - **/
>> + *
>> + * Note that at this point we have no way of knowing what other
>> + * buffers might request, hence this code only verifies that the
>> + * individual buffers request is plausible.
>> + */
>>  int iio_scan_mask_set(struct iio_dev *indio_dev,
>>  		      struct iio_buffer *buffer, int bit)
>>  {
>> @@ -597,7 +675,7 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
>>  			return -EINVAL;
>>  		}
>>  	}
>> -	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
>> +	set_bit(bit, buffer->scan_mask);
>=20
> Is this a unrelated fix?
Slight simplification.  Doesn't belong in this patch (and probably not
worth having at all really...
>=20
>> =20
>>  	kfree(trialmask);
>> =20
> [...]
>> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers=
/staging/iio/iio_simple_dummy_buffer.c
>> index fdfc873..5931cbb 100644
>> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
>> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
>> @@ -46,7 +46,6 @@ static irqreturn_t iio_simple_dummy_trigger_h(int =
irq, void *p)
>>  {
>>  	struct iio_poll_func *pf =3D p;
>>  	struct iio_dev *indio_dev =3D pf->indio_dev;
>> -	struct iio_buffer *buffer =3D indio_dev->buffer;
>>  	int len =3D 0;
>>  	u16 *data;
>> =20
>> @@ -76,7 +75,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int =
irq, void *p)
>>  		     i < bitmap_weight(indio_dev->active_scan_mask,
>>  				       indio_dev->masklength);
>>  		     i++) {
>> -			j =3D find_next_bit(buffer->scan_mask,
>> +			j =3D find_next_bit(indio_dev->buffer->scan_mask,
>=20
> should this be indio_dev->active_scan_mask?
This bit always give me a headache.  You are right of course. It's in
the trigger handler so should not care at all about the specific buffer
mask.
>=20
>>  					  indio_dev->masklength, j + 1);
>>  			/* random access read form the 'device' */
>>  			data[i] =3D fakedata[j];
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

