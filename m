Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/99] IIO: moving forward patch set.
Date: Wed,  4 May 2011 12:57:32 +0100
Message-Id: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

First to Arnd: Obviously I'm not expecting you to review this
'little' set. I just wanted to keep you in the loop on what happened
with your suggestions.

To All: This is a request for review. Please start at the beginning, but
beware that quite a lot of the nice simplifications take a while
to turn up as many drivers need to be carried along. Easiest option
is probably to pick a particular driver to follow through the changes.

Michael, in particular can you take a look at patch number 1. You've
been using it extensively, but if you have time I'd like your comments
/ ack on that one - particularly as I rewrote it yesterday following
our discussions.

This is the current state of what is in my iio-onwards master
branch (just pushed to kernel.org).  I've just rebased on todays
staging-next.

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio-onwards.git
(in a few mins as it hasn't synced yet).

The first patch has changed the most:

1) Single macro for all iio_chan_spec types.
   Feel free to define your own in a given driver (see how much it
   saved in max1363 for starters). Note I'm happy with not using the
   macro at all to fill the structure if people prefer that way.
2) Has a extend_name optional string to insert 'useful' additional
   strings into the middle of attribute names.
3) Modifiers now shared between here and event codes.  No longer
   should you specify 'x' as the channel number. This is much more
   flexible than what we had before.
4) Now handles _input
5) Some docs.

Second set of major changes are to use irq_alloc_descs etc to deal
with allocating the 'virtual' interrupts for the triggers. Basically
we are avoiding reinventing the wheel.  This is more or less entirely
removal of code from previous version.

