Return-Path: <lars@metafoo.de>
Message-ID: <4EE87755.3000000@metafoo.de>
Date: Wed, 14 Dec 2011 11:15:49 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
 Jonathan Cameron <jic23@kernel.org>,
 devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access
 ops
References: <1323684526-11134-1-git-send-email-lars@metafoo.de> <20111213004506.GA11553@kroah.com> <4EE7145F.9040003@metafoo.de> <20111213235926.GA23916@kroah.com>
In-Reply-To: <20111213235926.GA23916@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/14/2011 12:59 AM, Greg KH wrote:
> 
>>>> +static inline int buffer_get_length(struct iio_buffer *buffer)
>>>> +{
>>>> +	if (buffer->access->get_length)
>>>> +		return buffer->access->get_length(buffer);
>>>> +
>>>> +	return -ENOSYS;
>>>
>>> Here you return an error, but why ENOSYS?
>>>
>>> Consistancy is key, and you don't have it here at all.  Or if you do, I
>>> sure don't understand it...
>>
>> Well, different types of functions require different semantics. While the
>> previous ones did either return 0 in case of success or a error value in case
>> of an error, buffer_get_length returns an integer value where 0 is a valid
>> value. Since we can't make any meaningful assumptions about the buffer size if
>> the callback is not implemented we return an error value. Why ENOSYS? Because
>> it is the code for 'function not implemented' and is used throughout the kernel
>> in similar situations.
> 
> Is the caller always supposed to check this?  If so, please mark the
> function as such so the compiler will complain if it isn't.

Marking the function as __must_check doesn't make much sense here. Since it
will either return an error or the buffer length. So you'll always use the
returned result one way or the other.
