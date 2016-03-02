Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30868 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbcCBLJu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 2 Mar 2016 06:09:50 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 0/6] iio:magnetometer:ak8975: fix and enhancements
Date: Wed, 2 Mar 2016 12:10:22 +0100
Message-ID: <cover.1456916271.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Various fixes and enhancements for the ak8975 magnetometers family driver.

Regards,
Gregor.

Gregor Boirie (6):
  iio:magnetometer:ak8975: fix uninitialized chipset
  iio:magnetometer:ak8975: remove unused field
  iio:magnetometer:ak8975: use explicit endianness
  iio:magnetometer:ak8975: power regulator support
  iio:magnetometer:ak8975: mounting matrix support
  iio:magnetometer:ak8975: triggered buffer support

 .../bindings/iio/magnetometer/ak8975.txt           |  12 +
 drivers/iio/magnetometer/Kconfig                   |   2 +
 drivers/iio/magnetometer/ak8975.c                  | 273 ++++++++++++++++++---
 3 files changed, 255 insertions(+), 32 deletions(-)

-- 
2.1.4

