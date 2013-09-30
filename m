Return-Path: <gregkh@linuxfoundation.org>
Date: Sun, 29 Sep 2013 18:41:53 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO fixes for 3.12 set 2
Message-ID: <20130930014153.GA16401@kroah.com>
References: <52489407.4050302@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52489407.4050302@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Sep 29, 2013 at 09:56:39PM +0100, Jonathan Cameron wrote:
> The following changes since commit bda2f8fca20b564ac8edb2b9c080d942c2144359:
> 
>   iio:buffer_cb: Add missing iio_buffer_init() (2013-09-21 12:52:50 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.12b
> 
> for you to fetch changes up to f09b44ed1d8553c8a91b8de8cfa05f2ea585ab0d:
> 
>   iio:magnetometer: Bugfix magnetometer default output registers (2013-09-28 12:03:24 +0100)
> 
> ----------------------------------------------------------------
> Second set of IIO fixes for the 3.12 cycle.
> 
> One large fix here to add reference counting to IIO's buffers
> in order to prevent them being prematurely freed. The actual code addition
> is small but needs to be repeated in a number of different places.

That's a pretty major change to be doing so late in the development
cycle.  Are you _sure_ it's needed right now?

A few comments on the patch itself:

+static inline void iio_buffer_get(struct iio_buffer *buffer)
+{
+       kref_get(&buffer->ref);
+}

Traditionally a "get" function allows NULL pointers, and returns a
pointer to the object.  So that would mean this would look like:

static inline struct iio_buffer *iio_buffer_get(struct iio_buffer *buffer)
{
	if (buffer)
		kref_get(&buffer->ref);
	return buffer;
}

Why does it need to be inline?

With that change, your iio_device_attach_buffer() call becomes one line:
	indio_dev->buffer = iio_buffer_get(buffer);


Anyway, this is a really major change, and not anything that I can
defend so late in the development cycle.  Why are you making it now?
What happened that requires it at this point in time?

Oh, you forgot to include an "empty" function for iio_buffer_get() if
CONFIG_IIO_BUFFER is not defined (matching the other 2 you did provide.)

Why export __iio_buffer_release?  Why not just make these "real"
functions, then there is no need to use a __ function, or export it.

The three other patches here look fine to me, I can take them, but not
this one at this point in time, unless you have a lot more justification
for it.

thanks,

greg k-h
