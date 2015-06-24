Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:52072 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbbFXAai (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jun 2015 20:30:38 -0400
From: Simon Wood <simon@mungewell.org>
To: linux-input@vger.kernel.org
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-iio@vger.kernel.org
Subject: [RFC_v2 0/4] HID: hid-sony: Add IIO Suport for Motion Controllers
Date: Tue, 23 Jun 2015 18:30:26 -0600
Message-Id: <1435105830-2297-1-git-send-email-simon@mungewell.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


This series of patches is a RFC for the idea of connecting motion capability
controllers to the IIO subsystem, initially targeting the Sony SixAxis
controller. In the future I hope that this can be used for sensor packs used
in VR headset/devices.

The advantage of the IIO subsystem is that the data is presented in SI units,
although it is noted that the current API requires root level access - this is
really a distribution requirement (UDEV rules can make '/dev/iiodevice0'
accessible).

The RFC is in 4 parts, split into logical steps:
[PATCH 1/4] HID: hid-sony: Add basic IIO support for SixAxis Controller
[PATCH 2/4] HID: hid-sony: Add IIO buffer support for SixAxis Controller
[PATCH 3/4] HID: hid-sony: Add IIO trigger support for SixAxis Controller
[PATCH 4/4] HID: hid-sony: Add IIO support for DualShock4 Controller

The SixAxis contains accelerometers, the DS4 contains accelerometers and gyros.

The next stage would be support the PS Move controller, which contains
accelerometers, gyros and magnetometers.

As an example of IIO usage I would point to RTIMULib, which recently showed
a full 9-dof IMU fusion via IIO. (1)


Known Bug:
At present the 3rd patch introduces the issue that once loaded and a device
connects, the module can not be unloaded (even after device disconnects).

It seems that the refcount is being increased, but not decreased.
--
$ cat /sys/module/hid_sony/refcnt 
2
--


(1) https://richardstechnotes.wordpress.com/2015/06/17/rteiioimu-driving-a-9-dof-imu-via-industrial-io-iio/
