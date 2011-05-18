Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 000/111] IIO: chan_spec intro, generic irq based triggers,
Date: Wed, 18 May 2011 14:40:50 +0100
Message-Id: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Dear Greg,

Here is the set I mentioned was coming.

Thomas Gleixner just pushed the required irq patches to the tip tree
(though they aren't visible yet).

[tip:irq/core] genirq: Uninline and sanity check generic_handle_irq()
fe12bc2c996d3e492b2920e32ac79f7bbae3e15d

and

[tip:irq/core] irq: Export functions to allow modular irq drivers
edf76f8307c350bcb81f0c760118a991b3e62956

There are two other dependencies. One is a trivial missing header
in arm (patch on it's way through the arm tree). Doesn't break building
except on arm anyway.

The other is the strtobool that you added to driver-core
Add a strtobool function matching semantics of existing in kernel equivalents
ad58671cf32c74a8d6e8f51e63e9cf4e7a73bf1e

First some thanks are due:

Arnd Bergmann for a very useful 'review'.  We haven't yet done
everything Arnd suggested, but a lot of it is here.

Thomas Gleixner for suggesting how to handle the triggers without
reinventing the wheel.

Michael Hennerich as ever for trying everything out, killing bugs
and converting a whole host of Analog's devices over to the new
API.

Anyhow, now for a quick summary of what we have here:

1) iio_chan_spec structure introduction.  This moves responsibliity
for creation of most sysfs attributes into the core.  The same
structure is used to create all the relevant entries for buffers
as well as direct access attributes.  Note this only comes into
it's own after various other cleanups later in the series.
To evalutate this people should look at the end result, not all
the mashups that were required to let us introduce it slowly.

2) irq_chip based handling of triggers.  The kernel already has
a clean way of passing 'trigger' events around: irqs.  Thomas
pointed this out and gave some guidance on how to do this.  It
is far cleaner (and shorter) than our previous version and
also allows us to take everything into threaded interrupts.

3) Buffer interface rework.  This was based on Arnd's review.
 * event escalation is removed - there was no usecase for it,
   even when devices can provide the hardware suppport.  This
   greatly complicated our event system for little gain.
 * without escallation there is only one 'event' possible from
   a buffer at a time.  Thus Arnd pointed out we could just use
   poll to handle it and scrap the chrdev.
 * Now we only have one chrdev, we can drop most device tree we'd
   built up to handle them.
 * Event system is now only used for 'threshold events' and similar.
   Reworking that is probably next.

More minor stuff hiding in here:

* scrap the ring_helper stuff.  Seemed like a useful bit of
  helper code.  Now many things are simpler, it's not worth
  bothering.
* move name handling into the core - everyone has to do it, so why
  leave it to the drivers.
* move various allocation jobs into the core - again, they occur
  every time so why have them in drivers
* pull out const static elements of iio_dev into a new iio_info
  structure. (another Arnd suggestion).
* merge all the IMU drivers - this has been floating around for a
  long time.  We finally hammered it in as it made the other conversions
  easier.
* Lots of other cleanup.
* Couple of new parts for the max1363 driver.
* Michael found a few other old bugs whilst hammering various parts.

Anyhow, thanks Greg and sorry for sending you quite such
a big series in one go!  Its had a fair bit of testing on arm
and blackfin (build tested only on x86), but with this much code,
I wouldn't be entirely suprised if we broke a few devices...

Sorry to anyone with an out of tree driver - this will cause breakage.

Jonathan

