Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:58472 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbBWTgI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Feb 2015 14:36:08 -0500
Received: by mail-wi0-f180.google.com with SMTP id h11so20120185wiw.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2015 11:36:07 -0800 (PST)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com, octavian.purdila@intel.com,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 0/4] staging: iio: light: isl29018: Remove non-standard sysfs attributes
Date: Mon, 23 Feb 2015 21:35:50 +0200
Message-Id: <1424720154-4762-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This set of patches removes non-standard sysfs attributes used
by isl29018 driver.

It introduces IIO_CHAN_INFO_RANGE and then refactors isl29018 driver
code in order to use standard attributes.

The purpose of these patches is to change the isl29018 driver to use
standard IIO attributes in order to be moved out of staging.

Roberta Dobrescu (4):
  staging: iio: light: isl29018: Remove non-standard sysfs attributes
  iio: Introduce IIO_CHAN_INFO_RANGE
  staging: iio: light: isl29018: Rename lux_scale to calibscale
  staging: iio: light: isl29018: Use standard sysfs attributes for range
    and scale

 Documentation/ABI/testing/sysfs-bus-iio |  13 ++
 drivers/iio/industrialio-core.c         |   1 +
 drivers/staging/iio/light/isl29018.c    | 257 +++++++++++++++-----------------
 include/linux/iio/iio.h                 |   1 +
 4 files changed, 137 insertions(+), 135 deletions(-)

-- 
1.9.1

