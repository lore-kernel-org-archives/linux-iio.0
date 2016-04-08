Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:16613 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281AbcDHPHn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Apr 2016 11:07:43 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v4 0/1] iio:magnetometer:ak8975: fix and enhancements
Date: Fri, 8 Apr 2016 17:09:07 +0200
Message-ID: <cover.1460127559.git.gregor.boirie@parrot.com>
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

Changes since v3:
* drop first patch as applied
* drop second patch as mounting matrix support will be included in another patch
  series (see "iio sensor mounting matrix support" thread)

Gregor.

Gregor Boirie (1):
  iio:magnetometer:ak8975: triggered buffer support

 drivers/iio/magnetometer/Kconfig  |   2 +
 drivers/iio/magnetometer/ak8975.c | 135 +++++++++++++++++++++++++++++++-------
 2 files changed, 112 insertions(+), 25 deletions(-)

-- 
2.1.4

