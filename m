Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33156 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbcGYONC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 10:13:02 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 0/1] iio: stx104: Add IIO support for the ADC channels
Date: Mon, 25 Jul 2016 10:12:48 -0400
Message-Id: <cover.1469454998.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in v3:
  - Squash move patch as unneeded thanks to "git format-patch -M"
  - Fix multiline comment syntax for value conversion math explanation
  - Select between two const iio_chan_spec structures in order to support
    differential input channels configuration correctly for multiple devices
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

The first patch of version 2 of this patchset ("iio: stx104: Unregister IIO
device on remove callback") has been removed from this patchset since it was
picked up in the iio.git fixes-togreg-post-rc1 branch.

The move patch of version 2 of this patchset has been squashed with the ADC
support implementation code since the "git format-patch -M" command has been
used to clarify the rename of the stx104.c file from the dac directory to the
adc directory.

William Breathitt Gray (1):
  iio: stx104: Add IIO support for the ADC channels

 MAINTAINERS                       |   2 +-
 drivers/iio/adc/Kconfig           |  15 ++++
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/{dac => adc}/stx104.c | 157 ++++++++++++++++++++++++++++++++------
 drivers/iio/dac/Kconfig           |  10 ---
 drivers/iio/dac/Makefile          |   1 -
 6 files changed, 150 insertions(+), 36 deletions(-)
 rename drivers/iio/{dac => adc}/stx104.c (59%)

-- 
2.7.3

