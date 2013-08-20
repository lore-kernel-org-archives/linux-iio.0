Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30755 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab3HTOp6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2013 10:45:58 -0400
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH/RFC v5 0/2] gp2ap020a00f ambient light/proximity sensor
Date: Tue, 20 Aug 2013 16:45:20 +0200
Message-id: <1377009920-5088-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver supports:
 - reading channels in 'one shot' mode through read_raw callback,
 - four events - rising and falling ambient light events and
   rising and falling proximity roc events.
 - triggers for all the three channels (triggers can't be enabled
   simultaneosly with proximity detection event)

This is a follow-up of the previous series and it includes
following improvements:
  - switched over to "auto calculation" mode for ambient light
    measurement - it tells the device to automatically convert
    illuminance output value to lux units
  - added checking if the event state to be set is legal
  - removed superfluous !! on test_bit result assignment
  - precluding enabling proximity events if any of the
    proximity thresholds isn't greater than 0
  - precluding writing 0 to the proximity threshold value
    sysfs attributes
  - got rid of the warning upon call to the iio_trigger_poll
  - removed interrupt-parent property from DT bindings
    documentation file
  - changed the description of the interrupts property
    in the DT binding documentation file

Thanks,
Jacek Anaszewski

Jacek Anaszewski (2):
  DT: Add documentation for gp2ap020a00f sensor
  iio: gp2ap020a00f: Add a driver for the device

 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   17 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/gp2ap020a00f.c                   | 1446 ++++++++++++++++++++
 4 files changed, 1476 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
 create mode 100644 drivers/iio/light/gp2ap020a00f.c

-- 
1.7.5.4

