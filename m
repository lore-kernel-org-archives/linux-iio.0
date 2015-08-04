Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35853 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbbHDSQP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 14:16:15 -0400
From: Adam YH Lee <adam.yh.lee@gmail.com>
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, jic23@kernel.org
Cc: sre@kernel.org, pmeerw@pmeerw.net,
	Adam YH Lee <adam.yh.lee@gmail.com>
Subject: [V4] [TWL4030 MADC] Correction and clean-up
Date: Tue,  4 Aug 2015 11:15:47 -0700
Message-Id: <1438712148-27004-1-git-send-email-adam.yh.lee@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The V4 of this patch addresses issues raised by Jonathan [1].

"iio_device_register" call should be the last call in the probe.
All regulators should be configured before that call.

Remove devm_regulator_put as it is not necessary. "devm_allocators"
(devm_regulator_get, in this case) does device removal as well as error
handling.

[1] http://www.spinics.net/lists/linux-omap/msg120871.html

Adam YH Lee (1):
  [TWL4030 MADC] Fix ADC[3:6] readings

 drivers/iio/adc/twl4030-madc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.1.4

