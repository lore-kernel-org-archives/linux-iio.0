Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41734 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755649Ab1LNAC6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2011 19:02:58 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 017F221741
	for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2011 19:02:57 -0500 (EST)
Date: Tue, 13 Dec 2011 15:59:26 -0800
From: Greg KH <greg@kroah.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access
 ops
Message-ID: <20111213235926.GA23916@kroah.com>
References: <1323684526-11134-1-git-send-email-lars@metafoo.de>
 <20111213004506.GA11553@kroah.com>
 <4EE7145F.9040003@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EE7145F.9040003@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 13, 2011 at 10:01:19AM +0100, Lars-Peter Clausen wrote:
> On 12/13/2011 01:45 AM, Greg KH wrote:
> > On Mon, Dec 12, 2011 at 11:08:46AM +0100, Lars-Peter Clausen wrote:
> >> Add some convenience wrapper functions around the buffer access operations. This
> >> makes the resulting code both a bit easier to read and to write.
> > 
> > Yeah, but why are you abstracting this away?
> > 
> 
> Because it's nicer to read and to write :) This is a purely cosmetic patch
> which is supposed to ease to code flow a bit.
> 
> But it also hides the actual implementation from the user, which makes it
> easier to change the implementation at a later point without having to patch
> each user.
> 
> And of course it brings consistency to the users of these functions in regard
> to whether a callback is checked, because it is optional, or not, because it is
> mandatory.

Ok, but you aren't consistent in your error codes or checking it seems.

> >> +static inline int buffer_store_to(struct iio_buffer *buffer, u8 *data,
> >> +	s64 timestamp)
> >> +{
> >> +	return buffer->access->store_to(buffer, data, timestamp);
> > 
> > WHy didn't you check this one here?
> 
> Because the callback is not really optional.

And these are all documented, right?

> >> +static inline int buffer_mark_param_change(struct iio_buffer *buffer)
> >> +{
> >> +	if (buffer->access->mark_param_change)
> >> +		return buffer->access->mark_param_change(buffer);
> >> +
> >> +	return 0;
> > 
> > Why 0?  Not an error?
> 
> Why an error, not 0?
> 
> If the buffer doesn't implement a mark_param_change callback it is probably not
> interested in being notified about changes. So not implementing the function is
> not an error to the caller.

Ok, documenting this would be nice...

> >> +static inline int buffer_get_length(struct iio_buffer *buffer)
> >> +{
> >> +	if (buffer->access->get_length)
> >> +		return buffer->access->get_length(buffer);
> >> +
> >> +	return -ENOSYS;
> > 
> > Here you return an error, but why ENOSYS?
> > 
> > Consistancy is key, and you don't have it here at all.  Or if you do, I
> > sure don't understand it...
> 
> Well, different types of functions require different semantics. While the
> previous ones did either return 0 in case of success or a error value in case
> of an error, buffer_get_length returns an integer value where 0 is a valid
> value. Since we can't make any meaningful assumptions about the buffer size if
> the callback is not implemented we return an error value. Why ENOSYS? Because
> it is the code for 'function not implemented' and is used throughout the kernel
> in similar situations.

Is the caller always supposed to check this?  If so, please mark the
function as such so the compiler will complain if it isn't.

> >> --- a/drivers/staging/iio/industrialio-buffer.c
> >> +++ b/drivers/staging/iio/industrialio-buffer.c
> >> @@ -43,9 +43,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
> >>  	struct iio_dev *indio_dev = filp->private_data;
> >>  	struct iio_buffer *rb = indio_dev->buffer;
> >>  
> >> -	if (!rb || !rb->access->read_first_n)
> >> +	if (!rb)
> >>  		return -EINVAL;
> >> -	return rb->access->read_first_n(rb, n, buf);
> >> +	return buffer_read_first_n(rb, n, buf);
> > 
> > Oops, you just crashed if there wasn't a read_first_n() function here.
> 
> I suppose it's pretty save to assume that if we have a buffer implementation
> where you can't read any samples from it is broken anyway.

I would think so, but the original code didn't think so :)

greg k-h
