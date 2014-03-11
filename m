Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33614 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbaCKUgX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Mar 2014 16:36:23 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: sr@denx.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/5] iio: Minor cleanups to spear ADC driver followed by staging graduation.
Date: Tue, 11 Mar 2014 20:36:54 +0000
Message-Id: <1394570219-7672-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver has been reasonably clean since it was first merged within the
staging tree.  If it had been submitted after the IIO core was outside of
staging we might have taken it as is. I did a final review and the first 4
patches of this series rework various minor aspects of the driver.

Whilst it is a slow driver, the device tree matches at the lowest level seemed
a little unwise so the largest rework is concerned with centralising that
logic using a classic ops structure of function pointers.  The other large
change was to move to using the info_mask_shared_by_all approach to handle
sampling frequency.  This is something I am slowly propogating across the
whole tree, but might as well be done whilst we are looking at this driver.

I don't have hardware and whilst I think these are all changes that are
possible to easily verify by eye, a tested by would be most welcome!

Note this is the first driver I'm suggesting moving out of staging following
Greg's entirely reasonable question of 'What's wrong with the stuff that is
left?'  Any help with this sort of final cleanup and move would be most
welcome.

Jonathan

Jonathan Cameron (5):
  staging:iio:adc:spear adc - prefix defines to avoid namespace clashes.
  staging:iio:adc:spear adc rework so that device tree queries are all
    in probe
  staging:iio:adc:spear_adc drop initialization of unused scan_type
  staging:iio:adc:spear_adc use info_mask_shared_by_all for samp freq
  iio:adc:spear_adc move out of staging

 drivers/iio/adc/Kconfig             |   8 +
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/spear_adc.c         | 429 +++++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig     |   8 -
 drivers/staging/iio/adc/Makefile    |   1 -
 drivers/staging/iio/adc/spear_adc.c | 432 ------------------------------------
 6 files changed, 438 insertions(+), 441 deletions(-)
 create mode 100644 drivers/iio/adc/spear_adc.c
 delete mode 100644 drivers/staging/iio/adc/spear_adc.c

-- 
1.9.0

