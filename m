Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51796 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab0JDPwi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2010 11:52:38 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/16] staging:iio: Event code abi changes and new example
Date: Mon,  4 Oct 2010 16:57:49 +0100
Message-Id: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

The first half of this patch series is primarily concerned with
converting all the event codes to a constructed form (rather
than a fairly randomly ordered list of codes).  This change
was originally suggested by Manuel Stahl.

The first patch is a trivial typo fix.

The second half are mostly concerned with changing the relevant
sysfs attribute names to a much more consistent form as proposed a
few weeks ago (on linux-iio and lkml). This includes documentation
updates.

The final patch provides a new example for userspace (replacing the old
lis3l02dq_buffer_simple.c).

This should work with pretty much any driver supporting buffered
input.

All comments welcome.

The other two series I currently have are:

* the adis16350 merge and event support patches (waiting for further
  feedback from Manuel to work out why the burst mode devices are
  broken by that)
* the adis16250 support additions to adis16260 driver.  Initial tests
  on these are promising. Waiting for the spi guys to reply to an
  enquirey about whether it is every wrong to overspecify the nature
  of a message.

Jonathan Cameron (16):
  staging:iio: timestamp_en naming typo fix.
  staging:iio:events define macros for new event code system
  staging:iio:adc events update to new numbering system
  staging:iio:lis3l02dq move to new event code scheme
  staging:iio:sca3000 move to new event code scheme and add combined
    orientations
  staging:iio:accel remove old event codes
  staging:iio:tsl2563 move to new event numbering scheme and remove old
    definitions
  staging:iio:events move buffer codes so they do not clash with new
    scheme
  staging:iio:lis3l02dq event attribute renames
  staging:iio:sca3000 event attribute name updates
  staging:iio:accel remove deprecated and misleading event macros.
  staging:iio:tsl2563 event attribute name updates
  staging:iio:light remove empty light.h file
  staging:iio:events update documentation to match new abi.
  staging:iio:adc add numbers to naming of all adc channels as needed  
      to associate events with them.
  staging:iio: update example application.

 drivers/staging/iio/Documentation/generic_buffer.c |  318 ++++++++++++++++
 drivers/staging/iio/Documentation/iio_utils.h      |  396 +++++++++++++++++++-
 .../iio/Documentation/lis3l02dqbuffersimple.c      |  238 ------------
 drivers/staging/iio/Documentation/sysfs-bus-iio    |  192 +++++++---
 drivers/staging/iio/accel/accel.h                  |  134 -------
 drivers/staging/iio/accel/adis16209_core.c         |   16 +-
 drivers/staging/iio/accel/adis16220_core.c         |   14 +-
 drivers/staging/iio/accel/adis16240_core.c         |   12 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |   64 +++-
 drivers/staging/iio/accel/sca3000_core.c           |   67 +++--
 drivers/staging/iio/adc/adc.h                      |   20 +-
 drivers/staging/iio/gyro/adis16260_core.c          |   16 +-
 drivers/staging/iio/imu/adis16300_core.c           |   16 +-
 drivers/staging/iio/imu/adis16300_ring.c           |   24 +-
 drivers/staging/iio/imu/adis16350_core.c           |   16 +-
 drivers/staging/iio/imu/adis16350_ring.c           |   24 +-
 drivers/staging/iio/imu/adis16400_core.c           |   16 +-
 drivers/staging/iio/imu/adis16400_ring.c           |   24 +-
 drivers/staging/iio/light/light.h                  |    7 -
 drivers/staging/iio/light/tsl2563.c                |   35 +-
 drivers/staging/iio/ring_generic.h                 |    2 +-
 drivers/staging/iio/sysfs.h                        |   62 +++-
 22 files changed, 1105 insertions(+), 608 deletions(-)
 create mode 100644 drivers/staging/iio/Documentation/generic_buffer.c
 delete mode 100644 drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
 delete mode 100644 drivers/staging/iio/light/light.h

-- 
1.7.2.2

