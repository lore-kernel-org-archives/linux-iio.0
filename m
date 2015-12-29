Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33465 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbbL2L2O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2015 06:28:14 -0500
Received: by mail-pf0-f193.google.com with SMTP id 78so12395084pfw.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2015 03:28:14 -0800 (PST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 0/5] Staging: iio: cdc: Checkpatch cleanups
Date: Tue, 29 Dec 2015 16:57:26 +0530
Message-Id: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches fix warnings detected by checkpatch.

Shraddha Barke (5):
  Staging: iio: cdc: Prefer using the BIT macro
  Staging: iio: cdc: Prefer using the BIT macro
  Staging: iio: cdc: Fix alignment should match open parenthesis
  Staging: iio: cdc: Prefer using the BIT macro
  Staging: iio: cdc: Fix alignment should match open parenthesis

 drivers/staging/iio/cdc/ad7150.c | 34 ++++++++++++++++---------------
 drivers/staging/iio/cdc/ad7152.c | 44 ++++++++++++++++++++--------------------
 drivers/staging/iio/cdc/ad7746.c | 22 ++++++++++----------
 3 files changed, 51 insertions(+), 49 deletions(-)

-- 
2.1.4

