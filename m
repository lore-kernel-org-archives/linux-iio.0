Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27425 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbcEWSkV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 23 May 2016 14:40:21 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC 0/7] Deal with iio trigger names
Date: Mon, 23 May 2016 21:39:55 +0300
Message-Id: <cover.1464027859.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO documents that trigger names are unique but does not actually guarantee
this. You can easily create a software trigger with a duplicate name if you
enable CONFIG_IIO_HRTIMER_TRIGGER:

	mkdir /sys/kernel/config/iio/triggers/hrtimer/\
		`cat /sys/bus/iio/devices/trigger0/name`

You can also get in this situation if you connect two identical st_sensors.

My attempt to fix this is by adding a new 'current_trigger_id' ABI which is a
numeric ID (X from triggerX) rather than a non-unique string. I tested that
this works as expected when connecting two LIS3DH to the same system. This is
in patches 4,5.

In theory the current_trigger ABI could be overloaded to looks for something
matching "trigger[0-9]+" but this would be nastier. There would be a need to
prevent registering triggers that match that expression in order to prevent
stuff like:

	mkdir /sys/kernel/config/iio/triggers/hrtimer/trigger1

Such an overload wouldn't work on read and make it impossible to unambigiously
determine the currently selected trigger.


Patch 6 disallows registering duplicate trigger names. This makes drivers
which currently do that break at probe time.

Patch 7 attempts to ensure that all drivers include indio_dev->id when calling
iio_trigger_alloc. This obviously changes trigger names.


Either 4,5 or 6,7 fix this issue, but 4,5 causes fewer compat issues.


Patches 1,2,3 are just minor features in tools/generic_buffer. They supersede
the v2 I posted earlier:

	https://www.spinics.net/lists/linux-iio/msg24867.html

Crestez Dan Leonard (7):
  iio: generic_buffer: Cleanup when receiving signals
  iio: generic_buffer: Add --device-num option
  iio: generic_buffer: Add --trigger-num option
  iio: Add current_trigger_id alternative
  iio: generic_buffer: Use current_trigger_id
  iio: Refuse to register triggers with duplicate names
  iio: Make trigger names unique

 Documentation/ABI/testing/sysfs-bus-iio            |   9 +
 Documentation/DocBook/iio.tmpl                     |   4 +-
 drivers/iio/adc/max1027.c                          |   4 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   2 +-
 drivers/iio/industrialio-trigger.c                 | 136 ++++++++---
 drivers/iio/light/gp2ap020a00f.c                   |   4 +-
 tools/iio/generic_buffer.c                         | 269 ++++++++++++++-------
 7 files changed, 309 insertions(+), 119 deletions(-)

-- 
2.5.5

