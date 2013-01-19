Return-Path: <jic23@kernel.org>
Message-ID: <50FAA46B.8070405@kernel.org>
Date: Sat, 19 Jan 2013 13:49:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/5] staging:iio: drop sw_ring buffer implementation.
References: <1354285372-11779-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1354285372-11779-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Added all but patch 4 to the togreg branch of
iio.git given the only reason this was held was the just merged
series cleaning up the adis16400 driver (which included as a
side effect removing the code patch 4 dealt with).

On 11/30/2012 02:22 PM, Jonathan Cameron wrote:
> sw_ring was the original buffer implementation for IIO. It kind of evolved
> over a couple of late nights and even though I wrote it I was never
> convinced it was right.  Then a nice kfifo implementation came along
> and in the vast majority of IIO use cases whether we have a kfifo or
> a ring buffer is not as it turns out that important.
> 
> We have been telling people not to use this for quite some time now.
> Lets make that finally a really hard rule by dropping it.
> There are 4 remaining users. This patch drops support form lis3l02dq
> which had support for both this and kfifo.  For the other 3 users
> it simply switches over to kfifo.  We haven't seen any real problems
> doing this with any other driver so I can't see why these would cause
> trouble!
> 
> Note my aim for this cycle ist to greatly cut down what we have left
> in staging by removing legacy cruft and getting other stuff cleaned up and
> out!
> 
> Jonathan
> 
> Jonathan Cameron (5):
>   staging:iio:accel:lis3l02dq remove sw_ring support.
>   staging:iio:impedance-analyzer switch from sw_ring to kfifo.
>   staging:iio:meter:ade7758 switch from sw_ring to kfifo
>   staging:iio:imu: adis16400 switch from sw_ring to kfifo
>   staging:iio: drop sw_ring buffer implementation.
> 
>  drivers/staging/iio/Kconfig                     |  13 -
>  drivers/staging/iio/Makefile                    |   2 -
>  drivers/staging/iio/accel/Kconfig               |  23 +-
>  drivers/staging/iio/accel/lis3l02dq.h           |   8 -
>  drivers/staging/iio/accel/lis3l02dq_ring.c      |   7 +-
>  drivers/staging/iio/impedance-analyzer/Kconfig  |   2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c |   8 +-
>  drivers/staging/iio/imu/Kconfig                 |   2 +-
>  drivers/staging/iio/imu/adis16400_ring.c        |  12 +-
>  drivers/staging/iio/meter/Kconfig               |   2 +-
>  drivers/staging/iio/meter/ade7758_ring.c        |  12 +-
>  drivers/staging/iio/ring_sw.c                   | 366 ------------------------
>  drivers/staging/iio/ring_sw.h                   |  30 --
>  13 files changed, 23 insertions(+), 464 deletions(-)
>  delete mode 100644 drivers/staging/iio/ring_sw.c
>  delete mode 100644 drivers/staging/iio/ring_sw.h
> 
