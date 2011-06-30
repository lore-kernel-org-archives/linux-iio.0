Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E0C8DF5.5030805@cam.ac.uk>
Date: Thu, 30 Jun 2011 15:53:41 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 ldewangan@nvidia.com, shubhrajyoti@ti.com
Subject: Re: [PATCH 00/24] staging:iio: move chan_spec conversions and general
 cleanup.
References: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Sorry all. I've messed up the channel conversion patches in this series by
actually failing to set num_channels in any of them.

Will fix and repost and check I haven't made this particularly incompetent mistake
in previous patches...

Jonathan

> This series is intended to remove the last few users of accel.h, gyro.h, magnet.h
> and adc.h.
> 
> There are a fair few cleanps along the way including some bug fixes.
> 
> A few of these drivers are still in 'interesting' condition, but this
> is at least a step in the right direction. Taking them further probably
> requires test hardware.  Note this set is build tested only.
> (obviously for simple header removal that's enough, but others could do with
> testing if anyone has the hardware).
> 
> All comments welcome.
> 
> At some point we'll want to do the same for dds, resolver, dac and light.
> If anyone else wants to take one of those, feel free. *looks around hopefuly*
> 
> 
> This sits on top of
> 
> staging:iio:triggers introduce iio_trigger_ops to take const bits out of iio_trig_structure.
> + the dev_data removal patch and the tsl2583 one that Jon is testing.
> 
> Thanks all - looking like 3.1 is going to be a cleanup cycle for IIO
> rather than anything particularly ground breaking.  Of course it's
> relatively early days yet!
> 
> Thanks,
> 
> Jonathan
> 
> Jonathan Cameron (24):
>   staging:iio:accel:kxsd9 cleanup and conversion to iio_chan_spec.
>   staging:iio: add quadrature correction to chan info types.
>   staging:iio:gyro:adxrs450 move to iio_chan_spec registration
>   staging:iio:gyro:adxrs450 make more use of spi_read and spi_write.
>   staging:iio:gyro:adxrs450 squish some trivial single call point
>     wrappers functions.
>   staging:iio:gyro:adis16080 convert to iio_chan_spec.
>   staging:iio:gyro:adis16260 remove some unused headers
>   staging:iio:imu:adis16400 remove unused headers.
>   staging:iio:magnetometer:ak8975 convert to iio_chan_spec + cleanups.
>   staging:iio:magnetometer:hmc5843 iio_chan_spec conversion.
>   staging:iio:magnetometer: remove unused header magnet.h
>   staging:iio:gyro:adis16130 fix adis16130_spi_read which was never
>     selecting the channel
>   staging:iio:gyro:adis16130 drop control of adc resolution.
>   staging:iio:gyro:adis16130 move to iio_chan_spec registration.
>   staging:iio:gyro:adis16060 convert to iio_chan_spec
>   staging:iio:gyro: remove gyro.h
>   staging:iio:accel: usused header removals.
>   staging:iio:inclinometer.h remove as now unused.
>   staging:iio:adc: unused header removals.
>   staging:iio:various  header includes that should never have been.
>   staging:iio:accel:adis16204:  use peak_raw info_mask element + push
>     some defs down from header.
>   staging:iio:accel:adis16220 iio_chan_spec conversion.
>   staging:iio:accel remove unused accel.h header.
>   staging:iio:adc remove unused adc.h.
> 
>  drivers/staging/iio/accel/accel.h          |   87 -------
>  drivers/staging/iio/accel/adis16201_core.c |    4 -
>  drivers/staging/iio/accel/adis16201_ring.c |    1 -
>  drivers/staging/iio/accel/adis16203_core.c |    3 -
>  drivers/staging/iio/accel/adis16203_ring.c |    1 -
>  drivers/staging/iio/accel/adis16204_core.c |   47 +++--
>  drivers/staging/iio/accel/adis16204_ring.c |    1 -
>  drivers/staging/iio/accel/adis16209_core.c |    3 -
>  drivers/staging/iio/accel/adis16209_ring.c |    1 -
>  drivers/staging/iio/accel/adis16220_core.c |  340 +++++++++++++++++-----------
>  drivers/staging/iio/accel/adis16240_core.c |    2 -
>  drivers/staging/iio/accel/adis16240_ring.c |    1 -
>  drivers/staging/iio/accel/inclinometer.h   |   25 --
>  drivers/staging/iio/accel/kxsd9.c          |  267 +++++++++-------------
>  drivers/staging/iio/accel/lis3l02dq_core.c |    2 -
>  drivers/staging/iio/accel/lis3l02dq_ring.c |    1 -
>  drivers/staging/iio/accel/sca3000_core.c   |    1 -
>  drivers/staging/iio/accel/sca3000_ring.c   |    1 -
>  drivers/staging/iio/adc/ad7298_core.c      |    1 -
>  drivers/staging/iio/adc/ad7476_core.c      |    1 -
>  drivers/staging/iio/adc/ad7606_core.c      |    1 -
>  drivers/staging/iio/adc/ad7780.c           |    1 -
>  drivers/staging/iio/adc/ad7793.c           |    1 -
>  drivers/staging/iio/adc/ad7887_core.c      |    2 +-
>  drivers/staging/iio/adc/ad799x_core.c      |   13 +-
>  drivers/staging/iio/adc/adc.h              |   42 ----
>  drivers/staging/iio/adc/max1363_core.c     |   23 ++-
>  drivers/staging/iio/gyro/adis16060_core.c  |  113 +++++-----
>  drivers/staging/iio/gyro/adis16080_core.c  |   91 ++++----
>  drivers/staging/iio/gyro/adis16130_core.c  |  143 ++++---------
>  drivers/staging/iio/gyro/adis16260_core.c  |    2 -
>  drivers/staging/iio/gyro/adis16260_ring.c  |    1 -
>  drivers/staging/iio/gyro/adxrs450_core.c   |  251 +++++++++------------
>  drivers/staging/iio/gyro/gyro.h            |   85 -------
>  drivers/staging/iio/iio.h                  |    3 +
>  drivers/staging/iio/imu/adis16400_core.c   |    5 -
>  drivers/staging/iio/imu/adis16400_ring.c   |    1 -
>  drivers/staging/iio/industrialio-core.c    |    2 +
>  drivers/staging/iio/magnetometer/ak8975.c  |  213 +++++++++---------
>  drivers/staging/iio/magnetometer/hmc5843.c |   95 ++++----
>  drivers/staging/iio/magnetometer/magnet.h  |   31 ---
>  drivers/staging/iio/meter/ade7758_ring.c   |    1 -
>  42 files changed, 782 insertions(+), 1128 deletions(-)
>  delete mode 100644 drivers/staging/iio/accel/accel.h
>  delete mode 100644 drivers/staging/iio/accel/inclinometer.h
>  delete mode 100644 drivers/staging/iio/adc/adc.h
>  delete mode 100644 drivers/staging/iio/gyro/gyro.h
>  delete mode 100644 drivers/staging/iio/magnetometer/magnet.h
> 
