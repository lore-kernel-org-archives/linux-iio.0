Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58562 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab3IUOSI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 10:18:08 -0400
Message-ID: <523DB8C3.9000902@kernel.org>
Date: Sat, 21 Sep 2013 16:18:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.12
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c3cb718acc17f8e0d6b4b8d1f8ca9a20d1999159:

  staging: line6: add bounds check in snd_toneport_source_put() (2013-09-17 07:39:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.12a

for you to fetch changes up to bda2f8fca20b564ac8edb2b9c080d942c2144359:

  iio:buffer_cb: Add missing iio_buffer_init() (2013-09-21 12:52:50 +0100)

----------------------------------------------------------------
First round of IIO fixes for 3.12

A series of wrong 'struct dev' assumptions in suspend/resume callbacks
following on from this issue being identified in a new driver review.
One to watch out for in future.

A number of driver specific fixes
1) at91 - fix a overflow in clock rate computation
2) dummy - Kconfig dependency issue
3) isl29018 - uninitialized value
4) hmc5843 - measurement conversion bug introduced by recent cleanup.
5) ade7854-spi - wrong return value.

Some IIO core fixes
1) Wrong value picked up for event code creation for a modified channel
2) A null dereference on failure to initialize a buffer after no buffer has
   been in use, when using the available_scan_masks approach.
3) Sampling not stopped when a device is removed. Effects forced removal
   such as hot unplugging.
4) Prevent device going away if a chrdev is still open in userspace.
5) Prevent race on chardev opening and device being freed.
6) Add a missing iio_buffer_init in the call back buffer.

These last few are the first part of a set from Lars-Peter Clausen who
has been taking a closer look at our removal paths and buffer handling
than anyone has for quite some time.

----------------------------------------------------------------
Derek Basehore (1):
      iio: isl29018: Fix uninitialized value

Jonathan Cameron (1):
      staging:iio:dummy fix kfifo_buf kconfig dependency issue if kfifo modular and buffer enabled for built in dummy
driver.

Josh Wu (1):
      iio: at91: fix adc_clk overflow

Lars-Peter Clausen (4):
      iio: Stop sampling when the device is removed
      iio: fix: Keep a reference to the IIO device for open file descriptors
      iio: Prevent race between IIO chardev opening and IIO device free
      iio:buffer_cb: Add missing iio_buffer_init()

Lukasz Czerwinski (1):
      iio: iio_device_add_event_sysfs() bugfix

Peter Meerwald (5):
      staging:iio:hmc5843: Fix measurement conversion
      iio: Fix tmp006 dev-to-indio_dev conversion in suspend/resume
      iio: Fix bma180 dev-to-indio_dev conversion in suspend/resume
      iio: Fix mcp4725 dev-to-indio_dev conversion in suspend/resume
      iio: Fix crash when scan_bytes is computed with active_scan_mask == NULL

Sachin Kamat (1):
      staging: iio: ade7854-spi: Fix return value

 drivers/iio/accel/bma180.c                 |  4 ++--
 drivers/iio/adc/at91_adc.c                 | 11 ++++++-----
 drivers/iio/buffer_cb.c                    |  2 ++
 drivers/iio/dac/mcp4725.c                  | 12 ++++++------
 drivers/iio/iio_core.h                     |  4 ++++
 drivers/iio/industrialio-buffer.c          | 30 +++++++++++++++++++++++++++--
 drivers/iio/industrialio-core.c            | 31 ++++++++++++++++++++----------
 drivers/iio/industrialio-event.c           | 20 +++++++++++++------
 drivers/iio/temperature/tmp006.c           |  6 ++++--
 drivers/staging/iio/Kconfig                |  2 +-
 drivers/staging/iio/light/isl29018.c       |  1 +
 drivers/staging/iio/magnetometer/hmc5843.c |  2 +-
 drivers/staging/iio/meter/ade7854-spi.c    |  2 +-
 13 files changed, 91 insertions(+), 36 deletions(-)
