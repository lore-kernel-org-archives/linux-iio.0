Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:35345 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0JXX31 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 19:29:27 -0400
Message-ID: <4CC4C2B8.2@cam.ac.uk>
Date: Mon, 25 Oct 2010 00:35:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 00/36] staging: iio: ADI drivers for staging-next
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/10 22:22, Mike Frysinger wrote:
> I've rebased all the drivers onto staging-next.  I've only fixed the API
> breakage due to the changes made after 2.6.36 (and fixed a few warnings).
> I've also run checkpatch across these.
> 
> I have not however addressed any real feedback Jonathan has provided with
> regards to driver correctness or direction.  That stuff I'm leaving up to
> Michael Hennerich since it's his job and he actually understands this.
> 
> Where possible, I'd like to have drivers merged so as to avoid another
> round of "new API just broke all your drivers".  We will still look into
> feedback given, but we'd like to focus on that rather than random `sed`
> changes as API names change.
> 
> This patchset supersedes all other "new driver" patches I've posted in the
> last 48 hours.
> 
As we are still in staging, I'm happy to see these merge into IIO with some provisos
(this wouldn't be acceptable anywhere else in the kernel tree).

* We will be breaking abi's and probably even config symbol names cleaning these up.
  So if your customers start complaining you get to explain why to them :)

* We sought out some test coverage for these. I want someone I can poke if we
  get a bug report, happy to use a generic address as long as someone is able
  to respond in reasonable time! (no complaints so far with Analog, but this is
  a lot of new devices for someone to have wired up somewhere)

* If Randy or any one else reports build issues with weird combinations, someone
  other than me quickly fixes them.

* I want some proper proposals of abi's for the new classes of device. Lets debate
  these on list. I would probably get round to doing this myself eventually, but
  if someone who knows the device class does it, things will proceed much faster.
  I've never used a resolver and had to google what they were ;)
  Having poorly defined abi's has bitten us a few times in the past and tends to
  put others off using the subsystem.  So lets at least bash out what they should
  be even if it takes a little while to bring the drivers up to date.

* As per standard staging rules, I will ask Greg to drop any driver that no one is
  willing to support.  I will give plenty of warning of course!

* Some of the temp chips might want to be in hwmon. I would like to see an open
  discussion across both lists of whether then should be in IIO or there (or both).

The negatives of merging this set as is are that people might copy code with issues
we haven't fixed yet.  Such is life I guess. We could put a big note in the TODO
file, but then, who reads that?

So if there are no other issues raised send them on to Greg KH (feel free to say
I ack the merging of the set if not individual drivers as haven't looked at
them all yet, and it will be about a month before I have enough time).

Mike, thanks for all your work on this.

Jonathan

