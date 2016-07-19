Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34609 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbcGSQYu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 12:24:50 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 0/3] iio: stx104: Add IIO support for the ADC channels
Date: Tue, 19 Jul 2016 12:24:41 -0400
Message-Id: <cover.1468944073.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in v2:
  - IIO_CHAN_INFO_RAW mask used for analog input channels
  - STX104_ prefix added to IN_CHAN_OFFSET define
  - STX104_MAX_NUM_CHAN define removed as unnecessary
  - Whitespace added to pad comment about ADC sample capture and completion wait
  - Switch statement in write_raw callback refactored to return 0
  - Comma added to last element initialization of stx104_info
  - Comment added to warn why stx104_channels is not const
  - Comment added to explain GPIO offset in gpio_get_direction callback
  - ARRAY_SIZE macro utilized to get number of channels in stx104_channels
  - Replace devm_iio_device_register with iio_device_register call and
    respective iio_device_unregister call
  - Perform GPIO chip registration before iio_device_register to prevent race
    condition

The first patch in this patchset ("iio: stx104: Unregister IIO device on remove
callback") fixes the improper registration of the IIO device by replacing the
devm_iio_device_register call with a iio_device_register call and a subsequent
iio_device_unregister call in the remove callback. This issue when GPIO support
was added in commit 765550e4d98d ("iio: stx104: Add GPIO support for the Apex
Embedded Systems STX104"); a remove callback was introduced, but
devm_iio_device_register related code was not reimplemented.

The second patch is the actual code to implement the ADC support, while the
third patch is simply to move the STX104 driver to the IIO ADC directory; I
separated the move to its own patch in order to make the addition of the ADC
support code clear in the commit log.

William Breathitt Gray (3):
  iio: stx104: Unregister IIO device on remove callback
  iio: stx104: Add IIO support for the ADC channels
  iio: stx104: Move the STX104 IIO driver to the ADC directory

 MAINTAINERS              |   2 +-
 drivers/iio/adc/Kconfig  |  15 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/stx104.c | 390 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/dac/Kconfig  |  10 --
 drivers/iio/dac/Makefile |   1 -
 drivers/iio/dac/stx104.c | 255 -------------------------------
 7 files changed, 407 insertions(+), 267 deletions(-)
 create mode 100644 drivers/iio/adc/stx104.c
 delete mode 100644 drivers/iio/dac/stx104.c

-- 
2.7.3

