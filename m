Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9323 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101AbbDMPl1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Apr 2015 11:41:27 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 00/17] Fixes for the mma9553 driver
Date: Mon, 13 Apr 2015 18:40:47 +0300
Message-Id: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a set of follow-up patches for the mma9553 driver that fixes
issues as suggested by Hartmut and Daniel.

Changes in v2:
 - split some of the the v1 patches into smaller patches
as suggested by Jonathan
 - reordered the series to have bug fixes first followed by style fixes
 - use Reported-by for bug fixes
 - added more fixes for issues detected by checkpatch.pl --strict

Irina Tirdea (17):
  iio: accel: mma9553: fix endianness issue when reading status
  iio: accel: mma9553: check input value for activity period
  iio: accel: mma9551_core: prevent buffer overrun
  iio: accel: mma9553: add enable channel for activity
  iio: accel: mma9551_core: wrong doc fixes
  iio: accel: mma9551_core: typo fix in RSC APP ID
  iio: accel: mma9553: check for error in reading initial activity and
    stepcnt
  iio: accel: mma9553: return 0 as indication of success
  iio: accel: mma9553: comment and error message fixes
  iio: accel: mma9553: use GENMASK
  iio: accel: mma9553: prefix naming fixes
  iio: accel: mma9553: fix gpio bitnum init value
  iio: accel: mma9553: refactor mma9553_read_raw
  iio: accel: mma9551_core: use size in words for word buffers
  iio: accel: mma9553: fix alignment issues
  iio: accel: mma9553: document use of mutex
  iio: accel: mma9553: use unsigned counters

 drivers/iio/accel/mma9551_core.c |  70 ++++++-----
 drivers/iio/accel/mma9551_core.h |   8 +-
 drivers/iio/accel/mma9553.c      | 253 ++++++++++++++++++---------------------
 3 files changed, 160 insertions(+), 171 deletions(-)

-- 
1.9.1

