Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:56376 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbbIWL63 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2015 07:58:29 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-iio@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Crt Mori <cmo@melexis.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Peter Rosin <peda@lysator.liu.se>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] Driver for Microchip digital potentiometers
Date: Wed, 23 Sep 2015 13:57:32 +0200
Message-Id: <1443009454-14310-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

This is the fifth attempt for a driver for these chips.

Thanks for review comments from Greg Kroah-Hartman, Crt Mori,
Daniel Baluta, Lars-Peter Clauson, Andreas Dannenberg, Peter
Meerwald and Jonathan Cameron. I think and hope I got it all sorted.

Changes since v4:
- Less convoluted changelog (Jonathan)
- Use an index into an array of configs as dev_id (Jonathan)
- Drop .address and use .channel (Jonathan)
- Remove one layer of wrappers (Jonathan)
- Provide a scale (Jonathan, Lars-Peter)

Changes since v3:
- Use i2c_smbus_read_word_swapped (Peter)
- Use devm_iio_device_register and drop the mcp4531_remove op (Peter)
- Add defines for a few magic numbers (Peter)
- Deduplicate channel params with a macro (Peter)
- Mention the i2c client address options (Peter)
- Whitespace and other trivial nits (Peter)

Changes since v2:
- Change naming from mcp4xxx_dpot to mcp4531 (Daniel)
- Added links to datasheet in commit message and source (Daniel)
- Rename from pot to potentiometer (Daniel, Crt)
- Use IIO_RESISTANCE instead of IIO_STEPS (Crt, Lars-Peter)
- Don't use wildcards in MAINTAINERS and point to the iio list (Crt)
- Avoid races by not caching values (Crt)
- Spell Microchip correctly (Andreas)

Changes since v1:
- Make it an IIO driver instead (Greg)
- Don't convolute the code with big obscure macros (Greg)
- Inline the bits from mcp4xxx_dpot.h that are actually used
  and drop that file (me)
- Better Changelog (Greg)

Cheers,
Peter

Peter Rosin (2):
  iio: resistance: Document that resistance can be output
  iio: mcp4531: Driver for Microchip digital potentiometers

 Documentation/ABI/testing/sysfs-bus-iio |    2 +
 MAINTAINERS                             |    6 +
 drivers/iio/Kconfig                     |    1 +
 drivers/iio/Makefile                    |    1 +
 drivers/iio/potentiometer/Kconfig       |   20 +++
 drivers/iio/potentiometer/Makefile      |    6 +
 drivers/iio/potentiometer/mcp4531.c     |  228 +++++++++++++++++++++++++++++++
 7 files changed, 264 insertions(+)
 create mode 100644 drivers/iio/potentiometer/Kconfig
 create mode 100644 drivers/iio/potentiometer/Makefile
 create mode 100644 drivers/iio/potentiometer/mcp4531.c

-- 
1.7.10.4

