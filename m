Return-Path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC v2 0/4] iio: Devicetree support
Date: Sat,  2 Feb 2013 16:59:36 -0800
Message-Id: <1359853180-5664-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

This patch set adds basic device tree support to the IIO subsystem. It is the
result of the [1] and [2] discussions.

The first two patches are actually updates to the MAX1363 driver. The first
patch updates the driver to use devm_ functions, and the second patch adds
support for an external reference voltage.

Patch 3 changes the first parameter to iio_channel_get() to be the pointer to
the consumer device instead of the consumer device name.

Patch 4 adds basic OF support to the IIO subsystem. Support is modeled after
the clock subsystem.

The patches are now based on the to togreg branch of iio kernel repository.
Several patches were already applied and are no longer part of the patch set.

Guenter

---
[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
[2] http://marc.info/?l=lm-sensors&m=135375101529918&w=1
