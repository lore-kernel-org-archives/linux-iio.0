Return-Path: <jic23@cam.ac.uk>
References: <1323684526-11134-1-git-send-email-lars@metafoo.de> <20111213004506.GA11553@kroah.com> <4EE7145F.9040003@metafoo.de> <20111213235926.GA23916@kroah.com>
In-Reply-To: <20111213235926.GA23916@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access ops
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 14 Dec 2011 07:19:27 +0000
To: Greg KH <greg@kroah.com>,Lars-Peter Clausen <lars@metafoo.de>
CC: Greg Kroah-Hartman <gregkh@suse.de>,Jonathan Cameron <jic23@kernel.org>,devel@driverdev.osuosl.org,linux-iio@vger.kernel.org
Message-ID: <b46a9322-2dc4-43f9-9f71-65b6546a904c@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Greg KH <greg@kroah.com> wrote:

>On Tue, Dec 13, 2011 at 10:01:19AM +010=
0, Lars-Peter Clausen wrote:
>> On 12/13/2011 01:45 AM, Greg KH wrote:
>> >=
 On Mon, Dec 12, 2011 at 11:08:46AM +0100, Lars-Peter Clausen wrote:
>> >> =
Add some convenience wrapper functions around the buffer access
>operations=
. This
>> >> makes the resulting code both a bit easier to read and to writ=
e.
>> > 
>> > Yeah, but why are you abstracting this away?
>> > 
>> 
>> Bec=
ause it's nicer to read and to write :) This is a purely cosmetic
>patch
>>=
 which is supposed to ease to code flow a bit.
>> 
>> But it also hides the=
 actual implementation from the user, which
>makes it
>> easier to change t=
he implementation at a later point without having
>to patch
>> each user.
>=
> 
>> And of course it brings consistency to the users of these functions
>=
in regard
>> to whether a callback is checked, because it is optional, or n=
ot,
>because it is
>> mandatory.
>
>Ok, but you aren't consistent in your e=
rror codes or checking it seems.
>
>> >> +static inline int buffer_store_to=
(struct iio_buffer *buffer, u8
>*data,
>> >> +	s64 timestamp)
>> >> +{
>> >=
> +	return buffer->access->store_to(buffer, data, timestamp);
>> > 
>> > WH=
y didn't you check this one here?
>> 
>> Because the callback is not really=
 optional.
>
>And these are all documented, right?
>
>> >> +static inline i=
nt buffer_mark_param_change(struct iio_buffer
>*buffer)
>> >> +{
>> >> +	if=
 (buffer->access->mark_param_change)
>> >> +		return buffer->access->mark_p=
aram_change(buffer);
>> >> +
>> >> +	return 0;
>> > 
>> > Why 0?  Not an er=
ror?
>> 
>> Why an error, not 0?
>> 
>> If the buffer doesn't implement a m=
ark_param_change callback it is
>probably not
>> interested in being notifi=
ed about changes. So not implementing the
>function is
>> not an error to t=
he caller.
>
>Ok, documenting this would be nice...
>
>> >> +static inline =
int buffer_get_length(struct iio_buffer *buffer)
>> >> +{
>> >> +	if (buffe=
r->access->get_length)
>> >> +		return buffer->access->get_length(buffer);
=
>> >> +
>> >> +	return -ENOSYS;
>> > 
>> > Here you return an error, but wh=
y ENOSYS?
>> > 
>> > Consistancy is key, and you don't have it here at all.=
  Or if you
>do, I
>> > sure don't understand it...
>> 
>> Well, different =
types of functions require different semantics. While
>the
>> previous ones=
 did either return 0 in case of success or a error value
>in case
>> of an =
error, buffer_get_length returns an integer value where 0 is a
>valid
>> va=
lue. Since we can't make any meaningful assumptions about the
>buffer size =
if
>> the callback is not implemented we return an error value. Why ENOSYS?=

>Because
>> it is the code for 'function not implemented' and is used thro=
ughout
>the kernel
>> in similar situations.
>
>Is the caller always suppos=
ed to check this?  If so, please mark the
>function as such so the compiler=
 will complain if it isn't.
>
>> >> --- a/drivers/staging/iio/industrialio-=
buffer.c
>> >> +++ b/drivers/staging/iio/industrialio-buffer.c
>> >> @@ -43=
,9 +43,9 @@ ssize_t iio_buffer_read_first_n_outer(struct
>file *filp, char =
__user *buf,
>> >>  	struct iio_dev *indio_dev =3D filp->private_data;
>> >=
>  	struct iio_buffer *rb =3D indio_dev->buffer;
>> >>  
>> >> -	if (!rb ||=
 !rb->access->read_first_n)
>> >> +	if (!rb)
>> >>  		return -EINVAL;
>> >>=
 -	return rb->access->read_first_n(rb, n, buf);
>> >> +	return buffer_read_=
first_n(rb, n, buf);
>> > 
>> > Oops, you just crashed if there wasn't a re=
ad_first_n() function
>here.
>> 
>> I suppose it's pretty save to assume th=
at if we have a buffer
>implementation
>> where you can't read any samples =
from it is broken anyway.
>
>I would think so, but the original code didn't=
 think so :)

This isn't actually true as the data may leave iio. Still, if=
 the driver doesn't know that something buggy is going on!  The callback bu=
ffer in my rfc of a few weeks ago has no read back abilities.
>
>greg k-h
>=
--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in=

>the body of a message to majordomo@vger.kernel.org
>More majordomo info a=
t  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android pho=
ne 
with K-9 Mail. Please excuse my brevity.
