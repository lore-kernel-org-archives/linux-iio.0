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
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Anton Vorontsov <cbou@mail.ru>,
	David Woodhouse <dwmw2@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 0/2] iio: Devicetree support
Date: Mon,  4 Feb 2013 12:26:04 -0800
Message-Id: <1360009566-26347-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

This patch set adds basic device tree support to the IIO subsystem. It is the
result of discussions [1] and [2].

Patch 1 changes the first parameter to iio_channel_get() to be the pointer to
the consumer device instead of the consumer device name.

Patch 2 adds basic OF support to the IIO subsystem. Support is modeled after
the clock subsystem.

The patches are now based on the to togreg branch of iio kernel repository.
Already applied patches are no longer part of the patch set.

I increased the audience to all affected subsystems. Sorry for missing out
power and extcon earlier, which are both affected by the first patch.

Guenter

---
[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
[2] http://marc.info/?l=lm-sensors&m=135375101529918&w=1
