Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:49887 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751187Ab1LMJBv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2011 04:01:51 -0500
Message-ID: <4EE7145F.9040003@metafoo.de>
Date: Tue, 13 Dec 2011 10:01:19 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access
 ops
References: <1323684526-11134-1-git-send-email-lars@metafoo.de> <20111213004506.GA11553@kroah.com>
In-Reply-To: <20111213004506.GA11553@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/13/2011 01:45 AM, Greg KH wrote:
> On Mon, Dec 12, 2011 at 11:08:46AM +0100, Lars-Peter Clausen wrote:
>> Add some convenience wrapper functions around the buffer access operations. This
>> makes the resulting code both a bit easier to read and to write.
> 
> Yeah, but why are you abstracting this away?
> 

Because it's nicer to read and to write :) This is a purely cosmetic patch
which is supposed to ease to code flow a bit.

But it also hides the actual implementation from the user, which makes it
easier to change the implementation at a later point without having to patch
each user.

And of course it brings consistency to the users of these functions in regard
to whether a callback is checked, because it is optional, or not, because it is
mandatory.

>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/buffer.h              |   68 +++++++++++++++++++++++++++++
>>  drivers/staging/iio/industrialio-buffer.c |   63 +++++++++++---------------
>>  2 files changed, 95 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
>> index 44593b2..46e0867 100644
>> --- a/drivers/staging/iio/buffer.h
>> +++ b/drivers/staging/iio/buffer.h
>> @@ -194,6 +194,74 @@ ssize_t iio_buffer_show_enable(struct device *dev,
>>  
>>  int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
>>  
>> +static inline void buffer_mark_in_use(struct iio_buffer *buffer)
>> +{
>> +	if (buffer->access->mark_in_use)
> 
> Why would this check ever fail?

Because the callback is optional.

> 
>> +		buffer->access->mark_in_use(buffer);
>> +}
>> +
>> +static inline void buffer_unmark_in_use(struct iio_buffer *buffer)
>> +{
>> +	if (buffer->access->unmark_in_use)
> 
> Same for this one?
> 
>> +		buffer->access->unmark_in_use(buffer);
>> +}
>> +
>> +static inline int buffer_store_to(struct iio_buffer *buffer, u8 *data,
>> +	s64 timestamp)
>> +{
>> +	return buffer->access->store_to(buffer, data, timestamp);
> 
> WHy didn't you check this one here?

Because the callback is not really optional.

> 
>> +}
>> +
>> +static inline int buffer_read_first_n(struct iio_buffer *buffer, size_t n,
>> +	char __user *buf)
>> +{
>> +	return buffer->access->read_first_n(buffer, n, buf);
>> +}
>> +
>> +static inline int buffer_mark_param_change(struct iio_buffer *buffer)
>> +{
>> +	if (buffer->access->mark_param_change)
>> +		return buffer->access->mark_param_change(buffer);
>> +
>> +	return 0;
> 
> Why 0?  Not an error?

Why an error, not 0?

If the buffer doesn't implement a mark_param_change callback it is probably not
interested in being notified about changes. So not implementing the function is
not an error to the caller.

> 
>> +}
>> +
>> +static inline int buffer_request_update(struct iio_buffer *buffer)
>> +{
>> +	if (buffer->access->request_update)
>> +		return buffer->access->request_update(buffer);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int buffer_get_bytes_per_datum(struct iio_buffer *buffer)
>> +{
>> +	return buffer->access->get_bytes_per_datum(buffer);
>> +}
>> +
>> +static inline int buffer_set_bytes_per_datum(struct iio_buffer *buffer,
>> +	size_t bpd)
>> +{
>> +	return buffer->access->set_bytes_per_datum(buffer, bpd);
>> +}
>> +
>> +static inline int buffer_get_length(struct iio_buffer *buffer)
>> +{
>> +	if (buffer->access->get_length)
>> +		return buffer->access->get_length(buffer);
>> +
>> +	return -ENOSYS;
> 
> Here you return an error, but why ENOSYS?
> 
> Consistancy is key, and you don't have it here at all.  Or if you do, I
> sure don't understand it...

Well, different types of functions require different semantics. While the
previous ones did either return 0 in case of success or a error value in case
of an error, buffer_get_length returns an integer value where 0 is a valid
value. Since we can't make any meaningful assumptions about the buffer size if
the callback is not implemented we return an error value. Why ENOSYS? Because
it is the code for 'function not implemented' and is used throughout the kernel
in similar situations.

> 
> Are you trying to keep people from touching the access field of the
> buffer directly?  If so, that's great, but you don't prevent that here.

As said before the main purpose of this patch is cosmetics.

> 
> Perhaps you need to reduce the levels of indirection and work on making
> an easier buffer object to work with?

But, if we were ever to changes the levels of indirection it will be a lot
easier with this patch, since you only have to change the one implementation of
iio_buffer_whatever() instead of fixup up all the users.


> If you have to have these types
> of "helper" functions, just to keep the levels of pointers you have to
> type, perhaps that's not really a good data structure in the first place
> to be using?
> 

This is just a normal virtual function table. You have multiple types of
buffers and each type can have multiple instances. It's common practice to
provide such helper or wrapper functions for virtual function tables.

> 
> 
>> +}
>> +
>> +static inline int buffer_set_length(struct iio_buffer *buffer,
>> +	int length)
>> +{
>> +	if (buffer->access->set_length)
>> +		return buffer->access->set_length(buffer, length);
>> +
>> +	return -ENOSYS;
>> +}
>> +
>>  #else /* CONFIG_IIO_BUFFER */
>>  
>>  static inline int iio_buffer_register(struct iio_dev *indio_dev,
>> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
>> index a03a574..8472570 100644
>> --- a/drivers/staging/iio/industrialio-buffer.c
>> +++ b/drivers/staging/iio/industrialio-buffer.c
>> @@ -43,9 +43,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>  	struct iio_dev *indio_dev = filp->private_data;
>>  	struct iio_buffer *rb = indio_dev->buffer;
>>  
>> -	if (!rb || !rb->access->read_first_n)
>> +	if (!rb)
>>  		return -EINVAL;
>> -	return rb->access->read_first_n(rb, n, buf);
>> +	return buffer_read_first_n(rb, n, buf);
> 
> Oops, you just crashed if there wasn't a read_first_n() function here.

I suppose it's pretty save to assume that if we have a buffer implementation
where you can't read any samples from it is broken anyway.

> 
> See consistancy just tripped you up :)
> 
> Sorry, I don't want to take this patch as-is.
> 
