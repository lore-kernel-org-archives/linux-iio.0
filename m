Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netline-mail3.netline.ch ([78.47.214.34]:58297 "EHLO
	netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbbJVEfL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Oct 2015 00:35:11 -0400
From: Marc Andre <marc.andre@netline.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, marc.andre@netline.ch
Subject: [PATCH v3 0/2] iio:ad5064: Add support for LTC2617
Date: Thu, 22 Oct 2015 06:34:29 +0200
Message-Id: <1445488471-16568-1-git-send-email-marc.andre@netline.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Based on the feedback from Lars-Peter I've reordered the patch to
first adjust the structure and then add the LTC2617 support.
The result file (after applying both patches) is identical. Of course
the commit description has changed.

**** Original intro *****

Based on the discussion after submitting my patch to add a new driver
for LTC2617, I've now implemented the support for the LTC2617 (and
similar) devices into the AD5064 driver.

I've split the implementation into two patches. The first patch adds
basic support for LTC2617. The second patch fixes the power down
functionality because the LTC handle that differently than the AD
devices.

[PATCH v3 1/2] iio:ad5064: Structural changes to support LTC2617
[PATCH v3 2/2] iio:ad5064: Add support for ltc2617 and similar devices
