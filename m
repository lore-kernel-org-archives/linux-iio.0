Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netline-mail3.netline.ch ([78.47.214.34]:53566 "EHLO
	netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbJOMb0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Oct 2015 08:31:26 -0400
From: Marc Andre <marc.andre@netline.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, marc.andre@netline.ch
Subject: iio:ad5064: Add support for LTC2617
Date: Thu, 15 Oct 2015 14:31:02 +0200
Message-Id: <1444912264-44606-1-git-send-email-marc.andre@netline.ch>
In-Reply-To: <CAEnQRZC4sxWXkUgz7316NrzHYa9GkfneG82PcPKgK00S76W=GA@mail.gmail.com>
References: <CAEnQRZC4sxWXkUgz7316NrzHYa9GkfneG82PcPKgK00S76W=GA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I've updated the patches according to the feedback of Peter and Daniel.
- Added datasheet links to the description of patch 1/2.
- Added 90kohm_to_gnd to ABI documentation sysfs-bus-iio

**** Original intro *****

Based on the discussion after submitting my patch to add a new driver
for LTC2617, I've now implemented the support for the LTC2617 (and
similar) devices into the AD5064 driver.

I've split the implementation into two patches. The first patch adds
basic support for LTC2617. The second patch fixes the power down
functionality because the LTC handle that differently than the AD
devices.

[PATCH v2 1/2] iio:ad5064: Add support for ltc2617 and similar devices
[PATCH v2 2/2] iio:ad5064: Fix power down operation with LTC2617

Best Regards,
Marc
