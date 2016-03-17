Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:61651 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936024AbcCQQmu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 17 Mar 2016 12:42:50 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Rob Herring <robh+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v3 0/3] iio:magnetometer:ak8975: fix and enhancements
Date: Thu, 17 Mar 2016 17:43:25 +0100
Message-ID: <cover.1458231723.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Various fixes and enhancements for the ak8975 magnetometers family driver.

Changes since v1:
* get rid of silly le16 to cpu conversion since SMBUS handles this for us when
  reading words (patch 3/6)
* get rid of axes caching and serialize bus access between trigger handler and
  read_raw
* pack triggered buffer sampling bus accesses into a single SMBUS data block
  access
* use channel address within read_raw

Changes since v2:
* use devm_regulator_get to allow dummy regulator usage
* ensure regulator is properly disabled
* drop first 3 patches since applied
* document in_magn_matrix sysfs attribute
* single line comments where appropriate
* remove explicit zero init for shift field of iio_chan_spec structure as that's
  the default
* drop unnecessary ak8975_read_axis signature modification
* remove useless cosmetic changes related to ak8975_channels
* normalize and make error handling code paths clearer
* make ak8975_remove less nitpick'able :)

Gregor.

Gregor Boirie (3):
  iio:magnetometer:ak8975: fix missing regulator_disable
  iio:magnetometer:ak8975: mounting matrix support
  iio:magnetometer:ak8975: triggered buffer support

 Documentation/ABI/testing/sysfs-bus-iio-ak8975     |  46 ++++
 .../bindings/iio/magnetometer/ak8975.txt           |  10 +
 drivers/iio/magnetometer/Kconfig                   |   2 +
 drivers/iio/magnetometer/ak8975.c                  | 255 +++++++++++++++++----
 4 files changed, 271 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ak8975

-- 
2.1.4

