Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:53310 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751220Ab2KJMxB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Nov 2012 07:53:01 -0500
Message-ID: <509E4E50.7020707@metafoo.de>
Date: Sat, 10 Nov 2012 13:53:36 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL]  IIO cleanups and fixes (IIO set 4 for the 3.8 cycle)
References: <509E34F4.40204@kernel.org>
In-Reply-To: <509E34F4.40204@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/2012 12:05 PM, Jonathan Cameron wrote:
> The following changes since commit 3c7f0c2b1150eae8683a98a5a9143d81edfc2762:
> 
>   staging:iio:adis16400: Set the PROD_ID flag for the adis16334 (2012-11-04 15:55:44 +0000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.8d

Hi Jonathan,

Did you push this? There is only the iio-for-3.8c tag

Thanks,
- Lars

> 
> for you to fetch changes up to 168c9d95a94077a42e5bf5a4a660b45ccee4fc63:
> 
>   iio:adc:max1363 move from staging. (2012-11-10 10:17:31 +0000)
> 
> ----------------------------------------------------------------
> 4th set of IIO driver updates and new functionality for the 3.8 cycle.
> 
> 2 drivers going through final cleanup and moving out of staging.
> 
> Addition to the core of support for multiple buffers from a single
> datastream.  This functionality is core in allowing multiple users
> of interrupt driven data streams from the devices.  First user
> will shortly be an input bridge driver.  This has been in review
> / revision for over a year resulting in a far cleaner result.
> Much of the work had been in precursor patches. Here we just
> add the buffer set tear up and down support + switch to multiple
> buffer pushing in the drivers (a one line change in all users).
> Thanks to those who have tested / reviewed this set.
> 
> ----------------------------------------------------------------
> Jonathan Cameron (10):
>       staging:iio: Add support for multiple buffers
>       staging:iio:in kernel users: Add a data field for channel specific info.
>       staging:iio: add a callback buffer for in kernel push interface
>       staging:iio:adc:max1363 ring_sw->kfifo conversion
>       staging:iio:adc:max1363 consolidate files.
>       staging:iio:adc:max1363 drop references to 'ring' given now using a fifo
>       staging:iio:adc:max1363 make docs match the contents of max1363_chip_info
>       staging:iio:adc:max1363 white space cleanup
>       staging:iio:adc:max1363 cleanup regulator handling.
>       iio:adc:max1363 move from staging.
> 
> Lars-Peter Clausen (7):
>       staging:iio:ad7887: Preallocate sample buffer
>       staging:iio:ad7887: Rework regulator handling
>       staging:iio:ad7887: Squash everything into one file
>       staging:iio:ad7887: Use proper kernel doc
>       staging:iio:ad7887: Allow to use internal ref in two channel mode
>       staging:iio:ad7887: Use passed in chan spec in ad7887_read_raw
>       staging:iio: Move the ad7887 driver out of staging
> 
>  drivers/iio/Kconfig                                |   6 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/accel/hid-sensor-accel-3d.c            |  15 +-
>  drivers/iio/adc/Kconfig                            |  31 ++
>  drivers/iio/adc/Makefile                           |   2 +
>  drivers/iio/adc/ad7266.c                           |   3 +-
>  drivers/iio/adc/ad7476.c                           |   2 +-
>  .../iio/adc/ad7887_core.c => iio/adc/ad7887.c}     | 217 +++++++++---
>  drivers/iio/adc/ad_sigma_delta.c                   |   2 +-
>  drivers/iio/adc/at91_adc.c                         |   3 +-
>  .../iio/adc/max1363_core.c => iio/adc/max1363.c}   | 330 ++++++++++++++++--
>  drivers/iio/buffer_cb.c                            | 113 ++++++
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              |  15 +-
>  drivers/iio/industrialio-buffer.c                  | 380 ++++++++++++++-------
>  drivers/iio/industrialio-core.c                    |   1 +
>  drivers/iio/inkern.c                               |   1 +
>  drivers/iio/light/adjd_s311.c                      |   3 +-
>  drivers/iio/light/hid-sensor-als.c                 |  15 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  15 +-
>  drivers/staging/iio/accel/adis16201_ring.c         |   2 +-
>  drivers/staging/iio/accel/adis16203_ring.c         |   2 +-
>  drivers/staging/iio/accel/adis16204_ring.c         |   2 +-
>  drivers/staging/iio/accel/adis16209_ring.c         |   2 +-
>  drivers/staging/iio/accel/adis16240_ring.c         |   2 +-
>  drivers/staging/iio/accel/lis3l02dq_ring.c         |   2 +-
>  drivers/staging/iio/adc/Kconfig                    |  37 --
>  drivers/staging/iio/adc/Makefile                   |   9 -
>  drivers/staging/iio/adc/ad7298_ring.c              |   2 +-
>  drivers/staging/iio/adc/ad7606_ring.c              |   2 +-
>  drivers/staging/iio/adc/ad7887.h                   |  99 ------
>  drivers/staging/iio/adc/ad7887_ring.c              | 122 -------
>  drivers/staging/iio/adc/ad799x_ring.c              |   2 +-
>  drivers/staging/iio/adc/max1363.h                  | 177 ----------
>  drivers/staging/iio/adc/max1363_ring.c             | 139 --------
>  drivers/staging/iio/adc/mxs-lradc.c                |   3 +-
>  drivers/staging/iio/gyro/adis16260_ring.c          |   2 +-
>  drivers/staging/iio/iio_simple_dummy_buffer.c      |   5 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c    |   4 +-
>  drivers/staging/iio/imu/adis16400_ring.c           |   5 +-
>  drivers/staging/iio/meter/ade7758_ring.c           |   2 +-
>  include/linux/iio/buffer.h                         |  24 +-
>  include/linux/iio/consumer.h                       |  48 +++
>  include/linux/iio/iio.h                            |   2 +
>  include/linux/iio/machine.h                        |   2 +
>  include/linux/platform_data/ad7887.h               |  26 ++
>  45 files changed, 1003 insertions(+), 876 deletions(-)
>  rename drivers/{staging/iio/adc/ad7887_core.c => iio/adc/ad7887.c} (50%)
>  rename drivers/{staging/iio/adc/max1363_core.c => iio/adc/max1363.c} (81%)
>  create mode 100644 drivers/iio/buffer_cb.c
>  delete mode 100644 drivers/staging/iio/adc/ad7887.h
>  delete mode 100644 drivers/staging/iio/adc/ad7887_ring.c
>  delete mode 100644 drivers/staging/iio/adc/max1363.h
>  delete mode 100644 drivers/staging/iio/adc/max1363_ring.c
>  create mode 100644 include/linux/platform_data/ad7887.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

