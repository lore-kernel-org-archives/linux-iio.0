Return-Path: <jic23@kernel.org>
Message-ID: <4FB76561.5070706@kernel.org>
Date: Sat, 19 May 2012 10:18:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: sw_ring.c poll problem
References: <6e6a0f27b1900226df5350cc320f25bb@mail.gmail.com> <9d0339d0-2cde-4605-a8b0-99f568d05eb8@email.android.com> <4FB35420.4020001@cam.ac.uk> <0a0072f9cc413b7489544b461684c953@mail.gmail.com> <4FB68736.7040303@cam.ac.uk> <105f450dd4ba21f06937bc076ad60420@mail.gmail.com>
In-Reply-To: <105f450dd4ba21f06937bc076ad60420@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/18/2012 08:27 PM, Ge Gao wrote:
> I put a patch for the industrial-buffer.c to fix the problem of pollq
> always waiting. It is just two lines fix.
Hmm.. Might work given we have only one reader but smacks of a race
condition. What bothers me is that this issue should effect lots of
other subsystems and doesn't.  Evdev does it pretty much the same way we
do for example.

> I also add the quaternion definition to the types as well as core parts.
> Quaternion is a four-element stuff. It has a real part and three imaginary
> parts. Basically, it can be reprensented as (r + xi + yj + zk). This is
> important in rotation. It is computed by invensense MPU dmp(digital motion
> processing) unit and output as a data. So the real parts, I added one more
> modifier, the imaginary parts I am still using x, y, z as the modifier.
> Thanks.
Handling quaternions needs some thought.  The components do not have
independent value (it's useless knowing any one of them on their own) so
we should bind them into one channel element.  This obviously requires
us to extend the current scan_type bit of the channel spec.  That's
fine, though it will require some changes in the demux unit amongst
others which could get a little fiddly.  I suspect the biggest issue
with doing this will be preventing people using for channels where the
individual components do have independant value.  I guess I'll just
have to shout at people ;)

