Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36548 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbcF2RcW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2016 13:32:22 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of new device, new features and cleanups for IIO in
 the 4.8 cycle
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <37ca1a90-006f-8a58-e28d-401a3e13562f@kernel.org>
Date: Wed, 29 Jun 2016 18:32:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit bc2e1126eccb47517b9d1c685020c38600f99a3d:

  iio:trigger: Experimental kthread tight loop trigger (thread only) (2016-06-03 13:18:44 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.8b

for you to fetch changes up to 67626cc1a0f7bd6700b6f2f547244382247f5bb3:

  iio: ad5755: Add DT binding documentation (2016-06-27 21:09:08 +0100)

----------------------------------------------------------------
Second round of new iio device support, features and cleanups in the 4.8 cycle

Firstly some contact detail updates:
* NXP took over freescale. Update the mma8452 header to reflect this.
* Martin Kepplinger email address change in mma8452 header.
* Adriana Reus has changed email address. Update .mailmap.
* Matt Ranostay has changed email address. Update .mailmap.

New Device Support
* max1363
  - add the missing i2c_device_ids for a couple of parts so they can actually
    be used.
* ms5867
  - add device ids for ms5805 and ms5837 parts.

New Features
* ad5755
  - DT support.  This one was a bit controversial and under review for a long
    time.  Still no one could come up with a better solution.
* stx104
  - add gpio support
* ti-adc081c
  - Add ACPI device ID matching.

Core changes
* Refuse to register triggers with duplicate names.  There is no way to
  distinguish between them so this makes no sense.  A few drivers do not
  generate unique names for each instance of the device present.  We can't
  fix this without changing ABI so leave them and wait for someone to
  actually take the rare step of two identical accelerometers on the same
  board.
* buffer-dma
  - use ARRAY_SIZE in a few appropriate locations.

Tools
* Fix the fact that the --trigger-num option in generic_buffer didn't allow
  0 which is perfectly valid in the ABI.

Cleanups
* as3935
  - improve error reporting.
  - remove redundant zeroing of a field in iio_priv.
* gp2ap020a00f
  - use the iio_device_claim_*_mode helpers rather than open coding locking
  around mode changes.
* isl29125
  - use the iio_device_claim_*_mode helpers rather than open coding locking.
* lidar
  - use the iio_device_claim_*_mode helpers rather than open coding locking.
* mma8452
  - more detail in devices supported description in comments (addresses and
  similar)
* sca3000
  - add a missing error check.
* tcs3414
  - use the iio_device_claim_*_mode helpers rather than open coding locking.
* tcs3472
  - use the iio_device_claim_*_mode helpers rather than open coding locking.

----------------------------------------------------------------
Adriana Reus (1):
      mailmap: update Adriana Reus email address

Alison Schofield (4):
      iio: light: tcs3414: use iio helper function to guarantee direct mode
      iio: light: tcs3472: use iio helper function to guarantee direct mode
      iio: light: isl29125: use iio helper function to guarantee direct mode
      iio: light: gp2ap020a00f: use iio helper function to lock direct mode

Arnd Bergmann (1):
      iio: as3935: improve error reporting in as3935_event_work

Crestez Dan Leonard (2):
      iio: generic_buffer: Fix --trigger-num option
      iio: Refuse to register triggers with duplicate names

Dan O'Donovan (1):
      iio: adc: ti-adc081c: add ACPI device ID matching

Florian Vaussard (1):
      iio: adc: max1363: Fix missing i2c_device_id for MAX1164x parts

Luis de Bethencourt (1):
      staging: iio: accel: add error check

Markezana, William (1):
      iio: ms5637 Add Measurement Specialties explicit MS5805 and MS5837 support

Martin Kepplinger (3):
      iio: mma8452: update contact information for Martin Kepplinger
      iio: mma8452: update device description in header comments
      iio: mma8452: update Freescale company information

Matt Ranostay (3):
      iio: proximity: lidar: switch to iio_device_claim_*_mode helpers
      mailmap: update Matt Ranostay email address
      iio: proximity: as3935: remove redundant zeroing of tune_cap

Phil Reid (1):
      iio: buffer-dma: Use ARRAY_SIZE in for loop range

Sean Nyekjaer (2):
      iio: ad5755: add support for dt bindings
      iio: ad5755: Add DT binding documentation

William Breathitt Gray (1):
      iio: stx104: Add GPIO support for the Apex Embedded Systems STX104

 .mailmap                                           |   3 +
 .../devicetree/bindings/iio/dac/ad5755.txt         | 124 ++++++++++++++
 drivers/iio/accel/Kconfig                          |   4 +-
 drivers/iio/accel/mma8452.c                        |  24 +--
 drivers/iio/adc/max1363.c                          |   4 +
 drivers/iio/adc/ti-adc081c.c                       |  26 ++-
 drivers/iio/buffer/industrialio-buffer-dma.c       |   4 +-
 drivers/iio/dac/Kconfig                            |  11 +-
 drivers/iio/dac/ad5755.c                           | 188 ++++++++++++++++++++-
 drivers/iio/dac/stx104.c                           | 125 +++++++++++++-
 drivers/iio/industrialio-trigger.c                 |  22 +++
 drivers/iio/light/gp2ap020a00f.c                   |  18 +-
 drivers/iio/light/isl29125.c                       |  10 +-
 drivers/iio/light/tcs3414.c                        |  12 +-
 drivers/iio/light/tcs3472.c                        |  13 +-
 drivers/iio/pressure/ms5637.c                      |  12 +-
 drivers/iio/proximity/as3935.c                     |  11 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |  14 +-
 drivers/staging/iio/accel/sca3000_core.c           |   2 +
 tools/iio/iio_generic_buffer.c                     |   4 +-
 20 files changed, 554 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt
