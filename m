Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:37036 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbcLDVFi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2016 16:05:38 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Cc: daniel.baluta@intel.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] docs: IIO documentation
Date: Sun,  4 Dec 2016 20:49:06 +0000
Message-Id: <20161204204906.27327-2-jic23@kernel.org>
In-Reply-To: <20161204204906.27327-1-jic23@kernel.org>
References: <20161204204906.27327-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a manual conversion of the existing DocBook documentation
for IIO.  The intent is not to substantially change any of the
content in this patch, but to give a base to build upon.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 Documentation/driver-api/iio/buffers.rst           | 127 +++++++++++++++
 Documentation/driver-api/iio/core.rst              | 180 +++++++++++++++++++++
 Documentation/driver-api/iio/index.rst             |  15 ++
 Documentation/driver-api/iio/intro.rst             |  23 +++
 Documentation/driver-api/iio/triggered-buffers.rst |  70 ++++++++
 Documentation/driver-api/iio/triggers.rst          |  78 +++++++++
 Documentation/driver-api/index.rst                 |   1 +
 7 files changed, 494 insertions(+)

diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
new file mode 100644
index 000000000000..559256b8e607
--- /dev/null
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -0,0 +1,127 @@
+======================
+Industrial I/O Buffers
+======================
+
+* struct :c:type:`iio_buffer` — general buffer structure
+* :c:func:`iio_validate_scan_mask_onehot` — Validates that exactly one channel
+  is selected
+* :c:func:`iio_buffer_get` — Grab a reference to the buffer
+* :c:func:`iio_buffer_put` — Release the reference to the buffer
+
+The Industrial I/O core offers a way for continuous data capture based on a
+trigger source. Multiple data channels can be read at once from
+*/dev/iio:deviceX* character device node, thus reducing the CPU load.
+
+IIO buffer sysfs interface
+==========================
+An IIO buffer has an associated attributes directory under
+*/sys/bus/iio/iio:deviceX/buffer/*. Here are the existing attributes:
+
+* *length*, the total number of data samples (capacity) that can be stored by
+  the buffer.
+* *enable*, activate buffer capture.
+
+IIO buffer setup
+================
+
+The meta information associated with a channel reading placed in a buffer is
+called a scan element . The important bits configuring scan elements are
+exposed to userspace applications via the
+*/sys/bus/iio/iio:deviceX/scan_elements/* directory. This file contains
+attributes of the following form:
+
+* *enable*, used for enabling a channel. If and only if its attribute is non
+  *zero*, then a triggered capture will contain data samples for this channel.
+* *type*, description of the scan element data storage within the buffer and
+  hence the form in which it is read from user space.
+  Format is [be|le]:[s|u]bits/storagebitsXrepeat[>>shift] .
+  * *be* or *le*, specifies big or little endian.
+  * *s* or *u*, specifies if signed (2's complement) or unsigned.
+  * *bits*, is the number of valid data bits.
+  * *storagebits*, is the number of bits (after padding) that it occupies in the
+  buffer.
+  * *shift*, if specified, is the shift that needs to be applied prior to
+  masking out unused bits.
+  * *repeat*, specifies the number of bits/storagebits repetitions. When the
+  repeat element is 0 or 1, then the repeat value is omitted.
+
+For example, a driver for a 3-axis accelerometer with 12 bit resolution where data is stored in two 8-bits registers as follows:
+
+::
+   
+        7   6   5   4   3   2   1   0
+      +---+---+---+---+---+---+---+---+
+      |D3 |D2 |D1 |D0 | X | X | X | X | (LOW byte, address 0x06)
+      +---+---+---+---+---+---+---+---+
+
+        7   6   5   4   3   2   1   0
+      +---+---+---+---+---+---+---+---+
+      |D11|D10|D9 |D8 |D7 |D6 |D5 |D4 | (HIGH byte, address 0x07)
+      +---+---+---+---+---+---+---+---+
+
+will have the following scan element type for each axis:
+
+::
+   
+      $ cat /sys/bus/iio/devices/iio:device0/scan_elements/in_accel_y_type
+      le:s12/16>>4
+
+A user space application will interpret data samples read from the buffer as two byte little endian signed data, that needs a 4 bits right shift before masking out the 12 valid bits of data.
+
+For implementing buffer support a driver should initialize the following fields in iio_chan_spec definition:
+
+::
+
+   struct iio_chan_spec {
+   /* other members */
+           int scan_index
+           struct {
+                   char sign;
+                   u8 realbits;
+                   u8 storagebits;
+                   u8 shift;
+                   u8 repeat;
+                   enum iio_endian endianness;
+                  } scan_type;
+          };
+
+The driver implementing the accelerometer described above will have the following channel definition:
+
+::
+   
+   struct struct iio_chan_spec accel_channels[] = {
+           {
+                   .type = IIO_ACCEL,
+		   .modified = 1,
+		   .channel2 = IIO_MOD_X,
+		   /* other stuff here */
+		   .scan_index = 0,
+		   .scan_type = {
+		           .sign = 's',
+			   .realbits = 12,
+			   .storagebits = 16,
+			   .shift = 4,
+			   .endianness = IIO_LE,
+		   },
+           }
+           /* similar for Y (with channel2 = IIO_MOD_Y, scan_index = 1)
+            * and Z (with channel2 = IIO_MOD_Z, scan_index = 2) axis
+            */
+    }
+    
+Here **scan_index** defines the order in which the enabled channels are placed
+inside the buffer. Channels with a lower **scan_index** will be placed before
+channels with a higher index. Each channel needs to have a unique
+**scan_index**.
+
+Setting **scan_index** to -1 can be used to indicate that the specific channel
+does not support buffered capture. In this case no entries will be created for
+the channel in the scan_elements directory.
+
+More details
+============
+.. kernel-doc:: include/linux/iio/buffer.h
+.. kernel-doc:: drivers/iio/industrialio-buffer.c
+   :export:
+
+
diff --git a/Documentation/driver-api/iio/core.rst b/Documentation/driver-api/iio/core.rst
new file mode 100644
index 000000000000..25cbcb379ed6
--- /dev/null
+++ b/Documentation/driver-api/iio/core.rst
@@ -0,0 +1,180 @@
+===================
+Industrial I/O core
+===================
+
+The Industrial I/O core offers:
+
+a unified framework for writing drivers for many different types of embedded sensors.
+a standard interface to user space applications manipulating sensors.
+The implementation can be found under drivers/iio/industrialio-*
+
+Industrial I/O Devices
+----------------------
+
+* struct :c:type:`iio_dev` - industrial I/O device
+* :c:func:`iio_device_alloc()` - alocate an :c:type:`iio_dev` from a driver
+* :c:func:`iio_device_free()` - free an :c:type:`iio_dev` from a driver
+* :c:func:`iio_device_register()` - register a device with the IIO subsystem
+* :c:func:`iio_device_unregister()` - unregister a device from the IIO
+  subsystem
+
+An IIO device usually corresponds to a single hardware sensor and it
+provides all the information needed by a driver handling a device.
+Let's first have a look at the functionality embedded in an IIO device
+then we will show how a device driver makes use of an IIO device.
+
+There are two ways for a user space application to interact with an IIO driver.
+
+1. /sys/bus/iio/iio:deviceX/, this represents a hardware sensor and groups
+   together the data channels of the same chip.
+2. /dev/iio:deviceX, character device node interface used for buffered data
+   transfer and for events information retrieval.
+   
+A typical IIO driver will register itself as an I2C or SPI driver and will
+create two routines, probe and remove . At probe:
+
+1. Call :c:func:`iio_device_alloc()`, which allocates memory for an IIO device.
+2. Initialize IIO device fields with driver specific information (e.g.
+   device name, device channels).
+3. Call :c:func:`iio_device_register()`, this registers the device with the
+   IIO core. After this call the device is ready to accept requests from user
+   space applications.
+
+At remove, we free the resources allocated in probe in reverse order:
+
+1. :c:func:`iio_device_unregister()`, unregister the device from the IIO core.
+2. :c:func:`iio_device_free()`, free the memory allocated for the IIO device.
+
+   
+IIO device sysfs interface
+==========================
+
+Attributes are sysfs files used to expose chip info and also allowing
+applications to set various configuration parameters. For device with
+index X, attributes can be found under /sys/bus/iio/iio:deviceX/ directory.
+Common attributes are:
+
+* name, description of the physical chip.
+* dev, shows the major:minor pair associated with /dev/iio:deviceX node.
+* sampling_frequency_available, available discrete set of sampling frequency
+  values for device.
+* Available standard attributes for IIO devices are described in the
+  Documentation/ABI/testing/sysfs-bus-iio file in the Linux kernel sources.
+
+IIO device channels
+===================
+
+struct :c:type:`iio_chan_spec` - specification of a single channel
+
+An IIO device channel is a representation of a data channel. An IIO device can
+have one or multiple channels. For example:
+
+* a thermometer sensor has one channel representing the temperature measurement.
+* a light sensor with two channels indicating the measurements in the visible
+  and infrared spectrum.
+* an accelerometer can have up to 3 channels representing acceleration on X, Y
+  and Z axes.
+
+An IIO channel is described by the struct :c:type:`iio_chan_spec`. A thermometer driver for the temperature sensor in the example above would have to describe its channel as follows:
+
+::
+   
+   static const struct iio_chan_spec temp_channel[] = {
+        {
+            .type = IIO_TEMP,
+            .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+        },
+   };
+
+Channel sysfs attributes exposed to userspace are specified in the form of bitmasks. Depending on their shared info, attributes can be set in one of the following masks:
+
+* **info_mask_separate**, attributes will be specific to
+  this channel
+* **info_mask_shared_by_type**, attributes are shared by all channels of the
+  same type
+* **info_mask_shared_by_dir**, attributes are shared by all channels of the same
+  direction
+* **info_mask_shared_by_all**, attributes are shared by all channels
+
+When there are multiple data channels per channel type we have two ways to distinguish between them:
+
+* set **.modified** field of :c:type:`iio_chan_spec` to 1. Modifiers are
+  specified using **.channel2** field of the same :c:type:`iio_chan_spec`
+  structure and are used to indicate a physically unique characteristic of the
+  channel such as its direction or spectral response. For example, a light
+  sensor can have two channels, one for infrared light and one for both
+  infrared and visible light.
+* set **.indexed** field of :c:type:`iio_chan_spec` to 1. In this case the
+  channel is simply another instance with an index specified by the **.channel**
+  field.
+
+Here is how we can make use of the channel's modifiers:
+
+::
+   
+   static const struct iio_chan_spec light_channels[] = {
+           {
+                   .type = IIO_INTENSITY,
+                   .modified = 1,
+                   .channel2 = IIO_MOD_LIGHT_IR,
+                   .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+                   .info_mask_shared = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+           },
+           {
+                   .type = IIO_INTENSITY,
+                   .modified = 1,
+                   .channel2 = IIO_MOD_LIGHT_BOTH,
+                   .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+                   .info_mask_shared = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+           },
+           {
+                   .type = IIO_LIGHT,
+                   .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+                   .info_mask_shared = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+           },
+      }
+
+This channel's definition will generate two separate sysfs files for raw data retrieval:
+
+* /sys/bus/iio/iio:deviceX/in_intensity_ir_raw
+* /sys/bus/iio/iio:deviceX/in_intensity_both_raw
+
+one file for processed data:
+
+* /sys/bus/iio/iio:deviceX/in_illuminance_input
+
+and one shared sysfs file for sampling frequency:
+
+* /sys/bus/iio/iio:deviceX/sampling_frequency.
+
+Here is how we can make use of the channel's indexing:
+
+::
+   
+   static const struct iio_chan_spec light_channels[] = {
+           {
+                   .type = IIO_VOLTAGE,
+		   .indexed = 1,
+		   .channel = 0,
+		   .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	   },
+           {
+	           .type = IIO_VOLTAGE,
+                   .indexed = 1,
+                   .channel = 1,
+                   .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+           },
+   }
+      
+This will generate two separate attributes files for raw data retrieval:
+
+* /sys/bus/iio/devices/iio:deviceX/in_voltage0_raw, representing voltage
+  measurement for channel 0.
+* /sys/bus/iio/devices/iio:deviceX/in_voltage1_raw, representing voltage
+  measurement for channel 1.
+
+More details
+============
+.. kernel-doc:: include/linux/iio/iio.h
+.. kernel-doc:: drivers/iio/industrialio-core.c
+   :export:
diff --git a/Documentation/driver-api/iio/index.rst b/Documentation/driver-api/iio/index.rst
new file mode 100644
index 000000000000..5036267eb14a
--- /dev/null
+++ b/Documentation/driver-api/iio/index.rst
@@ -0,0 +1,15 @@
+Industrial I/O
+==============
+
+**Copyright** |copy| 2015 Intel Corporation
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
+   intro
+   core
+   buffers
+   triggers
+   triggered-buffers
diff --git a/Documentation/driver-api/iio/intro.rst b/Documentation/driver-api/iio/intro.rst
new file mode 100644
index 000000000000..8ee88ed8dc54
--- /dev/null
+++ b/Documentation/driver-api/iio/intro.rst
@@ -0,0 +1,23 @@
+.. include:: <isonum.txt>
+
+=================================
+Introduction to the IIO Subsystem
+=================================
+
+The main purpose of the Industrial I/O subsystem (IIO) is to provide support for devices that in some sense perform either analog-to-digital conversion (ADC) or digital-to-analog conversion (DAC) or both. The aim is to fill the gap between the somewhat similar hwmon and input subsystems. Hwmon is directed at low sample rate sensors used to monitor and control the system itself, like fan speed control or temperature measurement. Input is, as its name suggests, focused on human interaction input devices (keyboard, mouse, touchscreen). In some cases there is considerable overlap between these and IIO.
+
+Devices that fall into this category include:
+
+* analog to digital converters (ADCs)
+* accelerometers
+* capacitance to digital converters (CDCs)
+* digital to analog converters (DACs)
+* gyroscopes
+* inertial measurement units (IMUs)
+* color and light sensors
+* magnetometers
+* pressure sensors
+* proximity sensors
+* temperature sensors
+
+Usually these sensors are connected via SPI or I2C. A common use case of the sensors devices is to have combined functionality (e.g. light plus proximity sensor).
diff --git a/Documentation/driver-api/iio/triggered-buffers.rst b/Documentation/driver-api/iio/triggered-buffers.rst
new file mode 100644
index 000000000000..b79e72ef1149
--- /dev/null
+++ b/Documentation/driver-api/iio/triggered-buffers.rst
@@ -0,0 +1,70 @@
+=================
+Triggered Buffers
+=================
+
+Now that we know what buffers and triggers are let's see how they work together.
+
+IIO triggered buffer setup
+==========================
+
+* :c:func:`iio_triggered_buffer_setup` — Setup triggered buffer and pollfunc
+* :c:func:`iio_triggered_buffer_cleanup` — Free resources allocated by
+  :c:func:`iio_triggered_buffer_setup`
+* struct :c:type:`iio_buffer_setup_ops` — buffer setup related callbacks
+  
+A typical triggered buffer setup looks like this:
+
+::
+   
+    const struct iio_buffer_setup_ops sensor_buffer_setup_ops = {
+      .preenable    = sensor_buffer_preenable,
+      .postenable   = sensor_buffer_postenable,
+      .postdisable  = sensor_buffer_postdisable,
+      .predisable   = sensor_buffer_predisable,
+    };
+
+    irqreturn_t sensor_iio_pollfunc(int irq, void *p)
+    {
+        pf->timestamp = iio_get_time_ns((struct indio_dev *)p);
+        return IRQ_WAKE_THREAD;
+    }
+
+    irqreturn_t sensor_trigger_handler(int irq, void *p)
+    {
+        u16 buf[8];
+        int i = 0;
+
+        /* read data for each active channel */
+        for_each_set_bit(bit, active_scan_mask, masklength)
+            buf[i++] = sensor_get_data(bit)
+
+        iio_push_to_buffers_with_timestamp(indio_dev, buf, timestamp);
+
+        iio_trigger_notify_done(trigger);
+        return IRQ_HANDLED;
+    }
+
+    /* setup triggered buffer, usually in probe function */
+    iio_triggered_buffer_setup(indio_dev, sensor_iio_polfunc,
+                               sensor_trigger_handler,
+                               sensor_buffer_setup_ops);
+    
+The important things to notice here are:
+
+* :c:type:`iio_buffer_setup_ops`, the buffer setup functions to be called at
+  predefined points in the buffer configuration sequence (e.g. before enable,
+  after disable). If not specified, the IIO core uses the default
+  iio_triggered_buffer_setup_ops.
+* **sensor_iio_pollfunc**, the function that will be used as top half of poll
+  function. It should do as little processing as possible, because it runs in
+  interrupt context. The most common operation is recording of the current
+  timestamp and for this reason one can use the IIO core defined
+  :c:func:`iio_pollfunc_store_time` function.
+* **sensor_trigger_handler**, the function that will be used as bottom half of
+  the poll function. This runs in the context of a kernel thread and all the
+  processing takes place here. It usually reads data from the device and
+  stores it in the internal buffer together with the timestamp recorded in the
+  top half.
+
+.. kernel-doc:: include/linux/iio/triggered_buffer.h
+.. kernel-doc:: drivers/iio/buffer/industrialio-triggered-buffer.c
diff --git a/Documentation/driver-api/iio/triggers.rst b/Documentation/driver-api/iio/triggers.rst
new file mode 100644
index 000000000000..c0468e66cd87
--- /dev/null
+++ b/Documentation/driver-api/iio/triggers.rst
@@ -0,0 +1,78 @@
+=======================
+Industrial I/O Triggers
+=======================
+
+* struct :c:type:`iio_trigger` — industrial I/O trigger device
+* :c:func:`devm_iio_trigger_alloc` — Resource-managed iio_trigger_alloc
+* :c:func:`devm_iio_trigger_free` — Resource-managed iio_trigger_free
+* :c:func:`devm_iio_trigger_register` — Resource-managed iio_trigger_register
+* :c:func:`devm_iio_trigger_unregister` — Resource-managed
+  iio_trigger_unregister
+* :c:func:`iio_trigger_validate_own_device` — Check if a trigger and IIO
+  device belong to the same device
+
+In many situations it is useful for a driver to be able to capture data based
+on some external event (trigger) as opposed to periodically polling for data.
+An IIO trigger can be provided by a device driver that also has an IIO device
+based on hardware generated events (e.g. data ready or threshold exceeded) or
+provided by a separate driver from an independent interrupt source (e.g. GPIO
+line connected to some external system, timer interrupt or user space writing
+a specific file in sysfs). A trigger may initiate data capture for a number of
+sensors and also it may be completely unrelated to the sensor itself.
+
+IIO trigger sysfs interface
+===========================
+
+There are two locations in sysfs related to triggers:
+
+* */sys/bus/iio/devices/triggerY*, this file is created once an IIO trigger is
+  registered with the IIO core and corresponds to trigger with index Y.
+  Because triggers can be very different depending on type there are few
+  standard attributes that we can describe here:
+
+  * *name*, trigger name that can be later used for association with a device.
+  * *sampling_frequency*, some timer based triggers use this attribute to
+    specify the frequency for trigger calls.
+  
+* */sys/bus/iio/devices/iio:deviceX/trigger/*, this directory is created once
+  the device supports a triggered buffer. We can associate a trigger with our
+  device by writing the trigger's name in the current_trigger file.
+
+IIO trigger setup
+=================
+
+Let's see a simple example of how to setup a trigger to be used by a driver.
+
+::
+   
+      struct iio_trigger_ops trigger_ops = {
+          .set_trigger_state = sample_trigger_state,
+          .validate_device = sample_validate_device,
+      }
+
+      struct iio_trigger *trig;
+
+      /* first, allocate memory for our trigger */
+      trig = iio_trigger_alloc(dev, "trig-%s-%d", name, idx);
+
+      /* setup trigger operations field */
+      trig->ops = &trigger_ops;
+
+      /* now register the trigger with the IIO core */
+      iio_trigger_register(trig);
+      
+IIO trigger ops
+===============
+
+* struct :c:type:`iio_trigger_ops` — operations structure for an iio_trigger.
+
+Notice that a trigger has a set of operations attached:
+
+* **set_trigger_state**, switch the trigger on/off on demand.
+* **validate_device**, function to validate the device when the current trigger gets changed.
+
+More details
+============
+.. kernel-doc:: include/linux/iio/trigger.h
+.. kernel-doc:: drivers/iio/industrialio-trigger.c
+   :export:
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 8e259c5d0322..1650564dd665 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -19,6 +19,7 @@ available subsections can be seen below.
    message-based
    sound
    frame-buffer
+   iio/index
    input
    spi
    i2c
-- 
2.10.2

