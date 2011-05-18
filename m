Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 110/111] staging:iio:documenation partial update.
Date: Wed, 18 May 2011 14:42:40 +0100
Message-Id: <1305726161-5606-111-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

More to be added, but this brings the docs in line with
the current code. Now they are hopefully just uninformative
rather than actually incorrect.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/device.txt    |   78 ++++++++++++++++-------
 drivers/staging/iio/Documentation/overview.txt  |   19 ++----
 drivers/staging/iio/Documentation/ring.txt      |   44 ++++++-------
 drivers/staging/iio/Documentation/trigger.txt   |   16 +++---
 drivers/staging/iio/Documentation/userspace.txt |   12 ----
 5 files changed, 91 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
index c81e517..1abb80c 100644
--- a/drivers/staging/iio/Documentation/device.txt
+++ b/drivers/staging/iio/Documentation/device.txt
@@ -8,34 +8,66 @@ The crucial structure for device drivers in iio is iio_dev.
 
 First allocate one using:
 
-struct iio_dev *indio_dev = iio_allocate_device(0);
+struct iio_dev *indio_dev = iio_allocate_device(sizeof(struct chip_state));
+where chip_state is a structure of local state data for this instance of
+the chip.
 
-Then fill in the following:
-
-indio_dev->dev.parent
-  the struct device associated with the underlying hardware.
-
-indio_dev->num_interrupt_lines
-   number of event triggering hardware lines the device has.
+That data can be accessed using iio_priv(struct iio_dev *)
 
-indio_dev->event_attrs
-   attributes used to enable / disable hardware events - note the
-   attributes are embedded in iio_event_attr structures with an
-   associated iio_event_handler which may or may note be shared.
-   If num_interrupt_lines = 0, then no need to fill this in.
-
-indio_dev->attrs
-   general attributes such as polled access to device channels.
+Then fill in the following:
 
-indio_dev->dev_data
-   private device specific data.
+- indio_dev->dev.parent
+	Struct device associated with the underlying hardware.
+- indio_dev->name
+	Name of the device being driven - made available as the name
+	attribute in sysfs.
 
-indio_dev->driver_module
-   typically set to THIS_MODULE. Used to specify ownership of some
-   iio created resources.
+- indio_dev->info
+	pointer to a structure with elements that tend to be fixed for
+	large sets of different parts supported by a given driver.
+	This contains:
+	* info->driver_module:
+		Set to THIS_MODULE. Used to ensure correct ownership
+		of various resources allocate by the core.
+	* info->num_interrupt_lines:
+		Number of event triggering hardware lines the device has.
+	* info->event_attrs:
+		Attributes used to enable / disable hardware events.
+	* info->attrs:
+		General device attributes. Typically used for the weird
+		and the wonderful bits not covered by the channel specification.
+	* info->read_raw:
+		Raw data reading function. Used for both raw channel access
+		and for associate parameters such as offsets and scales.
+	* info->write_raw:
+		Raw value writing function. Used for writable device values such
+		as DAC values and caliboffset.
+	* info->read_event_config:
+		Typically only set if there are some interrupt lines.  This
+		is used to read if an on sensor event detector is enabled.
+	* info->write_event_config:
+		Enable / disable an on sensor event detector.
+	* info->read_event_value:
+		Read value associated with on sensor event detectors. Note that
+		the meaning of the returned value is dependent on the event
+		type.
+	* info->write_event_value:
+		Write the value associated with on sensor event detectors. E.g.
+		a threshold above which an interrupt occurs.  Note that the
+		meaning of the value to be set is event type dependant.
 
-indio_dev->modes
-   whether direct access and / or ring buffer access is supported.
+- indio_dev->modes:
+	Specify whether direct access and / or ring buffer access is supported.
+- indio_dev->ring:
+	An optional associated buffer.
+- indio_dev->pollfunc:
+	Poll function related elements. This controls what occurs when a trigger
+	to which this device is attached sends and event.
+- indio_dev->channels:
+	Specification of device channels. Most attributes etc are built
+	form this spec.
+- indio_dev->num_channels:
+	How many channels are there?
 
 Once these are set up, a call to iio_device_register(indio_dev),
 will register the device with the iio core.
diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
index d97106c..afc39ec 100644
--- a/drivers/staging/iio/Documentation/overview.txt
+++ b/drivers/staging/iio/Documentation/overview.txt
@@ -3,8 +3,7 @@ Overview of IIO
 The Industrial I/O subsystem is intended to provide support for devices
 that in some sense are analog to digital converters (ADCs). As many
 actual devices combine some ADCs with digital to analog converters
-(DACs) the intention is to add that functionality at a future date
-(hence the name).
+(DACs) that functionality is also supported.
 
 The aim is to fill the gap between the somewhat similar hwmon and
 input subsystems.  Hwmon is very much directed at low sample rate
@@ -31,32 +30,28 @@ event must be accessed via polling.
 Note: A given device may have one or more event channel.  These events are
 turned on or off (if possible) via sysfs interfaces.
 
-* Hardware ring buffer support.  Some recent sensors have included
+* Hardware buffer support.  Some recent sensors have included
 fifo / ring buffers on the sensor chip.  These greatly reduce the load
 on the host CPU by buffering relatively large numbers of data samples
 based on an internal sampling clock. Examples include VTI SCA3000
-series and Analog Device ADXL345 accelerometers.  Each ring buffer
-typically has an event chrdev (similar to the more general ones above)
-to pass on events such as buffer 50% full and an access chrdev via
-which the raw data it self may be read back.
+series and Analog Device ADXL345 accelerometers.  Each buffer supports
+polling to establish when data is available.
 
-* Trigger and software ring buffer support. In many data analysis
+* Trigger and software buffer support. In many data analysis
 applications it it useful to be able to capture data based on some
 external signal (trigger).  These triggers might be a data ready
 signal, a gpio line connected to some external system or an on
 processor periodic interrupt.  A single trigger may initialize data
 capture or reading from a number of sensors.  These triggers are
-used in IIO to fill software ring buffers acting in a very similar
+used in IIO to fill software buffers acting in a very similar
 fashion to the hardware buffers described above.
 
 Other documentation:
 
-userspace.txt - overview of ring buffer reading from userspace.
-
 device.txt - elements of a typical device driver.
 
 trigger.txt - elements of a typical trigger driver.
 
-ring.txt - additional elements required for ring buffer support.
+ring.txt - additional elements required for buffer support.
 
 sysfs-bus-iio - abi documentation file.
diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
index 3696c36..7e99ef2 100644
--- a/drivers/staging/iio/Documentation/ring.txt
+++ b/drivers/staging/iio/Documentation/ring.txt
@@ -1,57 +1,55 @@
-Ring buffer support within IIO
+Buffer support within IIO
 
 This document is intended as a general overview of the functionality
-a ring buffer may supply and how it is specified within IIO.  For more
-specific information on a given ring buffer implementation, see the
-comments in the source code.  Note that the intention is to allow
-some drivers to specify ring buffers choice at probe or runtime, but
-for now the selection is hard coded within a given driver.
+a buffer may supply and how it is specified within IIO.  For more
+specific information on a given buffer implementation, see the
+comments in the source code.  Note that some drivers allow buffer
+implementation to be selected at compile time via Kconfig options.
 
-A given ring buffer implementation typically embedded a struct
+A given buffer implementation typically embeds a struct
 iio_ring_buffer and it is a pointer to this that is provided to the
 IIO core. Access to the embedding structure is typically done via
 container_of functions.
 
-struct iio_ring_buffer contains 4 function pointers
-(preenable, postenable, predisable, postdisable).
-These are used to perform implementation specific steps on either side
-of the core changing it's current mode to indicate that the ring buffer
+struct iio_ring_buffer contains a struct iio_ring_setup_ops *setup_ops
+which in turn contains the 4 function pointers
+(preenable, postenable, predisable and postdisable).
+These are used to perform device specific steps on either side
+of the core changing it's current mode to indicate that the buffer
 is enabled or disabled (along with enabling triggering etc as appropriate).
 
 Also in struct iio_ring_buffer is a struct iio_ring_access_funcs.
 The function pointers within here are used to allow the core to handle
