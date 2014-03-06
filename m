Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57816 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbaCFTX0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Mar 2014 14:23:26 -0500
Message-ID: <5318CB62.2020103@kernel.org>
Date: Thu, 06 Mar 2014 19:24:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.15 - set 3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit aa256f8d0dd9c2dff872849418d8e09e5d06718f:

   Merge tag 'iio-for-3.15b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2014-02-23 09:08:34 -0800)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.15c

for you to fetch changes up to db8fa7311d1ce642134c53e175ca0ae35e021344:

   iio:adc:vf610 ensure correct handing of interruption of wait for completion (2014-03-02 21:45:28 +0000)

----------------------------------------------------------------
Third IIO new drivers and cleanups series for 3.15.

New driver
* Xilinx XADC driver -  This has been ready for a while but was awaiting
   a device tree ack (or as it turns out 3+ weeks).

Cleanup
* Drop some unreachable code from mag3110 highlighted by smatch.

Fix
* vf610 - introduced this cycle - put a possible negative error code
   into an unsigned long. Another smatch find - this one promoted by
   guilt that Dan was busy fixing all our messups.

----------------------------------------------------------------
Jonathan Cameron (1):
       iio:adc:vf610 ensure correct handing of interruption of wait for completion

Lars-Peter Clausen (2):
       devicetree: Add Xilinx XADC binding documentation
       iio:adc: Add Xilinx XADC driver

Peter Meerwald (1):
       iio:magnetometer:mag3110: Fix unreachable code

  .../devicetree/bindings/iio/adc/xilinx-xadc.txt    |  113 ++
  drivers/iio/adc/Kconfig                            |   13 +
  drivers/iio/adc/Makefile                           |    2 +
  drivers/iio/adc/vf610_adc.c                        |    2 +-
  drivers/iio/adc/xilinx-xadc-core.c                 | 1333 ++++++++++++++++++++
  drivers/iio/adc/xilinx-xadc-events.c               |  254 ++++
  drivers/iio/adc/xilinx-xadc.h                      |  209 +++
  drivers/iio/magnetometer/mag3110.c                 |    1 -
  8 files changed, 1925 insertions(+), 2 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
  create mode 100644 drivers/iio/adc/xilinx-xadc-core.c
  create mode 100644 drivers/iio/adc/xilinx-xadc-events.c
  create mode 100644 drivers/iio/adc/xilinx-xadc.h
