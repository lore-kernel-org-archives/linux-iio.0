Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20383 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbbCPXKX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 16 Mar 2015 19:10:23 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] HID: HID Sensor: Update document for custom sensor
Date: Mon, 16 Mar 2015 16:09:03 -0700
Message-Id: <1426547343-27747-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1426547343-27747-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1426547343-27747-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added custom sensor documentation

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/hid/hid-sensor.txt | 79 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/hid/hid-sensor.txt b/Documentation/hid/hid-sensor.txt
index 948b098..1a63538 100644
--- a/Documentation/hid/hid-sensor.txt
+++ b/Documentation/hid/hid-sensor.txt
@@ -138,3 +138,82 @@ accelerometer wants to poll X axis value, then it can call this function with
 the usage id of X axis. HID sensors can provide events, so this is not necessary
 to poll for any field. If there is some new sample, the core driver will call
 registered callback function to process the sample.
+
+
+----------
+
+HID Custom and generic Sensors
+
+HID Sensor specification defines two special sensor usage types. Since they
+don't represent a standard sensor, it is not possible to define using Linux IIO
+type interfaces.
+The purpose of these sensors is to extend the functionality or provide a
+way to obfuscate the data being communicated by a sensor. Without knowing the
+mapping between the data and its encapsulated form, it is difficult for
+an application/driver to determine what data is being communicated by the sensor.
+This allows some differentiating use cases, where vendor can provide applications.
+Some common use cases are debug other sensors or to provide some events like
+keyboard attached/detached or lid open/close.
+
+To allow application to utilize these sensors, here they are exported uses sysfs
+attribute groups, attributes and misc device interface.
+
+An example of this representation on sysfs:
+/sys/devices/pci0000:00/INT33C2:00/i2c-0/i2c-INT33D1:00/0018:8086:09FA.0001/HID-SENSOR-2000e1.6.auto$ tree -R
+.
+├── enable_sensor
+├── feature-0-200316
+│   ├── feature-0-200316-maximum
+│   ├── feature-0-200316-minimum
+│   ├── feature-0-200316-size
+│   ├── feature-0-200316-unit-expo
+│   ├── feature-0-200316-units
+│   └── feature-0-200316-value
+├── feature-1-200201
+│   ├── feature-1-200201-maximum
+│   ├── feature-1-200201-minimum
+│   ├── feature-1-200201-size
+│   ├── feature-1-200201-unit-expo
+│   ├── feature-1-200201-units
+│   └── feature-1-200201-value
+├── input-0-200201
+│   ├── input-0-200201-maximum
+│   ├── input-0-200201-minimum
+│   ├── input-0-200201-size
+│   ├── input-0-200201-unit-expo
+│   ├── input-0-200201-units
+│   └── input-0-200201-value
+├── input-1-200202
+│   ├── input-1-200202-maximum
+│   ├── input-1-200202-minimum
+│   ├── input-1-200202-size
+│   ├── input-1-200202-unit-expo
+│   ├── input-1-200202-units
+│   └── input-1-200202-value
+
+Here there is a custom sensors with four fields, two feature and two inputs.
+Each field is represented by a set of attributes. All fields except the "value"
+are read only. The value field is a RW field.
+Example
+/sys/bus/platform/devices/HID-SENSOR-2000e1.6.auto/feature-0-200316$ grep -r . *
+feature-0-200316-maximum:6
+feature-0-200316-minimum:0
+feature-0-200316-size:1
+feature-0-200316-unit-expo:0
+feature-0-200316-units:25
+feature-0-200316-value:1
+
+How to enable such sensor?
+By default sensor can be power gated. To enable sysfs attribute "enable" can be
+used.
+$ echo 1 > enable_sensor
+
+Once enabled and powered on, sensor can report value using HID reports.
+These reports are pushed using misc device interface in a FIFO order.
+/dev$ tree | grep HID-SENSOR-2000e1.6.auto
+│   ├── 10:53 -> ../HID-SENSOR-2000e1.6.auto
+├── HID-SENSOR-2000e1.6.auto
+
+Each reports can be of variable length preceded by a header. This header
+consist of a 32 bit usage id, 64 bit time stamp and 32 bit length field of raw
+data.
-- 
2.1.0

