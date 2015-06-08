Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57601 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbbFHVwp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2015 17:52:45 -0400
Message-ID: <55760EAA.4010200@kernel.org>
Date: Mon, 08 Jun 2015 22:52:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers etc for the 4.2 cycle round 3
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 884ca45613c47efe4b0b1238f6ee677d74fe3419:

  iio: accel: Add support for Sensortek STK8BA50 (2015-05-23 12:57:11 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-v4.2c

for you to fetch changes up to bbf5f037fad47e4affef6696aaf88a40b261e639:

  iio: st_accel: support the LIS331DL sensor (2015-06-08 22:21:18 +0100)

----------------------------------------------------------------
Third round of new IIO drivers, cleanups and functionality for the 4.2 cycle.

Given Linus announced a 4.8rc coming up, hopefully time for one more
lot of IIO patches this cycle.  Some of these are actually
improvements / fixes for patches earlier in the cycle.

New device support
* st_accel driver - support devices with 8 bit channels.

Cleanup
* A general cleanup of the iio tools under /tools/ from Hartmut.
  I'm more than a little embarrassed by how bad some of these were! Are well,
  much more refined and less bug prone now.
  These cover lots of stuff like un-handled error returns, memory leaks as
  well as general refactoring to tidy the code up.
* iio_simple_dummy - fix memory leaks in the init functions, drop some
  pointless error returns from functions that never generate errors and
  make the module parameter explicitly unsigned.
* More buffer handling reworks from Lars-Peter, this time targetting hardware
  buffers (a little used corner that looks likely to get more use in the near
  future). Specifically:
  - Always compute the masklength as inkernel buffer users may need it.
  - Add a means of labelling which buffer modes a given buffer implementation
    supports.
  - In the case of hardware buffers, require strict scan matching rather than
    matching to a super set.  Currently the demux is bypassed by these drivers
    (this may well not change for efficiency reasons) so allowing a superset
    of channels to be selected would otherwise lead to more data than requested
    confusing user space.

Driver functionality improvements
* mmc35240 - adds a compensation to the raw values as borrowed form Memsic's
  own input driver.
* mma8452
  - event support
  - event debouncing
  - high  pass filter configuration
  - triggers
* vf610 - allow conversion mode to be adjusted

Fixlets
* mmc35240
  - Off by one error that by coincidence had no real effect.
  - i2c_device_name should be lowercase.
  - Lack of null terminator at end of attributes array.
  - Avoid computing the fractional part of the magnetic field by moving
    the scaling into userspace where floating point is available to simplify
    the maths.
  - Use a smaller sleep before assuming the measurement is done.  This is
    safe and improves the possible polling rate.
  - Fix sensitivity on z-axis - datasheet disagrees with Memsic's releasedd
    code and the value used in the code seems to be correct.
* stk3310 - make a local variable signed to ensure error handling works.
* twl4030
  - fix calculation of the temperature sense current - bug unlikely
    to have ever been noticed as the difference is small.
  - Fix errors in descriptions.

----------------------------------------------------------------
Dan Carpenter (2):
      iio: magnetometer: correct a harmless off by one check
      iio: light: signedness bug in stk3310_write_raw()

Daniel Baluta (6):
      iio: magnetometer: mmc35240: i2c device name should be lower case
      iio: magnetometer: mmc35240: NULL terminate attribute array
      iio: magnetometer: mmc35240: Fix broken processed value
      iio: magnetometer: mmc35240: Use a smaller sleep value
      iio: magnetometer: mmc35240: Fix sensitivity on z-axis
      iio: magnetometer: mmc35240: Add compensation for raw values

H. Nikolaus Schaller (2):
      iio: adc: twl4030_madc: Fix calculation of the temperature sense current
      iio: adc: twl4030_madc: Fix description of twl4030_madc_set_current_generator()

Hartmut Knaack (28):
      tools:iio:generic_buffer: fix order of freeing data
      tools:iio:generic_buffer: free dev_dir_name on exit
      tools:iio:iio_utils: free scan_el_dir on exit
      tools:iio: free channel-array completely
      tools:iio:iio_utils: fix allocation handling
      tools:iio:lsiio: add closedir before exit
      tools:iio: save errno first
      tools:iio:iio_event_monitor: save right errno
      tools:iio:generic_buffer: fix check of errno
      tools:iio:generic_buffer: pass up right error code
      tools:iio:generic_buffer: sign-extend and shift data
      tools:iio:iio_utils: check amount of matches
      tools:iio:iio_utils: implement digit calculation
      tools:iio:iio_utils: mark private function static
      tools:iio: catch errors in string allocation
      tools:iio:generic_buffer: catch errors for arguments conversion
      tools:iio:generic_buffer: add error handling
      tools:iio:iio_event_monitor: add error handling
      tools:iio:iio_utils: add error handling
      tools:iio:lsiio: add error handling
      tools:iio:iio_utils: add missing documentation
      tools:iio: return values directly
      tools:iio:iio_event_monitor: refactor events output
      tools:iio:iio_utils: refactor assignment of is_signed
      tools:iio:iio_utils: move up reset of sysfsfp
      tools:iio:iio_utils: initialize count during declaration
      tools:iio: rework program parameters
      tools:iio:iio_utils: pass strings as const

Lars-Peter Clausen (3):
      iio: Always compute masklength
      iio: Specify supported modes for buffers
      iio: Require strict scan mask matching in hardware mode

Laurent Navet (1):
      iio: buffer: remove unneeded test

Linus Walleij (2):
      iio: st_accel: support 8bit channel data
      iio: st_accel: support the LIS331DL sensor

Martin Fuzzey (4):
      iio: mma8452: Basic support for transient events.
      iio: mma8452: Add support for transient event debouncing
      iio: mma8452: Add highpass filter configuration.
      iio: mma8452: Add support for interrupt driven triggers.

Stefan Agner (1):
      iio: adc: vf610: implement configurable conversion modes

Vladimirs Ambrosovs (3):
      staging: iio_simple_dummy: fix init function
      staging: iio_simple_dummy: fix return types
      staging: iio_simple_dummy: fix module_param type

 Documentation/ABI/testing/sysfs-bus-iio-vf610      |   7 +
 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   9 +
 .../devicetree/bindings/iio/st-sensors.txt         |   1 +
 drivers/iio/accel/mma8452.c                        | 495 ++++++++++++++++++++-
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |  86 ++++
 drivers/iio/accel/st_accel_i2c.c                   |   4 +
 drivers/iio/adc/twl4030-madc.c                     |   8 +-
 drivers/iio/adc/vf610_adc.c                        | 146 ++++--
 drivers/iio/buffer_cb.c                            |   2 +
 drivers/iio/common/st_sensors/st_sensors_core.c    |   4 +-
 drivers/iio/industrialio-buffer.c                  |  60 ++-
 drivers/iio/kfifo_buf.c                            |   2 +
 drivers/iio/light/stk3310.c                        |   2 +-
 drivers/iio/magnetometer/mmc35240.c                | 115 ++++-
 drivers/staging/iio/accel/sca3000_ring.c           |   2 +
 drivers/staging/iio/iio_dummy_evgen.c              |   4 +-
 drivers/staging/iio/iio_dummy_evgen.h              |   2 +-
 drivers/staging/iio/iio_simple_dummy.c             |  21 +-
 drivers/staging/iio/iio_simple_dummy.h             |   8 +-
 drivers/staging/iio/iio_simple_dummy_events.c      |   4 +-
 include/linux/iio/buffer.h                         |   3 +
 tools/iio/generic_buffer.c                         | 200 ++++++---
 tools/iio/iio_event_monitor.c                      |  50 ++-
 tools/iio/iio_utils.c                              | 469 +++++++++++++++----
 tools/iio/iio_utils.h                              |  20 +-
 tools/iio/lsiio.c                                  |  63 ++-
 27 files changed, 1471 insertions(+), 317 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-vf610