Otherwise there are additional cleanups and driver conversions
(many thanks to Michael who has been working on my constantly
evolving tree! - please check I didn't mess up the rebase fixups).
Note that the last chunk of patches break building for one of
the energy meter drivers. Michael is working to clean that up,
but I didn't want to hold the tree pending that.

There are a couple of dependencies.  The irqchip stuff
depends on some exports being added to the core irq code.
I'll send that out separately soon - they are in the git tree.
There is also a strtobool function that has been accepted
for merge through another of Greg's trees so isn't in
staging-next as yet.

A small build fix related to one of the gyro drivers is heading
through the arm tree so may already be present in staging-next.

All these dependencies are in the git tree so it should 'just work'.

Ideally we want most if not all of this to hit Greg's tree asap
as we are probably only a short way from a merge window openning.

Thanks,

Jonathan

Jonathan Cameron (87):
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
  staging:iio:ad799x move to new event handling
  staging:iio: Remove legacy event handling.
  staging:iio:lis3l02dq make threshold interrupt threaded.
  staging:iio: Add infrastructure for irq_chip based triggers
  staging:iio:Documentation generic_buffer.c update to new abi for
    buffers + misc fixes
  staging:iio:ring_sw add function needed for threaded irq.
  staging:iio: add generic data ready poll function.
  staging:iio:lis3l02dq move to threaded trigger handling.
  staging:iio:max1363 move to irqchip based threaded irq triggering
  staging:iio:ad7476 use channel_spec
  staging:iio:ad7476 move to irqchip based triggering
  staging:iio:meter:ade7758 move to irqchip based trigger handling.
  staging:iio:adis16400 move to irq based triggers and channel spec
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
  staging:iio:ad7606 conversion to irq_chip based polling.
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
  staging:iio:adc/ad799x removed unused headers.
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
  drivers:staging:iio:adis16400 avoid allocating rx, tx, and state
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

Michael Hennerich (12):
  IIO-onwards: ADC: AD7887: Convert to new channel registration method.
  IIO-onwards: ADC: AD7887: Use private data space from
    iio_allocate_device
  IIO-onwards: ADC: AD799x: Convert to new channel registration method.
  IIO-onwards: ADC: AD799x: Use private data space from
    iio_allocate_device
  IIO-onwards: ADC: AD7298: Convert to new channel registration method
  staging:iio:adc:ad7606 Convert to new channel registration method
    Update Add missing call to iio_trigger_notify_done() Set pollfunc
    top and bottom half handler
  staging:iio:adc:ad7606: Use private data space from
    iio_allocate_device
  staging:iio:adc:AD7298: Use private data space from
    iio_allocate_device
  staging:iio:adc: AD7606: Consitently use indio_dev
  staging:iio:adc: AD7606: Drop dev_data in favour of iio_priv()
  staging:iio:adc:AD7780: Convert to new channel registration method
  staging:iio:adc: AD7780: Use private data space from
    iio_allocate_device + trivial fixes

 drivers/staging/iio/Documentation/generic_buffer.c |   93 +-
 drivers/staging/iio/Documentation/iio_utils.h      |   20 +-
 drivers/staging/iio/Kconfig                        |    7 +
 drivers/staging/iio/accel/adis16201.h              |    9 +-
 drivers/staging/iio/accel/adis16201_core.c         |  458 ++++----
 drivers/staging/iio/accel/adis16201_ring.c         |  146 +--
 drivers/staging/iio/accel/adis16201_trigger.c      |   53 +-
 drivers/staging/iio/accel/adis16203.h              |   18 +-
 drivers/staging/iio/accel/adis16203_core.c         |  381 +++----
 drivers/staging/iio/accel/adis16203_ring.c         |  123 +--
 drivers/staging/iio/accel/adis16203_trigger.c      |   53 +-
 drivers/staging/iio/accel/adis16204.h              |   18 +-
 drivers/staging/iio/accel/adis16204_core.c         |  404 ++++----
 drivers/staging/iio/accel/adis16204_ring.c         |  126 +--
 drivers/staging/iio/accel/adis16204_trigger.c      |   53 +-
 drivers/staging/iio/accel/adis16209.h              |    6 +-
 drivers/staging/iio/accel/adis16209_core.c         |  438 ++++----
 drivers/staging/iio/accel/adis16209_ring.c         |  143 +--
 drivers/staging/iio/accel/adis16209_trigger.c      |   42 +-
 drivers/staging/iio/accel/adis16220_core.c         |    4 +-
 drivers/staging/iio/accel/adis16240.h              |    7 +-
 drivers/staging/iio/accel/adis16240_core.c         |  362 ++++---
 drivers/staging/iio/accel/adis16240_ring.c         |  131 +--
 drivers/staging/iio/accel/adis16240_trigger.c      |   42 +-
 drivers/staging/iio/accel/lis3l02dq.h              |   46 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |  841 ++++++--------
 drivers/staging/iio/accel/lis3l02dq_ring.c         |  502 ++++-----
 drivers/staging/iio/accel/sca3000.h                |   76 +-
 drivers/staging/iio/accel/sca3000_core.c           |  930 ++++++----------
 drivers/staging/iio/accel/sca3000_ring.c           |  265 +++--
 drivers/staging/iio/adc/Kconfig                    |    4 +-
 drivers/staging/iio/adc/ad7150.c                   |  161 +--
 drivers/staging/iio/adc/ad7152.c                   |   24 +-
 drivers/staging/iio/adc/ad7291.c                   |  489 +++-----
 drivers/staging/iio/adc/ad7298.h                   |   12 +-
 drivers/staging/iio/adc/ad7298_core.c              |  242 ++--
 drivers/staging/iio/adc/ad7298_ring.c              |  138 +--
 drivers/staging/iio/adc/ad7314.c                   |   26 +-
 drivers/staging/iio/adc/ad7476.h                   |    7 +-
 drivers/staging/iio/adc/ad7476_core.c              |  165 ++--
 drivers/staging/iio/adc/ad7476_ring.c              |  131 +--
 drivers/staging/iio/adc/ad7606.h                   |   20 +-
 drivers/staging/iio/adc/ad7606_core.c              |  296 +++---
 drivers/staging/iio/adc/ad7606_par.c               |   30 +-
 drivers/staging/iio/adc/ad7606_ring.c              |  156 +--
 drivers/staging/iio/adc/ad7606_spi.c               |   24 +-
 drivers/staging/iio/adc/ad7745.c                   |  108 +--
 drivers/staging/iio/adc/ad7780.c                   |  182 ++--
 drivers/staging/iio/adc/ad7816.c                   |   97 +--
 drivers/staging/iio/adc/ad7887.h                   |   17 +-
 drivers/staging/iio/adc/ad7887_core.c              |  196 ++--
 drivers/staging/iio/adc/ad7887_ring.c              |  160 +--
 drivers/staging/iio/adc/ad799x.h                   |   30 +-
 drivers/staging/iio/adc/ad799x_core.c              |  824 ++++++--------
 drivers/staging/iio/adc/ad799x_ring.c              |   98 +-
 drivers/staging/iio/adc/adt7310.c                  |  192 ++--
 drivers/staging/iio/adc/adt7410.c                  |  187 ++--
 drivers/staging/iio/adc/adt75.c                    |  166 +--
 drivers/staging/iio/adc/max1363.h                  |   17 +-
 drivers/staging/iio/adc/max1363_core.c             | 1203 ++++++--------------
 drivers/staging/iio/adc/max1363_ring.c             |   93 +-
 drivers/staging/iio/addac/adt7316.c                |  467 +++-----
 drivers/staging/iio/chrdev.h                       |   44 +-
 drivers/staging/iio/dac/ad5446.c                   |   13 +-
 drivers/staging/iio/dac/ad5504.c                   |   68 +-
 drivers/staging/iio/dac/ad5504.h                   |    4 -
 drivers/staging/iio/dac/ad5624r_spi.c              |   13 +-
 drivers/staging/iio/dds/ad9832.c                   |   13 +-
 drivers/staging/iio/dds/ad9834.c                   |   13 +-
 drivers/staging/iio/gyro/adis16080_core.c          |    3 +-
 drivers/staging/iio/gyro/adis16130_core.c          |    4 +-
 drivers/staging/iio/gyro/adis16260.h               |    7 +-
 drivers/staging/iio/gyro/adis16260_core.c          |  454 ++++----
 drivers/staging/iio/gyro/adis16260_ring.c          |  131 +--
 drivers/staging/iio/gyro/adis16260_trigger.c       |   55 +-
 drivers/staging/iio/iio.h                          |  293 +++--
 drivers/staging/iio/imu/Kconfig                    |   26 +-
 drivers/staging/iio/imu/Makefile                   |    8 -
 drivers/staging/iio/imu/adis16300.h                |  184 ---
 drivers/staging/iio/imu/adis16300_core.c           |  732 ------------
 drivers/staging/iio/imu/adis16300_ring.c           |  238 ----
 drivers/staging/iio/imu/adis16300_trigger.c        |  119 --
 drivers/staging/iio/imu/adis16350.h                |  177 ---
 drivers/staging/iio/imu/adis16350_core.c           |  733 ------------
 drivers/staging/iio/imu/adis16350_ring.c           |  236 ----
 drivers/staging/iio/imu/adis16350_trigger.c        |  119 --
 drivers/staging/iio/imu/adis16400.h                |   38 +-
 drivers/staging/iio/imu/adis16400_core.c           |  713 ++++++++-----
 drivers/staging/iio/imu/adis16400_ring.c           |  235 ++---
 drivers/staging/iio/imu/adis16400_trigger.c        |   71 +-
 drivers/staging/iio/industrialio-core.c            |  905 +++++++++++-----
 drivers/staging/iio/industrialio-ring.c            |  579 +++++-----
 drivers/staging/iio/industrialio-trigger.c         |  272 +++--
 drivers/staging/iio/kfifo_buf.c                    |   61 +-
 drivers/staging/iio/kfifo_buf.h                    |   40 +-
 drivers/staging/iio/light/isl29018.c               |   13 +-
 drivers/staging/iio/light/tsl2563.c                |  373 +++----
 drivers/staging/iio/meter/ade7753.c                |    4 +-
 drivers/staging/iio/meter/ade7754.c                |    4 +-
 drivers/staging/iio/meter/ade7758.h                |    5 -
 drivers/staging/iio/meter/ade7758_core.c           |    4 +-
 drivers/staging/iio/meter/ade7758_ring.c           |   58 +-
 drivers/staging/iio/meter/ade7759.c                |    4 +-
 drivers/staging/iio/ring_generic.h                 |  287 +----
 drivers/staging/iio/ring_sw.c                      |  198 ++--
 drivers/staging/iio/ring_sw.h                      |  196 +----
 drivers/staging/iio/sysfs.h                        |  185 +---
 drivers/staging/iio/trigger.h                      |  109 ++-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   22 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |   25 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   24 +-
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |  169 +++-
 112 files changed, 7402 insertions(+), 12638 deletions(-)
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
