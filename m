Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34896 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab3I3GbY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2013 02:31:24 -0400
In-Reply-To: <20130930014153.GA16401@kroah.com>
References: <52489407.4050302@kernel.org> <20130930014153.GA16401@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PULL] IIO fixes for 3.12 set 2
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 30 Sep 2013 07:31:16 +0100
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <961953e5-d48e-4b36-94c0-d9d4ab462f65@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Greg KH <gregkh@linuxfoundation.org> wrote:
>On Sun, Sep 29, 2013 at 09:56:39PM +0100, Jonathan Cameron wrote:
>> The following changes since commit
>bda2f8fca20b564ac8edb2b9c080d942c2144359:
>> 
>>   iio:buffer_cb: Add missing iio_buffer_init() (2013-09-21 12:52:50
>+0100)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>tags/iio-fixes-for-3.12b
>> 
>> for you to fetch changes up to
>f09b44ed1d8553c8a91b8de8cfa05f2ea585ab0d:
>> 
>>   iio:magnetometer: Bugfix magnetometer default output registers
>(2013-09-28 12:03:24 +0100)
>> 
>> ----------------------------------------------------------------
>> Second set of IIO fixes for the 3.12 cycle.
>> 
>> One large fix here to add reference counting to IIO's buffers
>> in order to prevent them being prematurely freed. The actual code
>addition
>> is small but needs to be repeated in a number of different places.
>
>That's a pretty major change to be doing so late in the development
>cycle.  Are you _sure_ it's needed right now?
No more than it has been needed for a couple of years. I guess it can wait a little longer! I think it is more likely to be hit with USB devices now present though but they have been about for a while as well.


>
>A few comments on the patch itself:
>
>+static inline void iio_buffer_get(struct iio_buffer *buffer)
>+{
>+       kref_get(&buffer->ref);
>+}
>
>Traditionally a "get" function allows NULL pointers, and returns a
>pointer to the object.  So that would mean this would look like:
>
>static inline struct iio_buffer *iio_buffer_get(struct iio_buffer
>*buffer)
>{
>	if (buffer)
>		kref_get(&buffer->ref);
>	return buffer;
>}
>
>Why does it need to be inline?
>
>With that change, your iio_device_attach_buffer() call becomes one
>line:
>	indio_dev->buffer = iio_buffer_get(buffer);
>
>
>Anyway, this is a really major change, and not anything that I can
>defend so late in the development cycle.  Why are you making it now?

Purely on the basis that a fix should go in ASAP.  I did wonder if should hold this for next. Clearly the answer was yes on that front!  Thanks as ever for restraining my worst excesses.

>What happened that requires it at this point in time?
Nothing changed. This has been there from the start. I didn't think this aspect through properly and it has taken this long for anyone to notice.

>
>Oh, you forgot to include an "empty" function for iio_buffer_get() if
>CONFIG_IIO_BUFFER is not defined (matching the other 2 you did
>provide.)
>
>Why export __iio_buffer_release?  Why not just make these "real"
>functions, then there is no need to use a __ function, or export it.
>
>The three other patches here look fine to me, I can take them, but not
>this one at this point in time, unless you have a lot more
>justification
>for it.
Sorry about this. I am still learning where to set the boundary for fixes. Thanks for taking such a close look!

Lars, can you refresh and repost to go in next merge cycle.

There are a few more related patches but they don't effect any current mainline drivers so were always going to be next material.

I will drop this patch and send a pull request for the others in that branch later today or tomorrow.

Jonathan
>
>thanks,
>
>greg k-h

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
