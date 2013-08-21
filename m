Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18984 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab3HUPGA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2013 11:06:00 -0400
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH/RFC v6 0/2] gp2ap020a00f ambient light/proximity sensor
Date: Wed, 21 Aug 2013 17:05:42 +0200
Message-id: <1377097542-4433-1-git-send-email-j.anaszewski@samsung.com>
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
  - brought back gp2ap020a00f_adjust_lux_mode function
    that adjustes maximum measurable range for the ALS
    unit
  - implemented gp2ap020a00f_output_to_lux function for
    calculating output value when in high lux mode
  - dropped setting a default trigger in the driver
  - added description justifying presence of the vled-supply
    property in the DT node for the device
  - changed the description of the interrupts property
    in the DT binding documentation file

Thanks,
Jacek Anaszewski

Jacek Anaszewski (2):
  DT: Add documentation for gp2ap020a00f sensor
  iio: gp2ap020a00f: Add a driver for the device

 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   21 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/gp2ap020a00f.c                   | 1519 ++++++++++++++++++++
 4 files changed, 1553 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
 create mode 100644 drivers/iio/light/gp2ap020a00f.c

-- 
1.7.5.4

