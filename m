Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55777 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab1DORyL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2011 13:54:11 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: jbrenner@taosinc.com, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/8 V2]
Date: Fri, 15 Apr 2011 18:55:52 +0100
Message-Id: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

A poorly ordered (sorry about that) set of fixes combined
with cleanups suggested by Arnd.  This is a precursor
to the more intersting (and intrusive) changes to follow.

As per earlier email this is based on, staging-next
with:

[PATCH V4]TAOS 258x: Device Driver
[PATCH 1/1] IIO: DAC: AD5446 add support for AD5541A devices
[PATCH 1/1] IIO: DAC: New driver for AD5791/AD5781 High Resolution Voltage Output DACs
[PATCH 1/3] IIO: GYRO: Add MACRO for gyro quadrature correction
(and rest of series)

on top.  You might not have the AD5791 one yet, but Michael
should send it to you shortly.

Original message was:

I should probably have broken these up into more coherent subsets
and made at least the allocate priv_data one an RFC.
May do so before sending on to Greg.

Patches 3, 4 and 6 are direct results of suggestions from Arnd Bergmann.
Basically it's the easy bits of the discussion before we get onto
the more 'interesting' ones.

1, 2 are things I spotted whilst working on the irq_chip stuff
Thomas Gleixner suggested.  They are just cleanups of some bizare
corners. That rewrite of triggers currently requires some
exports to be added to allow a modular build and I need to chase
down whether we are simply the first people to have a reasonable
case for it, or whether there is something more fundamental
going on.

The others are bugs / cleanups I came across whilst hammering
max1363 with the new example code. Some of the timestamp bit
was pointed out by Michael Hennerich a while back, but turns
out the driver was broken as well as not obeying the ABI.

Thanks,


