Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/70] IIO: Major rework set (review request).
Date: Sun, 17 Apr 2011 20:05:33 +0100
Message-Id: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Dear all,

A few of these have been posted before. A lot are conversion patches
and hence fairly mechanical but that's not saying I didn't do anything
silly.

So this is really just a request for anyone with any time at all to
take one of these patches and do a sanity check on it.  Of course, if
people have the parts, testing would be the best form of sanity check.
Obviously, starting at the beginning would be best, but then quite
a few of these patches introduce bits of intermediate code that gets
wiped out late, so commenting on issues with the results of these
patches is fine too!

My test set (which, 'touch wood' work) are:

sca3000-e05, max1363, max1238, lis3l02dq and adis16350.

Towards the end of the set a few drivers will not build for one
of two reasons:

a) They abuse the old buffer event codes.  These uses need to
go ASAP, but will take some datasheet trawling as we really want
to know what the heck those events actually are.

b) They are an adc driver which hasn't been converted to chan_spec
registration yet and still has some IIO_SCAN_EL_C macro usage.

Everything should build up to

staging:iio: rip out scan_el attributes.  Now handled as
    iio_dev_attrs like everything else.

Note this set sits on top of

* if you are on arm, a missing header fix deep in the cpu_type code
  which is needed to build one of the gyro types - its in Russells
  fix branch so should go to Linus in a day or two if it hasn't already.

* [PATCH] irq: export handle_simple_irq, irq_modify_status and irq_to_desc

* [PATCH 0/8 V2] staging:iio:mixed bag of fixes and cleanups.
which it turns sits on various new driver patches.

* [PATCH 00/12] IIO: precursor cleanups to even system rewrite

All in all, if you actually want to run this, then take a look at
the iio-onwards tree.

http://git.kernel.org/?p=linux/kernel/git/jic23/iio-onwards.git;a=summary

Please take a look if you possibly can.  Note I will be rebasing the above
tree in response to reviews.


Anyhow, lets briefly summarize what we have here for the record

All the way through I carry max1363 and lis3l02dq along, using new
functionality as it becomes available.  This leads to some
'fun and games' with interrupts in lis3l02dq that perhaps I could
have avoided, but there we are.

Patch 1 introduces the use of iio_chan_spec structures to specify
a channel.  Note this adds a set of callbacks to iio_dev. Arnd
pointed out that we can pull these out into constant iio_ops
structures.  I haven't done this yet, but it should be easy
to retrofit on at the end.

Patches 5-9 remove the event interface for buffers and replace
with use of poll.

11 fixes sca3000 to use the new approach and generally actually
work. It's been broken for some time.

13-25 Interrupt registration for event lines is then pushed into the
drivers (and various other fixes accomplished). Between 9 and these
patches some event lines may not work.

26 removes the old event methods.  Boy were they over engineered.
oops.

28 adds irq_chip route for triggers as suggested by Thomas Gleixner.
52 removes the old method.  Everything in between is driver conversions
- note that in the imu cases I merged all the drivers (as per a somewhat
old previous proposal - I'll add the event support that was in the
original patches at a later date).

53 is a cheeky cleanup that makes a lot of sense now we have very
few directly registered attributes in chan_spec using drivers.  Basically
it moves handling the device name into the core.
54 makes extensive use of this.

55-63 are mechanical switching over to chan_spec so I can get rid of
the whole SCAN_EL_C stuff.  Given all these drivers never use the
calbacks for setting the scan up, this was straight forward - if
lengthy.  Fixed a few bugs and generally cleaned up the drivers whilst
I was there (may well have introduced some new ones)

64 removes SCAN_EL_C and iio_scan_attr and all the support code.
Its' at this stage that the chan_spec code introduced in  patch (1)
actually reaches it's full potential, so if considering whether that
was worth while, take a look at the tree at this point.  What we have
is a lot simpler and more consise than the previous approach.
There are cases that are not yet handled, but it makes life easier
for the vast majority of drivers we have.  Thanks to Arnd for the
suggestion.

65,66 and 68 and trivial bits that should probably have been separated
out from this set. Hence I've pushed them down to the end.

70 puts lis3l02dq's interrupt handlers back together playing a slightly
unusual game with the top half handler.

67 is the sysfs-trigger rework.  Note the other non device triggers
need converting over - they build right now, but that's it.

69 removes the buffer event codes.  The only remaining uses are hideous
abuses that need to be hunted down and removed.

Sorry for the mass set.  There was a lot to do and separating it out
into coherent themes would be a real pain (yes I'm being lazy - if
we weren't still in staging I probably wouldn't try and get away
with it).

I'm convinced it was worth the pain.  What do others think?

The one big thing left to consider (to my mind anyway) is a better
way of pushing events up to userspace, but that's a topic for another day.


Thanks all.

Jonathan