> Barry Song (16):
>   staging: iio: new adis16201 driver
>   staging: iio: new adis16203 driver
>   staging: iio: new adis16204 driver
>   staging: iio: adc: new driver for AD7150/1/6 devices
>   staging: iio: adc: new driver for AD7152/3 devices
>   staging: iio: adc: new driver for AD7745/6/7 devices
>   staging: iio: gyro: new driver for ADIS16261 devices
>   staging: iio: gyro: new driver for ADIS16060 digital output gyros
>   staging: iio: gyro: new driver for ADIS16080 digital output gyros
>   staging: iio: gyro: new driver for ADIS16130 digital output gyros
>   staging: iio: dac: new driver for AD5624R devices
>   staging: iio: meter: new driver for ADE7753/6 devices
>   staging: iio: meter: new driver for ADE7754 devices
>   staging: iio: meter: new driver for ADE7758 devices
>   staging: iio: meter: new driver for ADE7759 devices
>   staging: iio: meter: new driver for ADE7854/58/68/78 devices
> 
> Cliff Cai (6):
>   staging: iio: dds: new driver for AD5930/2 devices
>   staging: iio: dds: new driver for AD9832/3/4/5 devices
>   staging: iio: dds: new driver for AD9850/1 devices
>   staging: iio: dds: new driver for AD9852/4 devices
>   staging: iio: dds: new driver for AD9910 devices
>   staging: iio: dds: new driver for AD9951 devices
> 
> Graf Yang (3):
>   staging: iio: resolver: new driver for AD2S90 devices
>   staging: iio: resolver: new driver for AD2S1200/1205 devices
>   staging: iio: resolver: new driver for AD2S1210 devices
> 
> Sonic Zhang (11):
>   staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver
>   staging: iio: adc: new driver for AD7291 devices
>   staging: iio: adc: new driver for AD7298 devices
>   staging: iio: adc: new driver for AD7314 devices
>   staging: iio: adc: new driver for AD7414/5 devices
>   staging: iio: adc: new driver for AD7416/7/8 devices
>   staging: iio: adc: new driver for AD7816 devices
>   staging: iio: adc: new driver for ADT75 temperature sensors
>   staging: iio: adc: new driver for ADT7310 temperature sensors
>   staging: iio: adc: new driver for ADT7408 temperature sensors
>   staging: iio: adc: new driver for ADT7410 temperature sensors
> 
>  drivers/staging/iio/Kconfig                   |    6 +-
>  drivers/staging/iio/Makefile                  |    7 +-
>  drivers/staging/iio/accel/Kconfig             |   27 +
>  drivers/staging/iio/accel/Makefile            |   12 +
>  drivers/staging/iio/accel/accel.h             |   20 +
>  drivers/staging/iio/accel/adis16201.h         |  150 ++
>  drivers/staging/iio/accel/adis16201_core.c    |  640 +++++++
>  drivers/staging/iio/accel/adis16201_ring.c    |  218 +++
>  drivers/staging/iio/accel/adis16201_trigger.c |  122 ++
>  drivers/staging/iio/accel/adis16203.h         |  143 ++
>  drivers/staging/iio/accel/adis16203_core.c    |  568 ++++++
>  drivers/staging/iio/accel/adis16203_ring.c    |  211 +++
>  drivers/staging/iio/accel/adis16203_trigger.c |  122 ++
>  drivers/staging/iio/accel/adis16204.h         |  151 ++
>  drivers/staging/iio/accel/adis16204_core.c    |  613 +++++++
>  drivers/staging/iio/accel/adis16204_ring.c    |  206 +++
>  drivers/staging/iio/accel/adis16204_trigger.c |  122 ++
>  drivers/staging/iio/adc/Kconfig               |   91 +
>  drivers/staging/iio/adc/Makefile              |   15 +
>  drivers/staging/iio/adc/ad7150.c              |  877 +++++++++
>  drivers/staging/iio/adc/ad7152.c              |  610 +++++++
>  drivers/staging/iio/adc/ad7291.c              | 1039 +++++++++++
>  drivers/staging/iio/adc/ad7298.c              |  501 +++++
>  drivers/staging/iio/adc/ad7314.c              |  308 ++++
>  drivers/staging/iio/adc/ad7414.c              |  573 ++++++
>  drivers/staging/iio/adc/ad7416.c              |  777 ++++++++
>  drivers/staging/iio/adc/ad774x.c              |  719 ++++++++
>  drivers/staging/iio/adc/ad7816.c              |  538 ++++++
>  drivers/staging/iio/adc/adt7310.c             |  951 ++++++++++
>  drivers/staging/iio/adc/adt7408.c             | 1006 +++++++++++
>  drivers/staging/iio/adc/adt7410.c             |  917 ++++++++++
>  drivers/staging/iio/adc/adt75.c               |  734 ++++++++
>  drivers/staging/iio/addac/Kconfig             |   25 +
>  drivers/staging/iio/addac/Makefile            |    7 +
>  drivers/staging/iio/addac/adt7316-i2c.c       |  169 ++
>  drivers/staging/iio/addac/adt7316-spi.c       |  179 ++
>  drivers/staging/iio/addac/adt7316.c           | 2402 +++++++++++++++++++++++++
>  drivers/staging/iio/addac/adt7316.h           |   33 +
>  drivers/staging/iio/dac/Kconfig               |   11 +
>  drivers/staging/iio/dac/Makefile              |    5 +
>  drivers/staging/iio/dac/ad5624r.h             |   21 +
>  drivers/staging/iio/dac/ad5624r_spi.c         |  313 ++++
>  drivers/staging/iio/dac/dac.h                 |    6 +
>  drivers/staging/iio/dds/Kconfig               |   46 +
>  drivers/staging/iio/dds/Makefile              |   10 +
>  drivers/staging/iio/dds/ad5930.c              |  170 ++
>  drivers/staging/iio/dds/ad9832.c              |  266 +++
>  drivers/staging/iio/dds/ad9850.c              |  156 ++
>  drivers/staging/iio/dds/ad9852.c              |  314 ++++
>  drivers/staging/iio/dds/ad9910.c              |  454 +++++
>  drivers/staging/iio/dds/ad9951.c              |  254 +++
>  drivers/staging/iio/gyro/Kconfig              |   28 +
>  drivers/staging/iio/gyro/Makefile             |   12 +
>  drivers/staging/iio/gyro/adis16060.h          |  101 +
>  drivers/staging/iio/gyro/adis16060_core.c     |  319 ++++
>  drivers/staging/iio/gyro/adis16080.h          |  102 ++
>  drivers/staging/iio/gyro/adis16080_core.c     |  271 +++
>  drivers/staging/iio/gyro/adis16130.h          |  108 ++
>  drivers/staging/iio/gyro/adis16130_core.c     |  313 ++++
>  drivers/staging/iio/gyro/adis16261.h          |  176 ++
>  drivers/staging/iio/gyro/adis16261_core.c     |  770 ++++++++
>  drivers/staging/iio/meter/Kconfig             |   61 +
>  drivers/staging/iio/meter/Makefile            |   15 +
>  drivers/staging/iio/meter/ade7753.c           |  730 ++++++++
>  drivers/staging/iio/meter/ade7753.h           |  140 ++
>  drivers/staging/iio/meter/ade7754.c           |  756 ++++++++
>  drivers/staging/iio/meter/ade7754.h           |  161 ++
>  drivers/staging/iio/meter/ade7758.h           |  171 ++
>  drivers/staging/iio/meter/ade7758_core.c      |  866 +++++++++
>  drivers/staging/iio/meter/ade7758_ring.c      |  212 +++
>  drivers/staging/iio/meter/ade7758_trigger.c   |  125 ++
>  drivers/staging/iio/meter/ade7759.c           |  670 +++++++
>  drivers/staging/iio/meter/ade7759.h           |  122 ++
>  drivers/staging/iio/meter/ade7854-i2c.c       |  272 +++
>  drivers/staging/iio/meter/ade7854-spi.c       |  360 ++++
>  drivers/staging/iio/meter/ade7854.c           |  680 +++++++
>  drivers/staging/iio/meter/ade7854.h           |  244 +++
>  drivers/staging/iio/meter/meter.h             |  396 ++++
>  drivers/staging/iio/resolver/Kconfig          |   54 +
>  drivers/staging/iio/resolver/Makefile         |    7 +
>  drivers/staging/iio/resolver/ad2s120x.c       |  310 ++++
>  drivers/staging/iio/resolver/ad2s1210.c       |  872 +++++++++
>  drivers/staging/iio/resolver/ad2s90.c         |  159 ++
>  drivers/staging/iio/sysfs.h                   |    6 +
>  84 files changed, 27422 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/staging/iio/accel/adis16201.h
>  create mode 100644 drivers/staging/iio/accel/adis16201_core.c
>  create mode 100644 drivers/staging/iio/accel/adis16201_ring.c
>  create mode 100644 drivers/staging/iio/accel/adis16201_trigger.c
>  create mode 100644 drivers/staging/iio/accel/adis16203.h
>  create mode 100644 drivers/staging/iio/accel/adis16203_core.c
>  create mode 100644 drivers/staging/iio/accel/adis16203_ring.c
>  create mode 100644 drivers/staging/iio/accel/adis16203_trigger.c
>  create mode 100644 drivers/staging/iio/accel/adis16204.h
>  create mode 100644 drivers/staging/iio/accel/adis16204_core.c
>  create mode 100644 drivers/staging/iio/accel/adis16204_ring.c
>  create mode 100644 drivers/staging/iio/accel/adis16204_trigger.c
>  create mode 100644 drivers/staging/iio/adc/ad7150.c
>  create mode 100644 drivers/staging/iio/adc/ad7152.c
>  create mode 100644 drivers/staging/iio/adc/ad7291.c
>  create mode 100644 drivers/staging/iio/adc/ad7298.c
>  create mode 100644 drivers/staging/iio/adc/ad7314.c
>  create mode 100644 drivers/staging/iio/adc/ad7414.c
>  create mode 100644 drivers/staging/iio/adc/ad7416.c
>  create mode 100644 drivers/staging/iio/adc/ad774x.c
>  create mode 100644 drivers/staging/iio/adc/ad7816.c
>  create mode 100644 drivers/staging/iio/adc/adt7310.c
>  create mode 100644 drivers/staging/iio/adc/adt7408.c
>  create mode 100644 drivers/staging/iio/adc/adt7410.c
>  create mode 100644 drivers/staging/iio/adc/adt75.c
>  create mode 100644 drivers/staging/iio/addac/Kconfig
>  create mode 100644 drivers/staging/iio/addac/Makefile
>  create mode 100644 drivers/staging/iio/addac/adt7316-i2c.c
>  create mode 100644 drivers/staging/iio/addac/adt7316-spi.c
>  create mode 100644 drivers/staging/iio/addac/adt7316.c
>  create mode 100644 drivers/staging/iio/addac/adt7316.h
>  create mode 100644 drivers/staging/iio/dac/Kconfig
>  create mode 100644 drivers/staging/iio/dac/Makefile
>  create mode 100644 drivers/staging/iio/dac/ad5624r.h
>  create mode 100644 drivers/staging/iio/dac/ad5624r_spi.c
>  create mode 100644 drivers/staging/iio/dac/dac.h
>  create mode 100644 drivers/staging/iio/dds/Kconfig
>  create mode 100644 drivers/staging/iio/dds/Makefile
>  create mode 100644 drivers/staging/iio/dds/ad5930.c
>  create mode 100644 drivers/staging/iio/dds/ad9832.c
>  create mode 100644 drivers/staging/iio/dds/ad9850.c
>  create mode 100644 drivers/staging/iio/dds/ad9852.c
>  create mode 100644 drivers/staging/iio/dds/ad9910.c
>  create mode 100644 drivers/staging/iio/dds/ad9951.c
>  create mode 100644 drivers/staging/iio/gyro/adis16060.h
>  create mode 100644 drivers/staging/iio/gyro/adis16060_core.c
>  create mode 100644 drivers/staging/iio/gyro/adis16080.h
>  create mode 100644 drivers/staging/iio/gyro/adis16080_core.c
>  create mode 100644 drivers/staging/iio/gyro/adis16130.h
>  create mode 100644 drivers/staging/iio/gyro/adis16130_core.c
>  create mode 100644 drivers/staging/iio/gyro/adis16261.h
>  create mode 100644 drivers/staging/iio/gyro/adis16261_core.c
>  create mode 100644 drivers/staging/iio/meter/Kconfig
>  create mode 100644 drivers/staging/iio/meter/Makefile
>  create mode 100644 drivers/staging/iio/meter/ade7753.c
>  create mode 100644 drivers/staging/iio/meter/ade7753.h
>  create mode 100644 drivers/staging/iio/meter/ade7754.c
>  create mode 100644 drivers/staging/iio/meter/ade7754.h
>  create mode 100644 drivers/staging/iio/meter/ade7758.h
>  create mode 100644 drivers/staging/iio/meter/ade7758_core.c
>  create mode 100644 drivers/staging/iio/meter/ade7758_ring.c
>  create mode 100644 drivers/staging/iio/meter/ade7758_trigger.c
>  create mode 100644 drivers/staging/iio/meter/ade7759.c
>  create mode 100644 drivers/staging/iio/meter/ade7759.h
>  create mode 100644 drivers/staging/iio/meter/ade7854-i2c.c
>  create mode 100644 drivers/staging/iio/meter/ade7854-spi.c
>  create mode 100644 drivers/staging/iio/meter/ade7854.c
>  create mode 100644 drivers/staging/iio/meter/ade7854.h
>  create mode 100644 drivers/staging/iio/meter/meter.h
>  create mode 100644 drivers/staging/iio/resolver/Kconfig
>  create mode 100644 drivers/staging/iio/resolver/Makefile
>  create mode 100644 drivers/staging/iio/resolver/ad2s120x.c
>  create mode 100644 drivers/staging/iio/resolver/ad2s1210.c
>  create mode 100644 drivers/staging/iio/resolver/ad2s90.c
> 

