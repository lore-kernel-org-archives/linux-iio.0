Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30863 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425514AbcBSTSv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Feb 2016 14:18:51 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 0/2] iio-interrupt-trigger enhancements
Date: Fri, 19 Feb 2016 20:18:42 +0100
Message-ID: <cover.1455908065.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

First patch enable device-tree support.

Second one adds poll(2) support through a new sysfs attribute file "count"
showing how many times the attached interrupt occurred since trigger
initialization. This allows a userspace process :
* to explicitly wait for the interrupt to happen ;
* and to know wether or not it missed interrupt events since last count
  retrieval.

Regards.
Grégor

Grégor Boirie (2):
  iio:iio-interrupt-trigger: device-tree support
  iio:iio-interrupt-trigger: sysfs poll support

 .../ABI/testing/sysfs-bus-iio-trig-interrupt       | 22 +++++
 drivers/iio/trigger/iio-trig-interrupt.c           | 99 +++++++++++++++++-----
 2 files changed, 98 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt

-- 
2.1.4