Jonathan Cameron (70):
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
  staging:iio:adc:ad7150 move from deprecated event handling.
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
  staging:iio:accel:adis16201 move to chan_spec based setup.
  staging:iio:accel:adis16203 move to chan_spec based setup.
  staging:iio:accel:adis16204 move to chan_spec based setup.
  staging:iio:accel:adis16209 move to chan_spec based setup.
  staging:iio:accel: lis3l02dq add writing for calibscale and
    calibbias.
  staging:iio: Add chan info support for 'peak_raw' attributes.
  staging:iio:accel:adis16240 move to chan_spec based setup.
  staging:iio: Add angl parameters to the chan spec code.
  staging:iio:gyro:adis16260 move to chan_spec based setup.
  staging:iio: rip out scan_el attributes.  Now handled as
    iio_dev_attrs like everything else.
  staging:iio:max1363 trivial removal of unused trig pointer.
  staging:iio:max1363 add new 2 channels parts form maxim, 11644-7
  staging:iio:trigger sysfs userspace trigger rework.
  staging:iio:core clean out unused elements.
  staging:iio:buffer - remove unused event code for buffer events.
  staging:iio:lis3l02dq remerge the two interrupt handlers.

 drivers/staging/Makefile                           |    2 +-
 drivers/staging/iio/Documentation/generic_buffer.c |   93 +-
 drivers/staging/iio/Documentation/iio_utils.h      |   20 +-
 drivers/staging/iio/Kconfig                        |   12 +
 drivers/staging/iio/Makefile                       |    2 +
 drivers/staging/iio/accel/adis16201.h              |    9 +-
 drivers/staging/iio/accel/adis16201_core.c         |  458 +++----
 drivers/staging/iio/accel/adis16201_ring.c         |  138 +--
 drivers/staging/iio/accel/adis16201_trigger.c      |   52 +-
 drivers/staging/iio/accel/adis16203.h              |   18 +-
 drivers/staging/iio/accel/adis16203_core.c         |  379 +++---
 drivers/staging/iio/accel/adis16203_ring.c         |  116 +--
 drivers/staging/iio/accel/adis16203_trigger.c      |   53 +-
 drivers/staging/iio/accel/adis16204.h              |   18 +-
 drivers/staging/iio/accel/adis16204_core.c         |  404 +++---
 drivers/staging/iio/accel/adis16204_ring.c         |  117 +--
 drivers/staging/iio/accel/adis16204_trigger.c      |   55 +-
 drivers/staging/iio/accel/adis16209.h              |    6 +-
 drivers/staging/iio/accel/adis16209_core.c         |  438 ++++---
 drivers/staging/iio/accel/adis16209_ring.c         |  135 +--
 drivers/staging/iio/accel/adis16209_trigger.c      |   42 +-
 drivers/staging/iio/accel/adis16220_core.c         |    4 +-
 drivers/staging/iio/accel/adis16240.h              |    7 +-
 drivers/staging/iio/accel/adis16240_core.c         |  362 +++---
 drivers/staging/iio/accel/adis16240_ring.c         |  125 +--
 drivers/staging/iio/accel/adis16240_trigger.c      |   41 +-
 drivers/staging/iio/accel/lis3l02dq.h              |   30 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |  715 +++++------
 drivers/staging/iio/accel/lis3l02dq_ring.c         |  443 +++----
 drivers/staging/iio/accel/sca3000.h                |   76 +-
 drivers/staging/iio/accel/sca3000_core.c           |  933 +++++---------
 drivers/staging/iio/accel/sca3000_ring.c           |  250 +++--
 drivers/staging/iio/adc/Kconfig                    |    4 +-
 drivers/staging/iio/adc/ad7150.c                   |  129 +--
 drivers/staging/iio/adc/ad7152.c                   |   20 +-
 drivers/staging/iio/adc/ad7291.c                   |  437 ++-----
 drivers/staging/iio/adc/ad7298.h                   |    2 -
 drivers/staging/iio/adc/ad7298_core.c              |   14 +-
 drivers/staging/iio/adc/ad7298_ring.c              |   65 +-
 drivers/staging/iio/adc/ad7314.c                   |   21 +-
 drivers/staging/iio/adc/ad7476.h                   |    7 +-
 drivers/staging/iio/adc/ad7476_core.c              |  162 +--
 drivers/staging/iio/adc/ad7476_ring.c              |  102 +-
 drivers/staging/iio/adc/ad7606_ring.c              |   27 +-
 drivers/staging/iio/adc/ad7745.c                   |  104 +--
 drivers/staging/iio/adc/ad7780.c                   |   13 +-
 drivers/staging/iio/adc/ad7816.c                   |   92 +-
 drivers/staging/iio/adc/ad7887.h                   |    2 -
 drivers/staging/iio/adc/ad7887_core.c              |   14 +-
 drivers/staging/iio/adc/ad7887_ring.c              |   63 +-
 drivers/staging/iio/adc/ad799x.h                   |    4 -
 drivers/staging/iio/adc/ad799x_core.c              |  268 ++---
 drivers/staging/iio/adc/ad799x_ring.c              |   60 +-
 drivers/staging/iio/adc/adt7310.c                  |  172 +--
 drivers/staging/iio/adc/adt7410.c                  |  167 +--
 drivers/staging/iio/adc/adt75.c                    |  159 +--
 drivers/staging/iio/adc/max1363.h                  |   17 +-
 drivers/staging/iio/adc/max1363_core.c             | 1371 ++++++++------------
 drivers/staging/iio/adc/max1363_ring.c             |   65 +-
 drivers/staging/iio/addac/adt7316.c                |  385 ++----
 drivers/staging/iio/chrdev.h                       |   33 +-
 drivers/staging/iio/dac/ad5446.c                   |   13 +-
 drivers/staging/iio/dac/ad5504.c                   |   68 +-
 drivers/staging/iio/dac/ad5504.h                   |    4 -
 drivers/staging/iio/dac/ad5624r_spi.c              |   13 +-
 drivers/staging/iio/dds/ad9832.c                   |   13 +-
 drivers/staging/iio/dds/ad9834.c                   |   13 +-
 drivers/staging/iio/gyro/adis16080_core.c          |    3 +-
 drivers/staging/iio/gyro/adis16130_core.c          |    4 +-
 drivers/staging/iio/gyro/adis16260.h               |    7 +-
 drivers/staging/iio/gyro/adis16260_core.c          |  450 ++++----
 drivers/staging/iio/gyro/adis16260_ring.c          |  117 +--
 drivers/staging/iio/gyro/adis16260_trigger.c       |   55 +-
 drivers/staging/iio/iio-board-info.h               |   24 +
 drivers/staging/iio/iio-core.h                     |   13 +
 drivers/staging/iio/iio.h                          |  276 +++--
 drivers/staging/iio/imu/Kconfig                    |   26 +-
 drivers/staging/iio/imu/Makefile                   |    8 -
 drivers/staging/iio/imu/adis16300.h                |  184 ---
 drivers/staging/iio/imu/adis16300_core.c           |  732 -----------
 drivers/staging/iio/imu/adis16300_ring.c           |  238 ----
 drivers/staging/iio/imu/adis16300_trigger.c        |  119 --
 drivers/staging/iio/imu/adis16350.h                |  177 ---
 drivers/staging/iio/imu/adis16350_core.c           |  733 -----------
 drivers/staging/iio/imu/adis16350_ring.c           |  236 ----
 drivers/staging/iio/imu/adis16350_trigger.c        |  119 --
 drivers/staging/iio/imu/adis16400.h                |   31 +-
 drivers/staging/iio/imu/adis16400_core.c           |  631 ++++++---
 drivers/staging/iio/imu/adis16400_ring.c           |  223 ++--
 drivers/staging/iio/imu/adis16400_trigger.c        |   55 +-
 drivers/staging/iio/industrialio-board-info.c      |   25 +
 drivers/staging/iio/industrialio-core.c            |  793 ++++++++----
 drivers/staging/iio/industrialio-ring.c            |  319 +++--
 drivers/staging/iio/industrialio-trigger.c         |  218 +++-
 drivers/staging/iio/kfifo_buf.c                    |    3 +-
 drivers/staging/iio/kfifo_buf.h                    |    3 +-
 drivers/staging/iio/light/isl29018.c               |   13 +-
 drivers/staging/iio/light/tsl2563.c                |   62 +-
 drivers/staging/iio/meter/ade7753.c                |    4 +-
 drivers/staging/iio/meter/ade7754.c                |    4 +-
 drivers/staging/iio/meter/ade7758.h                |    5 -
 drivers/staging/iio/meter/ade7758_core.c           |    4 +-
 drivers/staging/iio/meter/ade7758_ring.c           |   58 +-
 drivers/staging/iio/meter/ade7759.c                |    4 +-
 drivers/staging/iio/ring_generic.h                 |  166 +--
 drivers/staging/iio/ring_sw.c                      |   57 +-
 drivers/staging/iio/ring_sw.h                      |    5 +-
 drivers/staging/iio/sysfs.h                        |  161 +--
 drivers/staging/iio/trigger.h                      |   77 +-
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |  170 ++-
 110 files changed, 6094 insertions(+), 10174 deletions(-)
 create mode 100644 drivers/staging/iio/iio-board-info.h
 create mode 100644 drivers/staging/iio/iio-core.h
 delete mode 100644 drivers/staging/iio/imu/adis16300.h
 delete mode 100644 drivers/staging/iio/imu/adis16300_core.c
 delete mode 100644 drivers/staging/iio/imu/adis16300_ring.c
 delete mode 100644 drivers/staging/iio/imu/adis16300_trigger.c
 delete mode 100644 drivers/staging/iio/imu/adis16350.h
 delete mode 100644 drivers/staging/iio/imu/adis16350_core.c
 delete mode 100644 drivers/staging/iio/imu/adis16350_ring.c
 delete mode 100644 drivers/staging/iio/imu/adis16350_trigger.c
 create mode 100644 drivers/staging/iio/industrialio-board-info.c

-- 
1.7.3.4
