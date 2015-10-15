Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netline-mail3.netline.ch ([78.47.214.34]:51538 "EHLO
	netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbJOJM1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Oct 2015 05:12:27 -0400
From: Marc Andre <marc.andre@netline.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, marc.andre@netline.ch
Subject: iio:ad5064: Add support for LTC2617
Date: Thu, 15 Oct 2015 11:12:04 +0200
Message-Id: <1444900326-43839-1-git-send-email-marc.andre@netline.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Based on the discussion after submitting my patch to add a new driver
for LTC2617, I've now implemented the support for the LTC2617 (and
similar) devices into the AD5064 driver.

I've split the implementation into two patches. The first patch adds
basic support for LTC2617. The second patch fixes the power down
functionality because the LTC handle that differently than the AD
devices.

Datasheet for LTC devices:
LTC2606, LTC2616, LTC2626: http://www.linear.com/docs/6398
LTC2607, LTC2617, LTC2627: http://www.linear.com/docs/8977
LTC2709, LTC2619, LTC2629: http://www.linear.com/docs/8477

Best regards,
Marc

[PATCH 1/2] iio:ad5064: Add support for ltc2617 and similar devices
[PATCH 2/2] iio:ad5064: Fix power down operation with LTC2617
