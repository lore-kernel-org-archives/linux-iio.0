Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61664 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbbDLRJa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 12 Apr 2015 13:09:30 -0400
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH v3 0/3] iio: sx9500: power usage and gpio changes
Date: Sun, 12 Apr 2015 20:09:18 +0300
Message-Id: <1428858561-27994-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The meaty patch is the first one, making the chip use exactly as much
power as needed.  The other two are a code cleanup and the addition of
an optional GPIO reset pin.

Changes since v2:
 - don't reformat code in a patch that also changes functionality.

Changes since v1:
 - having an interrupt is now optional.  If none is available, raw reads
   just sleep for the amount of time defined in the datasheet before
   reading registers.

Vlad Dogaru (3):
  iio: sx9500: optimize power usage
  iio: sx9500: refactor GPIO interrupt code
  iio: sx9500: add GPIO reset pin

 drivers/iio/proximity/sx9500.c | 415 +++++++++++++++++++++++++++++++++--------
 1 file changed, 340 insertions(+), 75 deletions(-)

-- 
1.9.1

