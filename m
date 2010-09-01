Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 9/9] staging:iio:documentation - partial update to make more of it true.
Date: Wed,  1 Sep 2010 15:58:03 +0100
Message-Id: <1283353083-31313-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/overview.txt     |   17 +++---
 .../{sysfs-class-iio => sysfs-bus-iio}             |    0
 drivers/staging/iio/Documentation/userspace.txt    |   54 +-------------------
 3 files changed, 10 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
index cc6ecad..d97106c 100644
--- a/drivers/staging/iio/Documentation/overview.txt
+++ b/drivers/staging/iio/Documentation/overview.txt
@@ -1,8 +1,8 @@
 Overview of IIO
 
-The Industrial I/O subsytem is intended to provide support for devices
-that in some sense are analog to digital convertors (ADCs). As many
-actual devices combine some ADCs with digital to analog convertors
+The Industrial I/O subsystem is intended to provide support for devices
+that in some sense are analog to digital converters (ADCs). As many
+actual devices combine some ADCs with digital to analog converters
 (DACs) the intention is to add that functionality at a future date
 (hence the name).
 
@@ -46,18 +46,17 @@ external signal (trigger).  These triggers might be a data ready
 signal, a gpio line connected to some external system or an on
 processor periodic interrupt.  A single trigger may initialize data
 capture or reading from a number of sensors.  These triggers are
-used in iio to fill software ring buffers acting in a very similar
+used in IIO to fill software ring buffers acting in a very similar
 fashion to the hardware buffers described above.
 
 Other documentation:
 
-userspace.txt - overview of ring buffer reading from userspace
+userspace.txt - overview of ring buffer reading from userspace.
 
-device.txt - elemennts of a typical device driver.
+device.txt - elements of a typical device driver.
 
 trigger.txt - elements of a typical trigger driver.
 
-ring.txt - additional elements required for ring buffer support
-
-
+ring.txt - additional elements required for ring buffer support.
 
+sysfs-bus-iio - abi documentation file.
diff --git a/drivers/staging/iio/Documentation/sysfs-class-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
similarity index 100%
rename from drivers/staging/iio/Documentation/sysfs-class-iio
rename to drivers/staging/iio/Documentation/sysfs-bus-iio
diff --git a/drivers/staging/iio/Documentation/userspace.txt b/drivers/staging/iio/Documentation/userspace.txt
index 8bba2fa..ff06e5d 100644
--- a/drivers/staging/iio/Documentation/userspace.txt
+++ b/drivers/staging/iio/Documentation/userspace.txt
@@ -1,62 +1,12 @@
 Userspace access to IIO
 
-Example, ST Microelectronics LIS3L02DQ accelerometer.
-
-Typical sysfs entries (pruned for clarity)
-
-/sys/class/iio
-  device0 - iio_dev related elements
-    name - driver specific identifier (here lis3l02dq)
-    accel_x_raw - polled (or from ring) raw readout of acceleration
-    accel_x_offset - offset to be applied to the raw reading
-    accel_x_scale - scale to be applied to the raw reading and offset
-    accel_x_calibbias - hardware offset (calibration)
-    accel_x_calibscale - hardware gain (calibration)
-
-    sampling_frequency_available - what options are there
-    sampling_frequency - control of internal sampling frequency
-    device - link to underlying hardware device
-    uevent - udev related element
-
-    thresh - unified threshold used for detection on all axis
-    event_line0_sources - which events are enabled
-      accel_x_high - enable x axis high threshold event
-      accel_x_low - enable x axis low threshold event
-
-    event_line0 - event interface
-      dev - major:minor for the chrdev (note major allocation dynamic)
-    trigger - consumer attachement
-      current_trigger - name based association with a trigger
-    device0:buffer0 - ring buffer interface
-      bytes_per_datum - byptes per complete datum (read only),
-                        dependant on scan element selection
-      length - (rw) specificy length fo software ring buffer (typically ro in hw case)
-      enable - turn the ring on. If its the first to be enabled attached to this
-               trigger will also enable the trigger.
-      device0:buffer0:access0
-        dev - major:minor for ring buffer access chrdev
-      device0:buffer0:event0
-        dev - major:minor for ring buffer event chrdev
-      scan_elements - controls which channels will be stored in the ring buffer
-        accel_x_en
-        accel_y_en
-        timestamp_en
-
-  trigger0 - data ready trigger elements
-    name - unqiue name of trigger
+The sysfs attributes are documented in sysfs-bus-iio.
 
 Udev will create the following entries under /dev by default:
 
 device0:buffer0:access0 - ring access chrdev
 device0:buffer0:event0 - ring event chrdev
-event_line0 - general event chrdev.
-
-For the example code we assume the following rules have been used to ensure
-unique and consistent naming of these for the lis3l02dq in question:
-
-KERNEL="ring_event_line*", ID="spi1.0", DRIVER="lis3l02dq", NAME="iio/lis3l02dq_ring_event"
-KERNEL="event_line*", ID="spi1.0", DRIVER="lis3l02dq", NAME="iio/lis3l02dq_event"
-KERNEL="ring_access*", ID="spi1.0", DRIVER="lis3l02dq", NAME="iio/lis3l02dq_ring_access"
+device0:event0 - general event chrdev.
 
 The files, lis3l02dqbuffersimple.c and iio_utils.h in this directory provide an example
 of how to use the ring buffer and event interfaces.
-- 
1.7.1