Jonathan Cameron (8):
  staging:iio:trigger remove export of iio_trigger_find_by_name, use
    sysfs_streq for matching
  staging:iio: iio_trigger_unregister - remove rather strange search
    for what we already have.
  staging:iio: replace rip_lots naming with read_first_n
  staging:iio: Add ability to allocate private data space to
    iio_allocate_device
  staging:iio:adc:max1363 fix timestamp handling.
  staging:iio:adc: max1363 dev_info -> indio_dev in naming for
    consistency
  staging:iio:max1363 take advantage of new iio_device_allocate private
    data.
  staging:iio:documentation make read_size signed to allow for errors.

 drivers/staging/iio/Documentation/device.txt       |    2 +-
 drivers/staging/iio/Documentation/generic_buffer.c |    2 +-
 drivers/staging/iio/accel/adis16201_core.c         |    2 +-
 drivers/staging/iio/accel/adis16203_core.c         |    2 +-
 drivers/staging/iio/accel/adis16204_core.c         |    2 +-
 drivers/staging/iio/accel/adis16209_core.c         |    2 +-
 drivers/staging/iio/accel/adis16220_core.c         |    2 +-
 drivers/staging/iio/accel/adis16240_core.c         |    2 +-
 drivers/staging/iio/accel/kxsd9.c                  |    2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |    2 +-
 drivers/staging/iio/accel/sca3000_core.c           |    2 +-
 drivers/staging/iio/accel/sca3000_ring.c           |    8 +-
 drivers/staging/iio/adc/ad7150.c                   |    2 +-
 drivers/staging/iio/adc/ad7152.c                   |    2 +-
 drivers/staging/iio/adc/ad7291.c                   |    2 +-
 drivers/staging/iio/adc/ad7298_core.c              |    2 +-
 drivers/staging/iio/adc/ad7314.c                   |    2 +-
 drivers/staging/iio/adc/ad7476_core.c              |    2 +-
 drivers/staging/iio/adc/ad7606_core.c              |    2 +-
 drivers/staging/iio/adc/ad7745.c                   |    2 +-
 drivers/staging/iio/adc/ad7780.c                   |    2 +-
 drivers/staging/iio/adc/ad7816.c                   |    2 +-
 drivers/staging/iio/adc/ad7887_core.c              |    2 +-
 drivers/staging/iio/adc/ad799x_core.c              |    2 +-
 drivers/staging/iio/adc/adt7310.c                  |    2 +-
 drivers/staging/iio/adc/adt7410.c                  |    2 +-
 drivers/staging/iio/adc/adt75.c                    |    2 +-
 drivers/staging/iio/adc/max1363.h                  |    2 -
 drivers/staging/iio/adc/max1363_core.c             |  189 ++++++++++----------
 drivers/staging/iio/adc/max1363_ring.c             |   21 ++-
 drivers/staging/iio/addac/adt7316.c                |    2 +-
 drivers/staging/iio/dac/ad5446.c                   |    2 +-
 drivers/staging/iio/dac/ad5504.c                   |    2 +-
 drivers/staging/iio/dac/ad5624r_spi.c              |    2 +-
 drivers/staging/iio/dac/ad5791.c                   |    2 +-
 drivers/staging/iio/dac/max517.c                   |    2 +-
 drivers/staging/iio/dds/ad5930.c                   |    2 +-
 drivers/staging/iio/dds/ad9832.c                   |    2 +-
 drivers/staging/iio/dds/ad9834.c                   |    2 +-
 drivers/staging/iio/dds/ad9850.c                   |    2 +-
 drivers/staging/iio/dds/ad9852.c                   |    2 +-
 drivers/staging/iio/dds/ad9910.c                   |    2 +-
 drivers/staging/iio/dds/ad9951.c                   |    2 +-
 drivers/staging/iio/gyro/adis16060_core.c          |    2 +-
 drivers/staging/iio/gyro/adis16080_core.c          |    2 +-
 drivers/staging/iio/gyro/adis16130_core.c          |    2 +-
 drivers/staging/iio/gyro/adis16260_core.c          |    2 +-
 drivers/staging/iio/gyro/adxrs450_core.c           |    2 +-
 drivers/staging/iio/iio.h                          |   17 ++-
 drivers/staging/iio/imu/adis16300_core.c           |    2 +-
 drivers/staging/iio/imu/adis16350_core.c           |    2 +-
 drivers/staging/iio/imu/adis16400_core.c           |    2 +-
 drivers/staging/iio/industrialio-core.c            |   15 ++-
 drivers/staging/iio/industrialio-ring.c            |   12 +-
 drivers/staging/iio/industrialio-trigger.c         |   27 +--
 drivers/staging/iio/kfifo_buf.c                    |    8 +-
 drivers/staging/iio/kfifo_buf.h                    |   10 +-
 drivers/staging/iio/light/isl29018.c               |    2 +-
 drivers/staging/iio/light/tsl2563.c                |    2 +-
 drivers/staging/iio/light/tsl2583.c                |    2 +-
 drivers/staging/iio/magnetometer/ak8975.c          |    2 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |    2 +-
 drivers/staging/iio/meter/ade7753.c                |    2 +-
 drivers/staging/iio/meter/ade7754.c                |    2 +-
 drivers/staging/iio/meter/ade7758_core.c           |    2 +-
 drivers/staging/iio/meter/ade7759.c                |    2 +-
 drivers/staging/iio/meter/ade7854.c                |    2 +-
 drivers/staging/iio/resolver/ad2s120x.c            |    2 +-
 drivers/staging/iio/resolver/ad2s1210.c            |    2 +-
 drivers/staging/iio/resolver/ad2s90.c              |    2 +-
 drivers/staging/iio/ring_generic.h                 |   10 +-
 drivers/staging/iio/ring_sw.c                      |   13 +-
 drivers/staging/iio/ring_sw.h                      |   14 +-
 drivers/staging/iio/trigger.h                      |    7 -
 74 files changed, 242 insertions(+), 231 deletions(-)

-- 
1.7.3.4