Jonathan Cameron (92):
  staging:iio: allow channels to be set up using a table of
    iio_channel_spec structures.
  staging:iio:lis3l02dq - move to new channel_spec approach.
  staging:iio:max1363 - move to channel_spec registration.
  staging:iio: remove ability to escalate events.
  staging:iio: Add polling of events on the ring access chrdev.
  staging:iio: remove legacy event chrdev for the buffers
  staging:iio: Buffer device flattening.
  staging:iio:lis3l02dq: General cleanup
  staging:iio: Push interrupt setup down into the drivers for event
    lines.
  staging:iio: lis3l02dq - separate entirely interrupt handling for
    thesholds from that for the datardy signal.
  staging:iio:sca3000 extract old event handling and move to poll for
    events from buffer
  staging:iio:buffering remove unused parameter dead_offset from
    read_last_n in all buffer implementations.
  staging:iio:light:tsl2563 remove old style event registration.
  staging:iio:dac:ad5504 move from old to new event handling.
  staging:iio:adt7316 get rid of legacy event handling code.
  staging:iio:adc:ad7745 move from old to current event handling.
  staging:iio:adc:ad7816 move from old to current event handling.
  staging:iio:adc:ad7150 move from deprecated event handling plus
    remove irq as gpio requirement.
  staging:iio:adc:ad7152 remove unregister of interrupt line.
  staging:iio:adc:adt75 old to new event handling conversion
  staging:iio:ad7291 move from old event system to current.
  staging:iio:adc:adt7410 move to current event handling
  staging:iio:adt7310 move to current event handling
  staging:iio:adc:ad7314 remove unmatched unregister of event line.
  staging:iio:adc:ad799x move to new event handling
  staging:iio: Remove legacy event handling.
  staging:iio:accel:lis3l02dq make threshold interrupt threaded.
  staging:iio: Add infrastructure for irq_chip based triggers
  staging:iio:Documentation generic_buffer.c update to new abi for
    buffers + misc fixes
  staging:iio:ring_sw add function needed for threaded irq.
  staging:iio: add generic data ready poll function.
  staging:iio:accel:lis3l02dq move to threaded trigger handling.
  staging:iio:adc:max1363 move to irqchip based threaded irq triggering
  staging:iio:adc:ad7476 use channel_spec
  staging:iio:adc:ad7476 move to irqchip based triggering
  staging:iio:meter:ade7758 move to irqchip based trigger handling.
  staging:iio:imu:adis16400 move to irq based triggers and channel spec
    channel registration.
  staging:iio:imu:adis16350 etc support into adis16400 driver.
  staging:iio:imu remove old adis16350. Support now in adis16400
    driver.
  staging:iio:imu:adis16400 add support for adis16300
  staging:iio:imu remove adis16300 driver.
  staging:iio:accel:adis16201 move to irqchip based trigger handling.
  staging:iio:accel:adis16203 move to irqchip based trigger handling.
  staging:iio:accel:adis16204 move to irqchip based trigger handling.
  staging:iio:accel:adis16209 move to irqchip based trigger handling.
  staging:iio:accel:adis16240 move to irqchip based trigger handling.
  staging:iio:adc:ad7298 move to irqchip based trigger handling.
  staging:iio:adc:ad7606 conversion to irq_chip based polling.
  staging:iio:adc:ad7887 move to irqchip based trigger handling.
  staging:iio:adc:ad799x move to irqchip based trigger handling.
  staging:iio:gyro:adis16260 move to irqchip based trigger handling.
  staging:iio:trigger remove legacy pollfunc elements.
  staging:iio: Add core attribute handling for name of device.
  staging:iio: use the new central name attribute creation code
  staging:iio:light:tsl2563: chan_spec based channel setup.
  staging:iio:accel:adis16201 move to chan_spec based setup.
  staging:iio:accel:adis16203 move to chan_spec based setup.
  staging:iio:accel:adis16204 move to chan_spec based setup.
  staging:iio:accel:adis16209 move to chan_spec based setup.
  staging:iio:adc:ad799x removed unused headers.
  staging:iio:accel: lis3l02dq add writing for calibscale and
    calibbias.
  staging:iio: Add chan info support for 'peak_raw' attributes.
  staging:iio:accel:adis16240 move to chan_spec based setup.
  staging:iio:gyro:adis16260 move to chan_spec based setup.
  staging:iio: rip out scan_el attributes. Now handled as iio_dev_attrs
    like everything else.
  staging:iio:max1363 trivial removal of unused trig pointer.
  staging:iio:max1363 add new 2 channels parts form maxim, 11644-7
  staging:iio:trigger sysfs userspace trigger rework.
  staging:iio:core clean out unused elements.
  staging:iio:adc:ad7150 fix event codes.
  staging:iio:adc:ad7816 and adt75 change to meaningful event code.
  staging:iio:adc:ad7291 remove abuse of buffer events and replace with
    something almost sane
  staging:iio:adc:adt7310 replace abuse of buffer events.
  staging:iio:adc:adt7410 replace abuse of buffer events.
  staging:iio:addac:adt7316 replace abuse of buffer events.
  staging:iio:buffer - remove unused event code for buffer events.
  staging:iio:lis3l02dq remerge the two interrupt handlers.
  staging:iio: iio_event_interfaces - clean out unused elements
  staging:iio:trigger handle name attr in core, remove old alloc and
    register any control_attrs via struct device
  drivers:staging:iio:imu:adis16400 avoid allocating rx, tx, and state
    separately from iio_dev.
  staging:iio: rationalization of different buffer implementation
    hooks.
  staging:iio: Rip out helper for software rings.
  staging:iio:ad7780 trivial unused header cleanup.
  staging:iio: poll func allocation clean up.
  staging:iio:core cleanup: squash tiny wrappers and use dev_set_name
    to handle creation of event interface name.
  staging:iio: ring core cleanups + check if read_last available in
    lis3l02dq
  staging:iio:accel:lis3l02dq make write_reg_8 take value not a pointer
    to value.
  staging:iio: implement an iio_info structure to take some of the
    constant elements out of iio_dev.
  staging:iio:max1363 misc cleanups and use of for_each_bit_set to    
    simplify event code spitting out.
  staging:iio: use pollfunc allocation helpers in remaining drivers.
  staging:iio:documenation partial update.
  staging:iio: Trivial kconfig reorganization and uniformity
    improvements.

