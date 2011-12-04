Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:61628 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755094Ab1LDVoc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2011 16:44:32 -0500
Message-ID: <4EDBE9AC.4070100@metafoo.de>
Date: Sun, 04 Dec 2011 22:44:12 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de
Subject: Re: [PATCH 00/16] staging:iio: buffer cleanup series.
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/27/2011 02:33 PM, Jonathan Cameron wrote:
> A fairly straight forward set of cleanups of the buffer code.
> Recent discussion concluded that having access to channels being
> captured to a buffer by sysfs was an unnecessary complexity so that
> ist dropped.  The other patches get rid of some infrastructure and
> move the setup ops from a buffer instance to the device (as they will
> be relevant to all buffers when we allow more than one)
> 
> Anyhow, if people could verify I haven't messed any of this up, that
> would be great!
> 
> Jonathan

Except for "scrap scan_count" patch this is all straight forward and obvious,
and as discussed moving the setup of the transfers from the irq handler to the
update_scan_mode callback seem to be the right thing to do. Also we don't want
to do endian conversion in the driver itself, so the bitmap_weight call in the
interrupt handler should be hopefully gone anyway  soon.

So, all: Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> 
> Jonathan Cameron (16):
>   staging:iio:buffer drop bpe field.
>   staging:iio: remove userspace access to bytes per datum.
>   staging:iio:buffer move setup ops from buffer instance to iio_dev
>   staging:iio: scrap scan_count and ensure all drivers use
>     active_scan_mask
>   staging:iio:buffer remove unused owner field from struct iio_buffer
>   staging:iio:accel:lis3l02dq scrap reading from buffer for sysfs
>     access.
>   staging:iio:adc:ad7192 scrap read from buffer for sysfs access.
>   staging:iio:adc:ad7476 scrap read from buffer for sysfs access.
>   staging:iio:adc:ad7606 remove buffer access for sysfs interfaces.
>   staging:iio:adc:ad7606 remove buffer access to data from sysfs read.
>   staging:iio:adc:ad7993 stop reading from buffer for sysfs raw read.
>   staging:iio:adc:ad7887 stop reading from buffer for sysfs access.
>   staging:iio:adc:ad799x stop reading from buffer for sysfs accesses
>   staging:iio:adc:max1363 stop reading from buffer for sysfs access
>   staging:iio:ring_sw don't provide read last function.
>   staging:iio:buffer stop allowing for read_last callback.
> 
>  drivers/staging/iio/accel/adis16201_ring.c      |   14 ++---
>  drivers/staging/iio/accel/adis16203_ring.c      |   14 ++---
>  drivers/staging/iio/accel/adis16204_ring.c      |   14 ++---
>  drivers/staging/iio/accel/adis16209_ring.c      |    9 ++--
>  drivers/staging/iio/accel/adis16240_ring.c      |    9 ++--
>  drivers/staging/iio/accel/lis3l02dq.h           |   12 -----
>  drivers/staging/iio/accel/lis3l02dq_core.c      |    9 +--
>  drivers/staging/iio/accel/lis3l02dq_ring.c      |   59 +++++-----------------
>  drivers/staging/iio/accel/sca3000_ring.c        |    4 +-
>  drivers/staging/iio/adc/ad7192.c                |   34 +++----------
>  drivers/staging/iio/adc/ad7298.h                |    5 --
>  drivers/staging/iio/adc/ad7298_core.c           |    8 +--
>  drivers/staging/iio/adc/ad7298_ring.c           |   43 +++-------------
>  drivers/staging/iio/adc/ad7476.h                |    5 --
>  drivers/staging/iio/adc/ad7476_core.c           |    2 +-
>  drivers/staging/iio/adc/ad7476_ring.c           |   29 +----------
>  drivers/staging/iio/adc/ad7606.h                |    1 -
>  drivers/staging/iio/adc/ad7606_core.c           |    2 +-
>  drivers/staging/iio/adc/ad7606_ring.c           |   28 +----------
>  drivers/staging/iio/adc/ad7793.c                |   35 +++----------
>  drivers/staging/iio/adc/ad7887.h                |    5 --
>  drivers/staging/iio/adc/ad7887_core.c           |    2 +-
>  drivers/staging/iio/adc/ad7887_ring.c           |   44 ++---------------
>  drivers/staging/iio/adc/ad799x.h                |    6 --
>  drivers/staging/iio/adc/ad799x_core.c           |    3 +-
>  drivers/staging/iio/adc/ad799x_ring.c           |   45 ++++--------------
>  drivers/staging/iio/adc/max1363.h               |    7 ---
>  drivers/staging/iio/adc/max1363_core.c          |   51 ++++++++------------
>  drivers/staging/iio/adc/max1363_ring.c          |   38 +--------------
>  drivers/staging/iio/buffer.h                    |   33 -------------
>  drivers/staging/iio/gyro/adis16260_ring.c       |    9 ++--
>  drivers/staging/iio/iio.h                       |   16 ++++++
>  drivers/staging/iio/iio_simple_dummy_buffer.c   |   12 ++--
>  drivers/staging/iio/impedance-analyzer/ad5933.c |   16 ++++---
>  drivers/staging/iio/imu/adis16400_ring.c        |   23 +++++----
>  drivers/staging/iio/industrialio-buffer.c       |   37 ++++----------
>  drivers/staging/iio/kfifo_buf.c                 |    2 -
>  drivers/staging/iio/meter/ade7758_ring.c        |   10 ++--
>  drivers/staging/iio/ring_sw.c                   |   35 -------------
>  39 files changed, 177 insertions(+), 553 deletions(-)
> 

