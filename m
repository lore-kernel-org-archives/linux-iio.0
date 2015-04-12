Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38312 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbbDLQw4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 12 Apr 2015 12:52:56 -0400
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH v2 0/3] iio: sx9500: power usage and gpio changes
Date: Sun, 12 Apr 2015 19:52:37 +0300
Message-Id: <1428857560-32566-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The meaty patch is the first one, making the chip use exactly as much
power as needed.  The other two are a code cleanup and the addition of
an optional GPIO reset pin.

In v2, an interrupt is no longer required: If none is available, raw
reads just sleep for the amount of time defined in the data sheet before
reading registers.

Vlad Dogaru (3):
  iio: sx9500: optimize power usage
  iio: sx9500: refactor GPIO interrupt code
  iio: sx9500: add GPIO reset pin

 drivers/iio/proximity/sx9500.c | 427 +++++++++++++++++++++++++++++++++--------
 1 file changed, 347 insertions(+), 80 deletions(-)

-- 
1.9.1