-as much ring buffer functionality as possible. Note almost all of these
+as much buffer functionality as possible. Note almost all of these
 are optional.
 
 mark_in_use, unmark_in_use
-  Basically indicate that not changes should be made to the ring
-  buffer state that will effect the form of the data being captures
-  (e.g. scan elements or length)
+  Basically indicate that not changes should be made to the buffer state that
+  will effect the form of the data being captures (e.g. scan elements or length)
 
 store_to
-  If possible, push data to ring buffer.
+  If possible, push data to the buffer.
 
 read_last
-  If possible get the most recent entry from the buffer (without removal).
+  If possible, get the most recent scan from the buffer (without removal).
   This provides polling like functionality whilst the ring buffering is in
   use without a separate read from the device.
 
-rip_lots
-  The primary ring buffer reading function. Note that it may well not return
-  as much data as requested.  The deadoffset is used to indicate that some
-  initial data in the data array is not guaranteed to be valid.
+rip_first_n
+  The primary buffer reading function. Note that it may well not return
+  as much data as requested.
 
 mark_param_changed
   Used to indicate that something has changed. Used in conjunction with
 request_update
   If parameters have changed that require reinitialization or configuration of
-  the ring buffer this will trigger it.
+  the buffer this will trigger it.
 
 get_bytes_per_datum, set_bytes_per_datum
   Get/set the number of bytes for a complete scan. (All samples + timestamp)
 
 get_length / set_length
-  Get/set the number of sample sets that may be held by the buffer.
+  Get/set the number of complete scans that may be held by the buffer.
 
 is_enabled
   Query if ring buffer is in use
diff --git a/drivers/staging/iio/Documentation/trigger.txt b/drivers/staging/iio/Documentation/trigger.txt
index 650157f..fc2012e 100644
--- a/drivers/staging/iio/Documentation/trigger.txt
+++ b/drivers/staging/iio/Documentation/trigger.txt
@@ -5,14 +5,11 @@ an IIO device.  Whilst this can create device specific complexities
 such triggers are registered with the core in the same way as
 stand-alone triggers.
 
-struct iio_trig *trig = iio_allocate_trigger();
+struct iio_trig *trig = iio_allocate_trigger("<trigger format string>", ...);
 
 allocates a trigger structure.  The key elements to then fill in within
 a driver are:
 
-trig->control_attrs
-	Any sysfs attributes needed to control parameters of the trigger
-
 trig->private_data
 	Device specific private data.
 
@@ -20,8 +17,12 @@ trig->owner
 	Typically set to THIS_MODULE. Used to ensure correct
 	ownership of core allocated resources.
 
-trig->name
-	A unique name for the trigger.
+trig->set_trigger_state:
+	Function that enables / disables the underlying source of the trigger.
+
+There is also a
+trig->alloc_list which is useful for drivers that allocate multiple
+triggers to keep track of what they have created.
 
 When these have been set call:
 
@@ -30,9 +31,8 @@ iio_trigger_register(trig);
 to register the trigger with the core, making it available to trigger
 consumers.
 
-
 Trigger Consumers
 
-Currently triggers are only used for the filling of software ring
+Currently triggers are only used for the filling of software
 buffers and as such any device supporting INDIO_RING_TRIGGERED has the
 consumer interface automatically created.
diff --git a/drivers/staging/iio/Documentation/userspace.txt b/drivers/staging/iio/Documentation/userspace.txt
deleted file mode 100644
index ff06e5d..0000000
--- a/drivers/staging/iio/Documentation/userspace.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Userspace access to IIO
-
-The sysfs attributes are documented in sysfs-bus-iio.
-
-Udev will create the following entries under /dev by default:
-
-device0:buffer0:access0 - ring access chrdev
-device0:buffer0:event0 - ring event chrdev
-device0:event0 - general event chrdev.
-
-The files, lis3l02dqbuffersimple.c and iio_utils.h in this directory provide an example
-of how to use the ring buffer and event interfaces.
-- 
1.7.3.4