Jonathan
> 
> Best Regards,
> 
> GE GAO
> 
> 
> diff --git a/drivers/staging/iio/industrialio-buffer.c
> b/drivers/staging/iio/industrialio-buffer.c
> index 386ba76..3f82ded 100644
> --- a/drivers/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio-buffer.c
> @@ -56,6 +56,8 @@ unsigned int iio_buffer_poll(struct file *filp,
>  {
>         struct iio_dev *indio_dev = filp->private_data;
>         struct iio_buffer *rb = indio_dev->buffer;
> +        if (rb->stufftoread)
> +                return POLLIN | POLLRDNORM;
> 
>         poll_wait(filp, &rb->pollq, wait);
>         if (rb->stufftoread)
> 
> --------------------------------------------------------------------------
> -------------------------------------------
> diff --git a/drivers/staging/iio/types.h b/drivers/staging/iio/types.h
> index 0c32136..291c783 100644
> --- a/drivers/staging/iio/types.h
> +++ b/drivers/staging/iio/types.h
> @@ -27,6 +27,7 @@ enum iio_chan_type {
>         IIO_ANGL,
>         IIO_TIMESTAMP,
>         IIO_CAPACITANCE,
> +       IIO_QUATERNION,
>  };
> 
>  enum iio_modifier {
> @@ -44,6 +45,7 @@ enum iio_modifier {
>         IIO_MOD_X_OR_Y_OR_Z,
>         IIO_MOD_LIGHT_BOTH,
>         IIO_MOD_LIGHT_IR,
> +       IIO_MOD_R,
>  };
> 
>  #define IIO_VAL_INT 1
> --------------------------------------------------------------------------
> -----------------------
> diff --git a/drivers/staging/iio/industrialio-core.c
> b/drivers/staging/iio/industrialio-core.c
> index d303bfb..deb80aa 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -68,6 +68,7 @@ static const char * const iio_chan_type_name_spec[] = {
>         [IIO_ANGL] = "angl",
>         [IIO_TIMESTAMP] = "timestamp",
>         [IIO_CAPACITANCE] = "capacitance",
> +       [IIO_QUATERNION] = "quaternion",
>  };
> 
>  static const char * const iio_modifier_names[] = {
> @@ -76,6 +77,7 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_Z] = "z",
>         [IIO_MOD_LIGHT_BOTH] = "both",
>         [IIO_MOD_LIGHT_IR] = "ir",
> +       [IIO_MOD_R]  = "r",
>  };
> 
>  /* relies on pairs of these shared then separate */
> 
> 
> --------------------------------------------------------------------------
> -----------
> 
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> Sent: Friday, May 18, 2012 10:31 AM
> To: Ge Gao
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org
> Subject: Re: sw_ring.c poll problem
> 
> 
> 
> On 05/18/2012 02:08 AM, Ge Gao wrote:
>> Dear Jonathan,
>> 	I check the kfifo buffer implementation under IIO directory.
> However,
>> I didn't find the "pollq" is released anywhere as sw_ring does.
>> Without it, how can kfifo be polled if it is used by
> industrial-buffer.c? Thanks.
> Sorry for not getting back to you sooner.  Totally manic at the day job
> today tracking two delightful bugs.
> 
> Anyhow, looks like I'd imagined we'd actually added poll support to kfifo
> when it never got implemented.  Should be easy enough though.
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c index
> 6bf9d05..e69d6ce 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -6,6 +6,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/mutex.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/sched.h>
> 
>  struct iio_kfifo {
>  	struct iio_buffer buffer;
> @@ -35,6 +36,7 @@ static int iio_request_update_kfifo(struct iio_buffer
> *r)
>  	kfifo_free(&buf->kf);
>  	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>  				   buf->buffer.length);
> +	r->stufftoread = false;
>  error_ret:
>  	return ret;
>  }
> @@ -97,6 +99,10 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
>  	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
>  	if (ret != r->bytes_per_datum)
>  		return -EBUSY;
> +	
> +	r->stufftoread = true;
> +	wake_up_interruptible(&r->pollq);
> +
>  	return 0;
>  }
> 
> @@ -112,6 +118,12 @@ static int iio_read_first_n_kfifo(struct iio_buffer
> *r,
>  	n = rounddown(n, r->bytes_per_datum);
>  	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
> 
> +	if (kfifo_is_empty(&kf->kf))
> +		r->stufftoread = false;
> +	/* verify it is still empty to avoid race */
> +	if (!kfifo_is_empty(&kf->kf))
> +		r->stufftoread = true;
> +
>  	return copied;
>  }
> 
> .. is a totally untested patch to add poll support to it.
> The little dance at the end is to avoid a write having occured between the
> kfifo_is_empty and setting the flag false as that could wipe out the
> existence of some data in the buffer. Given we only ever have one writer
> and one reader that should work I think.
> 
> Jonathan
> 
>>
>> Hi Ge,
>>
>> I realised after sending that message that I was being rather
>> dismissive of your query.  Got up far too early this morning (as every
>> morning ;)
>>
>> Anyhow, to give more details. sw_ring is probably never going to make
>> it out of staging, hence the move to kfifo_buf. At somepoint we need
>> to work out how to do equivalent functionality of sw_ring but I've not
>> had time to more than start looking into this.
>>
>> As you saw, poll on sw_ring is a watershead signal indicating (in
>> theory and last I checked it worked) that the ring is more than half
> full.
>> Any read that takes the fill level below half (test code just reads
>> half the size of the buffer), should allow a new passing of the
>> watershead to resignal poll. It's entirely possible there is a bug in
>> there though I know it is been getting a fair bit of testing with some
>> other drivers so could be todo with the precise way you are reading it
>> hitting some corner case? (I'm
>> stretching...)
>>
>> Right now I'd just move over to kfifo_buf if I were you. It's much
>> more 'standard' in that it's a fifo and poll indicates if there is
>> anything there at all.
>>>> 	Thanks.
>>>>
>>>> Best regards,
>>>>
>>>> Ge GAO
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
