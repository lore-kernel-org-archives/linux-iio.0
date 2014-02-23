Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40507 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbaBWQES (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Feb 2014 11:04:18 -0500
Message-ID: <530A1C28.4050907@kernel.org>
Date: Sun, 23 Feb 2014 16:04:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL]  IIO new drivers, features and cleanups for 3.15 - set 2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a37d70eb655fdcbcd93b053d11b569cc7b1787eb:

   staging: usbip: prevent possible buffer overflow reading port records (2014-02-14 09:32:40 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.15b

for you to fetch changes up to b91accafbb1031b80d22ad83576877ff2f8b4774:

   iio:event: Fix and cleanup locking (2014-02-23 15:53:25 +0000)

----------------------------------------------------------------
Second round of IIO new driver, functionality and cleanups for the 3.15 series.

There are a few fixes in here that might, earlier in a cycle, have gone
to Greg as fixes. Given they are either minor or have never actually
been observed as causing trouble (the locking bug in the event code) and
are invasive, I have included them in this pull request, targeting the
3.15 merge window instead.

The rest are pretty uncontroversial new drivers, a handy little tool for
the example code in our documentation and little cleanups.

New drivers
* Freescale Vybrid and i.MX6SLX ADC driver.
* HID Sensor hub proximity sensors.
* HID Sensor hub pressure sensors.
* LPS25H Pressure sensors added to the ST micro pressure sensor driver.

New functionality
* lsiio tool.  This is added to the staging tree as we haven't yet moved
   the example code it sits with out.  Moving this code out is now a reasonably
   high priority but holding up this tool in the meantime did not seem
   worthwhile.
* mag3110 - add missing scale factor for temperature output to userspace.

Cleanups
* Fix a bug in the event reporting in which a spin lock might be held over
   when a sleep occured.  A similar bug was found by Lars in the buffer code.
   It has not to our knowledge been observed as actually occuring and is
   a little too invasive to push out as a fix.
* Drop the IIO_ST macro after clearing out all users.  This macro was a very
   bad idea leading to a number of bugs after it stopped covering all elements
   of the structure being assigned and people started making assumptions about
   what it did cover.  Glad to see it go!
* Avoid applying extended name to shared attributes as it makes no sense.
   No in tree drivers were using the combination, hence not pushed out as
   a fix.
* ad799x - move to devm_request_threaded_irq to reduce boilerplate clean up.
* bma180 - make the low_pass_filter_3db_frequency info element shared rather
   than per attribute.  The old approach was valid but not as clean as it might
   be and was setting a bad example.  Hence the cleanup.
* mxs-lradc - propogate the error code form a platform_get_irq call rather than
   eating it up by returning -EINVAL on all errors.
* ad799x - typo fix in the copyright message. Either that or Michael was
   asserting a copyright that moved backwards in time by about a thousand years.
* ad799x - use a regulator for vref rather than platform data.  The driver
   dates from just as the regulator framework was coming into common use so
   provides an alternative way of specifying the reference voltage.  We no
   longer need that approach so drop it in favour of a regulator only approach.
* max1363 - some internal vref values were out by a small amount.  The effect
   would have been tiny and no one noticed hence not pushing this through as
   a fix.
* core - replace some pointless goto error_ret (with no clean up) lines with
   direct returns.  This is my bad coding style so I'm glad to see it cleaned
   up.
* core - avoid a kasprintf that just directly prints a string with no
   formatting elements.  This has always been there but Lars just noticed it.
   Oops.

----------------------------------------------------------------
Archana Patni (2):
       iio: hid-sensors: Added Proximity Sensor Driver
       iio: hid-sensors: Added Pressure Sensor driver

Denis CIOCCA (1):
       iio:pressure: Add support for LPS25H pressure sensor

Fabio Estevam (1):
       iio: mxs-lradc: Propagate the real error code on platform_get_irq() failure

Fugang Duan (2):
       iio:adc:imx: add Freescale Vybrid vf610 adc driver
       Documentation: add the binding file for Freescale vf610 ADC driver

Hartmut Knaack (5):
       staging:iio:ad799x Move to devm_request_threaded_irq to make device-removal simpler.
       staging:iio:ad799x fix typo in copyright message
       staging:iio:ad799x use regulator for vref
       iio:max1363 fix typos of int_vref_mv
       iio get rid of unneccessary error_ret

Jonathan Cameron (1):
       iio:drop IIO_ST macro

Lars-Peter Clausen (3):
       iio: Don't include extended name in shared attributes
       iio: Avoid unnecessary kasprintf
       iio:event: Fix and cleanup locking

Manuel Stahl (1):
       staging: iio: Add tool to list IIO devices and triggers

Peter Meerwald (2):
       iio:magnetometer:mag3110: Scale factor missing for temperature
       iio:accel:bma180: Make LOW_PASS_FILTER_3DB_FREQUENCY shared_by_type

  .../devicetree/bindings/iio/adc/vf610-adc.txt      |  22 +
  drivers/iio/accel/bma180.c                         |   4 +-
  drivers/iio/adc/Kconfig                            |  10 +
  drivers/iio/adc/Makefile                           |   1 +
  drivers/iio/adc/max1363.c                          |   6 +-
  drivers/iio/adc/vf610_adc.c                        | 711 +++++++++++++++++++++
  drivers/iio/buffer_cb.c                            |   7 +-
  drivers/iio/industrialio-buffer.c                  |  16 +-
  drivers/iio/industrialio-core.c                    |  51 +-
  drivers/iio/industrialio-event.c                   | 100 ++-
  drivers/iio/industrialio-trigger.c                 |  11 +-
  drivers/iio/light/Kconfig                          |  14 +
  drivers/iio/light/Makefile                         |   1 +
  drivers/iio/light/hid-sensor-prox.c                | 375 +++++++++++
  drivers/iio/magnetometer/mag3110.c                 |  16 +-
  drivers/iio/pressure/Kconfig                       |  16 +-
  drivers/iio/pressure/Makefile                      |   1 +
  drivers/iio/pressure/hid-sensor-press.c            | 376 +++++++++++
  drivers/iio/pressure/st_pressure.h                 |   1 +
  drivers/iio/pressure/st_pressure_core.c            |  87 ++-
  drivers/iio/pressure/st_pressure_i2c.c             |   1 +
  drivers/iio/pressure/st_pressure_spi.c             |   1 +
  drivers/staging/iio/Documentation/iio_utils.h      |  22 +
  drivers/staging/iio/Documentation/lsiio.c          | 157 +++++
  drivers/staging/iio/adc/ad799x.h                   |  10 +-
  drivers/staging/iio/adc/ad799x_core.c              |  56 +-
  drivers/staging/iio/adc/mxs-lradc.c                |   2 +-
  include/linux/hid-sensor-ids.h                     |  10 +
  include/linux/iio/iio.h                            |  16 +-
  29 files changed, 1935 insertions(+), 166 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
  create mode 100644 drivers/iio/adc/vf610_adc.c
  create mode 100644 drivers/iio/light/hid-sensor-prox.c
  create mode 100644 drivers/iio/pressure/hid-sensor-press.c
  create mode 100644 drivers/staging/iio/Documentation/lsiio.c
