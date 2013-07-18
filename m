Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49064 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619Ab3GRSE2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2013 14:04:28 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MQ5001P68VFRRD0@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Fri, 19 Jul 2013 03:04:27 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, kyungmin.park@samsung.com,
	s.nawrocki@samsung.com, Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATHC/RFC v3] gp2ap020a00f ambient light/proximity sensor
Date: Thu, 18 Jul 2013 20:04:10 +0200
Message-id: <1374170651-3862-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver supports:
 - reading channels in 'one shot' mode through read_raw callback,
 - four events - rising and falling ambient light events and 
   rising and falling proximity roc events.
 - triggers for all the three channels (triggers can't be enabled
   simultaneosly with proximity detection event)


This is a follow-up of the previous patch and it includes
following improvements (Jonathan and Peter - thanks for the review):
  - changed "Opto" to "ALS" in the driver description
  - switched from HZ to jiffies units for the GP2AP020A00F_DATA_READY_TIMEOUT
  - added proximity detection falling event
  - added lookup table of register settings for different opmodes
  - switched to using regmap
  - added debugfs reg_addr and reg_val attributes
  - switched to using proximity detection/non detection device
    functionality for the proximity events (single event is generated
    upon crossing high and low thresholds)
  - adjusting lux mode depending on the light clear output value

Issues:
  - WARNING: at kernel/irq/handle.c:146 on call to iio_trigger_poll
  - how to deal with the scale value that changes depending on the output
    value?

Thanks,
Jacek

Jacek Anaszewski (1):
  iio: gp2ap020a00f: Add a driver for the device

 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   20 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/gp2ap020a00f.c                   | 1547 ++++++++++++++++++++
 4 files changed, 1580 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
 create mode 100644 drivers/iio/light/gp2ap020a00f.c

-- 
1.7.5.4

