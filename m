Return-Path: <jic23@cam.ac.uk>
Message-ID: <4D4DA97C.7000409@cam.ac.uk>
Date: Sat, 05 Feb 2011 19:48:12 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com
Subject: Re: [RFC PATCH 0/5] Add kfifo based buffer implementation
References: <1292790825-19156-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1292790825-19156-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/19/10 20:33, Jonathan Cameron wrote:
> This set is an update of the proof of concept I wrote a while back.
> This time around I've simply used a byte stream buffer rather than
> variable record sizes.  The first patch pushes some of the
> exiting buffer code down into the ring_sw implementation to
> make it simpler to provide other implementations.
> 
> What you gain by picking kfifo:
> * Clean fast code for the underlying buffer.
> 
> What you loose:
> * Events - userspace has to 'know' how often to read the buffer
>   so as to not loose data.
> 
> Obvious difference is it is a fifo rather than a ring buffer.
> 
> This buffer should also lend itself to a simple implementation
> of a store_n function which should be useful for devices with
> a hardware ring which we then want to feed into a software one.

If anyone has time to take a look at this, it would be great to
get some feedback. If not I propose merging it anyway soon.
There is still work to be done to get this to an optimal state, but
right now it works so might as well make it available.

I fear my sw_ring implementation is one of the main blockers to moving
IIO out of staging so would like to show how easy it is to use
alternatives.  On that note we should probably have some documentation
to provide a clear explanation of when to pick one buffer over another.

The 'What option should a distro use?' question Greg raised the other
day will here be controlled by driver writers setting a suitable
default buffer choice if they implement multiple options.
> 
> Jonathan Cameron (5):
>   staging:iio:buffering  move the copy to user on rip down into
>     implementations
>   staging:iio:kfifo buffer implementation
>   staging:iio:lis3l02dq allow buffer implementation selection
>   staging:iio: update example to handle case with no ring events
>   staging:iio: buffer example - add lots more runtime parameters
> 
>  drivers/staging/iio/Documentation/generic_buffer.c |   63 +++++--
>  drivers/staging/iio/Kconfig                        |    6 +
>  drivers/staging/iio/Makefile                       |    1 +
>  drivers/staging/iio/accel/Kconfig                  |   23 +++-
>  drivers/staging/iio/accel/lis3l02dq.h              |   10 +
>  drivers/staging/iio/accel/lis3l02dq_ring.c         |    9 +-
>  drivers/staging/iio/industrialio-ring.c            |   23 +--
>  drivers/staging/iio/kfifo_buf.c                    |  196 ++++++++++++++++++++
>  drivers/staging/iio/kfifo_buf.h                    |   56 ++++++
>  drivers/staging/iio/ring_generic.h                 |    2 +-
>  drivers/staging/iio/ring_sw.c                      |   29 ++-
>  drivers/staging/iio/ring_sw.h                      |    4 +-
>  12 files changed, 363 insertions(+), 59 deletions(-)
>  create mode 100644 drivers/staging/iio/kfifo_buf.c
>  create mode 100644 drivers/staging/iio/kfifo_buf.h
> 