Michael Hennerich (19):
  staging:iio:adc:ad7887: Convert to new channel registration method.
  staging:iio:adc:ad7887: Use private data space from
    iio_allocate_device
  staging:iio:adc:ad799x: Convert to new channel registration method.
  staging:iio:adc:ad799x: Use private data space from
    iio_allocate_device
  staging:iio:adc:ad7298: Convert to new channel registration method
  staging:iio:adc:ad7606 Convert to new channel registration method
    Update Add missing call to iio_trigger_notify_done() Set pollfunc
    top and bottom half handler
  staging:iio:adc:ad7606: Use private data space from
    iio_allocate_device
  staging:iio: Add channel types IIO_CURRENT and IIO_POWER.
  staging:iio:meter:ade7758: Update trigger to the new API
  staging:iio:meter:ade7758: Fix timing on SPI read accessor functions.
  iio:staging:meter:ade7758: Fix return value of ade7758_write_reset
  staging:iio:meter:ade7758: Fix list and set of available sample
    frequencies.
  staging:iio:meter:ade7758: Use iio channel spec and miscellaneous
    other changes.
  staging:iio:adc:AD7298: Use private data space from
    iio_allocate_device
  staging:iio:adc: AD7606: Consitently use indio_dev
  staging:iio:adc: AD7606: Drop dev_data in favour of iio_priv()
  staging:iio:adc:AD7780: Convert to new channel registration method
  staging:iio:adc: AD7780: Use private data space from
    iio_allocate_device + trivial fixes
  staging:iio:meter:ade7758: Use private data space from
    iio_allocate_device

 drivers/staging/iio/Documentation/device.txt       |   78 +-
 drivers/staging/iio/Documentation/generic_buffer.c |   93 +-
 drivers/staging/iio/Documentation/iio_utils.h      |   20 +-
 drivers/staging/iio/Documentation/overview.txt     |   19 +-
 drivers/staging/iio/Documentation/ring.txt         |   44 +-
 drivers/staging/iio/Documentation/trigger.txt      |   16 +-
 drivers/staging/iio/Documentation/userspace.txt    |   12 -
 drivers/staging/iio/Kconfig                        |   15 +-
 drivers/staging/iio/accel/adis16201.h              |    9 +-
 drivers/staging/iio/accel/adis16201_core.c         |  467 +++---
 drivers/staging/iio/accel/adis16201_ring.c         |  146 +--
 drivers/staging/iio/accel/adis16201_trigger.c      |   53 +-
 drivers/staging/iio/accel/adis16203.h              |   18 +-
 drivers/staging/iio/accel/adis16203_core.c         |  389 +++--
 drivers/staging/iio/accel/adis16203_ring.c         |  123 +-
 drivers/staging/iio/accel/adis16203_trigger.c      |   53 +-
 drivers/staging/iio/accel/adis16204.h              |   18 +-
 drivers/staging/iio/accel/adis16204_core.c         |  412 +++---
 drivers/staging/iio/accel/adis16204_ring.c         |  126 +-
 drivers/staging/iio/accel/adis16204_trigger.c      |   53 +-
 drivers/staging/iio/accel/adis16209.h              |    6 +-
 drivers/staging/iio/accel/adis16209_core.c         |  446 +++---
 drivers/staging/iio/accel/adis16209_ring.c         |  143 +--
 drivers/staging/iio/accel/adis16209_trigger.c      |   42 +-
 drivers/staging/iio/accel/adis16220_core.c         |   11 +-
 drivers/staging/iio/accel/adis16240.h              |    7 +-
 drivers/staging/iio/accel/adis16240_core.c         |  370 +++--
 drivers/staging/iio/accel/adis16240_ring.c         |  131 +-
 drivers/staging/iio/accel/adis16240_trigger.c      |   42 +-
 drivers/staging/iio/accel/kxsd9.c                  |   12 +-
 drivers/staging/iio/accel/lis3l02dq.h              |   46 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |  842 ++++------
 drivers/staging/iio/accel/lis3l02dq_ring.c         |  504 +++---
 drivers/staging/iio/accel/sca3000.h                |   76 +-
 drivers/staging/iio/accel/sca3000_core.c           |  953 ++++-------
 drivers/staging/iio/accel/sca3000_ring.c           |  265 ++-
 drivers/staging/iio/adc/Kconfig                    |   48 +-
 drivers/staging/iio/adc/ad7150.c                   |  176 +--
 drivers/staging/iio/adc/ad7152.c                   |   31 +-
 drivers/staging/iio/adc/ad7291.c                   |  500 ++----
 drivers/staging/iio/adc/ad7298.h                   |   12 +-
 drivers/staging/iio/adc/ad7298_core.c              |  242 ++--
 drivers/staging/iio/adc/ad7298_ring.c              |  134 +-
 drivers/staging/iio/adc/ad7314.c                   |   33 +-
 drivers/staging/iio/adc/ad7476.h                   |    7 +-
 drivers/staging/iio/adc/ad7476_core.c              |  171 +-
 drivers/staging/iio/adc/ad7476_ring.c              |  127 +-
 drivers/staging/iio/adc/ad7606.h                   |   20 +-
 drivers/staging/iio/adc/ad7606_core.c              |  300 ++--
 drivers/staging/iio/adc/ad7606_par.c               |   30 +-
 drivers/staging/iio/adc/ad7606_ring.c              |  152 +--
 drivers/staging/iio/adc/ad7606_spi.c               |   24 +-
 drivers/staging/iio/adc/ad7745.c                   |  119 +-
 drivers/staging/iio/adc/ad7780.c                   |  186 +--
 drivers/staging/iio/adc/ad7816.c                   |  109 +-
 drivers/staging/iio/adc/ad7887.h                   |   17 +-
 drivers/staging/iio/adc/ad7887_core.c              |  200 +--
 drivers/staging/iio/adc/ad7887_ring.c              |  156 +--
 drivers/staging/iio/adc/ad799x.h                   |   33 +-
 drivers/staging/iio/adc/ad799x_core.c              |  859 ++++------
 drivers/staging/iio/adc/ad799x_ring.c              |   93 +-
 drivers/staging/iio/adc/adt7310.c                  |  204 +--
 drivers/staging/iio/adc/adt7410.c                  |  199 +--
 drivers/staging/iio/adc/adt75.c                    |  178 +--
 drivers/staging/iio/adc/max1363.h                  |   91 +-
 drivers/staging/iio/adc/max1363_core.c             | 1844 ++++++++------------
 drivers/staging/iio/adc/max1363_ring.c             |   90 +-
 drivers/staging/iio/addac/adt7316.c                |  494 ++----
 drivers/staging/iio/chrdev.h                       |   44 +-
 drivers/staging/iio/dac/ad5446.c                   |   21 +-
 drivers/staging/iio/dac/ad5504.c                   |   88 +-
 drivers/staging/iio/dac/ad5504.h                   |    4 -
 drivers/staging/iio/dac/ad5624r_spi.c              |   21 +-
 drivers/staging/iio/dac/ad5791.c                   |    8 +-
 drivers/staging/iio/dac/max517.c                   |   15 +-
 drivers/staging/iio/dds/ad5930.c                   |   12 +-
 drivers/staging/iio/dds/ad9832.c                   |   21 +-
 drivers/staging/iio/dds/ad9834.c                   |   21 +-
 drivers/staging/iio/dds/ad9850.c                   |   10 +-
 drivers/staging/iio/dds/ad9852.c                   |   10 +-
 drivers/staging/iio/dds/ad9910.c                   |   10 +-
 drivers/staging/iio/dds/ad9951.c                   |   10 +-
 drivers/staging/iio/gyro/adis16060_core.c          |    8 +-
 drivers/staging/iio/gyro/adis16080_core.c          |   11 +-
 drivers/staging/iio/gyro/adis16130_core.c          |   12 +-
 drivers/staging/iio/gyro/adis16260.h               |    7 +-
 drivers/staging/iio/gyro/adis16260_core.c          |  460 +++---
 drivers/staging/iio/gyro/adis16260_ring.c          |  124 +-
 drivers/staging/iio/gyro/adis16260_trigger.c       |   55 +-
 drivers/staging/iio/gyro/adxrs450_core.c           |    8 +-
 drivers/staging/iio/iio.h                          |  339 +++--
 drivers/staging/iio/imu/Kconfig                    |   26 +-
 drivers/staging/iio/imu/Makefile                   |    8 -
 drivers/staging/iio/imu/adis16300.h                |  184 --
 drivers/staging/iio/imu/adis16300_core.c           |  732 --------
 drivers/staging/iio/imu/adis16300_ring.c           |  238 ---
 drivers/staging/iio/imu/adis16300_trigger.c        |  119 --
 drivers/staging/iio/imu/adis16350.h                |  177 --
 drivers/staging/iio/imu/adis16350_core.c           |  733 --------
 drivers/staging/iio/imu/adis16350_ring.c           |  236 ---
 drivers/staging/iio/imu/adis16350_trigger.c        |  119 --
 drivers/staging/iio/imu/adis16400.h                |   38 +-
 drivers/staging/iio/imu/adis16400_core.c           |  715 +++++---
 drivers/staging/iio/imu/adis16400_ring.c           |  235 ++--
 drivers/staging/iio/imu/adis16400_trigger.c        |   71 +-
 drivers/staging/iio/industrialio-core.c            |  928 +++++++---
 drivers/staging/iio/industrialio-ring.c            |  579 ++++---
 drivers/staging/iio/industrialio-trigger.c         |  272 ++-
 drivers/staging/iio/kfifo_buf.c                    |   61 +-
 drivers/staging/iio/kfifo_buf.h                    |   40 +-
 drivers/staging/iio/light/Kconfig                  |   26 +-
 drivers/staging/iio/light/isl29018.c               |   21 +-
 drivers/staging/iio/light/tsl2563.c                |  387 ++---
 drivers/staging/iio/light/tsl2583.c                |    8 +-
 drivers/staging/iio/magnetometer/ak8975.c          |    8 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |    8 +-
 drivers/staging/iio/meter/ade7753.c                |   12 +-
 drivers/staging/iio/meter/ade7754.c                |   12 +-
 drivers/staging/iio/meter/ade7758.h                |   71 +-
 drivers/staging/iio/meter/ade7758_core.c           |  342 ++--
 drivers/staging/iio/meter/ade7758_ring.c           |  281 ++--
 drivers/staging/iio/meter/ade7758_trigger.c        |   61 +-
 drivers/staging/iio/meter/ade7759.c                |   13 +-
 drivers/staging/iio/meter/ade7854.c                |    8 +-
 drivers/staging/iio/resolver/ad2s120x.c            |   11 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   10 +-
 drivers/staging/iio/resolver/ad2s90.c              |   10 +-
 drivers/staging/iio/ring_generic.h                 |  287 +---
 drivers/staging/iio/ring_sw.c                      |  198 +--
 drivers/staging/iio/ring_sw.h                      |  196 +--
 drivers/staging/iio/sysfs.h                        |  185 +--
 drivers/staging/iio/trigger.h                      |  109 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   22 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |   25 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   24 +-
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |  169 ++-
 136 files changed, 8665 insertions(+), 13608 deletions(-)
 delete mode 100644 drivers/staging/iio/Documentation/userspace.txt
 delete mode 100644 drivers/staging/iio/imu/adis16300.h
 delete mode 100644 drivers/staging/iio/imu/adis16300_core.c
 delete mode 100644 drivers/staging/iio/imu/adis16300_ring.c
 delete mode 100644 drivers/staging/iio/imu/adis16300_trigger.c
 delete mode 100644 drivers/staging/iio/imu/adis16350.h
 delete mode 100644 drivers/staging/iio/imu/adis16350_core.c
 delete mode 100644 drivers/staging/iio/imu/adis16350_ring.c
 delete mode 100644 drivers/staging/iio/imu/adis16350_trigger.c

-- 
1.7.3.4
