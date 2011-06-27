Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E08718C.6090607@cam.ac.uk>
Date: Mon, 27 Jun 2011 13:03:24 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: greg@kroah.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/54] staging:iio: driving towards removal of dev_data
 pointer
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk> <4E08672C.8060101@cam.ac.uk>
In-Reply-To: <4E08672C.8060101@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>


> Greg, please hold off on this set for a little while.
> I've spotted a clanger of a bug so want to take another look at
> these.
Up shot of rechecking these was 3 other instances of the same
bug.  Will repost fixed set in a mo.  I'll drop Michael's
new driver as that shouldn't really have been in this set
anyway + I somehow dropped one of the conversions away from
dev_data that should have been so have put that one back in.

All in all, far from my finest hour...

I'll just send the new round to Greg rather than continuing to
fill every one's in boxes.

For reference effected drivers were:
kxsd9, ad7745, ad7150, adt7410 and isl29018.

Jonathan
 
> Sorry for wasting your time!
> 
> Jonathan
>> Hi Greg,
>>
>> This series is mostly about using the iio_priv infrastructure we
>> introduced in the last big series and hence getting rid of the
>> previous allocation method.
>>
>> Along the way a lot of individual drivers have their spi buffers
>> moved into their chip specific structures with appropriate marking
>> as cacheline aligned.
>>
>> There are a few other bits a pieces of cleanup and the series includes
>> a few fixes / new features (and one sneeky new driver) you may have
>> already merged.  They are here because parts of this series depend
>> on parts of that one.
>>
>> The final few patches (including actually removing said pointer)
>> are waiting for an ack from Jon at TAOS but that may take a while
>> (he has sent apologies!) so no point in holding up all the others!
>>
>> Jonathan
>>
>> p.s. It may be a fairly quiet cycle for IIO.  Everyone seems
>> rather busy at the mo!
>>
>>
>> Jonathan Cameron (47):
>>   staging:iio:accel:adis16203 move buffers into state and use iio_priv
>>     to avoid allocating state separately.
>>   staging:iio:accel:adis16204 allocate tx and rx in state plus state
>>     via iio_priv
>>   staging:iio:accel:adis16209 allocate tx and rx in state plus state
>>     via iio_priv
>>   staging:iio:accel:adis16240 allocate tx and rx in state plus state
>>     via iio_priv
>>   staging:iio:accel:adis16220 allocate tx and rx in state plus state
>>     via iio_priv
>>   staging:iio:accel:sca3000: allocate state in iio_dev and use iio_priv
>>     to access.
>>   staging:iio:accel:kxsd9: allocate state with iio_dev and use iio_priv
>>     to access.
>>   staging:iio:adc:ad7476 allocate state with iio_dev and use iio_priv
>>     to access.
>>   staging:iio:adc:ad7887 clear out last few uses of iio_dev->dev_data.
>>   staging:iio:adc:ad799x clear out last few uses of iio_dev->dev_data.
>>   staging:iio:adc:ad7150: allocate chip state with iio_dev and use
>>     iio_priv to access.
>>   staging:iio:adc:ad7152: allocate chip state with iio_dev and use
>>     iio_priv for access.
>>   staging:iio:adc:ad7291: allocate chip state with iio_dev and use
>>     iio_priv for access.
>>   staging:iio:adc:ad7314 allocate chip state with iio_dev and use
>>     iio_priv to access.
>>   staging:iio:adc:ad7745 allocate chip state with iio_dev and use
>>     iio_priv to access.
>>   staging:iio:adc:ad7816: allocate chip state with iio_dev and use
>>     iio_priv to access.
>>   staging:iio:adc:adt75: allocate chip state with iio_dev and cleanup
>>     some function calls.
>>   staging:iio:adc:adt7310: allocate chip state with iio_dev and use
>>     iio_priv for access.
>>   staging:iio:addac:adt7316: allocate chip state with iio_dev and use
>>     iio_priv to access.
>>   staging:iio:dac:ad5624r: allocate chip state with iio_dev and use
>>     iio_priv for access.
>>   staging:iio:dac:ad5504: allocate chip state with iio_dev and use
>>     iio_priv for access.
>>   staging:iio:dac:ad5446: allocate chip state with iio_dev and use
>>     iio_priv for access.
>>   staging:iio:dac:ad5791: allocate chip state with iio_dev and use
>>     iio_priv for access.
>>   staging:iio:dac:max517: allocate chip state with iio_dev and use
>>     iio_priv to access it.
>>   staging:iio:dds:ad5930 Fix attr group location + allocate state with
>>     iio_dev
>>   staging:iio:dds:ad9832: allocate chip state with iio_dev and use
>>     iio_priv to access.
>>   staging:iio:ad9834: allocate chip state with iio_dev and use iio_priv
>>     to access.
>>   staging:iio:dds:ad9850 allocate chip state with iio_dev + fix name of
>>     attr group.
>>   staging:iio:dds:ad9810: allocate chip state with iio_dev and use
>>     iio_priv for access.
>>   staging:iio:dds:ad9910: allocate chip state with iio_dev
>>   staging:iio:dds:ad9951: allocate chip state with iio_dev
>>   staging:iio:gyro:adis16060 allocate chip state with iio_dev.
>>   staging:iio:gyro:adis16080: allocate chip state with iio_dev
>>   staging:iio:gyro:adis16130: allocate chip state with iio_dev and use
>>     iio_priv to access it.
>>   staging:iio:gyro:adis16260: allocate chip state with iio_dev and use
>>     iio_priv to access.
>>   staging:iio:gyro:adxrs450: allocate chip state with iio_dev
>>   staging:iio:meter:ade7753 allocate chip state with iio_dev; allocate
>>     buffers within state
>>   staging:iio:meter:ade7754: allocate state with iio_dev and buffers in
>>     state.
>>   staging:iio:meter:ade7854: Allocate buffers in state and state with
>>     iio_dev.
>>   staging:iio:resolver:ad2s1210 general driver cleanup.
>>   staging:iio:resolver:ad2s120x cleanup.
>>   staging:iio:resolver:ad2s90 general cleanup
>>   staging:iio:magnetometer:ak8975: allocate chip state with iio_dev.
>>   staging:iio:meter:ade7759: allocate state with iio_dev
>>   staging:iio:magnetometer:hmc5843: allocate device state with iio_dev.
>>   staging:iio:light:isl29018: allocate device state with iio_dev
>>   staging:iio:accel:adis16201 general cleanup, move to iio_priv and
>>     buffers in adis16201_state
>>
>> Michael Hennerich (5):
>>   iio: industrialio-core: introduce IIO_VAL_INT_PLUS_NANO
>>   iio: trigger: Move declaration of struct iio_poll_func to avoid
>>     warnings
>>   iio: trigger: Add filter callback
>>   iio: industrialio-core: iio_write_channel_info accept
>>     IIO_VAL_INT_PLUS_NANO
>>   IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI ADC
>>
>> anish (1):
>>   staging: IIO corrected the spelling in iio-trig-gpio
>>
>> anish kumar (1):
>>   staging:iio:accel:kxsd9 replace kmallocs in power_up with use of
>>     already allocated buffer.
>>
>>  drivers/staging/iio/accel/adis16201.h         |   12 +-
>>  drivers/staging/iio/accel/adis16201_core.c    |  125 ++--
>>  drivers/staging/iio/accel/adis16201_ring.c    |    8 +-
>>  drivers/staging/iio/accel/adis16201_trigger.c |   11 +-
>>  drivers/staging/iio/accel/adis16203.h         |   12 +-
>>  drivers/staging/iio/accel/adis16203_core.c    |   85 +--
>>  drivers/staging/iio/accel/adis16203_ring.c    |    8 +-
>>  drivers/staging/iio/accel/adis16203_trigger.c |   17 +-
>>  drivers/staging/iio/accel/adis16204.h         |   12 +-
>>  drivers/staging/iio/accel/adis16204_core.c    |   84 +--
>>  drivers/staging/iio/accel/adis16204_ring.c    |    8 +-
>>  drivers/staging/iio/accel/adis16204_trigger.c |   11 +-
>>  drivers/staging/iio/accel/adis16209.h         |   12 +-
>>  drivers/staging/iio/accel/adis16209_core.c    |   82 +--
>>  drivers/staging/iio/accel/adis16209_ring.c    |    8 +-
>>  drivers/staging/iio/accel/adis16209_trigger.c |   17 +-
>>  drivers/staging/iio/accel/adis16220.h         |   14 +-
>>  drivers/staging/iio/accel/adis16220_core.c    |  105 +--
>>  drivers/staging/iio/accel/adis16240.h         |   12 +-
>>  drivers/staging/iio/accel/adis16240_core.c    |   82 +--
>>  drivers/staging/iio/accel/adis16240_ring.c    |    8 +-
>>  drivers/staging/iio/accel/adis16240_trigger.c |   17 +-
>>  drivers/staging/iio/accel/kxsd9.c             |  102 +--
>>  drivers/staging/iio/accel/sca3000.h           |    1 -
>>  drivers/staging/iio/accel/sca3000_core.c      |   99 ++--
>>  drivers/staging/iio/accel/sca3000_ring.c      |   14 +-
>>  drivers/staging/iio/adc/Kconfig               |   14 +
>>  drivers/staging/iio/adc/Makefile              |    1 +
>>  drivers/staging/iio/adc/ad7150.c              |   91 +--
>>  drivers/staging/iio/adc/ad7152.c              |   73 +-
>>  drivers/staging/iio/adc/ad7291.c              |   85 +--
>>  drivers/staging/iio/adc/ad7314.c              |   48 +-
>>  drivers/staging/iio/adc/ad7476.h              |    5 +-
>>  drivers/staging/iio/adc/ad7476_core.c         |   82 +-
>>  drivers/staging/iio/adc/ad7476_ring.c         |   10 +-
>>  drivers/staging/iio/adc/ad7745.c              |   79 +--
>>  drivers/staging/iio/adc/ad7793.c              |  987 +++++++++++++++++++++++++
>>  drivers/staging/iio/adc/ad7793.h              |  107 +++
>>  drivers/staging/iio/adc/ad7816.c              |   74 +-
>>  drivers/staging/iio/adc/ad7887_core.c         |    3 +-
>>  drivers/staging/iio/adc/ad7887_ring.c         |    6 +-
>>  drivers/staging/iio/adc/ad799x_core.c         |   13 +-
>>  drivers/staging/iio/adc/ad799x_ring.c         |    4 +-
>>  drivers/staging/iio/adc/adt7310.c             |   94 +--
>>  drivers/staging/iio/adc/adt75.c               |  123 ++--
>>  drivers/staging/iio/addac/adt7316.c           |  224 +++---
>>  drivers/staging/iio/dac/ad5446.c              |   82 +--
>>  drivers/staging/iio/dac/ad5446.h              |    2 -
>>  drivers/staging/iio/dac/ad5504.c              |   89 +--
>>  drivers/staging/iio/dac/ad5504.h              |    2 -
>>  drivers/staging/iio/dac/ad5624r.h             |    1 -
>>  drivers/staging/iio/dac/ad5624r_spi.c         |   82 +--
>>  drivers/staging/iio/dac/ad5791.c              |  112 ++--
>>  drivers/staging/iio/dac/ad5791.h              |    2 -
>>  drivers/staging/iio/dac/max517.c              |   40 +-
>>  drivers/staging/iio/dds/ad5930.c              |   37 +-
>>  drivers/staging/iio/dds/ad9832.c              |   69 +-
>>  drivers/staging/iio/dds/ad9832.h              |    2 -
>>  drivers/staging/iio/dds/ad9834.c              |   81 +--
>>  drivers/staging/iio/dds/ad9834.h              |    2 -
>>  drivers/staging/iio/dds/ad9850.c              |   37 +-
>>  drivers/staging/iio/dds/ad9852.c              |   38 +-
>>  drivers/staging/iio/dds/ad9910.c              |   36 +-
>>  drivers/staging/iio/dds/ad9951.c              |   36 +-
>>  drivers/staging/iio/gyro/adis16060_core.c     |   59 +-
>>  drivers/staging/iio/gyro/adis16080_core.c     |   48 +-
>>  drivers/staging/iio/gyro/adis16130_core.c     |   50 +-
>>  drivers/staging/iio/gyro/adis16260.h          |   18 +-
>>  drivers/staging/iio/gyro/adis16260_core.c     |   98 +--
>>  drivers/staging/iio/gyro/adis16260_ring.c     |    9 +-
>>  drivers/staging/iio/gyro/adis16260_trigger.c  |   15 +-
>>  drivers/staging/iio/gyro/adxrs450.h           |   13 +-
>>  drivers/staging/iio/gyro/adxrs450_core.c      |   71 +--
>>  drivers/staging/iio/iio.h                     |   15 +
>>  drivers/staging/iio/industrialio-core.c       |   32 +-
>>  drivers/staging/iio/industrialio-trigger.c    |   20 +-
>>  drivers/staging/iio/light/isl29018.c          |   52 +-
>>  drivers/staging/iio/magnetometer/ak8975.c     |   91 +--
>>  drivers/staging/iio/magnetometer/hmc5843.c    |   50 +-
>>  drivers/staging/iio/meter/ade7753.c           |   79 +--
>>  drivers/staging/iio/meter/ade7753.h           |   10 +-
>>  drivers/staging/iio/meter/ade7754.c           |   80 +--
>>  drivers/staging/iio/meter/ade7754.h           |   12 +-
>>  drivers/staging/iio/meter/ade7759.c           |   80 +--
>>  drivers/staging/iio/meter/ade7759.h           |   12 +-
>>  drivers/staging/iio/meter/ade7854-i2c.c       |   39 +-
>>  drivers/staging/iio/meter/ade7854-spi.c       |   40 +-
>>  drivers/staging/iio/meter/ade7854.c           |   76 +--
>>  drivers/staging/iio/meter/ade7854.h           |   36 +-
>>  drivers/staging/iio/resolver/Kconfig          |   27 -
>>  drivers/staging/iio/resolver/ad2s120x.c       |  196 +----
>>  drivers/staging/iio/resolver/ad2s1210.c       |  856 ++++++++++------------
>>  drivers/staging/iio/resolver/ad2s1210.h       |   17 +
>>  drivers/staging/iio/resolver/ad2s90.c         |   48 +-
>>  drivers/staging/iio/trigger.h                 |   52 +-
>>  drivers/staging/iio/trigger/iio-trig-gpio.c   |    2 +-
>>  96 files changed, 3217 insertions(+), 2925 deletions(-)
>>  create mode 100644 drivers/staging/iio/adc/ad7793.c
>>  create mode 100644 drivers/staging/iio/adc/ad7793.h
>>  create mode 100644 drivers/staging/iio/resolver/ad2s1210.h
>>
> 
> 
