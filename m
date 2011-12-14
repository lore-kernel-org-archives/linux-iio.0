Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48573 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab1LNQx2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 14 Dec 2011 11:53:28 -0500
Date: Wed, 14 Dec 2011 07:49:32 -0800
From: Greg KH <gregkh@suse.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg KH <greg@kroah.com>, Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access
 ops
Message-ID: <20111214154932.GA24002@suse.de>
References: <1323684526-11134-1-git-send-email-lars@metafoo.de>
 <20111213004506.GA11553@kroah.com>
 <4EE7145F.9040003@metafoo.de>
 <20111213235926.GA23916@kroah.com>
 <4EE87755.3000000@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EE87755.3000000@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Dec 14, 2011 at 11:15:49AM +0100, Lars-Peter Clausen wrote:
> On 12/14/2011 12:59 AM, Greg KH wrote:
> > 
> >>>> +static inline int buffer_get_length(struct iio_buffer *buffer)
> >>>> +{
> >>>> +	if (buffer->access->get_length)
> >>>> +		return buffer->access->get_length(buffer);
> >>>> +
> >>>> +	return -ENOSYS;
> >>>
> >>> Here you return an error, but why ENOSYS?
> >>>
> >>> Consistancy is key, and you don't have it here at all.  Or if you do, I
> >>> sure don't understand it...
> >>
> >> Well, different types of functions require different semantics. While the
> >> previous ones did either return 0 in case of success or a error value in case
> >> of an error, buffer_get_length returns an integer value where 0 is a valid
> >> value. Since we can't make any meaningful assumptions about the buffer size if
> >> the callback is not implemented we return an error value. Why ENOSYS? Because
> >> it is the code for 'function not implemented' and is used throughout the kernel
> >> in similar situations.
> > 
> > Is the caller always supposed to check this?  If so, please mark the
> > function as such so the compiler will complain if it isn't.
> 
> Marking the function as __must_check doesn't make much sense here. Since it
> will either return an error or the buffer length. So you'll always use the
> returned result one way or the other.

That's exactly the point, you must use it, so mark it as such.

greg k-h
